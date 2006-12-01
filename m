Subject: [RFC] Ability to allow unknown class and permissions
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Cc: sds@tycho.nsa.gov, James Morris <jmorris@redhat.com>
Content-Type: multipart/mixed; boundary="=-kGud6Ds9uUQJLIT7GrI0"
Date: Fri, 01 Dec 2006 11:06:57 -0500
Message-Id: <1164989217.2079.106.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-kGud6Ds9uUQJLIT7GrI0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Thanks to recent patches we are able to add new classes and permissions
to the kernel that are not defined in policy.  This gets us half way to
allowing users to track the upstream kernel which introduces new classes
and permissions without having to worry about updating SELinux.  With
the recent patch set messages are emitted that classes or permissions
don't exist in the loaded policy that are needed for the kernel to fully
function but the policy is accepted anyway.  Problem is any attempt to
use the areas of the kernel which now have SELinux coverage will always
be denied.

A great example of the changes and how this might be detrimental to the
user is from the recent patch to make SELinux checks on dccp operations.
If a user was using dccp updated their kernel upstream so now dccp had
appropriate security checks they would not have a policy available to
allow dccp to work.  I feel that most users, outside 'secure'
environments, would rather new protections, like dccp checks be allowed
until their policy is capable of intelligently mediating access.  Since
clearly not all users feel this way and care more about security than
usability it has to be selectable.  In my best guess most 'targeted'
policy users would want new checks to be allowed and most 'mls' policy
users would not.

***Implementation details which might warrant discussion:

To make this selectable I check for a policy rule which has 'special
meaning.'  I don't know if we do this anywhere else, so maybe other have
a better idea how we would like to do this.  My policy rule looks like

allow unlabeled_t unlabeled_t:unknown everything;

If this rule is loaded in a module checks against undefined classes and
permissions will be allowed.  If not they will be denied just the way it
is today.

Denials will show up in the logs just as if it were 'permissive' even
though we are allowing checks against undefined classes and permissions.

Decisions about unknown classes are not cached in the avc.  This can be
relatively easily fixed, but I envision more special case creation of
avd entries (sorta like I do in security_compute_av for
SECCLASS_UNKNWON).  Since that's another part of the patch I'm not sure
people will like I figured I would get comments before I did it more
often.  It would need to be done in avc_has_perm_noaudit when we get
ENOENT back from security_compute_av.

I also really really don't like the way the function
security_class_defined_perm works, but i couldn't find a better way to
figure out if the permission was defined.  At one point I built a really
simple u32 perm_array[128] when we loaded policy and got the result I
get from security_class_defined_perm simply by doing (requested_perm &
perm_array[tclass]) but I didn't like the static array and the waste of
memory.  Maybe it's better than the terrible function I came up with to
find the information.  I'd love opinions.

This patch can still use a lot of cleanup to make it more robust about
mistakes (notice I don't do any checking in security_class_defined_perm
before I use values passed to us to dereference arrays? ewwww huh?) and
those comments are welcome, but comments on the approach and general
implementation would be appreciated.

-Eric

 security/selinux/avc.c                       |   63 +++++++++++++++++++++++++-
 security/selinux/include/av_perm_to_string.h |    1 
 security/selinux/include/av_permissions.h    |    2 +
 security/selinux/include/class_to_string.h   |    1 
 security/selinux/include/flask.h             |    1 
 security/selinux/include/security.h          |    2 +
 security/selinux/ss/services.c               |   48 ++++++++++++++++++--
 7 files changed, 111 insertions(+), 7 deletions(-)

diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index 74c0319..70c3b55 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -825,6 +825,41 @@ int avc_ss_reset(u32 seqno)
 	return rc;
 }
 
