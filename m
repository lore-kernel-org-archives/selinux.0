Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1T7LLD1006540
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 02:21:21 -0500
Received: from vidle.i.cz (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1T7LIVE001809
	for <selinux@tycho.nsa.gov>; Fri, 29 Feb 2008 07:21:19 GMT
Date: Fri, 29 Feb 2008 08:21:16 +0100
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-devel@lists.alioth.debian.org
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7, new patch
Message-ID: <20080229072116.GA13364@bobek.pm.i.cz>
References: <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
In-Reply-To: <1203703539.32061.22.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
this is a completion of previos patch...

On Fri, Feb 22, 2008 at 01:05:39PM -0500, Christopher J. PeBenito wrote:
> On Fri, 2008-02-22 at 16:27 +0100, Václav Ovsík wrote:
> > Hi,
> > I had some denials for ldconfig on Debian Sid. I took changes from
> > Fedora policy package - a patch attached. I grabed only things needed
> > to suppress denials below from Fedora.
> > 
> > audit(1203580520.435:11): avc:  denied  { read } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> > audit(1203580520.435:12): avc:  denied  { getattr } for  pid=3985 comm="ldconfig" name="aux-cache" dev=sda1 ino=294984 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> > audit(1203580520.907:13): avc:  denied  { write } for  pid=3985 comm="ldconfig" name="ldconfig" dev=sda1 ino=294986 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
> > audit(1203580520.907:14): avc:  denied  { add_name } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=dir
> > audit(1203580520.907:15): avc:  denied  { create } for  pid=3985 comm="ldconfig" name="aux-cache~" scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:var_t:s0 tclass=file
> 
> This is the right fix, and basically the same fix is queued up for
> merging as part of Dan's patch set.

When se_aptitude or se_apt is ran on Debian (apt or aptitude execution wrapped
with run_init), then the ldconfig called from a postinst and/or a postrm
scripts of shared libs brings following denials:

Feb 28 12:24:59 sid kernel: audit(1204197899.429:13): avc:  denied  { read write } for  pid=3209 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:object_r:devpts_t:s0 tclass=chr_file
Feb 28 12:24:59 sid kernel: audit(1204197899.429:14): avc:  denied  { use } for  pid=3209 comm="ldconfig" name="2" dev=devpts ino=4 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fd
Feb 28 12:24:59 sid kernel: audit(1204197899.429:15): avc:  denied  { write } for  pid=3209 comm="ldconfig" name="[23124]" dev=pipefs ino=23124 scontext=system_u:system_r:ldconfig_t:s0 tcontext=system_u:system_r:apt_t:s0 tclass=fifo_file

The attached patch (wich replaces my previos patch) suppresses these messages.
Maybe this could be solved also by adding unconfined_domain(ldconfig_t) like
Fedora or Ubuntu solves this. (This could be added to.)

Regards
-- 
Zito

--pWyiEgJYm5f9v55/
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="libraries.ldconfig.2.patch"

Index: policy/modules/system/libraries.fc
===================================================================
--- policy/modules/system/libraries.fc	(revision 2626)
+++ policy/modules/system/libraries.fc	(working copy)
@@ -304,3 +304,5 @@
 /var/spool/postfix/lib(64)?(/.*)? 		gen_context(system_u:object_r:lib_t,s0)
 /var/spool/postfix/usr(/.*)?			gen_context(system_u:object_r:lib_t,s0)
 /var/spool/postfix/lib(64)?/ld.*\.so.*	--	gen_context(system_u:object_r:ld_so_t,s0)
+
+/var/cache/ldconfig(/.*)?		    	gen_context(system_u:object_r:ldconfig_cache_t,s0)
Index: policy/modules/system/libraries.te
===================================================================
--- policy/modules/system/libraries.te	(revision 2626)
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
@@ -103,3 +108,10 @@
 	# blow up.
 	rpm_manage_script_tmp_files(ldconfig_t)
 ')
+
+optional_policy(`
+	# ldconfig run from postinstall, postrm scripts on Debian...
+	apt_rw_pipes(ldconfig_t)
+	apt_use_fds(ldconfig_t)
+	term_use_generic_ptys(ldconfig_t)
+')

--pWyiEgJYm5f9v55/--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
