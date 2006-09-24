Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8O0Vg2e030615
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 20:31:42 -0400
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k8O0Uda3015279
	for <selinux@tycho.nsa.gov>; Sun, 24 Sep 2006 00:30:40 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <method@gentoo.org>
Subject: Re: FC5 policy
Date: Sun, 24 Sep 2006 10:31:43 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
References: <200609240034.08217.russell@coker.com.au> <200609240813.56907.russell@coker.com.au> <4515CA12.3050107@gentoo.org>
In-Reply-To: <4515CA12.3050107@gentoo.org>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_yHdFF9H3MM0626l"
Message-Id: <200609241031.46481.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_yHdFF9H3MM0626l
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sunday 24 September 2006 09:58, Joshua Brindle <method@gentoo.org> wrote:
> >> um? in what way are the tools broken? It is quite easy to move a module
> >> to base:
> >>
> >> semodule -r clamav -i base-with-clamav.pp
> >
> > The package installation process can't do it.
>
> sounds like a problem with the package manager rather than the selinux
> tools.

The only way of doing this with the package manager would be to look for 
specific versions of packages and have code which says "if old version == X 
and new version == y then use parameter `-r clamav`" which gets ugly fairly 
quickly.

> > Ideally we would have some way for semodule to automatically figure out
> > that base-with-clamav.pp has the clamav module and do the right thing.
>
> doubtful. What if they have different rules? How about slightly
> different type spaces? Is it ok if some types are invalided as long as
> some aren't? This is certainly not something semodule should do.

If the module name is the same then it should be fairly unambiguous.  Any 
package upgrade may have slightly different type spaces etc so the difference 
in module vs base is no difference than that between successive versions of 
the base policy.

> >> Who doesn't like removing access from processes? I think we are all on
> >> the same side here..
> >
> > Then why do I keep sending this patch to the list and it doesn't get
> > applied?
> >
> > Why hasn't the pre-fedora /boot sym-links thing been cleaned up?
>
> i didn't see you send any patch to the list. you sent a link to some
> packages and some backhanded remarks about the policy, certainly not a
> good way to get something merged..

I've attached the patch to this message to save you the effort of visiting my 
web site.

You don't like my remarks, I don't like having to re-write patches multiple 
times to get them accepted.  Particularly not simple and obvious patches.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--Boundary-00=_yHdFF9H3MM0626l
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="rjc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rjc.patch"

diff -ru serefpolicy-2.3.7.orig/policy/modules/kernel/kernel.if serefpolicy-2.3.7/policy/modules/kernel/kernel.if
--- serefpolicy-2.3.7.orig/policy/modules/kernel/kernel.if	2006-09-23 22:43:33.000000000 +1000
+++ serefpolicy-2.3.7/policy/modules/kernel/kernel.if	2006-09-23 22:44:06.000000000 +1000
@@ -1978,6 +1978,24 @@
 
 ########################################
 ## <summary>
+##	Allow caller to stat unlabeled processes.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`kernel_getattr_unlabeled_procs',`
+	gen_require(`
+		type unlabeled_t;
+	')
+
+	allow $1 unlabeled_t:process getattr;
+')
+
+########################################
+## <summary>
 ##	Allow caller to relabel unlabeled files.
 ## </summary>
 ## <param name="domain">
diff -ru serefpolicy-2.3.7.orig/policy/modules/services/amavis.fc serefpolicy-2.3.7/policy/modules/services/amavis.fc
--- serefpolicy-2.3.7.orig/policy/modules/services/amavis.fc	2006-08-12 20:57:28.000000000 +1000
+++ serefpolicy-2.3.7/policy/modules/services/amavis.fc	2006-09-23 22:44:06.000000000 +1000
@@ -7,6 +7,6 @@
 /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
 /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
-/var/run/amavis(d)?(/.*)?		gen_context(system_u:object_r:amavis_var_run_t,s0)
+/var/run/amavis(d)?/.+			gen_context(system_u:object_r:amavis_var_run_t,s0)
 /var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
 /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
diff -ru serefpolicy-2.3.7.orig/policy/modules/services/amavis.te serefpolicy-2.3.7/policy/modules/services/amavis.te
--- serefpolicy-2.3.7.orig/policy/modules/services/amavis.te	2006-09-23 22:43:33.000000000 +1000
+++ serefpolicy-2.3.7/policy/modules/services/amavis.te	2006-09-23 22:44:06.000000000 +1000
@@ -50,6 +50,7 @@
 allow amavis_t self:unix_stream_socket create_stream_socket_perms;
 allow amavis_t self:unix_dgram_socket create_socket_perms;
 allow amavis_t self:tcp_socket { listen accept };
+allow amavis_t proc_t:lnk_file read;
 
 # configuration files
 allow amavis_t amavis_etc_t:dir r_dir_perms;
@@ -66,7 +67,6 @@
 allow amavis_t amavis_spool_t:dir manage_dir_perms;
 allow amavis_t amavis_spool_t:file manage_file_perms;
 allow amavis_t amavis_spool_t:sock_file manage_file_perms;
-files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
 type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
 
 # tmp files
@@ -78,8 +78,6 @@
 allow amavis_t amavis_var_lib_t:file create_file_perms;
 allow amavis_t amavis_var_lib_t:sock_file create_file_perms;
 allow amavis_t amavis_var_lib_t:dir create_dir_perms;
-files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
-files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
 
 # log files
 allow amavis_t amavis_var_log_t:file create_file_perms;
diff -ru serefpolicy-2.3.7.orig/policy/modules/services/samba.te serefpolicy-2.3.7/policy/modules/services/samba.te
--- serefpolicy-2.3.7.orig/policy/modules/services/samba.te	2006-09-23 22:43:33.000000000 +1000
+++ serefpolicy-2.3.7/policy/modules/services/samba.te	2006-09-23 22:44:06.000000000 +1000
@@ -521,10 +521,6 @@
 userdom_use_sysadm_ttys(smbmount_t)
 
 optional_policy(`
-	cups_read_rw_config(smbd_t)
-')
-
-optional_policy(`
 	nis_use_ypbind(smbmount_t)
 ')
 
diff -ru serefpolicy-2.3.7.orig/policy/modules/system/unconfined.if serefpolicy-2.3.7/policy/modules/system/unconfined.if
--- serefpolicy-2.3.7.orig/policy/modules/system/unconfined.if	2006-09-23 22:43:33.000000000 +1000
+++ serefpolicy-2.3.7/policy/modules/system/unconfined.if	2006-09-23 22:44:06.000000000 +1000
@@ -89,6 +89,11 @@
 	optional_policy(`
 		storage_unconfined($1)
 	')
+
+	optional_policy(`
+		kernel_getattr_unlabeled_procs($1)
+		kernel_kill_unlabeled($1)
+	')
 ')
 
 ########################################

--Boundary-00=_yHdFF9H3MM0626l--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
