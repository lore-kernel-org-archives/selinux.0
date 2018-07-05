Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w65BG2SP009427
 for <selinux@tycho.nsa.gov>; Thu, 5 Jul 2018 07:16:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID03.oob.disa.mil (Postfix) with SMTP id 41LwJt740nzmp4M
 for <selinux@tycho.nsa.gov>; Thu,  5 Jul 2018 11:15:58 +0000 (UTC)
Received: from USFB19PA07.eemsg.mil (unknown [192.168.16.4])
 by USFBF3ID03.oob.disa.mil (Postfix) with ESMTP id 41LwJt00Gyzmp4F
 for <selinux@tycho.nsa.gov>; Thu,  5 Jul 2018 11:15:57 +0000 (UTC)
Date: Thu, 05 Jul 2018 20:15:51 +0900 (KST)
Message-Id: <20180705.201551.1158772045763837695.davem@davemloft.net>
To: pmoore@redhat.com
Cc: netdev@vger.kernel.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <153071268532.4174.13831205890855497876.stgit@chester>
References: <153071268532.4174.13831205890855497876.stgit@chester>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [RFC PATCH v3] ipv6: make ipv6_renew_options()
 interrupt/kernel safe
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <pmoore@redhat.com>
Date: Wed, 04 Jul 2018 09:58:05 -0400

> From: Paul Moore <paul@paul-moore.com>
> 
> At present the ipv6_renew_options_kern() function ends up calling into
> access_ok() which is problematic if done from inside an interrupt as
> access_ok() calls WARN_ON_IN_IRQ() on some (all?) architectures
> (x86-64 is affected).  Example warning/backtrace is shown below:
> 
>  WARNING: CPU: 1 PID: 3144 at lib/usercopy.c:11 _copy_from_user+0x85/0x90
 ...
> While not present in the backtrace, ipv6_renew_option() ends up calling
> access_ok() via the following chain:
> 
>   access_ok()
>   _copy_from_user()
>   copy_from_user()
>   ipv6_renew_option()
> 
> The fix presented in this patch is to perform the userspace copy
> earlier in the call chain such that it is only called when the option
> data is actually coming from userspace; that place is
> do_ipv6_setsockopt().  Not only does this solve the problem seen in
> the backtrace above, it also allows us to simplify the code quite a
> bit by removing ipv6_renew_options_kern() completely.  We also take
> this opportunity to cleanup ipv6_renew_options()/ipv6_renew_option()
> a small amount as well.
> 
> This patch is heavily based on a rough patch by Al Viro.  I've taken
> his original patch, converted a kmemdup() call in do_ipv6_setsockopt()
> to a memdup_user() call, made better use of the e_inval jump target in
> the same function, and cleaned up the use ipv6_renew_option() by
> ipv6_renew_options().
> 
> CC: Al Viro <viro@zeniv.linux.org.uk>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

This looks good to me, applied to 'net'.