+int deny_unknown_checks(void)
+{
+	struct avc_entry entry, *p_ae;
+	struct avc_node *node;
+	int rc;
+	u32 ssid = SECSID_NULL;
+	u32 tsid = SECSID_NULL;
+	u16 tclass = SECCLASS_UNKNOWN;
+	u32 requested = 1;
+	u32 denied;
+
+	rcu_read_lock();
+
+	node = avc_lookup(ssid, tsid, tclass, requested);
+	if (!node) {
+		rcu_read_unlock();
+		rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
+		if (rc) 
+			return rc;
+		rcu_read_lock();
+		node = avc_insert(ssid,tsid,tclass,&entry);
+	}
+
+	p_ae = node ? &node->ae : &entry;
+
+	denied = requested & ~(p_ae->avd.allowed);
+
+	if (denied)
+		return -EACCES;
+
+	rcu_read_unlock();
+
+	return 0;
+}
+
 /**
  * avc_has_perm_noaudit - Check permissions but perform no auditing.
  * @ssid: source security identifier
@@ -859,8 +894,16 @@ int avc_has_perm_noaudit(u32 ssid, u32 t
 	if (!node) {
 		rcu_read_unlock();
 		rc = security_compute_av(ssid,tsid,tclass,requested,&entry.avd);
-		if (rc)
+		if (rc) {
+			if (rc == -ENOENT) {
+				/* tclass not defined: check if well allow undefined */
+				if (deny_unknown_checks())
+					rc = -EACCES;
+				else
+					rc = 0;
+			}
 			goto out;
+		}
 		rcu_read_lock();
 		node = avc_insert(ssid,tsid,tclass,&entry);
 	}
