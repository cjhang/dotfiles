host := `uname -a`
server := "pcir79"
folder := "work/storage"
sync_folder := 'apps/code_snippets'

# save the data to server
cp file destination:
  scp {{file}} {{destination}}

# save the data to server
save file:
  ssh {{server}} "mkdir -p ~/work/storage/$(dirname {{file}})"
  rsync -rhuv {{file}} {{server}}:{{folder}}

# sync the code in the project/code_snippets
sync_code server:
	rsync -rhuv ~/Documents/projects/code_snippets/* {{server}}:{{sync_folder}}

