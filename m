Subject: Re: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool
	-P	to	use	libsemanage
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: Daniel J Walsh <dwalsh@redhat.com>, selinux@tycho.nsa.gov,
   Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, James Morris <jmorris@redhat.com>,
   Chad Sellers <csellers@tresys.com>
In-Reply-To: <1131371323.20591.16.camel@moss-spartans.epoch.ncsc.mil>
References: <436915FB.3040500@tresys.com>
	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>
	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>
	 <1131116390.23420.247.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8185.4050508@cornell.edu>
	 <1131118424.23420.265.camel@moss-spartans.epoch.ncsc.mil>
	 <436B8771.60203@redhat.com>
	 <1131120757.23420.279.camel@moss-spartans.epoch.ncsc.mil>
	 <1131121900.23420.288.camel@moss-spartans.epoch.ncsc.mil>
	 <436BD878.1070300@cornell.edu>  <436BD9DB.2050700@cornell.edu>
	 <1131371323.20591.16.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed; boundary="=-avCQLuHWAneeUUZcvBgH"
Date: Mon, 07 Nov 2005 09:56:36 -0500
Message-Id: <1131375396.20591.20.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-avCQLuHWAneeUUZcvBgH
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2005-11-07 at 08:48 -0500, Stephen Smalley wrote:
> Let me clarify:  setsebool needs to fall back to the original behavior
> (i.e. direct call to security_set_boolean_list with permanent=1) if the
> system policy is not managed via libsemanage.  So I'm not talking about
> having libsemanage and/or setsebool automatically initialize the
> sandbox; I'm just talking about having a fall back to the original
> behavior for setting persistent boolean values on non-managed systems.
> In order to do this, we need to be able to detect whether the system
> policy is managed via libsemanage.  Which leads us to the next point...

Something like the patch below (un-tested):


-- 
Stephen Smalley
National Security Agency

--=-avCQLuHWAneeUUZcvBgH
Content-Disposition: attachment; filename=ismanaged.patch
Content-Type: text/x-patch; name=ismanaged.patch; charset=utf-8
Content-Transfer-Encoding: 7bit

