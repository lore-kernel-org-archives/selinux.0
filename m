Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA02249
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 09:46:38 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA03464
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 13:46:13 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id NAA03460
	for <selinux@tycho.nsa.gov>; Mon, 24 Jun 2002 13:46:13 GMT
Date: Mon, 24 Jun 2002 09:45:58 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Oren Abe-P27525 <Abe.Oren@gd-decisionsystems.com>
cc: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: SE Linux loading procedure.
In-Reply-To: <685C998FC4F39E48ABC93EABA534DEBD5690CA@AZ25EXM01N2.gddsi.com>
Message-ID: <Pine.GSO.4.33.0206240944170.10386-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Fri, 21 Jun 2002, Oren Abe-P27525 wrote:

> Do you (or anybody) have a flow chart(s)
> describe the SE Linux loading sequence.
>
> Something like step-by-step of the main
> modules and procedures that loads into the
> memory during the boot process ?

I'm not aware of any such flow chart for SELinux.  But keep in mind that
the SELinux kernel is merely a modified form of the Linux kernel
(Linux+the LSM kernel patch+the SELinux kernel module).

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
