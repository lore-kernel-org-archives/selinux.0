Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7AADTRJ032411
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 06:13:29 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7AADJFH010917
	for <selinux@tycho.nsa.gov>; Thu, 10 Aug 2006 10:13:20 GMT
From: Jim Meyering <jim@meyering.net>
To: selinux@tycho.nsa.gov
Subject: does mv need a --context=CTX (-Z) option, too?
Date: Thu, 10 Aug 2006 12:13:27 +0200
Message-ID: <87hd0kc308.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

It might make sense to add a --context=CTX (-Z) option to mv.  Currently,
cp, install, mkdir, mknod, mkfifo all have that option, but not mv.
Most of the time, mv would have no need, since it simply calls rename.
But when that fails, it reverts to using the very same copying code
(copy.c) that cp uses.  It is trivial to add this option to mv, with the
understanding that it'd take effect solely for e.g., cross-device moves.
I.e., if you want to simulate a cross device move, you'd have to use
cp -pr and rm -rf, so if it makes sense for cp to have the --context=CTX
(-Z) option, then it follows that mv must accept it as well.

This brings up another minor inconsistency: should the other
named-file-creation programs (dd, ln, link, touch) in coreutils also
accept the --context=CTX (-Z) option?

With that only partly rhetorical question, you should see why I'd like
an selinux/kernel hook that'd let me set the default fscreate context
for the upcoming execve.  Then I could simply add one option to runcon
and forget about all of these "-Z CTX" options.  IMHO, requiring all of
these tools to add an option like "-Z CTX" to perform the same simple
function is almost prohibitively onerous.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
