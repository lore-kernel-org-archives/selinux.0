Received: from nox.lemuria.org ([213.191.86.30])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id DAA11934
	for <selinux@tycho.nsa.gov>; Wed, 2 Oct 2002 03:20:58 -0400 (EDT)
Date: Wed, 2 Oct 2002 09:20:56 +0200
From: Tom <tom@lemuria.org>
To: Tracy R Reed <treed@ultraviolet.org>
Cc: selinux@tycho.nsa.gov
Subject: Re: SE Linux on Debian
Message-ID: <20021002092056.A4475@lemuria.org>
References: <20021001153638.J5416@ultraviolet.org> <20021002014815.GB14890@snoopy.apana.org.au> <20021001221022.B18667@ultraviolet.org> <20021002074201.C28663@lemuria.org> <20021001232715.A28686@ultraviolet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20021001232715.A28686@ultraviolet.org>; from treed@ultraviolet.org on Tue, Oct 01, 2002 at 11:27:15PM -0700
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Oct 01, 2002 at 11:27:15PM -0700, Tracy R Reed wrote:
> Ah. Actually they were in 
> 
> /usr/share/selinux/policy/current/
> 
> and
> 
> /usr/share/selinux/policy/default/
> 
> What's the difference? But I removed them and now the policy compiles.
> Yeay!  Thanks for the help.

That's just some symlinking, I believe.


> Next question: Just for kicks I did avc_toggle. The machine halted
> instantly. 

Welcome to SELinux. :)
I guess this happens to everyone at least once.

However, the (old) default policy worked fine for me and I don't think
there have been so many critical changes. Anything uncommon you
have, like raid, scsi, root filesystems on /dev/hdc7 or something?


-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
