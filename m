Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m792Ilwr009033
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 22:18:47 -0400
Received: from g1t0026.austin.hp.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m792Ic5I010046
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 02:18:38 GMT
From: Paul Moore <paul.moore@hp.com>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC PATCH v1 0/6] Labeled networking patches for 2.6.28
Date: Fri, 8 Aug 2008 22:18:43 -0400
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
References: <20080808203542.21077.37084.stgit@flek> <20080808.160957.43829121.davem@davemloft.net>
In-Reply-To: <20080808.160957.43829121.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808082218.43511.paul.moore@hp.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 08 August 2008 7:09:57 pm David Miller wrote:
> From: Paul Moore <paul.moore@hp.com>
> Date: Fri, 08 Aug 2008 16:52:45 -0400
>
> > Attached is a short series of patches which fixup some issues with
> > labeled networking and add an important new feature: NetLabel
> > address selectors.
>
> If relevant, please submit the bug fix parts for 2.6.27, thanks.

Most of the "problems" I've "fixed" haven't really been bugs, but rather 
issues that made the new features difficult to implement.  The one 
exception may be the first patch in the series; I've debated submitting 
it for 2.6.27 but I'm not sure if it is significant.  Perhaps the 
SELinux folks could comment on this, if they think it is a good idea 
I'll respin that patch and push it for 2.6.27.

-- 
paul moore
linux @ hp

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
