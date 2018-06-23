Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5NLQiUV008590
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 17:26:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC06.oob.disa.mil (Postfix) with SMTP id 41CpR23BvCz19Yj4
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 21:26:38 +0000 (UTC)
Received: from UPDC3CPA02.eemsg.mil (unknown [192.168.18.9])
 by UPDCF3IC06.oob.disa.mil (Postfix) with ESMTP id 41CpR22LQMz19Yj1
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 21:26:38 +0000 (UTC)
Date: Sat, 23 Jun 2018 22:26:27 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: David Miller <davem@davemloft.net>
Cc: pmoore@redhat.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Message-ID: <20180623212626.GD30522@ZenIV.linux.org.uk>
References: <152970230022.7734.15824980755229329454.stgit@chester>
 <20180623.105706.385733107379565893.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180623.105706.385733107379565893.davem@davemloft.net>
Sender: Al Viro <viro@ftp.linux.org.uk>
Subject: Re: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jun 23, 2018 at 10:57:06AM +0900, David Miller wrote:
> From: Paul Moore <pmoore@redhat.com>
> Date: Fri, 22 Jun 2018 17:18:20 -0400
> 
> > -	const mm_segment_t old_fs = get_fs();
> > -
> > -	set_fs(KERNEL_DS);
> > -	ret_val = ipv6_renew_options(sk, opt, newtype,
> > -				     (struct ipv6_opt_hdr __user *)newopt,
> > -				     newoptlen);
> > -	set_fs(old_fs);
> 
> So is it really the case that the traditional construct:
> 
> 	set_fs(KERNEL_DS);
> 	... copy_{from,to}_user(...);
> 	set_fs(old_fs);
> 
> is no longer allowed?

s/no longer allowed/best avoided/, but IMO in this case the replacement is
too ugly to live ;-/
