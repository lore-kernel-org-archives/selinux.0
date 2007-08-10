Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7ACD26o028786
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 08:13:02 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7ACD01t019292
	for <selinux@tycho.nsa.gov>; Fri, 10 Aug 2007 12:13:00 GMT
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: text/plain; charset="iso-8859-1"
Date: Fri, 10 Aug 2007 14:12:59 +0200
From: selinux770@tortenboxer.de
In-Reply-To: <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <20070810121259.128050@gmx.net>
MIME-Version: 1.0
References: <20070810101003.128080@gmx.net>
 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
Subject: Re: wrong magic number (using old sources)
To: selinux@tycho.nsa.gov
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> You should be able to use the latest selinux userland even if using an
> older kernel; newer userlands can still generate older kernel policy
> formats.

The current stable userlands don't compile in my environment.
First, libselinux-1.34.7 throws a compiler error which seems to be caused by a gcc bug:
cc  -shared -o libselinux.so.1 avc.lo avc_internal.lo avc_sidtab.lo booleans.lo canonicalize_context.lo checkAccess.lo check_context.lo compute_av.lo compute_cr eate.lo compute_member.lo compute_relabel.lo compute_user.lo context.lo disable. lo enabled.lo fgetfilecon.lo freecon.lo freeconary.lo fsetfilecon.lo get_context _list.lo get_default_type.lo getenforce.lo getfilecon.lo getpeercon.lo init.lo i s_customizable_type.lo lgetfilecon.lo load_policy.lo lsetfilecon.lo matchmediaco n.lo matchpathcon.lo policyvers.lo procattr.lo query_user_context.lo rpm.lo seli nux_check_securetty_context.lo selinux_config.lo setenforce.lo setfilecon.lo set rans_client.lo seusers.lo -ldl -lsepol -L/usr/lib -Wl,-soname,libselinux.so.1,-z ,defs,-z,relro
matchpathcon.lo: In function `set_matchpathcon_flags':matchpathcon.c:(.text+0x27 0): undefined reference to `__tls_get_addr'
matchpathcon.lo: In function `process_line':matchpathcon.c:(.text+0x1cf0): undef ined reference to `__tls_get_addr'
matchpathcon.lo: In function `matchpathcon_init_prefix':matchpathcon.c:(.text+0x 1fdc): undefined reference to `__tls_get_addr'
matchpathcon.lo: In function `matchpathcon':matchpathcon.c:(.text+0x2eb0): undef ined reference to `__tls_get_addr'
matchpathcon.lo: In function `selinux_file_context_verify':matchpathcon.c:(.text +0x3400): undefined reference to `__tls_get_addr'
matchpathcon.lo:matchpathcon.c:(.text+0x3468): more undefined references to `__t ls_get_addr' follow
collect2: ld returned 1 exit status
make[1]: *** [libselinux.so.1] Error 1

It could be solved by removing -z,defs from the src/Makefile. I don't know the consequences but it works.

Second, the policycoreutils-1.34-6 won't compile because of a missing header file, which is not existent in my environment:
cc -g -Werror -Wall -W -I/usr/include -D_FILE_OFFSET_BITS=64   -c -o restorecond.o restorecond.c
restorecond.c:44:25: sys/inotify.h: No such file or directory
restorecond.c: In function `watch_list_free':
restorecond.c:144: warning: implicit declaration of function `inotify_rm_watch'
restorecond.c: In function `read_config':
restorecond.c:283: warning: implicit declaration of function `inotify_add_watch'
restorecond.c:283: error: `IN_MOVED_FROM' undeclared (first use in this function)
restorecond.c:283: error: (Each undeclared identifier is reported only once
restorecond.c:283: error: for each function it appears in.)
restorecond.c:283: error: `IN_MODIFY' undeclared (first use in this function)
restorecond.c: In function `watch':
restorecond.c:291: error: invalid application of `sizeof' to incomplete type `inotify_event'
restorecond.c:293: error: invalid application of `sizeof' to incomplete type `inotify_event'
restorecond.c:309: error: dereferencing pointer to incomplete type
restorecond.c:309: error: dereferencing pointer to incomplete type
restorecond.c:310: error: dereferencing pointer to incomplete type
restorecond.c:310: error: dereferencing pointer to incomplete type
restorecond.c:311: error: dereferencing pointer to incomplete type
restorecond.c:314: error: dereferencing pointer to incomplete type
restorecond.c:316: error: dereferencing pointer to incomplete type
restorecond.c:317: error: dereferencing pointer to incomplete type
restorecond.c:317: error: dereferencing pointer to incomplete type
restorecond.c:329: error: invalid application of `sizeof' to incomplete type `inotify_event'
restorecond.c:329: error: dereferencing pointer to incomplete type
restorecond.c: In function `watch_list_add':
restorecond.c:412: error: `IN_CREATE' undeclared (first use in this function)
restorecond.c:412: error: `IN_MOVED_TO' undeclared (first use in this function)
restorecond.c: In function `main':
restorecond.c:456: warning: implicit declaration of function `inotify_init'
restorecond.c:484: warning: implicit declaration of function `matchpathcon_fini'
make[1]: *** [restorecond.o] Error 1

That's why I'm using the old sources. They work.

> Those versions are consistent with one another.
> Kernel version?  Policy version?
kernel version is 2.6.16-omap1
How do I find out the policy version?


-- 
Psssst! Schon vom neuen GMX MultiMessenger gehört?
Der kanns mit allen: http://www.gmx.net/de/go/multimessenger


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
