Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA18204
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 07:47:49 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA11592
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:45:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA11588
	for <selinux@tycho.nsa.gov>; Tue, 29 Oct 2002 12:45:56 GMT
Date: Tue, 29 Oct 2002 07:47:08 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Tom <tom@lemuria.org>
cc: <selinux@tycho.nsa.gov>
Subject: Re: patches to policy question
In-Reply-To: <20021029131543.C24527@lemuria.org>
Message-ID: <Pine.GSO.4.33.0210290743010.29605-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 29 Oct 2002, Tom wrote:

> I've posted a few patches against Russell's default policy, but I've
> started to wonder about the general workflow.
>
> Is Russell's policy worked into the NSA CVS, so the workflow would be
> 3rd Part -> Russell -> NSA ?
> Or would it be better if I (or anyone else) would also diff changes
> against the latest NSA release and post those patches?
>
> Is posting here the right way to submit patches anyway?

Yes, posting here is the right way to submit patches.  Russell does submit
policy patches to us for merging, but we also consider other directly
submitted policy patches.  A diff against the sourceforge selinux CVS tree
is optimal for us, but may not always be reasonable for Debian selinux
users if the Debian policy deviates too much.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
