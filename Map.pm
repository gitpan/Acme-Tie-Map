package Acme::Tie::Map;

use 5.00500;
use strict;

use vars qw($VERSION @ISA);
@ISA = qw( );

$VERSION = '0.03';

sub new
  {
    my $class  = shift;
    my $sub    = shift;

    die "Not a CODE reference", unless (ref($sub) eq "CODE");

    my $self   = {
      VALUE  => undef,
      MAP    => $sub,
    };

    bless $self, $class;
    return $self;
  }

sub store
  {
    my $self = shift;
    $self->{VALUE} = shift;
  }

sub fetch_raw
  {
    my $self = shift;
    return $self->{VALUE};
  }

sub fetch_mapped
  {
    my $self = shift;
    return  &{$self->{MAP}}( $self->fetch_raw );
  }

BEGIN
  {
    *TIESCALAR = \&new;
    *STORE     = \&store;
    *FETCH     = \&fetch_mapped;
  }

1;
__END__

=head1 NAME

Acme::Tie::Map - Ties a function to a scalar

=head1 REQUIREMENTS

Only standard modules are used.

=head1 SYNOPSIS

  use Acme::Tie::Map;

  sub quote {
    my $t = shift;
    return "``$t\'\'";
  }

  tie $x, 'Acme::Tie::Map', \&quote;

  $t = "some text";
  print $t;          # outputs ``some text''

=head1 DESCRIPTION

This is an experimental module to apply a function to a scalar.

=head1 AUTHOR

Robert Rothenberg <rrwo at cpan.org>

=head1 LICENSE

This module is in the public domain.  No copyright is claimed.

=cut
