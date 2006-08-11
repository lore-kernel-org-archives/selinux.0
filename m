Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7BDwPkQ004222
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 09:58:25 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7BDwFmM015035
	for <selinux@tycho.nsa.gov>; Fri, 11 Aug 2006 13:58:15 GMT
From: Jim Meyering <jim@meyering.net>
To: selinux@tycho.nsa.gov
Cc: Russell Coker <russell@coker.com.au>
Subject: justifying --context=CTX (-Z) for upstream coreutils, like mkdir
Date: Fri, 11 Aug 2006 15:58:23 +0200
Message-ID: <87mzabgyrk.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello again,

With clear agreement that neither cp nor mv needs the --context=CTX (-Z)
option, I am nearly convinced that the this option does not belong in any
other program in upstream coreutils.  [of course, I expect it to remain
in RHEL and probably in Fedora for some time]  Upstream coreutils will
display contexts (stat, ls, uname), and preserve them (cp, mv, install?),
and add chcon+runcon, but that's all.

For a little context on why, ...
I'm also considering the xattr patch that's been floating around for
years.  Currently it's part of SuSE's coreutils patch set.  It ensures
that mv and cp -p preserve any (selected) XATTR attributes.  There is
no option to let install(1) apply XATTR attributes.  Nor mkdir, mkfifo,
mknod.  Similarly for the ACL support that's widely available, there is
no option to let those programs apply a specified ACL.  Why should
SELinux security contexts be treated differently?

I do understand the race condition argument, but any sysadmin who is
silly enough to create new files in such a way that those races matter,
deserves whatever s/he gets.  If a destination file really must be in a
vulnerable place, it's not so hard to create it first in a safe place,
apply any necessary context via chcon, and then `install' them via rename.

Am I missing some justification for why e.g., mkdir should have the
option?  Yes, it does accept --mode=M (-m), but is that enough to
justify the SELinux---ACL/XATTR dichotomy?  Not to me.  But I'm
willing to be educated :)

BTW, what makes install so special that it needs to call matchpathcon?
Can it accomplish the same goal via "chcon ...;
install --preserve-context ..."?

Thanks for your feedback,

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
