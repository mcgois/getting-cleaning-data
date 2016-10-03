var gulp = require('gulp');
var markdown = require('gulp-markdown');

gulp.task('readme', function () {
    return gulp.src('README.md')
        .pipe(markdown())
        .pipe(gulp.dest('./'));
});

gulp.task('codebook', function () {
    return gulp.src('codebook.md')
        .pipe(markdown())
        .pipe(gulp.dest('./'));
});
