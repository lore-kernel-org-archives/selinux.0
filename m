Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l85Ef03p031166
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 10:41:00 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l85EexJV009584
	for <selinux@tycho.nsa.gov>; Wed, 5 Sep 2007 14:40:59 GMT
Subject: Re: [PATCH] refpolicy: admin_bootloader changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200708021935.l72JZi7C028806@redsox.boston.devel.redhat.com>
References: <200708021935.l72JZi7C028806@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Wed, 05 Sep 2007 10:39:41 -0400
Message-Id: <1189003181.30065.21.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-02 at 15:35 -0400, dwalsh@redhat.com wrote:
> hal redirects output to log file
> --- nsaserefpolicy/policy/modules/admin/bootloader.te   2007-07-25
> 10:37:43.000000000 -0400
> +++ serefpolicy-3.0.5/policy/modules/admin/bootloader.te
> 2007-08-02 11:02:02.000000000 -0400
> @@ -180,6 +180,7 @@
> 
>  optional_policy(`
>         hal_dontaudit_append_lib_files(bootloader_t)
> +       hal_write_log(bootloader_t)
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
