Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA03830
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 08:00:04 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA27216
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 12:59:14 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzband.ncsc.mil  with ESMTP id MAA27212
	for <selinux@tycho.nsa.gov>; Thu, 17 Jan 2002 12:59:13 GMT
Date: Thu, 17 Jan 2002 07:59:56 -0500 (EST)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: 2.4.17 support?
In-Reply-To: <20020116223308.8F7D715BBF@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0201170754570.18610-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 16 Jan 2002, Russell Coker wrote:

> The latest kernel patch for 2.4.17 from immunix uses version 8 of the Policy
> DB, while the latest utilities on the NSA site are clearly designed for
> version 7 only (compile errors when trying to compile with version 8 headers).

The NSA SELinux web site states that you should use the version of the LSM
kernel patch that is on it, since the one from lsm.immunix.org may not
always be compatible.  The policydb change was pushed to the
lsm.immunix.org tree (with a comment in the ChangeLog about the need for a
corresponding patch to the checkpolicy program) in preparation for a new
SELinux release on the NSA web site.  So just be patient and wait for the
new release.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
