use 5.010;
use strict;
use warnings;
use utf8;

package Dist::Zilla::Plugin::MetaNoIndex;

BEGIN {
    $Dist::Zilla::Plugin::MetaNoIndex::VERSION = '1.101130';
}

# ABSTRACT: Stop CPAN from indexing stuff

use English '-no_match_vars';
use Moose;
use Readonly;
with 'Dist::Zilla::Role::MetaProvider';

Readonly my %ATTR_ALIAS => (
    directory => [qw(dir directories folder)],
    file      => ['files'],
    package   => [qw(class module packages)],
    namespace => ['namespaces'],
);

sub mvp_aliases {
    my %aliases;
    while ( my ( $attr, $aliases_ref ) = each %ATTR_ALIAS ) {
        %aliases = ( %aliases, map { $ARG => $attr } @{$aliases_ref} );
    }
    return \%aliases;
}

sub mvp_multivalue_args { return keys %ATTR_ALIAS }

for ( keys %ATTR_ALIAS ) {
    has $ARG => (
        is        => 'ro',
        isa       => 'ArrayRef[Str]',
        init_arg  => $ARG,
        predicate => "_has_$ARG",
    );
}

sub metadata {
    my $self = shift;
    return {
        no_index => {
            map { $ARG => $self->$ARG }
                grep { my $method = "_has_$ARG"; $self->$method }
                keys %ATTR_ALIAS
        }
    };
}

__PACKAGE__->meta->make_immutable;
no Moose;
1;

=pod

=head1 NAME

Dist::Zilla::Plugin::MetaNoIndex - Stop CPAN from indexing stuff

=head1 VERSION

version 1.101130

=head1 SYNOPSIS

In your F<dist.ini>:

  [MetaNoIndex]
  directory = t/author
  directory = examples
  file = lib/Foo.pm
  package = My::Module
  namespace = My::Module

=head1 DESCRIPTION

This plugin allows you to prevent PAUSE/CPAN from indexing files you don't
want indexed. This is useful if you build test classes or example classes
that are used for those purposes only, and are not part of the distribution.
It does this by adding a C<no_index> block to your F<META.yml> file in your
distribution.

=head1 ATTRIBUTES

=head2 directory

Exclude folders and everything in them. Example: C<author.t>.
Aliases: C<folder>, C<dir>, C<directories>.

=head2 file

Exclude a specific file. Example: C<lib/Foo.pm>.
Alias: C<files>.

=head2 package

Exclude by package name. Example: C<My::Package>.
Aliases: C<class>, C<module>, C<packages>.

=head2 namespace

Exclude everything under a specific namespace. Example: C<My::Package>. 
Alias: C<namespaces>.

B<NOTE:> This will not exclude the package C<My::Package>, only everything
under it like C<My::Package::Foo>.

=head1 METHODS

=head2 metadata

Returns a reference to a hash containing the distribution's no_index metadata.

=encoding utf8

=for Pod::Coverage     mvp_aliases
    mvp_multivalue_args

=head1 SEE ALSO

=over

=item L<Dist::Zilla>

=item L<META-spec|http://module-build.sourceforge.net/META-spec-current.html>

=back

=head1 AUTHORS

  Mark Gardner <MJGARDNER@cpan.org>
  JT Smith <RIZEN@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Mark Gardner.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

__END__
