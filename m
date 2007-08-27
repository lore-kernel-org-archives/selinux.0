Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7RHogdv023073
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 13:50:42 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7RHofQQ018976
	for <selinux@tycho.nsa.gov>; Mon, 27 Aug 2007 17:50:41 GMT
Subject: Re: [PATCH] refpolicy: services_radius changes, raid with certs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022042.l72Kgxb8032656@redsox.boston.devel.redhat.com>
References: <200708022042.l72Kgxb8032656@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 27 Aug 2007 13:49:38 -0400
Message-Id: <1188236978.6723.26.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 16:42 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/services/radius.te    2007-07-25 10:37:42.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/radius.te 2007-08-02 11:02:02.000000000 -0400
> @@ -99,6 +100,7 @@
>  logging_send_syslog_msg(radiusd_t)
> 
>  miscfiles_read_localization(radiusd_t)
> +miscfiles_read_certs(radiusd_t)
> 
>  sysnet_read_config(radiusd_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
