Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5L9tsEj026456
 for <selinux@tycho.nsa.gov>; Tue, 21 Jun 2016 05:55:54 -0400
Date: Tue, 21 Jun 2016 10:55:48 +0100
From: Huw Davies <huw@codeweavers.com>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 selinux@tycho.nsa.gov, pmoore@redhat.com
Subject: Re: [PATCH v4 00/19] CALIPSO Implementation
Message-ID: <20160621095548.GA19213@merlot.physics.ox.ac.uk>
References: <1466429819-12707-1-git-send-email-huw@codeweavers.com>
 <20160621.053928.1340819307282355897.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160621.053928.1340819307282355897.davem@davemloft.net>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 21, 2016 at 05:39:28AM -0400, David Miller wrote:
> From: Huw Davies <huw@codeweavers.com>
> Date: Mon, 20 Jun 2016 14:36:40 +0100
> 
> > This patch series implements RFC 5570 - Common Architecture Label IPv6
> > Security Option (CALIPSO).  Its goal is to set MLS sensitivity labels
> > on IPv6 packets using a hop-by-hop option.  CALIPSO is very similar to
> > its IPv4 cousin CIPSO and much of this series is based on that code.
> 
> What tree do you expect to integrate this?

My understanding is that Paul Moore is happy to take them
in via the SELinux tree.  However, these patches do touch
some core networking code, such as the IPv6 option handling
code (in a similar manner to the way CIPSO touched the IPv4
option code), so if you have any comments on those aspects
that would be good to hear.

Thanks,
Huw.
