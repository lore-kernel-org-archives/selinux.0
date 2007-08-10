Subject: Re: wrong magic number (using old sources)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: selinux770@tortenboxer.de
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20070810121259.128050@gmx.net>
References: <20070810101003.128080@gmx.net>
	 <1186746338.7233.11.camel@moss-spartans.epoch.ncsc.mil>
	 <20070810121259.128050@gmx.net>
Content-Type: text/plain
Date: Fri, 10 Aug 2007 08:21:44 -0400
Message-Id: <1186748504.7233.34.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-08-10 at 14:12 +0200, selinux770@tortenboxer.de wrote:
> > You should be able to use the latest selinux userland even if using an
> > older kernel; newer userlands can still generate older kernel policy
> > formats.
> 
> The current stable userlands don't compile in my environment.
> First, libselinux-1.34.7 throws a compiler error which seems to be caused by a gcc bug:
> cc  -shared -o libselinux.so.1 avc.lo avc_internal.lo avc_sidtab.lo booleans.lo canonicalize_context.lo checkAccess.lo check_context.lo compute_av.lo compute_cr eate.lo compute_member.lo compute_relabel.lo compute_user.lo context.lo disable. lo enabled.lo fgetfilecon.lo freecon.lo freeconary.lo fsetfilecon.lo get_context _list.lo get_default_type.lo getenforce.lo getfilecon.lo getpeercon.lo init.lo i s_customizable_type.lo lgetfilecon.lo load_policy.lo lsetfilecon.lo matchmediaco n.lo matchpathcon.lo policyvers.lo procattr.lo query_user_context.lo rpm.lo seli nux_check_securetty_context.lo selinux_config.lo setenforce.lo setfilecon.lo set rans_client.lo seusers.lo -ldl -lsepol -L/usr/lib -Wl,-soname,libselinux.so.1,-z ,defs,-z,relro
> matchpathcon.lo: In function `set_matchpathcon_flags':matchpathcon.c:(.text+0x27 0): undefined reference to `__tls_get_addr'
> matchpathcon.lo: In function `process_line':matchpathcon.c:(.text+0x1cf0): undef ined reference to `__tls_get_addr'
> matchpathcon.lo: In function `matchpathcon_init_prefix':matchpathcon.c:(.text+0x 1fdc): undefined reference to `__tls_get_addr'
> matchpathcon.lo: In function `matchpathcon':matchpathcon.c:(.text+0x2eb0): undef ined reference to `__tls_get_addr'
> matchpathcon.lo: In function `selinux_file_context_verify':matchpathcon.c:(.text +0x3400): undefined reference to `__tls_get_addr'
> matchpathcon.lo:matchpathcon.c:(.text+0x3468): more undefined references to `__t ls_get_addr' follow
> collect2: ld returned 1 exit status
> make[1]: *** [libselinux.so.1] Error 1
> 
> It could be solved by removing -z,defs from the src/Makefile. I don't know the consequences but it works.

No, it depends on thread local storage support in your glibc.  Manoj was
using a workaround patch for it at one time for Debian,
http://marc.info/?l=selinux&m=115807948020898&w=2

> Second, the policycoreutils-1.34-6 won't compile because of a missing header file, which is not existent in my environment:
> cc -g -Werror -Wall -W -I/usr/include -D_FILE_OFFSET_BITS=64   -c -o restorecond.o restorecond.c
> restorecond.c:44:25: sys/inotify.h: No such file or directory

restorecond depends on inotify.  But you don't need restorecond to have
a working system, so you can always remove it from the Makefile SUBDIRS
definition.

> That's why I'm using the old sources. They work.

Well, except that they evidently don't.

> > Those versions are consistent with one another.
> > Kernel version?  Policy version?
> kernel version is 2.6.16-omap1
> How do I find out the policy version?

Same way you found out what package version you were using of
checkpolicy and friends, I assume.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
