Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k7TGpN3a022771
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 12:51:23 -0400
Received: from mail6.sea5.speakeasy.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k7TGoiRT002575
	for <selinux@tycho.nsa.gov>; Tue, 29 Aug 2006 16:50:46 GMT
Date: Tue, 29 Aug 2006 12:51:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: netdev@vger.kernel.org, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        akpm@osdl.org
Subject: Re: [PATCH 1/6] NetLabel: correctly initialize the NetLabel fields
In-Reply-To: <20060829144444.202106000@hp.com>
Message-ID: <Pine.LNX.4.64.0608291248410.29142@d.namei>
References: <20060829144251.452774000@hp.com> <20060829144444.202106000@hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 29 Aug 2006, paul.moore@hp.com wrote:

> +void selinux_netlbl_sk_security_init(struct sk_security_struct *ssec,
> +				     int family)
> +{
> +        if (family == PF_INET)

No tab.

> +		ssec->nlbl_state = NLBL_REQUIRE;
> +	else
> +		ssec->nlbl_state = NLBL_UNSET;
> +}

It doesn't look like this code handles ipv4 packets mapped on ipv6 
sockets.  See the test elsewhere in the SELinux code:

	if (family == PF_INET6 && skb->protocol == ntohs(ETH_P_IP))


Also, can you verify that you've tested these fixes and that they resolve 
all issues that you've encountered?



-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
