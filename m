Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8RCptNs021574
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 08:51:56 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8RCkVpk003747
	for <selinux@tycho.nsa.gov>; Tue, 27 Sep 2005 12:46:31 GMT
Message-Id: <200509271246.j8RCkcYs026042@gotham.columbia.tresys.com>
From: "Karl MacMillan" <kmacmillan@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: "'Joshua Brindle'" <jbrindle@tresys.com>
Subject: [PATCH] semanage-functionality 4/17
Date: Tue, 27 Sep 2005 08:46:38 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0019_01C5C33F.F9B6A620"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.

------=_NextPart_000_0019_01C5C33F.F9B6A620
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

This patch adds semanage.h - this is the new public interface for
libsemanage.

------
Karl MacMillan
Tresys Technology
http://www.tresys.com 


------=_NextPart_000_0019_01C5C33F.F9B6A620
Content-Type: application/octet-stream;
	name="libsemanage_include_semanage_semanage.h.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="libsemanage_include_semanage_semanage.h.diff"

diff -purN -x .svn libsemanage/include/semanage/semanage.h =
libsemanage/include/semanage/semanage.h=0A=
--- libsemanage/include/semanage/semanage.h	1969-12-31 =
19:00:00.000000000 -0500=0A=
+++ libsemanage/include/semanage/semanage.h	2005-09-26 =
09:59:04.000000000 -0400=0A=
@@ -0,0 +1,203 @@=0A=
+/* Authors: Joshua Brindle  <jbrindle@tresys.com>=0A=
+ *	    Jason Tang	    <jtang@tresys.com>=0A=
+ *=0A=
+ * Copyright (C) 2005 Tresys Technology, LLC=0A=
+ *=0A=
+ *  This library is free software; you can redistribute it and/or=0A=
+ *  modify it under the terms of the GNU Lesser General Public=0A=
+ *  License as published by the Free Software Foundation; either=0A=
+ *  version 2.1 of the License, or (at your option) any later version.=0A=
+ *=0A=
+ *  This library is distributed in the hope that it will be useful,=0A=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU=0A=
+ *  Lesser General Public License for more details.=0A=
+ *=0A=
+ *  You should have received a copy of the GNU Lesser General Public=0A=
+ *  License along with this library; if not, write to the Free Software=0A=
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =
02110-1301  USA=0A=
+ */=0A=
+=0A=
+#ifndef SEMANAGE_H=0A=
+#define SEMANAGE_H=0A=
+=0A=
+/* This #include needed to get struct timeval. */=0A=
+#include <sys/time.h>=0A=
+=0A=
+/* All accesses with semanage is through a "semanage_handle".  This=0A=
+ * handler may be with the monolithic policy, directly to a module=0A=
+ * store, or with a policy management server.  The handler represents=0A=
+ * a persistent connection to that policy manager.  It is created=0A=
+ * through a semanage_connect() call and must be afterwards=0A=
+ * deallocated with semanage_handle_destroy(). */=0A=
+typedef struct semanage_handle semanage_handle_t;=0A=
+=0A=
+/* Initialize the library - this needs to be called first. This loads=0A=
+ * any defaults from the configuration files and performs any other=0A=
+ * needed initialization.=0A=
+ * =0A=
+ * returns:=0A=
+ *	0	success=0A=
+ *	-1	general error=0A=
+ *	-2	error parsing configuration files=0A=
+ *=0A=
+ * WARNING: This function is NOT thread-safe.=0A=
+ */=0A=
+int semanage_init(void);=0A=
+=0A=
+/* "Connect" to a manager, as specified in the file=0A=
+ * /etc/selinux/semanage.conf.	This function always allocates a new=0A=
+ * semanage_handle_t and assigns it to the passed reference pointer.=0A=
+ * The caller is later responsible for deallocating the pointer by=0A=
+ * calling semanage_handle_destroy().  If the connect fails then this=0A=
+ * function returns a negative value, else it returns zero.=0A=
+ */=0A=
+int semanage_connect(semanage_handle_t **);=0A=
+=0A=
+/* Disconnect from the manager given by the handle.  If already=0A=
+ * disconnected then this function does nothing.  Return 0 if=0A=
+ * disconnected properly or already disconnected, negative value on=0A=
+ * error. */=0A=
+int semanage_disconnect(semanage_handle_t *);=0A=
+=0A=
+/* Deallocate all space associated with a semanage_handle_t, including=0A=
+ * the pointer itself.	CAUTION: this function does not disconnect=0A=
+ * from the manager; be sure that a semanage_disconnect() was=0A=
+ * previously called. */=0A=
+void semanage_handle_destroy(semanage_handle_t *);=0A=
+=0A=
+/* Return a string describing the most recently encountered error=0A=
+ * associated with a semanage_handle_t.	 The returned string must not=0A=
+ * be modified by the caller.  Be aware that this string is not=0A=
+ * persistent; future calls to this library may alter the buffer=0A=
+ * contents, so make a copy of it if necessary.=0A=
+ */=0A=
+const char *semanage_strerror(semanage_handle_t *);=0A=
+=0A=
+=0A=
+/* Attempt to obtain a transaction lock on the manager.	 If another=0A=
+ * process has the lock then this function may block, depending upon=0A=
+ * the timeout value in the handle.=0A=
+ *=0A=
+ * Note that if the semanage_handle has not yet obtained a transaction=0A=
+ * lock whenever a writer function is called, there will be an=0A=
+ * implicit call to this function. */=0A=
+int semanage_begin_transaction(semanage_handle_t *);=0A=
+=0A=
+/* Attempt to commit all changes since this transaction began.	If the=0A=
+ * commit is successful then increment the "policy sequence number"=0A=
+ * and then release the transaction lock.  Return that policy number=0A=
+ * afterwards, or -1 on error.=0A=
+ */=0A=
+int semanage_commit(semanage_handle_t *);=0A=
+=0A=
+=0A=
+/* META NOTES=0A=
+ *=0A=
+ * All of the below functions expect a semanage_handle as its first=0A=
+ * parameter.  If an error occurs then the function returns a negative=0A=
+ * value.  Call semanage_strerror() to retrieve a string that fully=0A=
+ * describes the error.=0A=
+ *=0A=
+ * For all functions a non-negative number indicates success. For query =0A=
+ * fucntions a >=3D0 returned value is the "policy sequence number".  =
This=0A=
+ * number keeps tracks of policy revisions and is used to detect if=0A=
+ * one semanage client has committed policy changes while another is=0A=
+ * still connected.=0A=
+ */=0A=
+=0A=
+/* High level module management functions. These are all part of=0A=
+ * a transaction  =0A=
+ */=0A=
+=0A=
+int semanage_module_install(semanage_handle_t *,=0A=
+			    char *module_data, size_t data_len);=0A=
+int semanage_module_upgrade(semanage_handle_t *,=0A=
+			    char *module_data, size_t data_len);=0A=
+int semanage_module_install_base(semanage_handle_t *,=0A=
+				 char *module_data, size_t data_len);=0A=
+int semanage_module_remove(semanage_handle_t *,=0A=
+			   char *module_name);=0A=
+=0A=
+=0A=
+/* semanage_module_info is for getting information on installed=0A=
+   modules, only name and version at this time */=0A=
+typedef struct semanage_module_info semanage_module_info_t;=0A=
+=0A=
+int semanage_module_list(semanage_handle_t *,=0A=
+			 semanage_module_info_t **, int *num_modules);=0A=
+void semanage_module_info_datum_destroy(semanage_module_info_t *);=0A=
+semanage_module_info_t *semanage_module_list_nth(semanage_module_info_t =
*list, int n);=0A=
+const char *semanage_module_get_name(semanage_module_info_t *);=0A=
+const char *semanage_module_get_version(semanage_module_info_t *);=0A=
+=0A=
+/* accessors for mls and role support structs */=0A=
+typedef struct semanage_mls semanage_mls_t;=0A=
+typedef struct semanage_role semanage_role_t;=0A=
+=0A=
+const char* semanage_mls_get_range(semanage_mls_t *);=0A=
+const char* semanage_mls_get_level(semanage_mls_t *);=0A=
+=0A=
+int semanage_mls_set_range(semanage_mls_t *);=0A=
+int semanage_mls_set_level(semanage_mls_t *);=0A=
+=0A=
+const char* semanage_role_get_name(semanage_role_t *);=0A=
+=0A=
+int semanage_role_set_name(semanage_role_t *, char *name);=0A=
+=0A=
+/* semanage_user represents selinux users in the policy */=0A=
+typedef struct semanage_user semanage_user_t;=0A=
+=0A=
+/* semanage_user management functions */=0A=
+int semanage_user_init(semanage_handle_t **);=0A=
+int semanage_user_add(semanage_handle_t *, semanage_user_t *userdata);=0A=
+int semanage_user_remove(semanage_handle_t *, char *userdata);=0A=
+int semanage_user_list(semanage_handle_t *, semanage_user_t **users, =
int *num_users);=0A=
+int semanage_user_change(semanage_handle_t *, semanage_user_t =
*userdata, char *key);=0A=
+void semanage_user_free(semanage_user_t *);=0A=
+=0A=
+/* semanage_user accessor functions */=0A=
+const char* semanage_user_get_name(semanage_user_t *);=0A=
+int semanage_user_get_roles(semanage_user_t *, semanage_role_t **roles, =
int num_roles);=0A=
+int semanage_user_get_mls(semanage_user_t *, semanage_mls_t *mls);=0A=
+ =0A=
+int semanage_user_set_name(semanage_user_t *, char *name);=0A=
+int semanage_user_set_roles(semanage_user_t *, semanage_role_t **roles, =
int num_roles);=0A=
+int semanage_user_set_mls(semanage_user_t *, semanage_mls_t *mls);=0A=
+=0A=
+/* semanage_homedir manages selinux_user->directory maps so that =0A=
+   we can expand home directory contexts */=0A=
+typedef struct semanage_homedir semanage_homedir_t;=0A=
+=0A=
+int semanage_homedir_add(semanage_handle_t *, semanage_homedir_t =
*homedir);=0A=
+int semanage_homedir_remove(semanage_handle_t *, semanage_homedir_t =
*homedir);=0A=
+int semanage_homedir_list(semanage_handle_t *, semanage_homedir_t **, =
int *num_homedirs);=0A=
+void semanage_homedir_free(semanage_homedir_t *);=0A=
+=0A=
+/* semanage_homedir accessors */=0A=
+=0A=
+const char* semanage_homedir_get_user(semanage_handle_t *);=0A=
+const char* semanage_homedir_get_path(semanage_handle_t *);=0A=
+=0A=
+int semanage_homedir_set_user(semanage_handle_t *, char *user);=0A=
+int semanage_homedir_set_path(semanage_handle_t *, char *path); =0A=
+=0A=
+/* semanage_boolean manages default boolean states */=0A=
+typedef struct semanage_boolean semanage_boolean_t;=0A=
+=0A=
+int semanage_boolean_set(semanage_handle_t *, semanage_boolean_t *bool);=0A=
+/* if for some reason the caller does not have permission to read a=0A=
+ * particular boolean value, it will not be added to the returned=0A=
+ * array -- only if something enforces that (eg. policy server) */=0A=
+int semanage_boolean_list(semanage_handle_t *, semanage_boolean_t **, =
int *num_bools);=0A=
+void semanage_boolean_free(semanage_boolean_t *);=0A=
+=0A=
+/* semanage_boolean accessors */=0A=
+=0A=
+const char *semanage_boolean_get_name(semanage_boolean_t *);=0A=
+char semanage_boolean_get_state(semanage_boolean_t *);=0A=
+=0A=
+int semanage_boolean_set_name(semanage_boolean_t *, char *name);=0A=
+int semanage_boolean_set_state(semanage_boolean_t *, char state);=0A=
+=0A=
+#endif=0A=

------=_NextPart_000_0019_01C5C33F.F9B6A620--



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
