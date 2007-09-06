Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l86EQEWc026441
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 10:26:14 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l86EQC8b020563
	for <selinux@tycho.nsa.gov>; Thu, 6 Sep 2007 14:26:12 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH] refpolicy: system_hostname changes
Date: Thu, 6 Sep 2007 10:21:10 -0400
Message-ID: <1189088470.3664.9.camel@gorn>
In-Reply-To: <46B220FC.40807@redhat.com>
References: <200708021806.l72I6HNw022445@redsox> <46B220FC.40807@redhat.com>
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: "Daniel J Walsh" <dwalsh@redhat.com>
Cc: "SE Linux" <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 14:22 -0400, Daniel J Walsh wrote:
> 
> Allow hostname to be redirected to xen log as well

Already is in trunk.

> dontaudit interaction with uncofined pipes.  system-config-network
> causes this
> --- nsaserefpolicy/policy/modules/system/hostname.te    2007-05-29
> 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.4/policy/modules/system/hostname.te 2007-07-25
> 12:27:26.000000000 -0400
> @@ -60,3 +64,11 @@
>         xen_append_log(hostname_t)
>         xen_dontaudit_use_fds(hostname_t)
>  ')
> +
> +optional_policy(`
> +       xen_append_log(hostname_t)
> +')
> +
> +optional_policy(`
> +       unconfined_dontaudit_rw_pipes(hostname_t)
> 
> +')
> 
> 
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
