Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9KIlEWt022120
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 14:47:14 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9KIlDmR023457
	for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 18:47:13 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9KIlDjp023454 for <selinux@tycho.nsa.gov>; Mon, 20 Oct 2003 18:47:13 GMT
Subject: Re: [PATCH] Warnings and 64bit
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20031020175611.GC3579@hydra.joerghoh.de>
References: <20031004231832.GE3573@hydra.joerghoh.de>
	 <1065467759.3919.121.camel@moss-spartans.epoch.ncsc.mil>
	 <20031007213151.GG4359@hydra.joerghoh.de>
	 <1065619026.8181.83.camel@moss-spartans.epoch.ncsc.mil>
	 <20031008173416.GB3537@hydra.joerghoh.de>
	 <1066667672.22196.205.camel@moss-spartans.epoch.ncsc.mil>
	 <20031020175611.GC3579@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066675631.22196.302.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 20 Oct 2003 14:47:11 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2003-10-20 at 13:56, Joerg Hoh wrote:
> I don't know exactly (maybe it even hasn't crashed, but just encounterd an
> error with a missing semicolon in the policy file), we (Bastian Blank and
> me) looked really soon in the code and discovered some things, which led to
> our opinion that selinux was only tested on 32bit architectures. So we
> didn't looked further on that error...

Ok.  Let us know more if you are able to reproduce an error with
checkpolicy (without your earlier patch applied) on 64bit.  I did merge
the recently posted patch by Bastian that included a subset of the
original changes.  I just want to make sure that any fixes are correct
and complete, and avoid any unnecessary changes to the binary policy
format or kernel API.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
