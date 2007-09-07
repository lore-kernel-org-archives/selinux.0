Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l87DYjgc016458
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 09:34:45 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l87DYaZp003163
	for <selinux@tycho.nsa.gov>; Fri, 7 Sep 2007 13:34:43 GMT
Subject: Re: [PATCH] refpolicy: services_audioentropy changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708022100.l72L0kmi000808@redsox.boston.devel.redhat.com>
References: <200708022100.l72L0kmi000808@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Fri, 07 Sep 2007 09:33:17 -0400
Message-Id: <1189171997.3664.59.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 17:00 -0400, dwalsh@redhat.com wrote:
> Audit entropy needs dav_override and read/write random device

Merged.

> --- nsaserefpolicy/policy/modules/services/audioentropy.te      2007-05-29 14:10:57.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/services/audioentropy.te   2007-08-02 11:02:02.000000000 -0400
> @@ -18,7 +18,7 @@
>  # Local policy
>  #
> 
> -allow entropyd_t self:capability { ipc_lock sys_admin };
> +allow entropyd_t self:capability { dac_override ipc_lock sys_admin };
>  dontaudit entropyd_t self:capability sys_tty_config;
>  allow entropyd_t self:process signal_perms;
> 
> @@ -32,6 +32,8 @@
>  dev_read_sysfs(entropyd_t)
>  dev_read_urand(entropyd_t)
>  dev_write_urand(entropyd_t)
> +dev_read_rand(entropyd_t)
> +dev_write_rand(entropyd_t)
>  dev_read_sound(entropyd_t)
> 
>  fs_getattr_all_fs(entropyd_t)
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
