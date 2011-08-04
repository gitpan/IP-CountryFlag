package IP::CountryFlag;

use Mouse;
use MouseX::Params::Validate;
use Mouse::Util::TypeConstraints;

use Carp;
use Readonly;
use Data::Dumper;

use HTTP::Request;
use LWP::UserAgent;
use File::Spec::Functions qw(catfile);
use Data::Validate::IP qw(is_ipv4 is_ipv6);

=head1 NAME

IP::CountryFlag - Interface to fetch country flag of an IP.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';
Readonly my $BASE_URL => 'http://api.hostip.info/flag.php';

=head1 DESCRIPTION

A very thin wrapper for the hostip.info API to get the country flag of an IP address.

=cut

type 'IP'      => where { is_ipv4($_) || is_ipv6($_) };
type 'Path'    => where { -d "$_" };
has  'browser' => (is => 'rw', isa => 'LWP::UserAgent', default => sub { return LWP::UserAgent->new(agent => 'Mozilla/5.0'); });

=head1 METHOD

=head2 save()

Saves the country flag in the given location for the given IP address. It returns the location
of the country flag where it has been saved.

    use strict; use warnings;
    use IP::CountryFlag;

    my $countryFlag = IP::CountryFlag->new();
    print $countryFlag->save(ip => '12.215.42.19', path => './');

=cut

sub save
{
    my $self  = shift;
    my %param = validated_hash(\@_,
                'ip'   => { isa => 'IP' },
                'path' => { isa => 'Path' },
                MX_PARAMS_VALIDATE_NO_CACHE => 1);

    my ($browser, $request, $response, $content, $url);
    $url = sprintf("%s?ip=%s", $BASE_URL, $param{'ip'});
    $browser = $self->browser;
    $browser->env_proxy;
    $request  = HTTP::Request->new(GET => $url);
    $response = $browser->request($request);
    croak("ERROR: Couldn't fetch data [$url]:[".$response->status_line."]\n")
        unless $response->is_success;
    $content  = $response->content;
    croak("ERROR: No data found.\n") unless defined $content;
    
    return _save(\%param, $content);
}

sub _save
{
    my $param = shift;
    my $data  = shift;
    
    my $flag = catfile($param->{path}, $param->{ip} . ".gif");
    eval
    {
        open(FLAG, ">$flag");
        binmode(FLAG);    
        print FLAG $data;
        close FLAG;
        return $flag;
    };
    croak("ERROR: Couldn't save flag [$flag][$@].\n") if $@;
}

=head1 AUTHOR

Mohammad S Anwar, C<< <mohammad.anwar at yahoo.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-ip-countryflag at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=IP-CountryFlag>.  I will 
be notified & then you'll automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc IP::CountryFlag

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=IP-CountryFlag>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/IP-CountryFlag>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/IP-CountryFlag>

=item * Search CPAN

L<http://search.cpan.org/dist/IP-CountryFlag/>

=back

=head1 LICENSE AND COPYRIGHT

This  program  is  free  software; you can redistribute it and/or modify it under the terms of
either:  the  GNU  General Public License as published by the Free Software Foundation; or the
Artistic License.

See http://dev.perl.org/licenses/ for more information.

DEAFilter API itself is distributed under the terms of the Gnu GPLv3 licence.

=head1 DISCLAIMER

This  program  is  distributed in the hope that it will be useful,  but  WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

=cut

__PACKAGE__->meta->make_immutable;
no Mouse; # Keywords are removed from the IP::CountryFlag package
no Mouse::Util::TypeConstraints;

1; # End of IP::CountryFlag