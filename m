Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v56JJSdM003525
 for <selinux@tycho.nsa.gov>; Tue, 6 Jun 2017 15:19:28 -0400
Date: Tue, 06 Jun 2017 15:19:19 -0400 (EDT)
Message-Id: <20170606.151919.50793178996552480.davem@davemloft.net>
To: richard_c_haines@btinternet.com
Cc: paul@paul-moore.com, netdev@vger.kernel.org, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH] net/ipv6: Fix CALIPSO causing GPF with datagram support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20170605154440.2434-1-richard_c_haines@btinternet.com>
References: <20170605154440.2434-1-richard_c_haines@btinternet.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Richard Haines <richard_c_haines@btinternet.com>
Date: Mon,  5 Jun 2017 16:44:40 +0100

> When using CALIPSO with IPPROTO_UDP it is possible to trigger a GPF as the
> IP header may have moved.
> 
> Also update the payload length after adding the CALIPSO option.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>

Applied and queued up for -stable, thank you Richard.
