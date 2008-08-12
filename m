Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m7CFUupf021417
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 11:30:56 -0400
Received: from vidle.i.cz (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m7CFUgLC014842
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 15:30:43 GMT
Received: from ns.i.cz (unknown [192.168.24.10])
	by vidle.i.cz (Postfix) with ESMTP id 38B891CC06
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 17:30:59 +0200 (CEST)
Received: from bobek.localdomain (bobek.pm.i.cz [192.168.64.71])
	by ns.i.cz (Postfix) with ESMTP id 2D4D25C04
	for <selinux@tycho.nsa.gov>; Tue, 12 Aug 2008 17:30:52 +0200 (CEST)
Received: from zito by bobek.localdomain with local (Exim 4.69)
	(envelope-from <vaclav.ovsik@i.cz>)
	id 1KSvpj-0006gv-VF
	for selinux@tycho.nsa.gov; Tue, 12 Aug 2008 17:30:51 +0200
Date: Tue, 12 Aug 2008 17:30:51 +0200
From: =?iso-8859-2?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>
To: selinux@tycho.nsa.gov
Subject: Re: refpolicy: patch for ldconfig from glibc 2.7
Message-ID: <20080812153051.GA25561@bobek.pm.i.cz>
References: <20080222152703.GA4163@bobek.pm.i.cz> <1203703539.32061.22.camel@gorn> <20080222152703.GA4163@bobek.pm.i.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
In-Reply-To: <1203703539.32061.22.camel@gorn> <20080222152703.GA4163@bobek.pm.i.cz>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
there is a message with a patch
http://marc.info/?l=selinux&m=120369420620609&w=2
in February 2008.

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
> 
> -- 
> Chris PeBenito
> Tresys Technology, LLC
> (410) 290-1411 x150

Can be this patch merged as-is?
(Attached again.)
-- 
Zito

--AqsLC8rIMeq19msA
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

--AqsLC8rIMeq19msA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
