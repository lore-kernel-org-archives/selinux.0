Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA08261
	for <selinux@tycho.nsa.gov>; Fri, 13 Dec 2002 19:49:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id AAA25283
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 00:47:31 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id AAA25279
	for <selinux@tycho.nsa.gov>; Sat, 14 Dec 2002 00:47:29 GMT
Date: Sat, 14 Dec 2002 11:53:31 +1100
From: Brian May <bam@snoopy.apana.org.au>
To: Tom <tom@lemuria.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: new Debian packages
Message-ID: <20021214005331.GG13385@snoopy.apana.org.au>
References: <20021213223108.GA5424@lyta.coker.com.au> <20021214004206.D22479@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021214004206.D22479@lemuria.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sat, Dec 14, 2002 at 12:42:07AM +0100, Tom wrote:
> I'll be testing this next week. Any new kernels from Brian that I could
> give a shakedown while I'm at it? (I've hosed my test machine again.
> Must remember to be more careful. Will probably write a new chapter
> into my "things not to do with SELinux" paper. :) )

The latest patch I have, at the usual place, is for the 2.4.19
kernel.

It has at least one know security bug fixed in the kernel, plus lots
of patches I need from time to time (eg. EVMS, ACL, SE-Linux, FreeS/WAN,
DOV).

I am not sure if there are version of these patches that will work
with 2.4.20 yet, that is something I need to investigate (DOV at least
is suppost to have been integrated into the kernel by now).

Also I haven't yet been able to get EVMS working properly (the kernel
fails to "discover" EVMS volumes), but that may be my fault, and is
off-topic for this list anyway.
--
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
