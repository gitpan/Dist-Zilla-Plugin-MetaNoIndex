
use strict;
use warnings;

 BEGIN { require 5.010; } 

use ExtUtils::MakeMaker 6.31;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::Plugin::MetaNoIndex',
                       'DISTNAME' => 'Dist-Zilla-Plugin-MetaNoIndex',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.31'
                                               },
                       'AUTHOR' => 'Mark Gardner <MJGARDNER@cpan.org>, JT Smith <RIZEN@cpan.org>',
                       'BUILD_REQUIRES' => {
                                             'Dist::Zilla::Tester' => '0',
                                             'Data::PowerSet' => '0',
                                             'Modern::Perl' => '0',
                                             'Test::More' => '0',
                                             'File::Find' => '0',
                                             'Test::Moose' => '0',
                                             'Test::Most' => '0',
                                             'File::Temp' => '0',
                                             'Path::Class' => '0',
                                             'Cwd' => '0',
                                             'Text::Template' => '0'
                                           },
                       'ABSTRACT' => 'Stop CPAN from indexing stuff',
                       'EXE_FILES' => [],
                       'VERSION' => '1.101200',
                       'PREREQ_PM' => {
                                        'English' => '0',
                                        'Dist::Zilla::Role::MetaProvider' => '0',
                                        'Readonly' => '0',
                                        'Moose' => '0',
                                        'utf8' => '0'
                                      },
                       'LICENSE' => 'perl'
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



