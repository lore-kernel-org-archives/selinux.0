Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5L9ddir024792
 for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2016 05:39:39 -0400
Date: Tue, 21 Jun 2016 05:39:28 -0400 (EDT)
Message-Id: <20160621.053928.1340819307282355897.davem@davemloft.net>
To: huw@codeweavers.com
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, pmoore@redhat.com
Subject: Re: [PATCH v4 00/19] CALIPSO Implementation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1466429819-12707-1-git-send-email-huw@codeweavers.com>
References: <1466429819-12707-1-git-send-email-huw@codeweavers.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Huw Davies <huw@codeweavers.com>
Date: Mon, 20 Jun 2016 14:36:40 +0100

> This patch series implements RFC 5570 - Common Architecture Label IPv6
> Security Option (CALIPSO).  Its goal is to set MLS sensitivity labels
> on IPv6 packets using a hop-by-hop option.  CALIPSO is very similar to
> its IPv4 cousin CIPSO and much of this series is based on that code.
> 
> To use this you'll need some patches to netlabel-tools that are
> available on the 'working-calipso-v3' branch at:
> https://github.com/netlabel/netlabel_tools .  The protocol has
> changed very slightly from the v2 patches, so please update to the
> latest if you haven't already done so.
> 
> This implementation has been tested against the CALIPSO implementation
> of Solaris Trusted Extensions.
> 
> This patch series is based off v4.6.
 ...

What tree do you expect to integrate this?
