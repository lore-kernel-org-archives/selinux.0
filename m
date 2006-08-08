Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k78DGld7032690
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 09:16:47 -0400
Received: from mx.meyering.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k78DGcGM011958
	for <selinux@tycho.nsa.gov>; Tue, 8 Aug 2006 13:16:39 GMT
From: Jim Meyering <jim@meyering.net>
To: selinux@tycho.nsa.gov
Subject: setexeccon vs. setfscreatecon
Date: Tue, 08 Aug 2006 15:16:13 +0200
Message-ID: <87u04ncqqq.fsf@rho.meyering.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I see that setexeccon sets the context to be used for next execve call.
And then there's setfscreatecon.  I want something similar that sets
the fscreate context for the next execve call.  Does such a function exist?
Is there some other way to do what I want?

In case you're wondering, here's my motivation: I'm merging some
coreutils selinux changes into upstream and noticed that they would break
thread-safety in coreutils' copying engine, src/copy.c -- because they
introduce calls to setfscreatecon.  From reading the man page for that
function, I gather that the fscreate-context is a per-process attribute.
As such (like umask and cwd), changing it affects all threads, and its
use should be avoided in library-esque code.

What I would like to do is merge the context-printing and
context-preserving parts of that patch, but not the context-setting
parts (--context=CTX in cp, mkdir, mkfifo, mknod, install).  Instead,
I'm trying to add an option to runcon that would let me also set the
fscreate context for the process it runs.  Then, all of the individual
context-setting options would be unnecessary.

Does this sound reasonable?  Feasible?

Thanks,

Jim

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
