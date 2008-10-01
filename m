Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9199ZAw011728
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 05:09:35 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m9198VHK018698
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:08:32 GMT
Date: Wed, 1 Oct 2008 19:09:33 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 09/16] netlabel: Add a generic way to create
 ordered linked lists of network addrs
In-Reply-To: <20080916125646.17132.5022.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011909000.6732@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125646.17132.5022.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> Create an ordered IP address linked list mechanism similar to the core
> kernel's linked list construct.  The idea behind this list functionality
> is to create an extensibile linked list ordered by IP address mask to
> ease the matching of network addresses.  The linked list is ordered with
> larger address masks at the front of the list and shorter address masks
> at the end to facilitate overriding network entries with individual host
> or subnet entries.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> 

Reviewed-by: James Morris <jmorris@namei.org>



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
