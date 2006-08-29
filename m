Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TGsk3h022939
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 12:54:46 -0400
Received: from mail3.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TGsPx8001956
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 16:54:26 GMT
Date: Tue, 29 Aug 2006 12:54:40 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>, "David S. Miller" <davem@davemloft.net>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov,
        Stephen Smalley <sds@tycho.nsa.gov>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/6] NetLabel: uninline selinux_netlbl_inode_permission()
In-Reply-To: <20060829144446.837714000@hp.com>
Message-ID: <Pine.LNX.4.64.0608291254010.29142@d.namei>
References: <20060829144251.452774000@hp.com> <20060829144446.837714000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Aug 2006, paul.moore@hp.com wrote:

> Uninline the selinux_netlbl_inode_permission() at the request of Andrew Morton.
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>

Acked-by: James Morris <jmorris@namei.org>


These patches should likely go in via Dave's tree.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
