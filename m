Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA05979
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 08:54:07 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id MAA23002
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 12:53:56 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id MAA22991
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 12:53:56 GMT
Date: Mon, 3 Jun 2002 08:53:10 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: Howard Holm <hdholm@epoch.ncsc.mil>, <selinux@tycho.nsa.gov>
Subject: Re: Updated Release
In-Reply-To: <20020601233729.77D2870C9@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0206030849470.25105-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Sat, 1 Jun 2002, Russell Coker wrote:

> For 2.4.18 the kernel patch doesn't have the recent patches for
> security_get_sids or the patch for sleeping allocation during a policy load.

I'm not sure what you mean.  I just downloaded the complete lsm-2.4 tree
and the lsm patch from the NSA SELinux web site, and they did include
these patches.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
