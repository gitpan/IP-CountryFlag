use strict;use warnings;
use Module::Build;

my $builder = Module::Build->new(
    sign              => 1,
    module_name       => 'IP::CountryFlag',
    license           => 'perl',
    dist_author       => q{Mohammad S Anwar <mohammad.anwar@yahoo.com>},
    dist_version_from => 'lib/IP/CountryFlag.pm',
    add_to_cleanup    => [ 'IP-CountryFlag-*' ],    
    build_requires    => {
        'Readonly'    => '1.03',
        'Mouse'       => '0.93',
        'HTTP::Request'  => '1.40',
        'LWP::UserAgent' => '2.33',
        'Data::Validate::IP'       => '0.10',
        'File::Spec::Functions'    => '3.30',
        'MouseX::Params::Validate' => '0.01',
    },
);

$builder->create_build_script();