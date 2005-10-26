Message-ID: <435F0EC9.5010407@cornell.edu>
Date: Wed, 26 Oct 2005 01:06:17 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: [ SEPOL 3 ] Fix MLS memory leaks: interfaces/ports/users
Content-Type: multipart/mixed;
 boundary="------------000701030309010900010001"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000701030309010900010001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This fixes the tricky memory leaks that I've been trying to find...
There are no more sepol leaks that I'm aware of at the moment.

See, all this init/destroy stuff looks so awfully fragile to me - it's 
the cause for all the memory leaks, and it also complicates your error 
recovery sequence. I would much rather prefer a single heap-based 
create() vs free() function, with opaque types that are only exposed to 
a single type. Then I can have at least some confidence that 
init/destroy is being properly done everywhere...

--------------000701030309010900010001
Content-Type: text/x-patch;
 name="libsepol.fix_leaks.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol.fix_leaks.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/interfaces.c new/libsepol/src/interfaces.c
--- old/libsepol/src/interfaces.c	2005-10-25 20:17:53.000000000 -0400
+++ new/libsepol/src/interfaces.c	2005-10-26 00:56:49.000000000 -0400
@@ -184,6 +184,8 @@ int sepol_iface_modify(
 			else
 				prev->next = iface;
 			free(c->u.name);
+			context_destroy(&c->context[0]);
+			context_destroy(&c->context[1]);
 			free(c);
 
 			return STATUS_SUCCESS;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/ports.c new/libsepol/src/ports.c
--- old/libsepol/src/ports.c	2005-10-25 20:42:07.000000000 -0400
+++ new/libsepol/src/ports.c	2005-10-26 00:57:00.000000000 -0400
@@ -270,6 +270,7 @@ int sepol_port_modify(
 				policydb->ocontexts[OCON_PORT] = port;
 			else
 				prev->next = port;
+			context_destroy(&c->context[0]);
 			free(c);
 
 			return STATUS_SUCCESS;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude direct_api.c --exclude semanage_store.c --exclude VERSION --exclude libsemanage.map --exclude 'module_record*' --exclude 'database_directory*' --exclude Makefile old/libsepol/src/users.c new/libsepol/src/users.c
--- old/libsepol/src/users.c	2005-10-25 20:42:07.000000000 -0400
+++ new/libsepol/src/users.c	2005-10-26 00:52:16.000000000 -0400
@@ -147,16 +147,18 @@ int sepol_user_modify(
 
 	/* If it does, we will modify it */
 	if (usrdatum) {
-		role_set_destroy(&usrdatum->roles);
-		role_set_init(&usrdatum->roles);
+
+		int value_cp = usrdatum->value;
+		user_datum_destroy(usrdatum);
+		user_datum_init(usrdatum);
+		usrdatum->value = value_cp;
 
 	/* Otherwise, create a new one */
 	} else {
 		usrdatum = (user_datum_t *) malloc(sizeof(user_datum_t));
 		if (!usrdatum) 
 			goto omem;
-		memset(usrdatum, 0, sizeof(user_datum_t));
-		role_set_init(&usrdatum->roles);
+		user_datum_init(usrdatum);
 		new = 1;
 	}
 

--------------000701030309010900010001--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
