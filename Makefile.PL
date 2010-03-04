
use strict;
use warnings;



use ExtUtils::MakeMaker;

WriteMakefile(
  DISTNAME  => 'Dist-Zilla-Plugin-MetaNoIndex',
  NAME      => 'Dist::Zilla::Plugin::MetaNoIndex',
  AUTHOR    => "JT\ Smith\ \<RIZEN\@cpan\.org\>",
  ABSTRACT  => "Stop\ CPAN\ from\ indexing\ stuff",
  VERSION   => '0.0200',
  EXE_FILES => [ qw() ],
  (eval { ExtUtils::MakeMaker->VERSION(6.31) } ? (LICENSE => 'perl') : ()),
  PREREQ_PM    => {
    "Dist::Zilla" => '1.093400',
  },
  test => {TESTS => 't/*.t'}
);

