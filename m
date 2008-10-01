Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m911ZlOD004717
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 21:35:47 -0400
Received: from tundra.namei.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m911ZlY0013498
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 01:35:47 GMT
Date: Wed, 1 Oct 2008 11:35:46 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 01/16] selinux: Cleanup the NetLabel glue code
In-Reply-To: <20080916125554.17132.61538.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011135140.5277@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125554.17132.61538.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

> We were doing a lot of extra work in selinux_netlbl_sock_graft() what wasn't
> necessary so this patch removes that code.  It also removes the redundant
> second argument to selinux_netlbl_sock_setsid() which allows us to simplify a
> few other functions.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Nice cleanup :-)

Acked-by: James Morris <jmorris@namei.org>



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
