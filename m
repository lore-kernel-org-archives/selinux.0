Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i149ceRb010765
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 04:38:40 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i149cT1I003254
	for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 09:38:29 GMT
Received: from butternut.transitive.com (dsl-217-207-128-218.uk.easynet.net [217.207.128.218] (may be forged))
        by jazzband.ncsc.mil  with ESMTP id i149cSbs003251 for <selinux@tycho.nsa.gov>; Wed, 4 Feb 2004 09:38:29 GMT
Message-ID: <4020BD63.3050004@treblig.org>
Date: Wed, 04 Feb 2004 09:37:39 +0000
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov, bam@snoopy.apana.org.au
Subject: Re: Problems finding working kernel/user land combination
References: <401FF280.8070301@treblig.org> <200402041216.54927.russell@coker.com.au>
In-Reply-To: <200402041216.54927.russell@coker.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Wed, 4 Feb 2004 06:12, "Dave Gilbert (Home)" <gilbertd@treblig.org> wrote:

Hi Russell,
   Thanks for the swift reply,

> 
> It appears that the "stable" repository on Brian's site is for old SE Linux 
> and "unstable" is for new SE Linux.  I've updated my web site to describe 
> this.

Thanks.

>>An strace of 'id' shows:
>>
>>SYS_223(0xf97cff8c, 0xc, 0, 0x400135cc) = -1 ENOSYS (Function not
>>implemented)
> 
> 
> SYS_223 is the LSM system call from the old SE Linux.

Perhaps it would be nice if new-LSM logged something like 'Your using 
the old userland tools' as a clue.

> Sounds like you aren't applying the patches to the Debian kernel source.  If 
> you get kernel-patch-debian-2.4.24 and apply it first then everything should 
> be fine.

Thanks; I'll give that a go.

So am I OK applying the kernel-patch-2.4-oldlsm_2003.08.13-8 - should 
that work with Brians tools ?
(If not then I guess its a case of downloading the source to your tool 
packages and rebuilding).

> But using 2.6.1 is probably easier.

Indeed; while my own experiences with 2.6.1 on my home machine are 
mostly positive, I'm not really ready to trust its stability on an 
important machine.

Thanks again for the swift response,

Dave


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
