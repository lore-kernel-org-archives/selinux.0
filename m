Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5LDgPl5029219
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 09:42:25 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5LDgLPC016763
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2007 13:42:21 GMT
Subject: Re: saslauthd needs to be able to update the passwd file (passwd
	expired)
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301422.l4UEMvG9007776@localhost.localdomain>
References: <200705301422.l4UEMvG9007776@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Jun 2007 09:40:26 -0400
Message-Id: <1182433226.24679.1.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:22 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/sasl.te	2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/services/sasl.te	2007-05-30 09:08:15.000000000 -0400
> @@ -63,6 +63,7 @@
>  selinux_compute_access_vector(saslauthd_t)
>  
>  auth_domtrans_chk_passwd(saslauthd_t)
> +auth_domtrans_upd_passwd(saslauthd_t)
>  auth_use_nsswitch(saslauthd_t)
>  
>  domain_use_interactive_fds(saslauthd_t)

I can't find the implementation of this interface in the other patches.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
