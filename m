Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA04392
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 15:29:31 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA10543
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 19:27:44 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id TAA10539 for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 19:27:44 GMT
Date: Fri, 27 Sep 2002 15:28:41 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: <selinux@tycho.nsa.gov>
Subject: Re: big patch
In-Reply-To: <200209261418.25737.russell@coker.com.au>
Message-ID: <Pine.GSO.4.33.0209271527330.11942-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 26 Sep 2002, Russell Coker wrote:

> I've attached a patch that contains everything in my tree that I am certain is
> worthy of inclusion.
>
> I have removed the things that Steve doesn't like, and I haven't included some
> new .te files.
>
> This patch applies against the sourceforge CVS, for Debian systems at least it
> contains some changes that are necessary for the latest kernel patch.

Thanks, merged, except for granting daemon's access to admin ttys.
The file_t change has also been merged.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
