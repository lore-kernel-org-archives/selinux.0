Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA27988
	for <selinux@tycho.nsa.gov>; Tue, 23 Jul 2002 23:34:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id DAA25332
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 03:33:43 GMT
Received: from snoopy.apana.org.au (snoopy.apana.org.au [203.12.237.97])
	by jazzswing.ncsc.mil  with ESMTP id DAA25328
	for <selinux@tycho.nsa.gov>; Wed, 24 Jul 2002 03:33:37 GMT
Subject: Re: user mount permissions
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@tislabs.com>,
        Ryan Bergauer <privateryan@mindspring.com>, selinux@tycho.nsa.gov,
        Brian May <bam@debian.org>
In-Reply-To: <20020723101402.BBAE56D13@lyta.coker.com.au>
References: <Pine.GSO.4.33.0207170742190.18645-100000@raven>
	<20020723101402.BBAE56D13@lyta.coker.com.au>
Content-Type: text/plain
Date: 24 Jul 2002 13:34:09 +1000
Message-Id: <1027481649.8878.149.camel@scrooge>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2002-07-23 at 20:14, Russell Coker wrote:
> Brian, how's your work on this going?  Got anything ready to post here?

My solution (although I haven't tested it recently...) was to apply the
changes (attached). I was debating whether or not it would be OK to
rename mount_t to sysadm_mount_t (if so, you could remove the extra
parameter, making it look more like the other macros). However, mount_t
is used in a lot of places.


I am currently not really happy with the current policy written in M4,
it seems full of assumptions like this one, that nobody but root will
want to run these programs.

Another example seems to be mailq, from postfix, which requires access
to either sysadm_tty_device_t or user_tty_device_t depending on who uses
it. At the moment, I have allowed it access to both, but this isn't
really ideal.

One solution might be to rewrite everything to use macros (as I have
done here with mount). However, there are still implicit assumptions
made regarding policy, that IMHO don't need to occur (eg, if you want to
split user_t up, there are a lot of separate files you would have to
edit).

I have been considering writing a XML based layer on-top of the M4 layer
(or could be used instead) that solves these issues by enforcing some
structure into the policy.

For instance, my current idea is to split policy files into several
"types":

        * package files: contain the bare minimum domain and type
          declarations. eg stuff like "domain mount can modify
          /etc/mtab", but not stuff like "when running mount_exec_t from
          user_t domain enter user_mount_exec_t domain". The package
          file also creates a local name space for that package. (don't
          get confused with deb or rpm packages here; you could have one
          package file per package, but that isn't currently required).
        * glue files: "macros" that contain the logic needed to "glue"
          several domains together. For instance, this would create a
          ($user)_mount_t domain based on the domain in the package
          file, that has access ($user)_devpts_t and
          ($user)_tty_device_t. The glue file is also responsible of
          transitioning from ($user)_t domain into ($user)_mount_t
          domain.
        * local files: use the glue file to create a transition between
          user_t domain and user_mount_t domain.
        * file_contexts: this is unchanged.


This is rather condensed, and I am still working on an example. When I
get an example, it might be easier to understand.

The idea is that you extract local policy decisions from the package
files and put them into the local files, so when you upgrade the package
file you don't have to reintegrate your local changes.

I am not sure about the glue files, these are currently required so you
don't have to rewrite lots of stuff per each user per each domain.

Instead of having ifdef('package',...), these rules would go into the
global files instead (directly or indirectly via glue files), which
defines local policy.

Obviously there are still a number of rough edges.

Comments anyone?


Anyway, here are my changes for mount. You should change the /flash
reference to what mount points you want to use...

This is based on the policy file in Russell's package.

A fix for guile shared libraries also got in.

diff -ruN --exclude-from=exclude policy/domains/program/mount.te local/domains/program/mount.te
--- policy/domains/program/mount.te	Tue Jul 16 11:54:25 2002
+++ local/domains/program/mount.te	Sat Jul 20 10:31:59 2002
@@ -1,5 +1,10 @@
 #
-# Authors:  Mark Westerman mark.westerman@csoconline.com
+# Macros for mount
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+# based on the work of:
+#          Mark Westerman mark.westerman@csoconline.com
 #
 
 #################################
@@ -7,25 +12,12 @@
 # Rules for the mount_t domain.
 #
 # mount_t is the domain for the mount process.
-# mount_exec_t is the type of the corresponding program.
 #
-type mount_t, domain, privlog;
+mount_domain(sysadm,mount)
 role system_r types mount_t;
 role sysadm_r types mount_t;
-every_domain(mount_t)
-type mount_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, mount_exec_t, mount_t)
 type_transition init_t mount_exec_t:process mount_t;
