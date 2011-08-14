use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Webs::CGI',
    AUTHOR              => q{Brad Haywood <brad@geeksware.net>},
    VERSION_FROM        => 'lib/Webs/CGI.pm',
    ABSTRACT_FROM       => 'lib/Webs/CGI.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'DB_File'   => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Webs-CGI-*' },
);
