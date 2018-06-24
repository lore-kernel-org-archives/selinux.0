Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5O7mo3e009962
 for <selinux@tycho.nsa.gov>; Sun, 24 Jun 2018 03:48:50 -0400
Date: Sun, 24 Jun 2018 16:48:37 +0900 (KST)
Message-Id: <20180624.164837.37612664745856114.davem@davemloft.net>
To: viro@ZenIV.linux.org.uk
Cc: pmoore@redhat.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180623222106.GE30522@ZenIV.linux.org.uk>
References: <20180623.105706.385733107379565893.davem@davemloft.net>
 <20180623212626.GD30522@ZenIV.linux.org.uk>
 <20180623222106.GE30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Al Viro <viro@ZenIV.linux.org.uk>
Date: Sat, 23 Jun 2018 23:21:07 +0100

> BTW, I wonder if the life would be simpler with do_ipv6_setsockopt() doing
> the copy-in and verifying ipv6_optlen(*hdr) <= newoptlen; that would've
> simplified ipv6_renew_option{,s}() quite a bit and completely eliminated
> ipv6_renew_options_kern()...

I agree that this makes things a lot simpler.

One thing that drives me crazy though is this inherit stuff:

> +	ipv6_renew_option(newtype == IPV6_HOPOPTS ? newopt :
> +				opt ? opt->hopopt : NULL,

Why don't we pass the type into ipv6_renew_option() and have it
do this pointer dance instead?

That's going to definitely be easier to read.

I don't know enough about this code to give feedback about the
option length handling wrt. copies, sorry.
