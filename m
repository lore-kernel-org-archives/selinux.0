Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id IAA04077
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 08:33:59 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id MAA08289
	for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:32:49 GMT
Received: from sentry.gw.tislabs.com (firewall-user@sentry.gw.tislabs.com [192.94.214.100])
        by jazzband.ncsc.mil  with ESMTP id MAA08285 for <selinux@tycho.nsa.gov>; Thu, 18 Apr 2002 12:32:48 GMT
Date: Thu, 18 Apr 2002 08:33:13 -0400 (EDT)
From: Stephen Smalley <sds@tislabs.com>
To: Russell Coker <russell@coker.com.au>
cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: setfiles patch
In-Reply-To: <20020418030227.90487239FA@lyta.coker.com.au>
Message-ID: <Pine.GSO.4.33.0204180831400.26541-100000@raven>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Thu, 18 Apr 2002, Russell Coker wrote:

> I have attached a patch for setfiles which gives support for files larger
> than 2G on i386, and which changes the support for file names on stdin to use
> a "-s" option flag instead of specifying "-" as the partition name.
>
> The large file support is a bit of a quick hack, I need to have something
> like #ifdef i386 around the definition of _LARGEFILE64_SOURCE, or maybe some
> autoconf stuff.
>
> But it's quite functional as a sample, and if you have a i386 machine with
> some >2G files you'll probably be very happy with this patch.

setfiles should already work for large files.  The -D_FILE_OFFSET_BITS=64
flag in the Makefile CFLAGS definition causes stat structures and calls to
be transparently remapped to stat64.

--
Stephen D. Smalley, NAI Labs
ssmalley@nai.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
