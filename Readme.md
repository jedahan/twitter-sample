# Twitter Socket.IO sample

## Dependencies

  * [npm] for server libraries (`brew install node`)
  * [foreman] for orchestrating the database, preprocessors and server (`gem install foreman`)

## Installation

  * `npm install` will isntall node libraries, then client libraries (using bower)
  * Put your twitter credentials in `credentials.json`, (`mv credentials.json{.template,} && subl credentials.json`)

## Running

  * `foreman start` will execute the `Procfile`

[npm]: https://npmjs.org
[foreman]: https://github.com/ddollar/foreman