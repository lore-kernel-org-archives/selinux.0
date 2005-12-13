Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jBDK0EMA000809
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 15:00:14 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id jBDJpbN7002705
	for <selinux@tycho.nsa.gov>; Tue, 13 Dec 2005 19:51:37 GMT
Subject: Re: Updated policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <439A671E.8040804@redhat.com>
References: <439A671E.8040804@redhat.com>
Content-Type: text/plain
Date: Tue, 13 Dec 2005 14:51:30 -0500
Message-Id: <1134503490.4936.19.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, 2005-12-10 at 00:26 -0500, Daniel J Walsh wrote:
> Added booleans to turn on httpd connecting to mysql/postgres as well as 
> relay.

merged.

> nis_signal_ypbind requires you to be able to read pidfile.

Not going to merge this, for a couple reasons.  First, it would still be
good to have an interface that allows just the signal, for the case that
the signaler already knows the PID.  Second, it introduces a large info
flow backchannel, since ypbid can write it's pid file.  This is a
candidate for a more abstract interface whose implementation would be to
call the signal interface and the read pid interface.

> mount command wants access to tty

This sounds specific to targeted since its devpts_t, shouldn't it be in
a ifdef(`targeted_policy' ?

>  needs to be able to search rpc_pipefs 
> in Fedora.

Added an interface to handle this, rather than the raw rule.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
