Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA18176
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 17:16:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA12995
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 22:13:36 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id WAA12990
	for <selinux@tycho.nsa.gov>; Thu, 16 Jan 2003 22:13:34 GMT
Date: Fri, 17 Jan 2003 09:16:05 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>, Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
Subject: Re: version mismatch in Debian packages
Message-ID: <20030116221605.GA13472@snoopy.apana.org.au>
References: <20030116160010.A2883@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030116160010.A2883@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jan 16, 2003 at 04:00:10PM +0100, Tom wrote:
> I'm doing a clean install today and noticed a version mismatch in the
> Debian packages at Brian's site.
> 
> The tools seem to be compiled to version 12, but the lsm patch for
> kernel 2.4.18 is version 11. The patches for 2.4.19 and 2.4.20 are
> version 12, it's only the 2.4.18 that is affected.

I think 2.4.18 is no longer supported anymore. The patch should probably
get deleted from the package. Russell?

> This is ugly because woody doesn't contain source packages for 19 or
> 20, only for 2.4.18

You could use the prepatched kernels (source and image) already
on my website...

Both 2.4.19 and 2.4.20 are available, although I haven't yet been able
to test 2.4.20 properly, one of my computers is very unstable with
2.4.20, and I am not yet certain why. It could be hardware related, but
it sure is weird that is only crashes with 2.4.20, and never crashed
yet with 2.4.19.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
