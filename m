Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h56DSsI4003488
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 09:28:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h56DSJss022434
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:28:19 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h56DSFhY022431
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:28:16 GMT
Date: Fri, 6 Jun 2003 23:28:42 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Wayne Salamon <wsalamon@nailabs.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux (fwd)
Message-ID: <20030606132842.GE2911@snoopy.apana.org.au>
References: <Pine.LNX.4.33.0306060554430.10200-300000@vox.rv.nailabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0306060554430.10200-300000@vox.rv.nailabs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Jun 06, 2003 at 05:55:33AM -0400, Wayne Salamon wrote:
> 	Ad rem. The following command, issued by an user with
> anyuser:user_r:user_t security context, which has uid=0, will result in 
> overwriting /etc/passwd with junk:
> # bash -c "ulimit -s 10000; LD_PRELOAD=/lib/libSegfault.so
> 	SEGFAULT_USE_ALTSTACK=true SEGFAULT_OUTPUT_NAME=/etc/passwd
> 	/usr/local/selinux/bin/schfn dummyarg"
> How does it work ? /lib/libSegfault.so is successfully preloaded - as it
> resides in /lib, it was labeled with the security context of 
> system_u:object_r:shlib_t. The .init section of libSegfault.so executes, which 
> installs a handler for SIGSEGV. Then schfn starts execution. As the stack size 
> is made low, it segfaults quickly. The signal handler from libSegfault.so 
> happily overwrites SEGFAULT_OUTPUT_NAME with data similar to the following:
> *** Segmentation fault
> Register dump:

I had a feeling that LD_PRELOAD was somehow ignored if the exec would
trigger a change in domain?

I can't remember how this was done right now though, and I might be
mistaken.

Can this be reproduced with 2.4.x?
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
