Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02699
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 17:45:08 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA19768
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:43:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id WAA19763
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 22:43:14 GMT
Date: Wed, 30 Oct 2002 17:44:27 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: <selinux@tycho.nsa.gov>, <linux-security-module@wirex.com>
Subject: Re: SELinux Kernel Oops
In-Reply-To: <200210302230.RAA26019@moss-anteater.epoch.ncsc.mil>
Message-ID: <Pine.GSO.4.33.0210301742240.25777-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 30 Oct 2002, James W Carter wrote:

> I found a problem with SELinux on a 2.5.44 kernel generating a kernel Oops when
> running nfsd.

Just to clarify, the issue exists in both 2.4.19 and 2.5.44, and it is
relevant to the LSM patch, not just SELinux.  Without these patches,
private file structs will have NULL security fields.  We'd like to commit
these patches to the LSM BitKeeper trees as well.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
