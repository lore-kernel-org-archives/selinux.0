Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BFavAY021740
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 11:36:57 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BFauQ2026235
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 15:36:57 GMT
Subject: Re: admin_logwatch changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301526.l4UFQo4L010564@localhost.localdomain>
References: <200705301526.l4UFQo4L010564@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 11:35:31 -0400
Message-Id: <1181576131.16029.38.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:26 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/admin/logwatch.te	2007-05-29 14:10:59.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/admin/logwatch.te	2007-05-30 09:25:53.000000000 -0400
> @@ -63,6 +63,8 @@
>  files_search_mnt(logwatch_t)
>  files_dontaudit_search_home(logwatch_t)
>  files_dontaudit_search_boot(logwatch_t)
> +# Execs df and if file system mounted with a context avc raised
> +files_dontaudit_search_all_dirs(logwatch_t)
>  
>  fs_getattr_all_fs(logwatch_t)
>  fs_dontaudit_list_auto_mountpoints(logwatch_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
