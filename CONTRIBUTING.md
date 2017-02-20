# CONTRIBUTING

### Code of Conduct

Users, contributors, and maintainers of this project shall conform to the project [Code of Conduct][code of conduct].

[code of conduct]: https://github.com/4-20ma/ModbusMaster/blob/master/CODE_OF_CONDUCT.md


### Repository

1. Fork the repository on GitHub
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
    - include specs with adequate coverage
    - verify `bundle exec rake` is successful
4. Push the branch (`git push origin my-new-feature`)
5. Verify the Travis-CI build passes
6. Create new Pull Request

Note: Pull requests will not be merged with insufficient specs or if `bundle exec rake` fails for any reason.

Additionally, please **DO NOT**:

- modify the version of the cookbook
- update the CHANGELOG


### Labels

Project maintainers assign labels to Issues and Pull Requests (PRs) to categorize, prioritize, and provide status. The following guidelines and conventions are used in this project:

#### Type

- `Bug` - existing code does not behave as described in the project documentation; _requires_ clear test case and be _reproducible_ by project maintainer
- `Enhancement` - improvement to an existing feature (Issue or Pull Request)
- `Feature Requst` - new functionality; _requires_ a well-written, clear user story (Issue)
- `Maintenance` - minor administrative change that does not provide enhancement or introduce new feature
- `Question` - self-explanatory

#### Priority

- `Low` - default priority; new issues generally start here
- `Medium` - issues are escalated, depending on severity of the issue
- `High` - issues are escalated, depending on severity of the issue
- `Critical` - these issues are to be resolved ahead of any other

#### Status

- `Abandoned` - issue/PR closed due to inactivity
- `Blocked` - issue/PR will not be resolved/merged (some projects label these items as `wontfix`; include explanation in issue/PR)
- `In Progress` - issue has been assigned and is actively being addressed; re-label issue `On Hold` with explanation if there will be a significant delay
- `Maintainer Review Needed` - last step prior to merge; PR passes continuous integration tests and is able to be cleanly merged - awaiting review for style, code cleanliness, etc.
- `On Hold` - implementation delayed; provide explanation in issue/PR
- `Pending Contributor Response` - issue/PR closed after 14 days of inactivity (re-label `Abandoned` at closure)
