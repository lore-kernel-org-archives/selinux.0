Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qAKHrCgb019049
	for <selinux@tycho.nsa.gov>; Tue, 20 Nov 2012 12:53:12 -0500
From: Guillem Jover <guillem@debian.org>
To: selinux@tycho.nsa.gov
Cc: rpm-maint@lists.rpm.org, debian-dpkg@lists.debian.org
Subject: [PATCH RFC] Package script(let)s SELinux execution context
Date: Tue, 20 Nov 2012 16:27:54 +0100
Message-Id: <1353425275-10277-1-git-send-email-guillem@debian.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi!

Some context for the rpm folks. While looking into improving SELinux
support in dpkg, I noticed that dpkg is not setting a new execution
context when running the package maintainer scripts (package scriptlets
in rpm lingo, I think). And when checking how to implement it, it seemed
that reusing something like the current rpm_execcon() would be best,
and Stephen seemed to agree. For more details, see the thread starting
at <http://marc.info/?t=135236358700001&r=1&w=2>.

Having checked the rpm code, and the mailing list, it seems like this
new function would make it easy to be used there too for stuff like
the Lua scriptlets (if desired), and might make it easier also to
switch to the new rpm plugins framework (?).

I've discarded the verified argument for the new function because that
seemed best handled from the rpm side, and in any case seemed unrelated
to the execution context. I'm not entirely convinced about the function
name though, as it could be confused as applying a context to a path on
the filesystem. And I've not marked rpm_execcon() as deprecated because
it might be annoying at the beginning, but would change that if you think
it makes sense.

In any case, here's a patch adding such new function. For dpkg, given
that it has never set a new context up to now, I'd only make use of the
function if it's available in libselinux, as I don't think it's worth it
to ship an embedded copy. For rpm, I guess it could switch to use the
function also if available and fallback to rpm_execcon() otherwise. After
a while the rpm_execcon() function could be removed from libselinux, on
the next ABI break, as I understand was the plan anyway (?).

(The patch might not apply w/o the man page cleanup series.)

So, what do you think?

Thanks,
Guillem

Guillem Jover (1):
  libselinux: Refactor rpm_execcon into a new setexecfilecon()

 libselinux/Makefile                        |  3 +++
 libselinux/include/selinux/selinux.h       |  4 ++++
 libselinux/man/man3/getexeccon.3           | 23 ++++++++++++++++++++---
 libselinux/src/Makefile                    |  3 ---
 libselinux/src/{rpm.c => setexecfilecon.c} | 27 ++++++++++++++++++++-------
 5 files changed, 47 insertions(+), 13 deletions(-)
 rename libselinux/src/{rpm.c => setexecfilecon.c} (71%)

-- 
1.8.0


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
