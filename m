Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n750h7uQ027188
	for <selinux@tycho.nsa.gov>; Tue, 4 Aug 2009 20:43:07 -0400
Received: from tundra.namei.org (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n750gfN8011009
	for <selinux@tycho.nsa.gov>; Wed, 5 Aug 2009 00:42:41 GMT
Date: Wed, 5 Aug 2009 10:43:03 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
Subject: Re: [RFC PATCH v1 0/2] The Long Lost TUN LSM Hooks
In-Reply-To: <20090804211304.10798.65601.stgit@flek.lan>
Message-ID: <alpine.LRH.2.00.0908051035530.29562@tundra.namei.org>
References: <20090804211304.10798.65601.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 4 Aug 2009, Paul Moore wrote:

> While drivers in general aren't good places for LSM hooks the TUN driver is
> a bit different because of how it handles sockets and network traffic.  The
> problem lies in the fact that the TUN driver creates a sock structure to use
> when sending network traffic but the sock is never put through the same LSM
> setup/control as other sock structures on the system which makes enforcing
> security on TUN generated traffic difficult for some LSMs.  This patch set
> adds three new LSM hooks, all specific to the TUN driver (none of the existing
> hooks made sense, trust me we tried), to control and monitor the creating and
> attachment of TUN devices.

Looks ok to me in principle.

For netdev reviewers: we're lacking proper LSM control over tun devices 
because they're not created like normal sockets, and subsequently don't 
get labeled appropriately.  They also behave differently to normal sockets 
and need special handling for security per Paul's notes.


- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
