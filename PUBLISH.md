# PUBLISH

Instructions for publishing this cookbook to the Chef Supermarket:

- Select appropriate chef environment

        $ chefvm use chef.io

- Ensure all style/specs pass

        $ rake

- Update `CHANGELOG.md` with recent changes; adjust wording of Issues and Pull Requests and re-run as required.

        $ rake changelog

- Publish cookbook (select revision, minor, major, or no version bump)

        $ rake publish        # revision version bump, tag, publish
        $ rake publish:minor  # minor version bump, tag, publish
        $ rake publish:major  # major version bump, tag, publish
        # rake publish:now    # use existing version, tag, publish


## Config reference

Chef environment manager `chefvm` is used.

`~/.bash_profile`

    ...
    # configure stove gem to use chefvm path
    export STOVE_CONFIG=$HOME/.chef/stove.json
    ...

`~/.chef/stove.json`

    {"username":"USERNAME","key":"/PATH/TO/.chef/USERNAME.pem"}


`~/.chef/USERNAME.pem`

    -----BEGIN RSA PRIVATE KEY-----
    ...
    -----END RSA PRIVATE KEY-----
