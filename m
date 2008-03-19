Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2JDPqDB004476
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 09:25:52 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id m2JDPpYY012938
	for <selinux@tycho.nsa.gov>; Wed, 19 Mar 2008 13:25:51 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH 1/5] REFPOL: Add new labeled networking permissions
Date: Wed, 19 Mar 2008 09:19:53 -0400
Message-ID: <1205932793.16113.42.camel@gorn>
In-Reply-To: <20080226184404.862575664@hp.com>
References: <20080226184032.834798290@hp.com> <20080226184404.862575664@hp.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: <paul.moore@hp.com>
Cc: <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2008-02-26 at 13:40 -0500, paul.moore@hp.com wrote:
> The 2.6.25 kernel will introduce a new set of labeled networking controls to
> SELinux and this patch makes the necessary changes to the Reference Policy
> to support unlabeled network traffic with the new controls.
> 
> A description of the new/improved labeled networking controls was posted to
> the SELinux list back in early January 2008.
> 
>  * http://marc.info/?l=selinux&m=119991234501200&w=2
> 
> Signed-off-by: Paul Moore <paul.moore@hp.com>
> ---
>  policy/modules/kernel/corenetwork.if.in |   69 +++++++++++++++++++++++---------

Is there a reason why you skipped adding ingress/egress to the "all"
interfaces (e.g. corenet_udp_receive_all_if)?

>  policy/modules/kernel/corenetwork.if.m4 |   20 ++++-----
>  policy/modules/kernel/kernel.if         |   30 +++++++++++++
>  policy/modules/kernel/kernel.te         |    3 +
>  4 files changed, 94 insertions(+), 28 deletions(-)

> --- refpolicy_svn_repo.orig/policy/modules/kernel/corenetwork.if.in
> +++ refpolicy_svn_repo/policy/modules/kernel/corenetwork.if.in
> @@ -2380,6 +2392,27 @@ interface(`corenet_sendrecv_unlabeled_pa
>  
>  ########################################
>  ## <summary>
> +##	Receive packets from an unlabeled peer.
> +## </summary>
> +## <desc>
> +##	<p>
> +##	Receive packets from an unlabeled peer,
> +##      these packets do not have any peer labeling
> +##      information present.
> +##	</p>
> +## </desc>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`corenet_recvfrom_unlabeled_peer',`
> +	kernel_recvfrom_unlabeled_peer($1)
> +')

Seems unnecessary since it seems like it should be called from
corenet_(tcp|udp|raw)_recvfrom_unlabeled?

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
