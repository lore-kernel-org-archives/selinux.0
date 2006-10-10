Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9AI9hA8024322
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 14:09:43 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9AI93lj001569
	for <selinux@tycho.nsa.gov>; Tue, 10 Oct 2006 18:09:04 GMT
Subject: Re: [RFC 1/2] Reference policy: NetLabel policy additions
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: paul.moore@hp.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20061010172154.448485000@hp.com>
References: <20061010171524.936739000@hp.com>
	 <20061010172154.448485000@hp.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 14:10:04 -0400
Message-Id: <1160503804.20774.82.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-10-10 at 13:15 -0400, paul.moore@hp.com wrote:
> plain text document attachment (netlabel-refpolicy_core)
> This patch adds basic NetLabel support to the reference policy.

The main problem is that there are references to types that are not
owned by this module.  These have to be changed to use interfaces that
are provided by the modules that own the types.

> +interface(`netlabel_udp_recvfrom',`
> +        gen_require(`
> +                type unlabeled_t;
> +        ')
> +
> +	allow $1 unlabeled_t:udp_socket recvfrom;
> +')

> +interface(`netlabel_tcp_recvfrom',`
> +        gen_require(`
> +                type unlabeled_t;
> +        ')
> +
> +	allow $1 unlabeled_t:tcp_socket recvfrom;
> +')

Unlabeled_t is not declared in this module, so kernel should provide
these interfaces.  To make things clearer, interfaces in corenetwork
should be added that just call the kernel interfaces.  See
corenet_non_ipsec_sendrecv() (I realize its somewhat misnamed in light
of netlabel) and kernel_sendrecv_unlabeled_association() to see what I
mean by the above.

> +# sending netlabel'd packets does not require a selinux privilege, however
> +# receiving netlabel's packets does
> +allow staff_t unlabeled_t:{ tcp_socket udp_socket } recvfrom;
> +allow user_t unlabeled_t:{ tcp_socket udp_socket } recvfrom;

Should be added to userdomain via interface.  Also, why not sysadm_t?

> +# allow sysadm_t to run netlabelctl
> +domain_auto_trans(sysadm_t,netlabelctl_exec_t,netlabelctl_t)

Also should be added to userdomain via interface.  A domtrans interface
should be added to this module.  See clock_domtrans() for an example.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
