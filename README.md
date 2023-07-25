## Setup

To run this project, clone the repository. You will need ruby `3.2.0` and rails installed.
If you want, this repository support dev container extension of vs code. [Here to know more about](https://code.visualstudio.com/docs/devcontainers/containers).

```
# clone the repository
> git clone git@github.com:droderuan/movies_on_rails.git && cd movies_on_rails

# install the gems
> bundle install

# run the migrations and the seed
> rails db:migrate
> rails db:seed

# start the api!
> rails s
```

You can check the routes on [insomnia](https://insomnia.rest/download) by importing the yml inside `/.local`.

## Existing Endpoints

To verify all routes off the application:
`rails routes`