Index: libsemanage/include/semanage/handle.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/include/semanage/handle.h,v
retrieving revision 1.4
diff -u -p -r1.4 handle.h
--- libsemanage/include/semanage/handle.h	7 Nov 2005 15:12:44 -0000	1.4
+++ libsemanage/include/semanage/handle.h	7 Nov 2005 15:38:01 -0000
@@ -63,6 +63,13 @@ void semanage_set_reload(semanage_handle
  * 1 for yes, 0 for no (default */
 int semanage_set_reload_bools(semanage_handle_t *sh, int do_reload);
 
+/* Check whether policy is managed via libsemanage on this system.
+ * Must be called prior to trying to connect.
+ * Return 1 if policy is managed via libsemanage on this system,
+ * 0 if policy is not managed, or -1 on error.
+ */
+int semanage_is_managed(semanage_handle_t *);
+
 /* "Connect" to a manager based on the configuration and 
  * associate the provided handle with the connection.
  * If the connect fails then this function returns a negative value, 
Index: libsemanage/src/direct_api.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/direct_api.c,v
retrieving revision 1.21
diff -u -p -r1.21 direct_api.c
--- libsemanage/src/direct_api.c	4 Nov 2005 16:16:35 -0000	1.21
+++ libsemanage/src/direct_api.c	7 Nov 2005 15:39:23 -0000
@@ -74,6 +74,24 @@ static struct semanage_policy_table dire
 	.list = semanage_direct_list
 };
 
+int semanage_direct_is_managed(semanage_handle_t *sh) {
+	char polpath[PATH_MAX];
+
+	snprintf(polpath, PATH_MAX, "%s%s", selinux_path(), sh->conf->store_path);
+	
+	if (semanage_check_init(polpath))
+		goto err;
+
+	if (semanage_create_store(sh, 0) < 0) 
+		return 0;
+
+	return 1;
+
+	err:
+	ERR(sh, "could not check whether policy is managed");
+	return STATUS_ERR;	
+}
+
 /* Check that the module store exists, creating it if necessary.
  */
 int semanage_direct_connect(semanage_handle_t *sh) {
Index: libsemanage/src/direct_api.h
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/direct_api.h,v
retrieving revision 1.2
diff -u -p -r1.2 direct_api.h
--- libsemanage/src/direct_api.h	30 Sep 2005 19:23:36 -0000	1.2
+++ libsemanage/src/direct_api.h	7 Nov 2005 15:24:08 -0000
@@ -23,5 +23,6 @@
 #include "handle.h"
 
 int semanage_direct_connect(semanage_handle_t *sh);
+int semanage_direct_is_managed(semanage_handle_t *sh);
 
 #endif
Index: libsemanage/src/handle.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/handle.c,v
retrieving revision 1.17
diff -u -p -r1.17 handle.c
--- libsemanage/src/handle.c	7 Nov 2005 15:12:44 -0000	1.17
+++ libsemanage/src/handle.c	7 Nov 2005 15:40:09 -0000
@@ -122,6 +122,23 @@ void semanage_select_store(semanage_hand
 	return;
 }
 
+int semanage_is_managed(semanage_handle_t *sh)
+{
+	assert(sh != NULL);
+	if (sh->is_connected) {
+		ERR(sh, "Already connected.");
+		return -1;
+	}
+	switch (sh->conf->store_type) {
+	case SEMANAGE_CON_DIRECT:
+		return semanage_direct_is_managed(sh);
+	default:
+		ERR(sh, "The connection type specified within your semanage.conf file has not been implemented yet.");
+		/* fall through */
+	}
+	return -1;
+}
+
 int semanage_connect(semanage_handle_t *sh) {
 	assert(sh != NULL);
 	switch (sh->conf->store_type) {
@@ -132,8 +149,8 @@ int semanage_connect(semanage_handle_t *
 		break;
 	}
 	default: {
-		fprintf(stderr, "The connection type specified within your semanage.conf file has not been implemented yet.\n");
-		exit(EXIT_FAILURE);
+		ERR(sh, "The connection type specified within your semanage.conf file has not been implemented yet.");
+		return -1;
 	}
 	}
 	sh->is_connected = 1;
Index: libsemanage/src/libsemanage.map
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/libsemanage/src/libsemanage.map,v
retrieving revision 1.6
diff -u -p -r1.6 libsemanage.map
--- libsemanage/src/libsemanage.map	7 Nov 2005 15:12:44 -0000	1.6
+++ libsemanage/src/libsemanage.map	7 Nov 2005 15:41:50 -0000
@@ -1,6 +1,6 @@
 LIBSEMANAGE_1.0 {
   global: semanage_handle_create; semanage_handle_destroy; 
-          semanage_connect; semanage_disconnect; 
+          semanage_is_managed; semanage_connect; semanage_disconnect; 
 	  semanage_msg_*;
           semanage_begin_transaction; semanage_commit;
           semanage_module_install; semanage_module_upgrade;
Index: policycoreutils/setsebool/setsebool.c
===================================================================
RCS file: /nfshome/pal/CVS/selinux-usr/policycoreutils/setsebool/setsebool.c,v
retrieving revision 1.2
diff -u -p -r1.2 setsebool.c
--- policycoreutils/setsebool/setsebool.c	7 Nov 2005 15:12:45 -0000	1.2
+++ policycoreutils/setsebool/setsebool.c	7 Nov 2005 15:40:40 -0000
@@ -80,6 +80,7 @@ int semanage_set_boolean_list(size_t boo
 	semanage_handle_t* handle = NULL;
 	semanage_bool_t* boolean = NULL;
 	semanage_bool_key_t* bool_key = NULL;
+	int managed;
 
 	handle = semanage_handle_create();
 	if (handle == NULL) {
@@ -87,6 +88,22 @@ int semanage_set_boolean_list(size_t boo
 		goto err;
 	}
 
+	managed = semanage_is_managed(handle);
+	if (managed < 0) {
+		fprintf(stderr, "Error when checking whether policy is managed\n"); 
+		goto err;
+	} else if (managed == 0) {
+		if (security_set_boolean_list(boolcnt, boollist, 1)) {
+			if (errno == ENOENT) 
+				fprintf(stderr, "Error setting boolean: "
+					"Invalid boolean\n");
+			else if (errno)
+				perror("Error setting booleans");
+			goto err;
+		}
+		goto out;
+	}
+
 	if (semanage_connect(handle) < 0)
 		goto err;
 
@@ -122,6 +139,8 @@ int semanage_set_boolean_list(size_t boo
 		goto err;
 
 	semanage_disconnect(handle);
+
+        out:
 	semanage_handle_destroy(handle);
 	return 0;
 

--=-avCQLuHWAneeUUZcvBgH--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