-domain_auto_trans(sysadm_t, mount_exec_t, mount_t)
-
-type mount_tmp_t, file_type, sysadmfile, tmpfile;
-file_type_auto_trans(mount_t, tmp_t, mount_tmp_t)
-
-# Use capabilities.
-allow mount_t mount_t:capability { sys_admin sys_rawio dac_override net_bind_service };
-
-# Create and modify /etc/mtab.
-file_type_auto_trans(mount_t, etc_t, etc_runtime_t)
 
 # Inherit and use descriptors from init.
 allow mount_t init_t:fd use;
@@ -47,14 +39,19 @@
 # Mount on the automount mount point.
 ifdef(`automount.te', `allow mount_t automount_tmp_t:dir { search mounton };')
 
-# Access the terminal.
-allow mount_t sysadm_tty_device_t:chr_file rw_file_perms;
-allow mount_t sysadm_devpts_t:chr_file rw_file_perms;
-ifdef(`gnome-pty-helper.te', `allow mount_t sysadm_gph_t:fd use;')
-
 # Communicate with portmap.
 ifdef(`portmap.te',
 `can_udp_send(mount_t, portmap_t)
 can_udp_send(portmap_t, mount_t)')
 

+#################################
+#
+# Rules for the user_mount_t domain.
+#
+# user_mount_t is the domain for the mount process.
+#
+in_user_role(user_mount_t);
+mount_domain(user,user_mount)
+domain_auto_trans(user_t, mount_exec_t, user_mount_t)
+allow user_mount_t file_t:dir mounton;
diff -ruN --exclude-from=exclude policy/file_contexts/types.fc local/file_contexts/types.fc
--- policy/file_contexts/types.fc	Tue Jul 16 11:54:25 2002
+++ local/file_contexts/types.fc	Sat Jul 20 10:31:59 2002
@@ -207,6 +207,7 @@
 /usr/lib/selinux(|/.*)		system_u:object_r:policy_src_t
 /usr/lib/emacsen-common/.*	system_u:object_r:bin_t
 /usr/lib/.*/bin(|/.*)		system_u:object_r:bin_t
+/usr/share/guile/g-wrapped/.*\.so	system_u:object_r:shlib_t
 /usr/share/locale/.*/LC_.* 	system_u:object_r:writeable_t
 /usr/share/selinux(|/.*)	system_u:object_r:policy_src_t
 /usr/games(|/.*)		system_u:object_r:bin_t
@@ -322,3 +323,8 @@
 #
 .*/lost\+found(|/.*)		system_u:object_r:lost_found_t
 
+
+#
+# for the /flash mountpoint
+#
+/flash(|/.*)			system_u:object_r:mountable_t
diff -ruN --exclude-from=exclude policy/macros/program/mount_macros.te local/macros/program/mount_macros.te
--- policy/macros/program/mount_macros.te	Thu Jan  1 10:00:00 1970
+++ local/macros/program/mount_macros.te	Sat Jul 20 10:31:59 2002
@@ -0,0 +1,40 @@
+#
+# Macros for mount
+#
+# Author:  Brian May <bam@snoopy.apana.org.au>
+#
+
+# mount_exec_t is the type of the corresponding program.
+type mount_exec_t, file_type, sysadmfile, exec_type;
+
+#
+# mount_domain(domain_prefix,dst_domain_prefix)
+#
+# Define a derived domain for the mount program for anyone.
+#
+define(`mount_domain', `
+#
+# Rules for the $2_t domain, used by the $1_t domain.
+#
+# $2_t is the domain for the mount process.
+#
+type $2_t, domain, privlog;
+
+every_domain($2_t)
+# when mount is run by $1_t goto $2_t domain
+domain_auto_trans($1_t, mount_exec_t, $2_t)
+
+type $2_tmp_t, file_type, sysadmfile, tmpfile;
+file_type_auto_trans($2_t, tmp_t, $2_tmp_t)
+
+# Use capabilities.
+allow $2_t $2_t:capability { sys_admin sys_rawio dac_override net_bind_service };
+
+# Create and modify /etc/mtab.
+file_type_auto_trans($2_t, etc_t, etc_runtime_t)
+
+# Access the terminal.
+allow $2_t $1_tty_device_t:chr_file rw_file_perms;
+allow $2_t $1_devpts_t:chr_file rw_file_perms;
+ifdef(`gnome-pty-helper.te', `allow $2_t $1_gph_t:fd use;')
+')
-- 
Brian May <bam@snoopy.apana.org.au>


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
