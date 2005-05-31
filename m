Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j4VKKrgA008906
	for <selinux@tycho.nsa.gov>; Tue, 31 May 2005 16:20:53 -0400 (EDT)
Subject: Re: [Patch 1/3] Loadable policy module infrastructure
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: selinux-dev@tresys.com, selinux <selinux@tycho.nsa.gov>
In-Reply-To: <1117569209.9783.85.camel@localhost>
References: <1117128423.3483.19.camel@localhost>
	 <1117554540.28924.184.camel@moss-spartans.epoch.ncsc.mil>
	 <1117569209.9783.85.camel@localhost>
Content-Type: text/plain
Date: Tue, 31 May 2005 16:05:44 -0400
Message-Id: <1117569944.28924.294.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2005-05-31 at 15:53 -0400, Joshua Brindle wrote:
> would ebitmap_inplace_or be better? 

I think you can do better.

> This function is called from the linking code by passing in a reference to an ebitmap inside, say, a role set so it is unsafe to assign.

I don't follow.  In either case, you are destroying dst and mutating it
in place; current code does it by ebitmap_cpy(dst, &tmp) and then
destroys tmp, but you could just as easily memcpy(dst, &tmp, sizeof
*dst) and not destroy tmp, avoiding any extra allocation and copy.  In
either case, dst->node and dst->highbit fields are mutated.

> Yes, pre-expansion (or even checking context validity after expansion) would be better, we were more worried about correctness than performance this time, we'll optimize these things later

It isn't significantly different than having to index (to generate the
val_to_struct arrays) prior to calling this function.  And deferring the
expansion means you have a new failure mode from this function due to
OOM condition that didn't exist previously.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
