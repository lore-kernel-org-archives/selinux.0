Message-ID: <4534FE1E.4080502@trustedcs.com>
Date: Tue, 17 Oct 2006 11:00:30 -0500
From: Darrel Goeddel <dgoeddel@TrustedCS.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        Linda Knippers <linda.knippers@hp.com>,
        Daniel Walsh <dwalsh@redhat.com>
Subject: [PATCH 3/4] reference policy support for setransd enhancement
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch is for the fedora policy.  I can "translate" (pun?) this to the
current CVS policy if necessary.

Add the flask definitions for the new context class (and add the setsockcreate
to the process class so the generated headers do not miss things) and the
corresponding mlsconstraint.

Add an interface that will allow a domain the ability to override the MLS
check when translating contexts (mls_context_translate_all_levels).

Make the setrans daemon run at the highest MLS label and protect the config
file at the same label (and make this work by adding mls_socket_write_all_levels
to the setransd policy).

Allow the translating domain TE access to translate contexts with the setrans_t
type.  This is the type that the daemon will use when doing the check.  The
type is from the running setransd process.

---

 policy/flask/access_vectors          |    6 ++++++
 policy/flask/security_classes        |    2 ++
 policy/mls                           |   10 ++++++++++
 policy/modules/kernel/mls.if         |   20 ++++++++++++++++++++
 policy/modules/kernel/mls.te         |    4 +++-
 policy/modules/system/selinuxutil.fc |    1 +
 policy/modules/system/setrans.if     |    1 +
 policy/modules/system/setrans.te     |    1 +
 8 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/policy/flask/access_vectors b/policy/flask/access_vectors
index 5d4f36a..6770ff1 100644
--- a/policy/flask/access_vectors
+++ b/policy/flask/access_vectors
@@ -253,6 +253,7 @@ class process
 	execstack
 	execheap
 	setkeycreate
+	setsockcreate
 }
 
 
@@ -632,3 +633,8 @@ class key
 	setattr
 	create
 }
+
+class context
+{
+	translate
+}
diff --git a/policy/flask/security_classes b/policy/flask/security_classes
index 57f49bc..53c0cf1 100644
--- a/policy/flask/security_classes
+++ b/policy/flask/security_classes
@@ -93,4 +93,6 @@ class packet
 # Kernel access key retention
 class key
 
+class context			# userspace
+
 # FLASK
diff --git a/policy/mls b/policy/mls
index 06085c5..fb70a32 100644
--- a/policy/mls
+++ b/policy/mls
@@ -617,4 +617,14 @@ mlsconstrain association { polmatch }
 	((( l1 dom l2 ) and ( h1 domby h2 )) or
 	 ( t2 == unlabeled_t ));
 
+
+
+
+#
+# MLS policy for the context class
+#
+
+mlsconstrain context translate
+	(( h1 dom h2 ) or ( t1 == mlstranslate ));
+
 ') dnl end enable_mls
diff --git a/policy/modules/kernel/mls.if b/policy/modules/kernel/mls.if
index 5ca509e..8946213 100644
--- a/policy/modules/kernel/mls.if
+++ b/policy/modules/kernel/mls.if
@@ -451,3 +451,23 @@ interface(`mls_fd_share_all_levels',`
 
 	typeattribute $1 mlsfdshare;
 ')
+
+########################################
+## <summary>
+##	Make specified domain MLS trusted
+##	for translating contexts at all levels.
+## </summary>
+## <param name="domain">
+##	<summary>
+##	Domain allowed access.
+##	</summary>
+## </param>
+#
+interface(`mls_context_translate_all_levels',`
+	gen_require(`
+		attribute mlstranslate;
+	')
+
+	typeattribute $1 mlstranslate;
+')
+
diff --git a/policy/modules/kernel/mls.te b/policy/modules/kernel/mls.te
index 6e5cb9f..3dce831 100644
--- a/policy/modules/kernel/mls.te
+++ b/policy/modules/kernel/mls.te
@@ -50,6 +50,8 @@ attribute mlsrangetrans;
 attribute mlsfduse; 
 attribute mlsfdshare;
 
+attribute mlstranslate;
+
 ########################################
 #
 # THIS IS A HACK
@@ -67,6 +69,6 @@ ifdef(`enable_mls',`
 range_transition initrc_t auditd_exec_t s15:c0.c1023;
 range_transition kernel_t init_exec_t s0 - s15:c0.c1023;
 range_transition kernel_t lvm_exec_t s0 - s15:c0.c1023;
-#range_transition initrc_t setrans_exec_t s15:c0.c1023;
+range_transition initrc_t setrans_exec_t s15:c0.c1023;
 range_transition run_init_t initrc_exec_t s0 - s15:c0.c1023;
 ')
diff --git a/policy/modules/system/selinuxutil.fc b/policy/modules/system/selinuxutil.fc
index 78d5e51..4641575 100644
--- a/policy/modules/system/selinuxutil.fc
+++ b/policy/modules/system/selinuxutil.fc
@@ -7,6 +7,7 @@ #
 /etc/selinux/([^/]*/)?contexts(/.*)?	gen_context(system_u:object_r:default_context_t,s0)
 /etc/selinux/([^/]*/)?contexts/files(/.*)? gen_context(system_u:object_r:file_context_t,s0)
 /etc/selinux/([^/]*/)?policy(/.*)?	gen_context(system_u:object_r:policy_config_t,s15:c0.c1023)
+/etc/selinux/([^/]*/)?setrans\.conf	--	gen_context(system_u:object_r:selinux_config_t,s15:c0.c1023)
 /etc/selinux/([^/]*/)?seusers	--	gen_context(system_u:object_r:selinux_config_t,s15:c0.c1023)
 /etc/selinux/([^/]*/)?modules/(active|tmp|previous)(/.*)?     gen_context(system_u:object_r:semanage_store_t,s0)
 /etc/selinux/([^/]*/)?modules/semanage\.read\.LOCK    --	gen_context(system_u:object_r:semanage_read_lock_t,s0)
diff --git a/policy/modules/system/setrans.if b/policy/modules/system/setrans.if
index 9547503..94f2c53 100644
--- a/policy/modules/system/setrans.if
+++ b/policy/modules/system/setrans.if
@@ -22,4 +22,5 @@ interface(`setrans_translate_context',`
 	allow $1 setrans_var_run_t:sock_file rw_file_perms;
 	allow $1 setrans_var_run_t:dir search_dir_perms;
 	files_list_pids($1)
+	allow $1 setrans_t:context translate;
 ')
diff --git a/policy/modules/system/setrans.te b/policy/modules/system/setrans.te
index 2d54d0a..dd68201 100644
--- a/policy/modules/system/setrans.te
+++ b/policy/modules/system/setrans.te
@@ -53,6 +53,7 @@ mls_file_read_up(setrans_t)
 mls_file_write_down(setrans_t)
 mls_net_receive_all_levels(setrans_t)
 mls_socket_read_all_levels(setrans_t)
+mls_socket_write_all_levels(setrans_t)
 mls_rangetrans_target(setrans_t)
 mls_fd_use_all_levels(setrans_t)
 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
