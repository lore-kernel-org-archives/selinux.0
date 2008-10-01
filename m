Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m91A0PaS020777
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 06:00:25 -0400
Received: from tundra.namei.org (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m919xLHK003199
	for <selinux@tycho.nsa.gov>; Wed, 1 Oct 2008 09:59:22 GMT
Date: Wed, 1 Oct 2008 20:00:25 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Paul Moore <paul.moore@hp.com>
cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH v6 12/16] selinux: Set socket NetLabel based on
 connection endpoint
In-Reply-To: <20080916125709.17132.47022.stgit@flek.lan>
Message-ID: <alpine.LRH.1.10.0810011958380.6732@tundra.namei.org>
References: <20080916124722.17132.38741.stgit@flek.lan> <20080916125709.17132.47022.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 16 Sep 2008, Paul Moore wrote:

>  /**
> + * cipso_v4_sock_delattr - Delete the CIPSO option from a socket
> + * @sk: the socket
> + *
> + * Description:
> + * Removes the CIPSO option from a socket, if present.
> + *
> + */
> +void cipso_v4_sock_delattr(struct sock *sk)

Reviewed-by: James Morris <jmorris@namei.org>


Btw, what kind of testing has this patch had?



- James
-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