@@ -873,8 +916,22 @@ int avc_has_perm_noaudit(u32 ssid, u32 t
 	denied = requested & ~(p_ae->avd.allowed);
 
 	if (!requested || denied) {
-		if (selinux_enforcing)
-			rc = -EACCES;
+		if (selinux_enforcing) {
+			/* determine if the failure was because of an undefined perm or because of a denial.
+			 * if undefined check deny_unknown_checks().  we can use the avc_update_node() just fine
+			 * even for undefined permissions */
+			int allow_unknown;
+			rcu_read_unlock();
+			allow_unknown = !deny_unknown_checks();
+			rcu_read_lock();
+			if (allow_unknown && security_class_defined_perm(tclass, requested)) {
+				rc = 0;
+				if (node)
+					avc_update_node(AVC_CALLBACK_GRANT,requested,
+						ssid,tsid,tclass);
+			} else
+				rc = -EACCES;
+		}
 		else
 			if (node)
 				avc_update_node(AVC_CALLBACK_GRANT,requested,
diff --git a/security/selinux/include/av_perm_to_string.h b/security/selinux/include/av_perm_to_string.h
index ad9fb2d..321d4b1 100644
--- a/security/selinux/include/av_perm_to_string.h
+++ b/security/selinux/include/av_perm_to_string.h
@@ -260,3 +260,4 @@
    S_(SECCLASS_CONTEXT, CONTEXT__CONTAINS, "contains")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NODE_BIND, "node_bind")
    S_(SECCLASS_DCCP_SOCKET, DCCP_SOCKET__NAME_CONNECT, "name_connect")
+   S_(SECCLASS_UNKNOWN, UNKNOWN__EVERYTHING, "everything")
diff --git a/security/selinux/include/av_permissions.h b/security/selinux/include/av_permissions.h
index 058bbe5..2b26d5d 100644
--- a/security/selinux/include/av_permissions.h
+++ b/security/selinux/include/av_permissions.h
@@ -1002,3 +1002,5 @@ #define DCCP_SOCKET__SEND_MSG           
 #define DCCP_SOCKET__NAME_BIND                    0x00200000UL
 #define DCCP_SOCKET__NODE_BIND                    0x00400000UL
 #define DCCP_SOCKET__NAME_CONNECT                 0x00800000UL
+
+#define UNKNOWN__EVERYTHING                       0x00000001UL
diff --git a/security/selinux/include/class_to_string.h b/security/selinux/include/class_to_string.h
index 9f3ebb1..a7040b8 100644
--- a/security/selinux/include/class_to_string.h
+++ b/security/selinux/include/class_to_string.h
@@ -63,3 +63,4 @@
     S_("key")
     S_("context")
     S_("dccp_socket")
+    S_("unknown")
diff --git a/security/selinux/include/flask.h b/security/selinux/include/flask.h
index 67cef37..bcfbe28 100644
--- a/security/selinux/include/flask.h
+++ b/security/selinux/include/flask.h
@@ -65,6 +65,7 @@ #define SECCLASS_PACKET                 
 #define SECCLASS_KEY                                     58
 #define SECCLASS_CONTEXT                                 59
 #define SECCLASS_DCCP_SOCKET                             60
+#define SECCLASS_UNKNOWN                                 61
 
 /*
  * Security identifier indices for initial entities
diff --git a/security/selinux/include/security.h b/security/selinux/include/security.h
index 1ef7917..28af4a2 100644
--- a/security/selinux/include/security.h
+++ b/security/selinux/include/security.h
@@ -85,6 +85,8 @@ int security_validate_transition(u32 old
 
 int security_sid_mls_copy(u32 sid, u32 mls_sid, u32 *new_sid);
 
+int security_class_defined_perm(u16 tclass, u32 requested_perm);
+
 #define SECURITY_FS_USE_XATTR		1 /* use xattr */
 #define SECURITY_FS_USE_TRANS		2 /* use transition SIDs, e.g. devpts/tmpfs */
 #define SECURITY_FS_USE_TASK		3 /* use task SIDs, e.g. pipefs/sockfs */
diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.c
index 4088204..c957130 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -303,10 +303,25 @@ static int context_struct_compute_av(str
 		    tclass <= SECCLASS_NETLINK_DNRT_SOCKET)
 			tclass = SECCLASS_NETLINK_SOCKET;
 
-	if (!tclass || tclass > policydb.p_classes.nprim) {
-		printk(KERN_ERR "security_compute_av:  unrecognized class %d\n",
-		       tclass);
-		return -EINVAL;
+	if (!tclass || tclass > policydb.p_classes.nprim)
+	{
+		/* 
+		 * special case the checks of SECCLASS_UNKNOWN as the
+		 * whole point of that class is to allow unknown classes 
+		 * and we want a avc entry for future checks if we are 
+		 * allowing unknown.
+		 */
+		if (tclass == SECCLASS_UNKNOWN) {
+			avd->allowed = 0;
+			avd->decided = 0xffffffff;
+			avd->auditallow = 0;
+			avd->auditdeny = 0xffffffff;
+			avd->seqno = latest_granting;
+			return 0;
+		} else
+			printk(KERN_ERR "context_struct_compute_av: unrecognized "
+						"class %d\n", tclass);
+		return -ENOENT;
 	}
 	tclass_datum = policydb.class_val_to_struct[tclass - 1];
 
@@ -1027,6 +1042,31 @@ int security_change_sid(u32 ssid,
 	return security_compute_sid(ssid, tsid, tclass, AVTAB_CHANGE, out_sid);
 }
 
+int security_class_defined_perm(u16 tclass,
+			    u32 requested_perm)
+{
+	struct class_datum *cladatum;
+	struct perm_datum *perdatum;
+	const struct selinux_class_perm *kdefs = &selinux_class_perm;
+	const char *def_class, *def_perm;
+	struct symtab *perms;
+	int perm_num = 0;
+	while (!(requested_perm & 1))
+	{
+		requested_perm = requested_perm >> 1;
+		perm_num++;
+	}
+	def_class = kdefs->class_to_string[tclass];
+	cladatum = hashtab_search(policydb.p_classes.table, def_class);
+	BUG_ON(!cladatum);
+	perms = &cladatum->permissions;
+	def_perm = kdefs->av_perm_to_string[requested_perm].name;
+	perdatum = hashtab_search(perms->table, def_perm);
+	if (perdatum == NULL)
+		return -EINVAL;
+	return 0;
+}
+
 /*
  * Verify that each kernel class that is defined in the
  * policy is correct


--=-kGud6Ds9uUQJLIT7GrI0
Content-Disposition: attachment; filename=policy-unknown-class.patch
Content-Type: text/x-patch; name=policy-unknown-class.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naupr serefpolicy-2.4.5.orig/policy/flask/access_vectors serefpolicy-2.4.5/policy/flask/access_vectors
--- serefpolicy-2.4.5.orig/policy/flask/access_vectors	2006-11-28 14:12:13.000000000 -0500
+++ serefpolicy-2.4.5/policy/flask/access_vectors	2006-11-28 14:12:35.000000000 -0500
@@ -642,3 +642,8 @@ class context
 
 class dccp_socket
 inherits socket
+
+class unknown
+{
+	everything
+}
diff -Naupr serefpolicy-2.4.5.orig/policy/flask/security_classes serefpolicy-2.4.5/policy/flask/security_classes
--- serefpolicy-2.4.5.orig/policy/flask/security_classes	2006-11-28 14:12:13.000000000 -0500
+++ serefpolicy-2.4.5/policy/flask/security_classes	2006-11-28 14:12:50.000000000 -0500
@@ -97,4 +97,6 @@ class context			# userspace
 
 class dccp_socket
 
+class unknown
+
 # FLASK

--=-kGud6Ds9uUQJLIT7GrI0--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
