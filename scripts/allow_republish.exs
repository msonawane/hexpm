[name, version] = System.argv

package = Hexpm.Repo.get_by!(Hexpm.Repository.Package, name: name)

unless package do
  IO.puts "No package: #{name}"
  System.halt(1)
end

release = Hexpm.Repo.get_by!(assoc(package, :releases), version: version)

unless release do
  IO.puts "No release: #{name} #{version}"
  System.halt(1)
end

Ecto.Changeset.change(release, release | inserted_at: NaiveDateTime.utc_now)
|> Hexpm.Repo.update!(release)
