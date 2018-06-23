Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5NCGQEH011308
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 08:16:26 -0400
Date: Sat, 23 Jun 2018 21:16:18 +0900 (KST)
Message-Id: <20180623.211618.698435338116789998.davem@davemloft.net>
To: pmoore@redhat.com
Cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <152970230022.7734.15824980755229329454.stgit@chester>
References: <152970230022.7734.15824980755229329454.stgit@chester>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <pmoore@redhat.com>
Date: Fri, 22 Jun 2018 17:18:20 -0400

> From: Paul Moore <paul@paul-moore.com>
> 
> The ipv6_renew_options_kern() function eventually called into
> copy_from_user(), despite it not using any userspace buffers, which
> was problematic as that ended up calling access_ok() which emited
> a warning on x86 (and likely other arches as well).
> 
>   ipv6_renew_options_kern()
>     ipv6_renew_options()
>       ipv6_renew_option()
>         copy_from_user()
>           _copy_from_user()
>             access_ok()
> 
> The access_ok() check inside _copy_from_user() is obviously the right
> thing to do which means that calling copy_from_user() via
> ipv6_renew_options_kern() is obviously the wrong thing to do.

Ok, I re-read the code around here.

access_ok() is not warning because we are calling copy_from_user()
with a kernel pointer.  The set_ds(KERNEL_DS) adjusts the
user_addr_max() setting, and thus that check passes.

The problem is that we are invoking this from an interrupt, and this
triggers the WARN_ON_IN_IRQ() in access_ok().

Although I think that WARN_ON_IN_IRQ() is completely unnecessary when
KERNEL_DS is set, the situation that really causes this problem is not
at all clear from your commit message.

I guess that for now your fix is fine, but I want you to please adjust
the commit message.

Provide the _full_ annotated kernel backtrace from the warning that
triggers, because this will show the reader that we are in an
interrupt.  And explain that being in the interrupt is strictly what
causes this to warn, not that we are using kernel pointers.  The
latter is %100 valid when set_fs(KERNEL_DS) is performed.

Thank you.
