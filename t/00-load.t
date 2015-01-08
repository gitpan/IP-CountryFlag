#!perl

use Test::More tests => 4;

BEGIN {
    use_ok('IP::CountryFlag')                       || print "Bail out!";
    use_ok('IP::CountryFlag::Params')               || print "Bail out!";
    use_ok('IP::CountryFlag::UserAgent')            || print "Bail out!";
    use_ok('IP::CountryFlag::UserAgent::Exception') || print "Bail out!";
}
