Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w645T5Vm021619
 for <selinux@tycho.nsa.gov>; Wed, 4 Jul 2018 01:29:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID10.oob.disa.mil (Postfix) with SMTP id 41L8g139cSz2L9Cm
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 05:29:01 +0000 (UTC)
Received: from USFB3CPA06_EEMSG_MP28.eemsg.mil (unknown [192.168.16.23])
 by USFBF3ID10.oob.disa.mil (Postfix) with ESMTP id 41L8g05MmMz2L92Y
 for <selinux@tycho.nsa.gov>; Wed,  4 Jul 2018 05:29:00 +0000 (UTC)
Date: Wed, 04 Jul 2018 14:28:53 +0900 (KST)
Message-Id: <20180704.142853.1524154785411171806.davem@davemloft.net>
To: pmoore@redhat.com
Cc: netdev@vger.kernel.org, viro@zeniv.linux.org.uk, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <153055565291.30739.11949388336400371265.stgit@chester>
References: <153055565291.30739.11949388336400371265.stgit@chester>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [RFC PATCH v2] ipv6: make ipv6_renew_options()
 interrupt/kernel safe
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Paul Moore <pmoore@redhat.com>
Date: Mon, 02 Jul 2018 14:20:52 -0400

> -static int ipv6_renew_option(void *ohdr,
> -			     struct ipv6_opt_hdr __user *newopt, int newoptlen,
> -			     int inherit,
> -			     struct ipv6_opt_hdr **hdr,
> -			     char **p)
> +static void ipv6_renew_option(int renewtype,
> +			      struct ipv6_opt_hdr **dest,
> +			      struct ipv6_opt_hdr *old,
> +			      struct ipv6_opt_hdr *new,
> +			      int newtype, char **p)
>  {
 ...
> +	p += CMSG_ALIGN(ipv6_optlen(*dest));

I don't think this actually advances the pointer in the caller,
you need something like:

	*p += CMSG_ALIGN(ipv6_optlen(*dest));
