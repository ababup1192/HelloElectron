gulp = require('gulp')
$ = require('gulp-load-plugins')()
electron = require('electron-connect').server.create()

gulp.task 'typescript', () ->
  gulp.src(['./src/**/*.ts'])
      .pipe($.typescript({target: "ES5", noExternalResolve: true, removeComments: true}))
      .js
      .pipe(gulp.dest('./build'))

gulp.task 'jade', () ->
  gulp.src(['./src/**/*.jade'])
      .pipe($.jade({pretty: true}))
      .pipe(gulp.dest('./build'))

gulp.task 'start', ['jade', 'typescript'], () ->
  electron.start()
  gulp.watch('./src/**/*.{jade,ts}', ['jade', 'typescript'])
  gulp.watch(['main.js'], electron.restart)
  gulp.watch(['./build/**/*.{html,js,css}'], electron.reload)
