Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UEuN6j032596
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:56:23 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l3UEuMid000364
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:56:22 GMT
Subject: Re: Fixes for locate tool
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200704201929.l3KJTPT6027296@redsox.boston.devel.redhat.com>
References: <200704201929.l3KJTPT6027296@redsox.boston.devel.redhat.com>
Content-Type: text/plain
Date: Mon, 30 Apr 2007 10:56:03 -0400
Message-Id: <1177944963.3570.92.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-04-20 at 15:29 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/apps/slocate.te	2007-02-19 11:32:52.000000000 -0500
> +++ serefpolicy-2.5.12/policy/modules/apps/slocate.te	2007-04-16 12:08:09.000000000 -0400
> @@ -42,9 +42,8 @@
>  files_read_etc_runtime_files(locate_t)
>  files_read_etc_files(locate_t)
>  
> -fs_getattr_xattr_fs(locate_t)
> -fs_getattr_rpc_pipefs(locate_t)
> -fs_getattr_rpc_dirs(locate_t)
> +fs_getattr_all_fs(locate_t)
> +fs_getattr_all_dirs(locate_t)
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
