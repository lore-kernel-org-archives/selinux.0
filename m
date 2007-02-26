Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QJUbOf018133
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 14:30:37 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l1QJVuW2023774
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 19:31:57 GMT
Subject: Re: Policy patch for hal
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <45DB27D7.7090604@redhat.com>
References: <45DB27D7.7090604@redhat.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 14:32:14 -0500
Message-Id: <1172518334.22224.16.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2007-02-20 at 11:54 -0500, Daniel J Walsh wrote:
> Hal now is changing the attributes of sound device and video devices so 
> userswitching can happen.
> 
> It reads and writes raw memory.

This is disappointing.  With this and raw disk access, hal is basically
unconfined.  Is there any chance we can figure out what these perms are
tied to so they could potentially be made conditional?

> It has a new cache directory where it wants to store stuff.
> 
> Needs to telinit to change runlevel.
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
