defmodule Mirrorlog.WorkFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mirrorlog.Work` context.
  """

  @doc """
  Generate a project.
  """
  def project_fixture(attrs \\ %{}) do
    {:ok, project} =
      attrs
      |> Enum.into(%{
        date_start: ~N[2022-02-10 11:00:00],
        main_picture_id: 42,
        name: "some name",
        status: 42
      })
      |> Mirrorlog.Work.create_project()

    project
  end
end
