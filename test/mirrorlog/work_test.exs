defmodule Mirrorlog.WorkTest do
  use Mirrorlog.DataCase

  alias Mirrorlog.Work

  describe "projects" do
    alias Mirrorlog.Work.Project

    import Mirrorlog.WorkFixtures

    @invalid_attrs %{date_start: nil, main_picture_id: nil, member_id: nil, name: nil, status: nil}

    test "list_projects/0 returns all projects" do
      project = project_fixture()
      assert Work.list_projects() == [project]
    end

    test "get_project!/1 returns the project with given id" do
      project = project_fixture()
      assert Work.get_project!(project.id) == project
    end

    test "create_project/1 with valid data creates a project" do
      valid_attrs = %{date_start: ~N[2022-02-10 11:00:00], main_picture_id: 42, member_id: 42, name: "some name", status: 42}

      assert {:ok, %Project{} = project} = Work.create_project(valid_attrs)
      assert project.date_start == ~N[2022-02-10 11:00:00]
      assert project.main_picture_id == 42
      assert project.member_id == 42
      assert project.name == "some name"
      assert project.status == 42
    end

    test "create_project/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Work.create_project(@invalid_attrs)
    end

    test "update_project/2 with valid data updates the project" do
      project = project_fixture()
      update_attrs = %{date_start: ~N[2022-02-11 11:00:00], main_picture_id: 43, member_id: 43, name: "some updated name", status: 43}

      assert {:ok, %Project{} = project} = Work.update_project(project, update_attrs)
      assert project.date_start == ~N[2022-02-11 11:00:00]
      assert project.main_picture_id == 43
      assert project.member_id == 43
      assert project.name == "some updated name"
      assert project.status == 43
    end

    test "update_project/2 with invalid data returns error changeset" do
      project = project_fixture()
      assert {:error, %Ecto.Changeset{}} = Work.update_project(project, @invalid_attrs)
      assert project == Work.get_project!(project.id)
    end

    test "delete_project/1 deletes the project" do
      project = project_fixture()
      assert {:ok, %Project{}} = Work.delete_project(project)
      assert_raise Ecto.NoResultsError, fn -> Work.get_project!(project.id) end
    end

    test "change_project/1 returns a project changeset" do
      project = project_fixture()
      assert %Ecto.Changeset{} = Work.change_project(project)
    end
  end
end
