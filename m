Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1MFROjg023874
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 10:27:25 -0500
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1MFRNDE018323
	for <selinux@tycho.nsa.gov>; Fri, 22 Feb 2008 15:27:24 GMT
Date: Fri, 22 Feb 2008 16:27:04 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: refpolicy: patch for ldconfig from glibc 2.7
Message-ID: <20080222152703.GA4163@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
I had some denials for ldconfig on Debian Sid. I took changes from
Fedora policy package - a patch attached. I grabed only things needed
to suppress denials below from Fedora.

audit(1203580520.435:11): avc:  denied  { read } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
audit(1203580520.435:12): avc:  denied  { getattr } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
audit(1203580520.907:13): avc:  denied  { write } for  pid=3985 comm="ldconfig" name="ldconfig" dev=sda1 ino=294986 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
audit(1203580520.907:14): avc:  denied  { add_name } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
audit(1203580520.907:15): avc:  denied  { create } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
...

Thanks
-- 
Zito

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="libraries.ldconfig.patch"

Index: policy/modules/system/libraries.fc
===================================================================
--- policy/modules/system/libraries.fc	(revision 2624)
+++ policy/modules/system/libraries.fc	(working copy)
@@ -304,3 +304,5 @@
 /var/spool/postfix/lib(64)?(/.*)? 		gen_context(system_u:object_r:lib_t,s0)
 /var/spool/postfix/usr(/.*)?			gen_context(system_u:object_r:lib_t,s0)
 /var/spool/postfix/lib(64)?/ld.*\.so.*	--	gen_context(system_u:object_r:ld_so_t,s0)
+
+/var/cache/ldconfig(/.*)?		    	gen_context(system_u:object_r:ldconfig_cache_t,s0)
Index: policy/modules/system/libraries.te
===================================================================
--- policy/modules/system/libraries.te	(revision 2624)
+++ policy/modules/system/libraries.te	(working copy)
@@ -23,6 +23,9 @@
 init_system_domain(ldconfig_t,ldconfig_exec_t)
 role system_r types ldconfig_t;
 
+type ldconfig_cache_t;
+files_type(ldconfig_cache_t)
+
 type ldconfig_tmp_t;
 files_tmp_file(ldconfig_tmp_t)
 
@@ -46,7 +49,9 @@
 
 allow ldconfig_t self:capability sys_chroot;
 
-allow ldconfig_t ld_so_cache_t:file manage_file_perms;
+manage_files_pattern(ldconfig_t,ldconfig_cache_t,ldconfig_cache_t)
+
+manage_files_pattern(ldconfig_t,ld_so_cache_t,ld_so_cache_t)
 files_etc_filetrans(ldconfig_t,ld_so_cache_t,file)
 
 manage_dirs_pattern(ldconfig_t,ldconfig_tmp_t,ldconfig_tmp_t)

--4Ckj6UjgE2iN1+kY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
