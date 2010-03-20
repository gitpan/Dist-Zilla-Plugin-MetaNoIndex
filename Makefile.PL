
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Dist::Zilla::Plugin::MetaNoIndex',
                       'DISTNAME' => 'Dist-Zilla-Plugin-MetaNoIndex',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'JT Smith <RIZEN@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Stop CPAN from indexing stuff',
                       'EXE_FILES' => [],
                       'VERSION' => '0.0300',
                       'PREREQ_PM' => {
                                        'Config::MVP' => '0.100780',
                                        'Dist::Zilla' => '1.093400'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



