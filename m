Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m911awhc004850
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 21:36:58 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m911Zs04029766
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 01:35:55 GMT
Date: Wed, 1 Oct 2008 11:36:57 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 02/16] selinux: Correctly handle IPv4 packets on
 IPv6 sockets in all cases
In-Reply-To: <20080916125601.17132.61002.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011136230.5277@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125601.17132.61002.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> We did the right thing in a few cases but there were several areas where we
> determined a packet's address family based on the socket's address family which
> is not the right thing to do since we can get IPv4 packets on IPv6 sockets.
> This patch fixes these problems by either taking the address family directly
> from the packet.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Acked-by: James Morris <jmorris@namei.org>


-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
