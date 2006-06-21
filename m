Subject: [PATCH] refpolicy: add keycreate process attribute
From: Michael LeMay <mdlemay@epoch.ncsc.mil>
To: selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:08:48 -0400
Message-Id: <1150895328.3256.15.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Now that the kernel patch for the keycreate process attribute has been
finalized, the following patch should be applied to refpolicy.  It not
only adds the new permissions, but also updates a few system policies
to permit GDM and the login program to modify the attribute.  I'm
currently working with David to patch those programs in Fedora, and
those changes should eventually make it upstream for other
distributions.

---<snip>---
From: Michael LeMay <mdlemay@epoch.ncsc.mil>

Add the "setkeycreate" permission to the "process" class.  This
controls which domains can set the "keycreate" process attribute.
Add the "create" permission to the "key" class.  This is checked
before the "keycreate" process attribute is updated, and controls
which contexts may be assigned to the attribute.  Update the
policies for xdm_t and local_login_t so that programs within those
domains can set the "keycreate" process attribute.

Signed-off-by: Michael LeMay <mdlemay@epoch.ncsc.mil>

---

 policy/flask/access_vectors         |    2 ++
 policy/modules/services/xserver.te  |    5 ++++-
 policy/modules/system/locallogin.te |    6 ++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff -uprN refpolicy.orig/policy/flask/access_vectors refpolicy.keycreate/policy/flask/access_vectors
--- refpolicy.orig/policy/flask/access_vectors	2006-06-20 15:14:04.000000000 -0400
+++ refpolicy.keycreate/policy/flask/access_vectors	2006-06-20 15:25:16.000000000 -0400
@@ -252,6 +252,7 @@ class process
 	execmem
 	execstack
 	execheap
+	setkeycreate
 }
 
 
@@ -629,4 +630,5 @@ class key
 	search
 	link
 	setattr
+	create
 }
diff -uprN refpolicy.orig/policy/modules/services/xserver.te refpolicy.keycreate/policy/modules/services/xserver.te
--- refpolicy.orig/policy/modules/services/xserver.te	2006-06-20 15:14:12.000000000 -0400
+++ refpolicy.keycreate/policy/modules/services/xserver.te	2006-06-20 15:51:50.000000000 -0400
@@ -80,7 +80,7 @@ optional_policy(`
 #
 
 allow xdm_t self:capability { setgid setuid sys_resource kill sys_tty_config mknod chown dac_override dac_read_search fowner fsetid ipc_owner sys_nice sys_rawio net_bind_service };
-allow xdm_t self:process { setexec setpgid setsched setrlimit signal_perms };
+allow xdm_t self:process { setexec setpgid setsched setrlimit signal_perms setkeycreate };
 allow xdm_t self:fifo_file rw_file_perms;
 allow xdm_t self:shm create_shm_perms;
 allow xdm_t self:sem create_sem_perms;
@@ -313,6 +313,7 @@ ifdef(`targeted_policy',`
 	unconfined_domtrans(xdm_t)
 	userdom_generic_user_home_dir_filetrans_generic_user_home_content(xdm_t, {file dir })
 
+	allow xdm_t unconfined_t:key create;
 ')
 
 tunable_policy(`use_nfs_home_dirs',`
@@ -433,6 +434,8 @@ ifdef(`strict_policy',`
 	userdom_read_unpriv_users_home_content_files(xdm_xserver_t)
 
 	xserver_use_all_users_fonts(xdm_xserver_t)
+
+	allow xdm_t { sysadm_t staff_t user_t }:key create;
 ')
 
 ifdef(`targeted_policy',`
diff -uprN refpolicy.orig/policy/modules/system/locallogin.te refpolicy.keycreate/policy/modules/system/locallogin.te
--- refpolicy.orig/policy/modules/system/locallogin.te	2006-06-20 15:14:12.000000000 -0400
+++ refpolicy.keycreate/policy/modules/system/locallogin.te	2006-06-20 15:49:53.000000000 -0400
@@ -176,6 +176,12 @@ mta_getattr_spool(local_login_t)
 ifdef(`targeted_policy',`
 	unconfined_domain(local_login_t)
 	unconfined_shell_domtrans(local_login_t)
+
+	allow local_login_t unconfined_t:key create;
+')
+
+ifdef(`strict_policy',`
+	allow local_login_t { sysadm_t staff_t user_t }:key create;
 ')
 
 tunable_policy(`read_default_t',`



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
