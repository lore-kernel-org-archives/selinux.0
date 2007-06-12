Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5CD1Aog017668
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 09:01:10 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l5CD18go003219
	for <selinux@tycho.nsa.gov>; Tue, 12 Jun 2007 13:01:08 GMT
Subject: Re: apps_slocate changes
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301522.l4UFM0PG010486@localhost.localdomain>
References: <200705301522.l4UFM0PG010486@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 12 Jun 2007 08:59:21 -0400
Message-Id: <1181653161.16029.63.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 11:22 -0400, dwalsh@redhat.com wrote:
> locates generates avc messages without these rules
> 
> --- nsaserefpolicy/policy/modules/apps/slocate.te	2007-05-29 14:10:48.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/apps/slocate.te	2007-05-30 09:25:53.000000000 -0400
> @@ -39,11 +39,13 @@
>  
>  files_list_all(locate_t)
>  files_getattr_all_files(locate_t)
> +files_getattr_all_sockets(locate_t)
>  files_read_etc_runtime_files(locate_t)
>  files_read_etc_files(locate_t)
>  
>  fs_getattr_all_fs(locate_t)
> -fs_getattr_all_dirs(locate_t)
> +fs_getattr_all_files(locate_t)
> +fs_list_all(locate_t)
>  
>  libs_use_shared_libs(locate_t)
>  libs_use_ld_so(locate_t)

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
