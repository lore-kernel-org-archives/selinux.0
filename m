Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h9MLLuWt006245
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 17:21:56 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h9MLLtIE011591
	for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:21:55 GMT
Received: from epoch.ncsc.mil (facesaver.epoch.ncsc.mil [144.51.25.10])
        by jazzband.ncsc.mil  with ESMTP id h9MLLt1J011588 for <selinux@tycho.nsa.gov>; Wed, 22 Oct 2003 21:21:55 GMT
Subject: Re: [PATCH] checkpolicy/policy_scan.y
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joerg Hoh <joerg@devone.org>
Cc: selinux@tycho.nsa.gov, James Morris <jmorris@redhat.com>
In-Reply-To: <20031022211407.GC4671@hydra.joerghoh.de>
References: <20031022175608.GB4531@hydra.joerghoh.de>
	 <1066847603.32228.76.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022190241.GA4671@hydra.joerghoh.de>
	 <1066855497.32228.150.camel@moss-spartans.epoch.ncsc.mil>
	 <20031022211407.GC4671@hydra.joerghoh.de>
Content-Type: text/plain
Message-Id: <1066857705.32228.164.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 22 Oct 2003 17:21:45 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-10-22 at 17:14, Joerg Hoh wrote:
> policy_parse.y: In function `define_te_avtab':
> policy_parse.y:2031: warning: large integer implicitly truncated to unsigned type

My mistake, ~0UL should be ~0U.  Or (access_vector_t) ~0.  

> > Note that with either patch, warnings
> > will still occur on 64bit unless you have also patched your constraint.h
> > to use uintptr_t for the fields of the constraint_expr structure, but
> > that is not acceptable as it changes the binary policy format (or it
> > would, if the write.c code were also adjusted correspondingly, and it
> > serves no purpose otherwise). 
> 
> I will try it tomorrow.

Not sure what you mean.  The point is that you can't change the types on
those fields.

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
