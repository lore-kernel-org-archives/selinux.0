Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n466ho4O005470
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 02:44:18 -0400
Received: from ladon.golden-gryphon.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id n466hjI3029848
	for <selinux@tycho.nsa.gov>; Wed, 6 May 2009 06:43:50 GMT
From: Manoj Srivastava <srivasta@golden-gryphon.com>
To: selinux@tycho.nsa.gov
Cc: 505920-forwarded@bgs.debian.org, Kees Cook <kees@debian.org>,
        505920-submitter@bugs.debian.org,
        selinux-devel-owner@lists.alioth.debian.org
Subject: Problems with freeing thread local storage in libselinux
Date: Wed, 06 May 2009 01:32:13 -0500
Message-ID: <8763geivwy.fsf@anzu.internal.golden-gryphon.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--=-=-=

Hi folks,

        There have been numerous reports in Debian and derivatives of
 programs linked with libselinux intermittently getting segfaults.
 There is, for instance, the Debian report 505920[0], and Ubuntu
 reports[1], [3] and [5], and Gnome [2]. I have not been able to
 reproduce the error myself, though I have run the test cases a number
 of times.

        The common thread in unclutter, libavg, gst-inspect et al. is a
 segmentation fault in libselinux1, in the 'fini' destructor functions,
 referencing the thread local variables.

        The Ubuntu bug log reference my old patch for libselinux from
 1.X days, where I replaced the thread local storage with regular
 variables and mutexes, and people report success with that.  I suspect
 that something is corrupting the thread local storage. From the ubuntu
 report:
--8<---------------cut here---------------start------------->8---
Valgrind reports:
=29183== Invalid read of size 8
==29183== at 0xE29B9DD: fini_context_translations (setrans_client.c:211)
==29183== by 0xE28F1F1: (within /lib/libselinux.so.1)
==29183== by 0xE29D040: (within /lib/libselinux.so.1)
==29183== by 0x570010F: exit (exit.c:75)
505920==29183== by 0x56E91CA: (below main) (libc-start.c:252)
==29183== Address 0x80 is not stack'd, malloc'd or (recently) free'd
==29183==
==29183== Process terminating with default action of signal 11 (SIGSEGV): dumping core
==29183== Access not within mapped region at address 0x80
==29183== at 0xE29B9DD: fini_context_translations (setrans_client.c:211)
==29183== by 0xE28F1F1: (within /lib/libselinux.so.1)
==29183== by 0xE29D040: (within /lib/libselinux.so.1)==29183== by 0x570010F: exit (exit.c:75)
==29183== by 0x56E91CA: (below main) (libc-start.c:252)


(gdb) bt
#0 0x00007f3ae812a9dd in fini_context_translations () at setrans_client.c:211
#1 0x00007f3ae811e1f2 in __do_global_dtors_aux () from /lib/libselinux.so.1
#2 0x00007ffff9097700 in ?? ()
#3 0x00007f3ae812c041 in _fini () from /lib/libselinux.so.1
#4 0x00007ffff9097700 in ?? ()
#5 0x00007f3af0e88796 in _dl_fini () from /lib64/ld-linux-x86-64.so.2
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
--8<---------------cut here---------------end--------------->8---

        There have been two sets of patches proposed for this; first one
 merely initializes the variables in the init function, and this works
 for a number of people, but at least one person has reported a second
 segfault even with the patch installed[6]

        The second patch below converts a thread local cache to a
 process wide cache, with mutex guards, which makes the cache slower,
 and non-thread local caches means that cache misses are more likely.

        I'll try and follow up with people who can reproduce the
 problems to see if either one of the patches solve their problems
 without triggering other segmentation faults, but I'd appreciate
 comments if anyone has insight into the issue.

        manoj

[0] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=505920
[1] http://bugs.launchpad.net/ubuntu/+source/libselinux/+bug/237156  
[2] http://mail.gnome.org/archives/gnome-shell-list/2008-November/msg00001.html
[3] https://bugs.launchpad.net/ubuntu/+source/nspluginwrapper/+bug/357965
[4] https://bugs.launchpad.net/ubuntu/+source/libselinux/+bug/237156/comments/6
[5] https://bugs.launchpad.net/ubuntu/+source/libselinux/+bug/99949



--=-=-=
Content-Type: text/x-diff
Content-Disposition: attachment;
 filename=0001--init-static-variables-Initialize-thread-variable.patch
Content-Description: First patch, initialize variables


--=-=-=--
