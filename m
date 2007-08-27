Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RISbFV026085
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 14:28:37 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RISavi027216
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 18:28:37 GMT
Subject: Re: [PATCH] refpolicy: services_rshd changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022040.l72Keu8m032593@redsox.boston.devel.redhat.com>
References: <200708022040.l72Keu8m032593@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 14:27:34 -0400
Message-Id: <1188239254.6723.32.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:40 -0400, dwalsh@redhat.com wrote:
> Remove unconfiend_domain from rshd

Merged.

> --- nsaserefpolicy/policy/modules/services/rshd.te      2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/rshd.te   2007-08-02 11:02:02.000000000 -0400
> @@ -85,6 +86,5 @@
>  ')
> 
>  optional_policy(`
> -       unconfined_domain(rshd_t)
>         unconfined_shell_domtrans(rshd_t)
>  ')
> 
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
