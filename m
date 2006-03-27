Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2RFGM6Z014570
	for <selinux@tycho.nsa.gov>; Mon, 27 Mar 2006 10:16:22 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2RFEZ3e013886
	for <selinux@tycho.nsa.gov>; Mon, 27 Mar 2006 15:14:38 GMT
Subject: Re: mta=module not working, make 3.81-rc2 issues
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1143252807.9540.3.camel@wintermute.xmldesign.de>
References: <1143252807.9540.3.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 27 Mar 2006 10:16:18 -0500
Message-Id: <1143472578.3962.105.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2006-03-25 at 03:13 +0100, Erich Schubert wrote:
> first of all, mta=module does currently not work. A couple of modules
> (e.g. cron) call mta_something interfaces without an optional_policy()
> wrap around it.

This sounds like expected behavior to me.  We can't make everything
optional; cron emails output from the cron jobs to the user.  If you
feel some of these can be made optional, please let me know.

> Maybe we should put that optional_policy statement _into_ the interface
> def?

In general, putting optionals in interfaces should be avoided (there are
a few interfaces that do have optionals).  When users have an interface
call outside of an optional, the expected behavior is unconditional
dependency, but making an interface completely optional in the interface
definition would break this expectation.  The few interfaces currently
in refpolicy that do have optionals still have unconditional parts.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
