Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8PJIK4j024726
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 15:18:20 -0400
Received: from mail8.sea5.speakeasy.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8PJHdaU026922
	for <selinux@tycho.nsa.gov>; Mon, 25 Sep 2006 19:17:45 GMT
Date: Mon, 25 Sep 2006 15:18:03 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>, "David S. Miller" <davem@davemloft.net>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, tgraf@suug.ch,
        jmorris@redhat.com, sds@epoch.ncsc.mil
Subject: Re: [PATCH v2 0/8] Updated patchset with Thomas' comments
In-Reply-To: <20060925180412.715069000@hp.com>
Message-ID: <Pine.LNX.4.64.0609251516240.26346@d.namei>
References: <20060925180412.715069000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 25 Sep 2006, paul.moore@hp.com wrote:

> This is an updated patchset which takes into account Thomas' comments.  This
> includes the addition of two new patches in the patchset which add a new
> Netlink interface as well as correct the list of interfaces in the large
> comment block at the top of include/net/netlink.h.
> 
> Please consider these patches for 2.6.19, thanks.

All patches -

Acked-by: James Morris <jmorris@namei.org>


Dave, I think these should be applied now and queued for 2.6.19.



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
