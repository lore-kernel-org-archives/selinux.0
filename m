Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA22653
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 08:48:29 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA22784
	for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 12:46:47 GMT
Received: from sentry.gw.tislabs.com (sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA22780 for <selinux@tycho.nsa.gov>; Thu, 29 Aug 2002 12:46:47 GMT
Date: Thu, 29 Aug 2002 08:48:15 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: "M. H." <metalhead00@hotmail.com>
cc: <selinux@tycho.nsa.gov>
Subject: Re: building libsecure.a advice
In-Reply-To: <F255oHMwVN7miR9Odut0000011b@hotmail.com>
Message-ID: <Pine.GSO.4.33.0208290846260.2189-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Wed, 28 Aug 2002, M. H. wrote:

> I may be missing something but running 'make install' from selinux/module
> fails (complains about missing asm/flask files.)
> Are you saying that doing 'make install' from selinux/module followed by
> make in selinux/libsecure is sufficient to compile the library (and place
> the appropriate headers in /usr/local/selinux...)?

Good point.  The 'make install' in selinux/module expects that the
lsm-2.4/include/asm and the lsm-2.4/security/selinux/include/asm symlinks
have already been created by the kernel build.  I suppose we could have
the selinux/module Makefile create the symlinks if they do not exist.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
