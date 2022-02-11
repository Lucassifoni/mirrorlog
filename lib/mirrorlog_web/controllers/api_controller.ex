defmodule MirrorlogWeb.ApiController do
  use MirrorlogWeb, :controller
  import Ecto.Query
  alias Mirrorlog.Work.Project
  alias Mirrorlog.Repo

  def get_projects(conn, _) do
    projects = Project |> Repo.all()
    conn |> json(projects)
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
    inserted = Map.put(db_project, :optics, db_optics)

    conn |> json(inserted)
  end
end
