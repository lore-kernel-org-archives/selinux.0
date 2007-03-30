Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l2UBItlf009651
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 07:18:56 -0400
Received: from mx.meyering.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l2UBIsO8017092
	for <selinux@tycho.nsa.gov>; Fri, 30 Mar 2007 11:18:54 GMT
To: bug-coreutils@gnu.org, selinux@tycho.nsa.gov
Subject: SELinux for upstream coreutils, finally (RFC: does mkdir need -Z?)
From: Jim Meyering <jim@meyering.net>
Date: Fri, 30 Mar 2007 13:18:23 +0200
Message-ID: <87tzw3x9mo.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've merged the SELinux changes onto the trunk.  For reference, this
work is based on the patches from Fedora, as of about 6 months ago, but
with some semantic changes.  For example, I've removed the --lcontext and
--scontext options that were specific to their version of ls.  Since the
new -Z option enables printing of the security context, you can get the
same behavior with -lZ, and -Z respectively.  Their -Z option would
print mode, user, group, security context and file name (effectively
eliminating link count, size, and date) in an attempt to fit everything
on a limited-width line.  With this version of ls, there is no equivalent
to that -Z.  However, you can approximate it using stat.

Also, I've removed the vast majority of the cpp directives that guarded
SELinux-related things in src/*.c.  Instead, now there are stub functions
that are compiled on systems lacking SELinux support, so the callers
are more readable/maintainable.

Unlike with other SELinux-enabled coreutils, here, mv and cp do not
provide the "-Z context" option.  It is not the job of such programs
to *change* the security context (which that -Z context enabled).

Regarding the --context=C (-Z C) option that is now accepted by
mkdir, mknod, mkfifo, and install, I am inclined to
omit it altogether, and there was a lot of discussion on the SELinux
mailing list, boiling down to whether the alternative I proposed
was sufficiently "usable".  Hoping to get some feedback about that
from "regular" SELinux users, I summarized and posted to fedora-list, here:

    http://www.redhat.com/archives/fedora-list/2006-August/msg02264.html

Unfortunately, that provoked no discussion.

I'm still not entirely convinced that mkdir, mknod, mkfifo, and install
need the option, and would welcome opinions one way or the other.  There's
a good chance that I'll remove those -Z options before coreutils-6.10.

Another tidbit (from a ChangeLog entry, below):

	Change how "cp -a" and "cp --preserve=context" work with SELinux.
	Now, cp -a attempts to preserve context, but failure to do so does
	not change cp's exit status.  However "cp --preserve=context" is
	similar, but failure *does* cause cp to exit with nonzero status.

---------------------
With these changes, coreutils still builds and passes all tests on Linux
systems (I've tried 2.4.x and 2.6.x, with and without SELinux, and with
different versions of libc).

Below, I'm including only the diffstat summary, and the ChangeLog.
If you want to see the whole diff, this produces it:

    git-diff 8487f9c HEAD

Portability testing (and adding new tests) aside, there are still things
left to do, including NEWS and documentation updates.

---------------------

 .cvsignore                   |    1
 .gitignore                   |    1
 AUTHORS                      |    2
 ChangeLog                    |  215 +++++++++++++++
 README                       |   16 -
 bootstrap.conf               |    4
 gl/lib/se-context_.h         |   31 ++
 gl/lib/se-selinux_.h         |   54 +++
 gl/lib/selinux-at.c          |   92 ++++++
 gl/lib/selinux-at.h          |   24 +
 gl/m4/selinux-context-h.m4   |   18 +
 gl/m4/selinux-selinux-h.m4   |   18 +
 gl/modules/selinux-at        |   32 ++
 gl/modules/selinux-h         |   54 +++
 lib/.cvsignore               |    7
 lib/.gitignore               |    7
 m4/.cvsignore                |    2
 m4/.gitignore                |    2
 man/Makefile.am              |    7
 man/chcon.x                  |    4
 man/runcon.x                 |   14 +
 po/ChangeLog                 |    8
 po/POTFILES.in               |    4
 src/Makefile.am              |   25 +
 src/chcon.c                  |  590 +++++++++++++++++++++++++++++++++++++++++++
 src/copy.c                   |   86 ++++++
 src/copy.h                   |   21 +
 src/cp.c                     |   32 +-
 src/id.c                     |   63 +++-
 src/install.c                |  104 +++++++
 src/ls.c                     |   91 ++++--
 src/mkdir.c                  |   18 +
 src/mkfifo.c                 |   18 +
 src/mknod.c                  |   18 +
 src/mv.c                     |    5
 src/runcon.c                 |  249 ++++++++++++++++++
 src/stat.c                   |   47 ++-
 src/system.h                 |    2
 tests/Makefile.am            |    8
 tests/chmod/equals           |    4
 tests/cp/Makefile.am         |    1
 tests/cp/cp-a-selinux        |   94 ++++++
 tests/cp/cp-parents          |    6
 tests/cp/fail-perm           |    5
 tests/cp/link-preserve       |    2
 tests/help-version           |    7
 tests/install/basic-1        |    5
 tests/misc/Makefile.am       |    6
 tests/misc/chcon             |   73 +++++
 tests/misc/chcon-fail        |   41 ++
 tests/misc/mknod             |    6
 tests/misc/runcon-no-reorder |   57 ++++
 tests/misc/selinux           |   61 ++++
 tests/mkdir/parents          |    8
 tests/mkdir/special-1        |    8
 tests/mv/partition-perm      |    2
 tests/selinux                |   24 +
 57 files changed, 2296 insertions(+), 108 deletions(-)


2007-03-30  Jim Meyering  <jim@meyering.net>

	* ChangeLog-selinux: Remove file.
	Move its contents into this file, removing old dates.

	* src/runcon.c (main): Don't reorder arguments.  Reported by
	Ulrich Drepper in <http://bugzilla.redhat.com/232652>.
	* tests/misc/runcon-no-reorder: New file.  Test for the above.
	* tests/misc/Makefile.am (TESTS): Add runcon-no-reorder.

	* src/runcon.c (main): Remove "." at end of a diagnostic.

	* src/runcon.c: New program.
	* src/Makefile.am (bin_PROGRAMS): Add runcon.
	(runcon_LDADD): Define.
	* README: Add runcon to the list of programs.
	* AUTHORS: Add this: runcon: Russell Coker
	* tests/help-version: Add runcon as an exception.
	* man/Makefile.am (dist_man_MANS): Add runcon.1.
	(runcon.1): New dependency.

	mkfifo, mknod: Accept new "-Z, --context=C" option.
	* src/mkfifo.c, src/mknod.c: Include <selinux/selinux.h>.
	(main): Honor it.
	* src/Makefile.am (mkfifo_LDADD, mknod_LDADD): Use $(LIB_SELINUX).

	mkdir: Accept new "-Z, --context=C" option.
	* src/mkdir.c: Include <selinux/selinux.h>.
	(main): Honor it.
	* src/Makefile.am (mkdir_LDADD): Use $(LIB_SELINUX).

	* tests/cp/cp-a-selinux: New file.  Test for the bug reported in
	<http://bugzilla.redhat.com/219900>.
	* tests/cp/Makefile.am (TESTS): Add cp-a-selinux.

	* tests/selinux: New file.
	* tests/Makefile.am (EXTRA_DIST): Add selinux.
	* tests/misc/selinux: Source the new script, rather than open coding it.

	Change how "cp -a" and "cp --preserve=context" work with SELinux.
	Now, cp -a attempts to preserve context, but failure to do so does
	not change cp's exit status.  However "cp --preserve=context" is
	similar, but failure *does* cause cp to exit with nonzero status.
	* src/copy.h (struct cp_options) [require_preserve_context]: New member.
	* src/copy.c (copy_reg, copy_internal): Implement the above.
	* src/mv.c (cp_option_init): Initialize the new member.
	* src/install.c (cp_option_init): Likewise.
	* src/cp.c (cp_option_init): Likewise.
	(decode_preserve_arg): Set it or reset it.

	cp, mv, install: add SELinux support, but unlike with the Red Hat
	patch, mv and cp do not provide the "-Z context" option.
	* src/copy.c: Include <selinux/selinux.h>.
	(restore_default_fscreatecon): New function.
	(copy_reg): Make cp --preserve=context work for existing destination.
	(copy_internal): Likewise for new destinations.
	* src/copy.h (cp_options) [preserve_security_context]: New member.
	* src/cp.c: Include <selinux/selinux.h>.
	(selinux_enabled): New global.
	(usage): Mention new --preserve=context option.
	(PRESERVE_CONTEXT): Define/use.
	(decode_preserve_arg): Handle PRESERVE_CONTEXT.
	(main): Remove an obsolete comment.
	If --preserve=context is specified on a system without SELinux
	enabled, give a diagnostic and fail.
	* src/mv.c: Include <selinux/selinux.h>.
	Set x->preserve_security_context if SELinux is enabled.
	* src/install.c: Accept new "-Z, --context=C" option.
	Accept --preserve-context option (but not -P option).
	Accept alternate spelling: --preserve_context, for now.
	Include <selinux/selinux.h> and "quotearg.h".
	(selinux_enabled, use_default_selinux_context): New globals.
	(PRESERVE_CONTEXT_OPTION): Define.
	(cp_option_init): Default: do not preserve security context.
	(setdefaultfilecon): New function.
	(main): Honor new options.
	* src/Makefile.am (mv_LDADD, cp_LDADD, ginstall_LDADD):
	Add $(LIB_SELINUX).
	* src/system.h (GETOPT_SELINUX_CONTEXT_OPTION_DECL): Define.

	* tests/misc/selinux [VERBOSE]: Print version info for each
	of the tested tools, not just ls.

	* src/c99-to-c89.diff: Remove the ls.c patch, now that I've
	temporarily removed the offending c99'ism.

	* src/chcon.c (usage): Split a string literal that was longer than 509.

	* src/ls.c (gobble_file): Don't call getfilecon unless print_scontext.
	Upon failed getfilecon, accept not just ENOTSUP, but also ENODATA.

	* src/c99-to-c89.diff: Adjust offsets.

	* AUTHORS: Add chcon.

	* src/c99-to-c89.diff: Remove trailing blanks.

	* src/chcon.c: Don't include "dirname.h".  system.h already includes it.

	* gl/lib/selinux-at.c: Remove a use of HAVE_CONFIG_H.

	* src/c99-to-c89.diff: Handle a new c99'ism in ls.c.

	* src/id.c (main): Tweak id -Z diagnostic.

	id: Add SELinux support: -Z option.
	* src/id.c (main): Apply patches from Fedora, with these changes:
	Remove #ifdef WITH_SELINUX.
	Use error (EXIT_FAILURE, not fprintf+exit(1).
	* src/Makefile.am (id_LDADD): Define, so as to add $(LIB_SELINUX).

	stat: Add support for SELinux in the form of a %C format directive.
	* src/stat.c (follow_links): Make this variable file-global.
	(out_file_context): New function.
	(print_statfs): Honor %C.
	(print_stat): Honor %C.
	(do_stat): Remove follow_links parameter.
	(usage): Document the two %C directives.
	(main): Accept -Z (though it's a no-op).
	* src/Makefile.am (stat_LDADD): Define.

	ls: Add support for SELinux and a slightly modified -Z option.
	I started with the patches from Red Hat.
	The entries below tell how the code evolved.

	* src/ls.c (print_long_format, print_file_name_and_frills): When
	there is no security context (due to getfilecon/lgetfilecon failing
	with e.g. ENOTSUP), print it as "?", not "".
	* src/ls.c (print_file_name_and_frills): Make -Z work without -l.
	(length_of_file_name_and_frills): Likewise.

	* src/ls.c: Remove the --lcontext and --scontext options.
	Change the way -Z, --context work so that it no longer implies -l.
	Thus, -Z -l will work like -lcontext and -Z without -l will work
	like --scontext.

	Adjust tests to reflect new 'ls -l' syntax -- affects only
	systems with SELinux when operating on a file with no ACL.
	These tests assumed that everything before the first space on
	each line is the 10-byte mode string.  But there may also be a "+"
	in the 11th column, just before the space.  However, note that this
	is not new.  The same thing would have happened even without the
	change below, when listing a file with an ACL.
	* tests/chmod/equals, tests/cp/cp-parents, tests/cp/fail-perm:
	* tests/cp/link-preserve, tests/install/basic-1, tests/misc/mknod:
	* tests/mkdir/parents, tests/mkdir/special-1, tests/mv/partition-perm:

	Don't make compilation depend on USE_ACL.  An SELinux security
	context counts as an "alternate access control method", so ls
	must output a "+" for each file with a security context.
	* src/ls.c [struct fileinfo] (have_acl): Declare unconditionally.
	(FILE_HAS_ACL): Remove macro definition.  Use f->have_acl directly.
	(gobble_file): Record whether a file has a security context, and
	update the condition used to determine whether to print the "+".
	(gobble_file): Call getfilecon/lgetfilecon also when
	format == long_format, so that we get the "+".

	* src/ls.c (gobble_file): Add a comment explaining why (with a
	security context option) ls doesn't exit nonzero due to e.g.,
	getfilecon failing with errno == ENOTSUP.

	* src/ls.c (gobble_file): Ignore failure of getfilecon if it's due
	to ENOTSUP.

	* src/ls.c (gobble_file): Factor out three small blocks using
	getfilecon and lgetfilecon.
	Don't ignore return value from getfilecon and lgetfilecon.

	* src/ls.c (print_long_format): Don't use ?: (empty 2nd arg with C
	ternary operator).
	(print_scontext_format): Likewise.
	(print_scontext): Declare to be "bool", not int.  Adjust uses.

	* src/Makefile.am (dir_LDADD, ls_LDADD, vdir_LDADD): Add $(LIB_SELINUX).

	* tests/misc/chcon: New file.
	* tests/misc/chcon-fail: New file.
	* tests/Makefile.am (check-root): Run new, root-only misc/chcon test.
	* tests/misc/Makefile.am (TESTS): Add chcon and chcon-fail.

	* tests/misc/Makefile.am (TESTS): Add selinux.
	* tests/misc/selinux: New file.
	* tests/help-version: Skip chcon.
	* man/chcon.x: New file.
	* man/Makefile.am: Build chcon.1.

	New program: chcon
	* gl/modules/selinux-at: New module.  Check for libselinux and set
	LIB_SELINUX here, unconditionally, rather than depending on
	the configure-time --enable-selinux option.
	* gl/modules/selinux-h: New module.
	* bootstrap.conf (gnulib_modules): Add selinux-at.
	* gl/lib/selinux-at.c, gl/lib/selinux-at.h: New files.
	* gl/lib/se-selinux_.h: New file.
	* gl/lib/se-context_.h: New file.
	* gl/m4/selinux-selinux-h.m4: New file.
	* gl/m4/selinux-context-h.m4: New file.
	* src/Makefile.am (bin_PROGRAMS): Add chcon.
	(chcon_LDADD): Define.
	* README: Add chcon to the list of programs.
	* src/chcon.c: Rewrite the original (Red Hat) chcon to use fts.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
