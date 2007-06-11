Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l5BErSn6018563
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 10:53:28 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l5BErQDE019053
	for <selinux@tycho.nsa.gov>; Mon, 11 Jun 2007 14:53:26 GMT
Subject: Re: Additional textrel-shlib_t, ldconfig execed in rebuilding
	kernel needs tmp lnk_files
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200705301417.l4UEHWS1007729@localhost.localdomain>
References: <200705301417.l4UEHWS1007729@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 11 Jun 2007 10:51:32 -0400
Message-Id: <1181573492.16029.24.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2007-05-30 at 10:17 -0400, dwalsh@redhat.com wrote:
> --- nsaserefpolicy/policy/modules/system/libraries.fc	2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/system/libraries.fc	2007-05-30 08:56:20.000000000 -0400
> @@ -134,11 +134,14 @@
>  
>  /usr/lib/transgaming_cedega/gddb_parser.so --	gen_context(system_u:object_r:shlib_t,s0)
>  /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
> +/usr/lib/vlc/codec/libdmo_plugin.so	   --	gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/lib/vlc/codec/librealaudio_plugin.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
>  
>  /usr/(.*/)?lib(64)?(/.*)?/nvidia/.+\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?(/.*)?/nvidia/.+\.so(\..*)? --	gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?/libsipphoneapi\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?/ati-fglrx/.+\.so(\..*)?	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
> +/usr/lib(64)?/xorg/libGL\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?/fglrx/libGL\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
>  /usr/lib(64)?/libGLU\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
> --- nsaserefpolicy/policy/modules/system/libraries.te	2007-05-29 14:10:58.000000000 -0400
> +++ serefpolicy-3.0.1/policy/modules/system/libraries.te	2007-05-30 07:35:54.000000000 -0400
> @@ -62,7 +62,8 @@
>  
>  manage_dirs_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
>  manage_files_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
> -files_tmp_filetrans(ldconfig_t, ldconfig_tmp_t, { file dir })
> +manage_lnk_files_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
> +files_tmp_filetrans(ldconfig_t, ldconfig_tmp_t, { file dir lnk_file })
>  
>  manage_lnk_files_pattern(ldconfig_t,lib_t,lib_t)

Merged.
 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
