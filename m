Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7MJtu70019228
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 15:55:56 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7MJttca002232
	for <selinux@tycho.nsa.gov>; Wed, 22 Aug 2007 19:55:55 GMT
Subject: Re: [PATCH] refpolicy: apps_usernetctl changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021956.l72JuSF2029434@redsox.boston.devel.redhat.com>
References: <200708021956.l72JuSF2029434@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 22 Aug 2007 15:55:01 -0400
Message-Id: <1187812501.13874.97.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:56 -0400, dwalsh@redhat.com wrote:
> No one uses this boolean
> --- nsaserefpolicy/policy/modules/apps/usernetctl.te    2007-07-25 10:37:37.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/apps/usernetctl.te 2007-08-02 11:02:02.000000000 -0400
> @@ -6,14 +6,6 @@
>  # Declarations
>  #
> 
> -## <desc>
> -## <p>
> -## Allow users to control network interfaces
> -## (also needs USERCTL=true)
> -## </p>
> -## </desc>
> -gen_tunable(user_net_control,false)
> -
>  type usernetctl_t;
>  type usernetctl_exec_t;
>  application_domain(usernetctl_t,usernetctl_exec_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
