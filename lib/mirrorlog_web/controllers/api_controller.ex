defmodule MirrorlogWeb.ApiController do
  use MirrorlogWeb, :controller
  import Ecto.Query
  alias Mirrorlog.Work.Project
  alias Mirrorlog.Repo

  def map_assoc(nil, _transform_fn), do: nil
  def map_assoc(%Ecto.Association.NotLoaded{}, _transform_fn), do: nil
  def map_assoc(item, transform_fn) when is_list(item) do
    item |> Enum.map(fn i -> transform_fn.(i) end)
  end
  def map_assoc(item, transform_fn) do
    transform_fn.(item)
  end

  def transform_attachment(a) do
    %{
      id: a.id,
      hash: a.hash,
      mime: a.mime,
      original_filename: a.original_filename,
      storage_path: a.storage_path,
    }
  end

  def transform_optic(o) do
    %{
      id: o.id,
      date_end: o.date_end,
      date_start: o.date_start,
      diameter: o.diameter,
      name: o.name,
      status: o.status,
      thickness: o.thickness,
      type: o.type,
      surfaces: o.surfaces |> map_assoc(&transform_surface/1),
      glass: o.glass |> map_assoc(&transform_glass/1),
      project: o.project |> map_assoc(&transform_project/1),
    }
  end

  def transform_glass(s) do
    %{
      id: s.id,
      name: s.name,
    }
  end

  def transform_surface(s) do
    %{
      id: s.id,
      conic: s.conic,
      date_end: s.date_end,
      date_start: s.date_start,
      radius: s.radius,
      status: s.status,
      type: s.type,
      optic: s.optic |> map_assoc(&transform_optic/1),
      sessions: s.sessions |> map_assoc(&transform_session/1),
    }
  end

  def transform_tool(t) do
    %{
      id: t.id,
      comments: t.comments,
      diameter: t.diameter,
      picture: t.picture |> map_assoc(&transform_attachment/1),
      project: t.project |> map_assoc(&transform_project/1),
      radius: t.radius,
      short_note: t.short_note,
      thickness: t.thickness,
      type: t.type,
    }
  end

  def transform_session(s) do
    %{
      id: s.id,
      comments: s.comments,
      date_start: s.date_start,
      duration: s.duration,
      efficiency: s.efficiency,
      end_conic: s.end_conic,
      end_pv: s.end_pv,
      end_roc: s.end_roc,
      goal: s.goal,
      outcome: s.outcome,
      short_note: s.short_note,
      start_conic: s.start_conic,
      start_pv: s.start_pv,
      start_roc: s.start_roc,
      type: s.type,
      tool: s.tool |> map_assoc(&transform_tool/1),
      project: s.project |> map_assoc(&transform_project/1),
      surface: s.surface |> map_assoc(&transform_surface/1),
      previous_session: s.previous_session |> map_assoc(&transform_session/1),
      next_session: s.next_session |> map_assoc(&transform_session/1),
      stroke: s.stroke |> map_assoc(&transform_stroke/1)
    }
  end

  def transform_stroke(s) do
    %{
      id: s.id,
      expression: s.expression,
      name: s.name,
      picture: s.picture |> map_assoc(&transform_attachment/1)
    }
  end

  def transform_project(p) do
    %{
      id: p.id,
      date_start: p.date_start,
      name: p.name,
      status: p.status,
      main_picture: p.main_picture |> map_assoc(&transform_attachment/1),
      optics: p.optics |> map_assoc(&transform_optic/1),
      tools: p.tools |> map_assoc(&transform_tool/1),
      sessions: p.sessions |> map_assoc(&transform_session/1)
    }
  end

  def get_projects(conn, _) do
    projects = from(Project, preload: [optics: [:surfaces]]) |> Repo.all() |> map_assoc(&transform_project/1)
    conn |> json(projects)
  end

  def get_project(conn, %{"id" => i}) do
    project = from(p in Project, where: p.id == ^i, preload: [
      :main_picture,
      optics: [:glass, surfaces: [sessions: [:tool, :stroke]]],
      tools: [:picture],
    ]) |> Repo.one |> map_assoc(&transform_project/1)

    conn |> json(project)
  end

  def create_project_from_wizard(conn, %{"name" => n, "status" => s, "date_start" => d, "optics" => optics}) do
    {:ok, db_project} = Mirrorlog.Work.create_project(%{
      "name" => n,
      "status" => s,
      "date_start" => "#{d}T00:00:00" |> NaiveDateTime.from_iso8601!()
    })
    db_optics = optics |> Enum.map(fn o ->
      db_glass = Mirrorlog.Work.get_or_create_glass_by_name(Map.get(o, "glass", "bk7"))

      {:ok, db_optic} = Mirrorlog.Work.create_optic(%{
        "project_id" => db_project.id,
        "name" => Map.get(o, "name", ""),
        "diameter" => Map.get(o, "diameter", 1),
        "glass_id" => db_glass.id,
        "type" => Map.get(o, "type", 0),
        "thickness" => Map.get(o, "thickness", 1)
      })

      db_surfaces = Map.get(o, "surfaces", []) |> Enum.map(fn s ->
        {:ok, surface} = Mirrorlog.Work.create_surface(%{
          "optic_id" => db_optic.id,
          "radius" => Map.get(s, "radius", 1),
          "status" => Map.get(s, "status", 0),
          "type" => Map.get(s, "type", 0),
          "conic" => Map.get(s, "conic", 0)
        })
        surface
      end)

      db_optic |> Map.put(:surfaces, db_surfaces)
               |> Map.put(:glass, db_glass)
    end)

    get_project(conn, %{"id" => db_project.id})
  end
end
