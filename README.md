# Marketdown

[Live demo](https://marketdown.herokuapp.com)

This is a Rails 4.2.1 app. Tested with Ruby 2.2.0.

It's a demo to test what implementing a Rails app might look like if we used the DCI pattern. In this app, we use the [Surrounded gem](https://github.com/saturnflyer/surrounded) for this.

You can log in (there's no password, just give a name). You can create books written in Markdown. You can then also purchase books others have written.

## Development

After you clone the app, install the gems and then set up the database:

```
bundle install --path=.bundle
bundle exec rake db:create
bundle exec rake db:migrate
```

## Deployment

You can deploy to Heroku easily.

```
heroku apps:create your-marketdown-instance
git push && git push heroku
heroku open --app your-marketdown-instance
```

## License

MIT

