Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA04346
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 15:27:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id TAA03853
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 19:25:58 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
	by jazzswing.ncsc.mil  with ESMTP id TAA03849
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 19:25:58 GMT
Date: Fri, 27 Sep 2002 15:27:00 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: patch to remove initrd support
In-Reply-To: <200209261340.23623.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209271526170.11942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 26 Sep 2002, Russell Coker wrote:

> The attached patch removes initrd support from policy/Makefile as it's just
> been obsoleted by Steve's recent kernel patches.

Thanks, merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
