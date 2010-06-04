
use strict;
use warnings;

 BEGIN { require 5.010; } 

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
  'ABSTRACT' => 'Stop CPAN from indexing stuff',
  'AUTHOR' => 'Mark Gardner <MJGARDNER@cpan.org>, JT Smith <RIZEN@cpan.org>',
  'BUILD_REQUIRES' => {
    'Cwd' => '0',
    'Data::PowerSet' => '0',
    'Dist::Zilla::Tester' => '4.101550',
    'File::Find' => '0',
    'File::Temp' => '0',
    'Modern::Perl' => '0',
    'Path::Class' => '0',
    'Test::Moose' => '0',
    'Test::More' => '0',
    'Test::Most' => '0',
    'Text::Template' => '0'
  },
  'CONFIGURE_REQUIRES' => {
    'ExtUtils::MakeMaker' => '6.31'
  },
  'DISTNAME' => 'Dist-Zilla-Plugin-MetaNoIndex',
  'EXE_FILES' => [],
  'LICENSE' => 'perl',
  'NAME' => 'Dist::Zilla::Plugin::MetaNoIndex',
  'PREREQ_PM' => {
    'Dist::Zilla::Role::MetaProvider' => '4.101550',
    'English' => '0',
    'Moose' => '0',
    'Readonly' => '0',
    'utf8' => '0'
  },
  'VERSION' => '1.101550',
  'test' => {
    'TESTS' => 't/*.t'
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



