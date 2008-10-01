Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m911cb02005111
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 21:38:37 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m911bX04029965
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 01:37:34 GMT
Date: Wed, 1 Oct 2008 11:38:36 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 03/16] netlabel: Remove unneeded in-kernel API
 functions
In-Reply-To: <20080916125607.17132.84448.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011138150.5277@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125607.17132.84448.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> After some discussions with the Smack folks, well just Casey, I now have a
> better idea of what Smack wants out of NetLabel in the future so I think it
> is now safe to do some API "pruning".  If another LSM comes along that
> needs this functionality we can always add it back in, but I don't see any
> LSMs on the horizon which might make use of these functions.
> 
> Thanks to Rami Rosen who suggested removing netlbl_cfg_cipsov4_del() back
> in February 2008.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Reviewed-by: James Morris <jmorris@namei.org>



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
