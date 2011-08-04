use strict;use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'IP::CountryFlag',
    AUTHOR        => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    VERSION_FROM  => 'lib/IP/CountryFlag.pm',
    ABSTRACT_FROM => 'lib/IP/CountryFlag.pm',
    dist          => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean         => { FILES => 'IP-CountryFlag-*' },
    PREREQ_PM     => {
        'Readonly'    => 0,
        'Mouse'       => '0.93',
        'HTTP::Request'  => '1.40',
        'LWP::UserAgent' => '2.33',
        'Data::Validate::IP'       => '0.10',
        'File::Spec::Functions'    => '3.30',
        'MouseX::Params::Validate' => '0.01',
    },
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
);