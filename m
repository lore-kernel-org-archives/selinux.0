Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h56DhPI4003582
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 09:43:25 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h56Dgoss023084
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:42:50 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id h56DgkhY023081
	for <selinux@tycho.nsa.gov>; Fri, 6 Jun 2003 13:42:47 GMT
Date: Fri, 6 Jun 2003 23:40:09 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Wayne Salamon <wsalamon@nailabs.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: A vulnerability in SELinux (fwd)
Message-ID: <20030606134009.GA5463@snoopy.apana.org.au>
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

I remember what I was trying to remember before.

What is the label associated with libSegfault.so?

IIRC A process needs exec rights in order to use a shared library.

Therefore schfn (running in the new domain) will only be able to load
the library if it has been given the correct label by the system
adminstrator, and presumably a system adminstrator would only do this
with trusted shared libraries.

There might be implications here if a system adminstrator is tricked
into labelling a bad file, but I can't think of these right NOW.
-- 
Brian May <bam@snoopy.apana.org.au>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
