Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id LAA24677
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 11:55:25 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id QAA06871
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 16:55:18 GMT
Received: from sentry.gw.tislabs.com (relay.hq.tis.com [192.94.214.100] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id QAA06867
	for <selinux@tycho.nsa.gov>; Tue, 6 Nov 2001 16:55:17 GMT
Date: Tue, 6 Nov 2001 11:54:23 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: "Timothy E. Kohler" <tim@odo.arl.psu.edu>
cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: Re: New SELinux release???
In-Reply-To: <3BE810A9.EAA3B410@odo.arl.psu.edu>
Message-ID: <Pine.GSO.4.33.0111061143140.11349-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 6 Nov 2001, Timothy E. Kohler wrote:

> Been trying to work with SELinux under RedHat 7.2.  I've
> had compile problems with utils/fileutils-4.0.  Everything
> worked fine under 7.1.  Get the following error:

We haven't tried SELinux with RedHat 7.2 yet, as I've previously mentioned
(http://marc.theaimsgroup.com/?l=selinux&m=100446361005413&w=2).  With
regard to fileutils, you might try upgrading to a newer set of base
sources (i.e. port the fileutils patch to the fileutils SRPM provided with
RedHat 7.2).  But note that you will still have to deal with the ext3
issue that I mentioned in my previous message.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
