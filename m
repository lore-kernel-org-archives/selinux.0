Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KHtqWt021604
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 13:55:52 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KHtpmR020302
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:55:51 GMT
Received: from a141.shuttle.de (home.nightdaughter.de [194.95.224.141])
        by jazzband.ncsc.mil  with ESMTP id h9KHtojp020272 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 17:55:51 GMT
Received: from hydra.joerghoh.de (unknown [192.168.0.14])
	by a141.shuttle.de (Postfix) with SMTP id A132B170021
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 20:09:33 +0200 (CEST)
Date: Mon, 20 Oct 2003 19:56:11 +0200
From: Joerg Hoh <joerg@devone.org>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH] Warnings and 64bit
Message-ID: <20031020175611.GC3579@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de> <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil> <20031007213151.GG4359@hydra.joerghoh.de> <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil> <20031008173416.GB3537@hydra.joerghoh.de> <1066667672.22196.205.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1066667672.22196.205.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 20, 2003 at 12:34:32PM -0400, Stephen Smalley wrote:
> On Wed, 2003-10-08 at 13:34, Joerg Hoh wrote:
> 
> AFAIK,
> 
> u32 i = 4;
> void *p = (void*)i;
> u32 j= (u32)p;
> 
> will always work in practice.  As long as a consistent behavior is
> applied for conversion, it will store and extract correctly, and you can
> certainly store 32bit values in 64bit variables.  Endianness doesn't
> come into play, as we aren't crossing a machine boundary when passing
> this value, and checkpolicy does convert to a standard ordering (little
> endian) before writing to the binary policy file (and the kernel
> converts to the native ordering upon reading it).

Yes, I realized that after having written that mail.

> 
> > These warnings soon becomes errors if you go off your 32bit plattform. The
> > unpatched policy loader simply crashed because of such errors.
> 
> This is what we need to know more about in order to develop a correct
> and complete fix to the problem.  Where does it crash?

I don't know exactly (maybe it even hasn't crashed, but just encounterd an
error with a missing semicolon in the policy file), we (Bastian Blank and
me) looked really soon in the code and discovered some things, which led to
our opinion that selinux was only tested on 32bit architectures. So we
didn't looked further on that error...

Joerg


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
