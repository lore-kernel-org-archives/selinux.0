Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w28ICipl027789
 for <selinux@tycho.nsa.gov>; Thu, 8 Mar 2018 13:12:48 -0500
Date: Thu, 08 Mar 2018 13:11:15 -0500 (EST)
Message-Id: <20180308.131115.611191617522587758.davem@davemloft.net>
To: eric.dumazet@gmail.com
Cc: stephen@networkplumber.org, pmoore@redhat.com, netdev@vger.kernel.org,
 viro@zeniv.linux.org.uk, dac.override@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org
From: David Miller <davem@davemloft.net>
In-Reply-To: <c2d378b6-80b3-d9e1-7087-95f143875067@gmail.com>
References: <20180306155920.7b6379ac@xeon-e3>
 <20180308.123440.2224695014753871221.davem@davemloft.net>
 <c2d378b6-80b3-d9e1-7087-95f143875067@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Subject: Re: [PATCH] net: don't unnecessarily load kernel modules in
 dev_ioctl()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 8 Mar 2018 10:05:12 -0800

> Another problematic legacy behavior is the automatic creation of
> fallback tunnels, which hurts netns creation/deletion.
> 
> Some environments want to create a netns for every job/task, and they
> do not care if the init netns has these tunnels or not.
> 
> We have a local patch adding yet another knob to control this, since
> it saves a lot of cpu cycles (about 10ms per netns create/delete pair
> here)

Yeah, understood.  At small scale the current behavior maybe made
sense, but these days it really doesn't.

No objections to the knob if you want to submit it.
