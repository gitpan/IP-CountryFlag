use strict;use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME               => 'IP::CountryFlag',
    AUTHOR             => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM       => 'lib/IP/CountryFlag.pm',
    ABSTRACT_FROM      => 'lib/IP/CountryFlag.pm',
    LICENSE            => 'artistic_2',
    PL_FILES           => {},
    MIN_PERL_VERSION   => 5.006,
    CONFIGURE_REQUIRES => {
        'ExtUtils::MakeMaker' => 0,
    },
    BUILD_REQUIRES => {
        'Test::More' => 0,
    },
    PREREQ_PM     => {
        'Moo'                   => 0,
        'namespace::clean'      => 0,
        'Throwable'             => 0,
        'Data::Validate::IP'    => '0.10',
        'File::Spec::Functions' => '3.30',
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES => 'IP-CountryFlag-*' },
    (eval { ExtUtils::MakeMaker->VERSION(6.46) } ? (META_MERGE => {
        'meta-spec' => { version => 2 },
        resources => {
            repository => {
                type => 'git',
                url  => 'https://github.com/Manwar/IP-CountryFlag.git',
                web  => 'https://github.com/Manwar/IP-CountryFlag',
            },
        }})
     : ()
    ),
);
