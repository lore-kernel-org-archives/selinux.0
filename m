Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id HAA05453
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 07:40:15 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id LAA11834
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 11:39:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id LAA11830
	for <selinux@tycho.nsa.gov>; Thu, 13 Jun 2002 11:39:58 GMT
Date: Thu, 13 Jun 2002 07:39:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <linux-security-module@wirex.com>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: XFS and LSM
In-Reply-To: <20020613104731.CF50F1F09@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206130737180.23212-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 13 Jun 2002, Russell Coker wrote:

> BTW  XFS also changes the quota system in a serious way which breaks SE Linux
> (not LSM).

The changes to the quota code have already been merged into 2.5, and the
2.5 SELinux module in BitKeeeper has already been updated for those
changes.  You can backport the quotactl hook from the 2.5 SELinux module.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
