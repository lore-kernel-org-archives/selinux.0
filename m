Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA13798
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2001 08:40:37 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA20401
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2001 12:38:59 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA20397
	for <selinux@tycho.nsa.gov>; Wed, 26 Sep 2001 12:38:58 GMT
Date: Wed, 26 Sep 2001 08:39:40 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "Brian L. Simonin" <brian.simonin@ghg.net>
cc: National Security Agency <selinux@tycho.nsa.gov>
Subject: Re: Questions on the NSA and use of SELinux
In-Reply-To: <000001c14631$24f803a0$e931a718@simoninxp>
Message-ID: <Pine.SOL.3.95.1010926082910.15614F-100000@clipper.gw.tislabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 25 Sep 2001, Brian L. Simonin wrote:

> On a secondary note, I noted that the an updated Kernel (2.4.10) just
> got released. What is the usual time delay from a new Kernel release to
> the incorporation into SELinux?

Naturally, it varies depending on the nature and extent of the changes
to the kernel.  However, the time delay should typically be shorter
now that we are using the LSM kernel patch, because Greg K-H typically
tracks the kernel pre-releases as they occur and is able to update
to new stable releases very quickly.  I think that Greg updated the LSM
kernel patch the same day that 2.4.10 was released (Sunday Sep 23rd), and
we updated SELinux (internally) on Monday Sep 24th.  A new release based
on 2.4.10 should be available soon on the web site.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
