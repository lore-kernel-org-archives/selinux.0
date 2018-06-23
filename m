Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5N1vYq6010934
 for <selinux@tycho.nsa.gov>; Fri, 22 Jun 2018 21:57:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC12.oob.disa.mil (Postfix) with SMTP id 41CJTl2pdDz1pF1J
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 01:57:15 +0000 (UTC)
Received: from UPBD19PA06.eemsg.mil (unknown [192.168.18.7])
 by UPDCF3IC12.oob.disa.mil (Postfix) with ESMTP id 41CJTk669qz1pF1C
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 01:57:14 +0000 (UTC)
Date: Sat, 23 Jun 2018 10:57:06 +0900 (KST)
Message-Id: <20180623.105706.385733107379565893.davem@davemloft.net>
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

> -	const mm_segment_t old_fs = get_fs();
> -
> -	set_fs(KERNEL_DS);
> -	ret_val = ipv6_renew_options(sk, opt, newtype,
> -				     (struct ipv6_opt_hdr __user *)newopt,
> -				     newoptlen);
> -	set_fs(old_fs);

So is it really the case that the traditional construct:

	set_fs(KERNEL_DS);
	... copy_{from,to}_user(...);
	set_fs(old_fs);

is no longer allowed?

Setting fs to KERNEL_DS is supposed to make user copies work on kernel
memory.  Or at least it did for 20+ years :-)
