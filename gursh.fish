function __fish_gursh_no_subcommand --description 'Test if gursh has yet to be given the subcommand'
    for i in (commandline -opc)
        if contains -- $i create download
            return 1
        end
    end
    return 0
end

complete -f -c gursh -n '__fish_gursh_no_subcommand' -a create -d 'Create a new repo in ~/Code/<repo_name> and open it in VS Code'
complete -f -c gursh -n '__fish_gursh_no_subcommand' -a download -d 'Download a video from kick.com'