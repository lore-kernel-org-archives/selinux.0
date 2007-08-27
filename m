Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RHohQp023079
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:50:43 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RHogQQ018992
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 17:50:43 GMT
Subject: Re: [PATCH] refpolicy: services_amavis changes amavis signals pyzor
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022031.l72KVx2S032312@redsox.boston.devel.redhat.com>
References: <200708022031.l72KVx2S032312@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 13:49:39 -0400
Message-Id: <1188236979.6723.28.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:31 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/amavis.te    2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/amavis.te 2007-08-02 11:02:02.000000000 -0400
> @@ -166,6 +166,7 @@
> 
>  optional_policy(`
>         pyzor_domtrans(amavis_t)
> +       pyzor_signal(amavis_t)
>  ')
> 
>  optional_policy(`

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
