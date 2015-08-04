gulp = require('gulp')
$ = require('gulp-load-plugins')()
electron = require('electron-connect').server.create()
mainBowerFiles = require('main-bower-files')
gulpFilter = require('gulp-filter');

gulp.task 'jade', () ->
  gulp.src(['./src/**/*.jade'])
      .pipe($.jade({pretty: true}))
      .pipe(gulp.dest('./build'))

gulp.task 'typescript', () ->
  gulp.src(['./src/**/*.ts'])
      .pipe($.typescript({target: "ES5", noExternalResolve: true, removeComments: true}))
      .js
      .pipe(gulp.dest('./build'))

gulp.task 'css', () ->
  gulp.src(['./src/**/*.css'])
      .pipe(gulp.dest('./build'))

gulp.task 'assets', () ->
  gulp.src(['./src/**/*.json'])
      .pipe(gulp.dest('./build'))

gulp.task 'bower', () ->
  jsFilter = gulpFilter('**/*.js')
  cssFilter = gulpFilter('**/*.css')
  gulp.src(mainBowerFiles({debugging:true,checkExistence:true}))
    .pipe(jsFilter)
    .pipe(gulp.dest('./build/js/lib'))
    .pipe(jsFilter.restore())
    .pipe(cssFilter)
    .pipe(gulp.dest('./build/css/lib'))

gulp.task 'start', ['jade', 'typescript', 'bower', 'css', 'assets'], () ->
  electron.start()
  gulp.watch('./src/**/*.{jade,ts,css}', ['jade', 'typescript', 'css', 'assets'])
  gulp.watch(['main.js'], electron.restart)
  gulp.watch(['./build/**/*.{html,js,css}'], electron.reload)
