Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA23293
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 09:36:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA17194
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:35:40 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil (8.9.1/8.9.1) with ESMTP id OAA17190
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 14:35:40 GMT
Received: from localhost by clipper.gw.tislabs.com (8.9.3/8.9.1) with SMTP id JAA27114
	for <selinux@tycho.nsa.gov>; Tue, 26 Dec 2000 09:35:15 -0500 (EST)
Date: Tue, 26 Dec 2000 09:35:15 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: selinux@tycho.nsa.gov
Subject: Re: Does this address the setuid() bug?
In-Reply-To: <3A44F97D.9E908172@worldnet.att.net>
Message-ID: <Pine.SOL.3.95.1001226091223.26114B-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
Reply-To: selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>


As mentioned by others, Security-Enhanced Linux does not
fix existing bugs in the Linux kernel but it does provide 
mandatory access controls that can confine the potential
damage that can be caused by such bugs.  The mandatory
access controls are orthogonal to the existing Linux
access control mechanism and are unaffected by the
Unix superuser identity or Linux capabilities.

--
Stephen D. Smalley, NAI Labs
sds@tislabs.com


On Sat, 23 Dec 2000, Bucky Goldstein wrote:

> Seeing as selinix is based on the 2.2.12 kernel, is it affected by the
> setuid() bug that plagued kernel versions < 2.2.15 ?
> 
> Sorry if this question has been asked before.
> 
> TIA,
> 
> Bucky Goldstein
> You have received this message because you are subscribed to the selinux list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
