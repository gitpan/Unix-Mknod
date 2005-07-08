package Unix::Mknod;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use Unix::Mknod ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(
	mknod major minor makedev
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} });

our @EXPORT = qw(

);

our $VERSION = '0.02';

require XSLoader;
XSLoader::load('Unix::Mknod', $VERSION);

# Preloaded methods go here.

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Unix::Mknod - Perl extension for mknod, major, minor, and makedev

=head1 SYNOPSIS

 use Unix::Mknod;
 use File::stat;
 use Fcntl ':mode';

 $st=stat('/dev/null');
 $major=major($st->rdev);
 $minor=minor($st->rdev);

 mknod('/tmp/special', S_IFCHR|0600, makedev($major,$minor+1));

=head1 DESCRIPTION

This module allows access to the device routines major()/minor()/makedev()
that may or may not be macros in .h files.    

It also allows access to the mknod system call.

=head1 FUNCTIONS

=over 4

=item I<mknod($filename, $mode, $rdev)>

Creates a block or character special device named $filename.  Returns
0 on success and -1 on failure.  Must be run as root.

=item I<$major = major($rdev)>

Returns the major number for the specical device as defined by the 
st_rdev field from the stat() call.

=item I<$minor = minor($rdev)>

Returns the minor number for the specical device as defined by the 
st_rdev field from the stat() call.

=item I<$rdev = makedev($major, $minor)>

Returns the st_rdev number for the specical device from the $major 
and $minor numbers.

=back

=head1 NOTES

There are 2 other perl modules that implement the mknod(2) system call,
but they have problems working on some platforms.  Sys::Mknod does not
work on AIX because it uses the syscall(2) generic system call which
AIX does not have.  Mknod implements S_IFIFO, which on most platforms
is not implemented in mknod, but rather mkfifo (which is implemented
in POSIX perl module).

The perl module File::Stat::Bits also implements major() and minor() (and
a version of makedev() called dev_join).  They are done as a program to
get the bit masks at compile time, but if major() and minor() are 
implemented as sub routines, the arugment could be something as simple
as an index to a lookup table (and thereby having no decernable relation
to its result).

=head1 BUGS

mknod will not work when you are not I<root>, nor when you are trying to
create a device on a filesystem that is mounted I<nodev>, nor within a
Solaris zone that is not the global zone.

=head1 SEE ALSO

File::Stat::Bits, Mknod, POSIX, Sys::Mknod

major(9), minor(9), mkfifo(1), mknod(8)

ftp://ftp-dev.cites.uiuc.edu/pub/Unix-Mknod

=head1 AUTHOR

Jim Pirzyk, E<lt>pirzyk@uiuc.eduE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (c) 2005  University of Illinois Board of Trustees
All rights reserved.

Developed by: Campus Information Technologies and Educational Services,
              University of Illinois at Urbana-Champaign

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
``Software''), to deal with the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

* Redistributions of source code must retain the above copyright
  notice, this list of conditions and the following disclaimers.

* Redistributions in binary form must reproduce the above copyright
  notice, this list of conditions and the following disclaimers in the
  documentation and/or other materials provided with the distribution.

* Neither the names of Campus Information Technologies and Educational
  Services, University of Illinois at Urbana-Champaign, nor the names
  of its contributors may be used to endorse or promote products derived
  from this Software without specific prior written permission.

THE SOFTWARE IS PROVIDED ``AS IS'', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR
ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE
OR THE USE OR OTHER DEALINGS WITH THE SOFTWARE.

=cut
