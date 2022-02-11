defmodule Mirrorlog.Tasks.Uploads do
  def place_upload(%Plug.Upload{} = upload) do
    {:ok, [storage_root: s]} = Application.fetch_env(:mirrorlog, MirrorlogWeb)
    %{year: y, month: m} = Date.utc_today()
    differentiator = :crypto.strong_rand_bytes(8) |> Base.url_encode64 |> binary_part(0, 8)
    storage_folder = Path.join(["#{s}","#{y}", "#{m}"])
    file_name = "#{differentiator}_#{Slug.slugify(upload.filename)}"
    file_path = Path.join([storage_folder, file_name])
    db_file_path = Path.join(["#{y}", "#{m}", file_name])
    :ok = File.mkdir_p(storage_folder)
    :ok = File.cp(upload.path, file_path)
    %{
      db_file_path: db_file_path,
      file_path: file_path,
    }
  end

  def get_disk_path(db_path) do
    {:ok, [storage_root: app_path]} = Application.fetch_env(:mirrorlog, MirrorlogWeb)
    Path.join([app_path, db_path])
  end
end
