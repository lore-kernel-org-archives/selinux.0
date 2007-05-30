Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4UHbwL0014476
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 13:37:58 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4UHbr2p008430
	for <selinux@tycho.nsa.gov>; Wed, 30 May 2007 17:37:53 GMT
Date: Wed, 30 May 2007 10:17:32 -0400
Message-Id: <200705301417.l4UEHWS1007729@localhost.localdomain>
From: dwalsh@redhat.com
To: cpebenito@tresys.com
CC: selinux@tycho.nsa.gov
Subject: Additional textrel-shlib_t, ldconfig execed in rebuilding kernel needs tmp lnk_files
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- nsaserefpolicy/policy/modules/system/libraries.fc	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/libraries.fc	2007-05-30 08:56:20.000000000 -0400
@@ -134,11 +134,14 @@
 
 /usr/lib/transgaming_cedega/gddb_parser.so --	gen_context(system_u:object_r:shlib_t,s0)
 /usr/lib/win32/.*			--	gen_context(system_u:object_r:shlib_t,s0)
+/usr/lib/vlc/codec/libdmo_plugin.so	   --	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib/vlc/codec/librealaudio_plugin.so  --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 
 /usr/(.*/)?lib(64)?(/.*)?/nvidia/.+\.so(\..*)? -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?(/.*)?/nvidia/.+\.so(\..*)? --	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libsipphoneapi\.so.*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/ati-fglrx/.+\.so(\..*)?	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
+/usr/lib(64)?/xorg/libGL\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/(nvidia/)?libGL(core)?\.so(\.[^/]*)* -- gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/fglrx/libGL\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
 /usr/lib(64)?/libGLU\.so(\.[^/]*)*	--	gen_context(system_u:object_r:textrel_shlib_t,s0)
--- nsaserefpolicy/policy/modules/system/libraries.te	2007-05-29 14:10:58.000000000 -0400
+++ serefpolicy-3.0.1/policy/modules/system/libraries.te	2007-05-30 07:35:54.000000000 -0400
@@ -62,7 +62,8 @@
 
 manage_dirs_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
 manage_files_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
-files_tmp_filetrans(ldconfig_t, ldconfig_tmp_t, { file dir })
+manage_lnk_files_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)
+files_tmp_filetrans(ldconfig_t, ldconfig_tmp_t, { file dir lnk_file })
 
 manage_lnk_files_pattern(ldconfig_t,lib_t,lib_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
