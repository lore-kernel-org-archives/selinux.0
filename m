Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91GpFKl013567
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 12:51:15 -0400
Received: from g4t0015.houston.hp.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m91GpFOR025615
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 16:51:16 GMT
From: Paul Moore <paul.moore@hp.com>
To: James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH v6 11/16] netlabel: Add functionality to set the security attributes of a packet
Date: Wed, 1 Oct 2008 12:51:12 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125701.17132.46623.stgit@flek.lan> <alpine.LRH.1.10.0810011952100.6732@tundra.namei.org>
In-Reply-To: <alpine.LRH.1.10.0810011952100.6732@tundra.namei.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200810011251.12898.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 01 October 2008 5:55:49 am James Morris wrote:
> It might be better in the long term to integrate this stuff more
> directly with the core networking.

Agreed.  I did it the way I did because I wanted to impact the core 
stack as little as possible.  I looked at potentially doing the work in 
ip_options_compile() but that was going to require a lot of tweaking 
and some rather ugly hacks to keep everything contained and off to the 
side.  Tighter integration with the core stack can always be treated as 
an optimization at a later date; I want to see what our IPv6 needs will 
be first and I don't have a clear picture of that just yet.

On the plus side, only traffic coming from unconnected sockets is going 
to be hit by this and with most stuff using TCP these days I'm hopeful 
that the impact to the SELinux folks using labeled networking will be 
_relatively_ minimal.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
