#!perl

use strict; use warnings;
use IP::CountryFlag;
use Test::More tests => 4;

my $countryFlag = IP::CountryFlag->new();

eval { $countryFlag->save('path' => './'); };
like($@, qr/Mandatory parameter 'ip' missing/);

eval { $countryFlag->save(ip => '12.215.42.19'); };
like($@, qr/Mandatory parameter 'path' missing/);

eval { $countryFlag->save(ip => '12.215.42.19', path => './tt'); };
like($@, qr/The 'path' parameter/);

eval { $countryFlag->save(ip => '215.42.19', path => './'); };
like($@, qr/The 'ip' parameter/);