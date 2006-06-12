Subject: Re: [PATCH] policy server API
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Christopher Ashworth <cashworth@tresys.com>
Cc: selinux@tycho.nsa.gov, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <1149008008.19716.1.camel@popeye.columbia.tresys.com>
References: <1148417141.20016.53.camel@popeye.columbia.tresys.com>
	 <1148494501.517.76.camel@popeye.columbia.tresys.com>
	 <1149008008.19716.1.camel@popeye.columbia.tresys.com>
Content-Type: text/plain
Date: Mon, 12 Jun 2006 16:13:24 -0400
Message-Id: <1150143204.8086.159.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 2006-05-30 at 12:53 -0400, Christopher Ashworth wrote:
> On Wed, 2006-05-24 at 14:15 -0400, Christopher Ashworth wrote:
> > I'll resubmit the patch after awhile to give a chance for more comments
> > and corrections.
> 
> Modified patch attached.

Do you have a simple test program/util to exercise this code?
A few quick comments below.

diff --exclude=.svn --exclude=semanageswig_wrap.c -pruN ../../trunk/libsemanage/include/semanage/handle.h libsemanage/include/semanage/handle.h
--- ../../trunk/libsemanage/include/semanage/handle.h	2006-03-29 04:48:49.000000000 -0500
+++ libsemanage/include/semanage/handle.h	2006-05-05 02:19:27.000000000 -0400
@@ -64,6 +66,9 @@ void semanage_set_reload(semanage_handle
  * 1 for yes, 0 for no (default) */
 void semanage_set_rebuild(semanage_handle_t *handle, int do_rebuild);
 
+/* returns the sepol handle associated with this handle */
+sepol_handle_t *semanage_get_sepol_handle(semanage_handle_t *sh);
+

Why do we need to export the sepol handle to the caller?

diff --exclude=.svn --exclude=semanageswig_wrap.c -pruN ../../trunk/libsemanage/src/handle.c libsemanage/src/handle.c
--- ../../trunk/libsemanage/src/handle.c	2006-03-29 04:48:51.000000000 -0500
+++ libsemanage/src/handle.c	2006-05-08 01:58:58.000000000 -0400
@@ -110,19 +112,24 @@ int semanage_is_connected(semanage_handl
 	return sh->is_connected;
 }
 
-void semanage_select_store(semanage_handle_t *sh, char *storename,
+void semanage_select_store(semanage_handle_t *sh, const char *storename,
 			  enum semanage_connect_type storetype) {
 	
 	assert(sh != NULL);
 
 	/* This just sets the storename to what the user requests, no 
 	   verification of existance will be done until connect */
-	sh->conf->store_path = storename;
+	sh->conf->store_path = strdup(storename);

strdup can fail.  And we can't return an error from this function, so it
isn't really an option.

diff --exclude=.svn --exclude=semanageswig_wrap.c -pruN ../../trunk/libsemanage/src/handle.h libsemanage/src/handle.h
--- ../../trunk/libsemanage/src/handle.h	2006-03-29 04:48:51.000000000 -0500
+++ libsemanage/src/handle.h	2006-05-10 09:15:51.000000000 -0400
@@ -30,10 +30,12 @@
 #include "semanage_conf.h"
 #include "database.h"
 #include "direct_api.h"
+#include "ps_api.h"
 #include "policy.h"
 
 struct semanage_handle {
 	int con_id;             /* Connection ID */
+	int policy_serial;	/* Policy serial number at connect time */

Should this truly be an int or should it be a uint32_t?

diff --exclude=.svn --exclude=semanageswig_wrap.c -pruN ../../trunk/libsemanage/src/modules.c libsemanage/src/modules.c
--- ../../trunk/libsemanage/src/modules.c	2006-03-29 04:48:51.000000000 -0500
+++ libsemanage/src/modules.c	2006-05-11 14:36:23.000000000 -0400
@@ -122,6 +128,159 @@ int semanage_module_list(semanage_handle
 	return sh->funcs->list(sh, modinfo, num_modules);
 }
 
+/* serialize a list of modules into a string, for sending over the wire.
+ * this function (and the corresponding unserialize function) will have to be
+ * able to handle changes to semanage_module_info_t since it is opaque.
+ * caller is responsible for freeing results 
+ */
+int semanage_module_list_serialize(semanage_handle_t *sh, char **results, size_t *results_size,
+				   semanage_module_info_t *modules, int num_modules)
+{
<snip>
+	if ((num_modules < 0) || ((unsigned int)num_modules > UINT32_MAX)) {
+		ERR(sh, "num_modules out of range." );
+		return -1;
+	}
+	number_of_modules = (uint32_t)num_modules;

Can we just be uint32_t throughout and avoid unnecessary tests and
casts?

+/* unserialize a list of modules from a string that has been received over the wire.
+ * caller is responsible for freeing modules.
+ * NOTE: *data is modified by this function.
+ */
+int semanage_module_list_unserialize(semanage_handle_t *sh, char *data,
+			  	     semanage_module_info_t **modules, int *num_modules)
+{
+	memcpy(&number_of_modules, data, sizeof(number_of_modules));
+	number_of_modules = le32_to_cpu(number_of_modules);
+	data += sizeof(number_of_modules);
+
+	if (number_of_modules > INT_MAX) {
+		ERR(sh, "Number of modules received is out of range." );
+		return -1;
+	}
+	*num_modules = (int)number_of_modules;

Likewise.

diff --exclude=.svn --exclude=semanageswig_wrap.c -pruN ../../trunk/libsemanage/src/ps_api.c libsemanage/src/ps_api.c
--- ../../trunk/libsemanage/src/ps_api.c	1969-12-31 19:00:00.000000000 -0500
+++ libsemanage/src/ps_api.c	2006-05-12 16:34:21.000000000 -0400
@@ -0,0 +1,960 @@
<snip>
+int semanage_ps_connect(semanage_handle_t *sh)
+{
<snip>
+	/*********************************************************************/
+	/* FIXME: The following calls initialize the direct 'file' apis; 
+		  they need to be replaced by a full set of remote 'ps' apis.
+		  These are here just to prevent crashes; the
+		  functionality is not available.
+	*/
+
+	ERR(sh, "\n"
+ 		"******************************************************************* \n"
+		"WARNING: libsemanage currently supports only module operations      \n"
+		"         when connected to a remote policy server.                  \n"
+		"         Manipulating other policy components is not yet supported. \n"      
+		"******************************************************************* \n");

Yuck.  User-visible warning during connect?

+        /* Object databases: local modifications */
+	if (user_base_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_USERS_BASE_LOCAL),
+		semanage_user_base_dbase_local(sh)) < 0)
+		goto err;
+
+	if (user_extra_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_USERS_EXTRA_LOCAL),
+		semanage_user_extra_dbase_local(sh)) < 0)
+		goto err;
+
+	if (user_join_dbase_init(sh,
+		semanage_user_base_dbase_local(sh),
+		semanage_user_extra_dbase_local(sh),
+		semanage_user_dbase_local(sh)) < 0)
+		goto err;
+
+	if (port_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_PORTS_LOCAL), 
+		semanage_port_dbase_local(sh)) < 0)
+		goto err;
+
+	if (iface_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_INTERFACES_LOCAL),
+		semanage_iface_dbase_local(sh)) < 0)
+		goto err;
+
+	if (bool_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_BOOLEANS_LOCAL),
+		semanage_bool_dbase_local(sh)) < 0)
+		goto err;
+
+	if (fcontext_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_FC_LOCAL), 
+		semanage_fcontext_dbase_local(sh)) < 0)
+		goto err;
+
+	if (seuser_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_SEUSERS_LOCAL),
+		semanage_seuser_dbase_local(sh)) < 0)
+		goto err;
+
+	if (node_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_NODES_LOCAL),
+		semanage_node_dbase_local(sh)) < 0)
+		goto err;
+
+	/* Object databases: local modifications + policy */
+	if (user_base_policydb_dbase_init(sh, 
+		semanage_user_base_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (user_extra_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_USERS_EXTRA), 
+		semanage_user_extra_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (user_join_dbase_init(sh, 
+		semanage_user_base_dbase_policy(sh),
+		semanage_user_extra_dbase_policy(sh),
+		semanage_user_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (port_policydb_dbase_init(sh, semanage_port_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (iface_policydb_dbase_init(sh, semanage_iface_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (bool_policydb_dbase_init(sh, semanage_bool_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (fcontext_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_FC), 
+		semanage_fcontext_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (seuser_file_dbase_init(sh, 
+		semanage_fname(SEMANAGE_SEUSERS), 
+		semanage_seuser_dbase_policy(sh)) < 0)
+		goto err;
+
+	if (node_policydb_dbase_init(sh, semanage_node_dbase_policy(sh)) < 0)
+		goto err;
+
+	/* Active kernel policy */
+	if (bool_activedb_dbase_init(sh, semanage_bool_dbase_active(sh)) < 0)
+		goto err;

Stuff all of the code that should go away later in a static inline.

+int semanage_ps_disconnect(semanage_handle_t *sh)
+{
+	int err = 0;
+
+	write_msg(sh->u.ps_handle.socket_fd, PS_DISCONNECT, 0, NULL);
+
+	/*********************************************************************/
+	/* FIXME: These will be removed when these databases are handled 
+		  properly on the server side.
+	*/
+	
+	/* Release object databases: local modifications */
+	user_base_file_dbase_release(semanage_user_base_dbase_local(sh));
+	user_extra_file_dbase_release(semanage_user_extra_dbase_local(sh));
+	user_join_dbase_release(semanage_user_dbase_local(sh));
+	port_file_dbase_release(semanage_port_dbase_local(sh));
+	iface_file_dbase_release(semanage_iface_dbase_local(sh));
+	bool_file_dbase_release(semanage_bool_dbase_local(sh));
+	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh));
+	seuser_file_dbase_release(semanage_seuser_dbase_local(sh));
+	node_file_dbase_release(semanage_node_dbase_local(sh));
+
+	/* Release object databases: local modifications + policy */
+	user_base_policydb_dbase_release(semanage_user_base_dbase_policy(sh));
+	user_extra_file_dbase_release(semanage_user_extra_dbase_policy(sh));
+	user_join_dbase_release(semanage_user_dbase_policy(sh));
+	port_policydb_dbase_release(semanage_port_dbase_policy(sh));
+	iface_policydb_dbase_release(semanage_iface_dbase_policy(sh));
+	bool_policydb_dbase_release(semanage_bool_dbase_policy(sh));
+	fcontext_file_dbase_release(semanage_fcontext_dbase_policy(sh));
+	seuser_file_dbase_release(semanage_seuser_dbase_policy(sh));
+	node_policydb_dbase_release(semanage_node_dbase_policy(sh));
+
+	/* Release object databases: active kernel policy */
+	bool_activedb_dbase_release(semanage_bool_dbase_active(sh));
+
+	/* EMXIF							     */
+	/*********************************************************************/

Likewise, in a static inline.

+static int connect_remote(semanage_handle_t *sh)
+{
+	char *server_addr = sh->conf->store_path;
+	int server_port = sh->conf->server_port;
+	struct sockaddr_in sock;
+
+	sh->u.ps_handle.socket_fd = socket(PF_INET, SOCK_STREAM, 0);
+	if (sh->u.ps_handle.socket_fd < 0) {
+		sh->u.ps_handle.socket_fd = -3;
+		return EXIT_FAILURE;
+	}
+	memset(&sock, 0, sizeof(sock));
+	sock.sin_family = AF_INET;
+	sock.sin_port = htons(server_port);
+	if (inet_pton(AF_INET, server_addr, &sock.sin_addr) != 1) {
+		close(sh->u.ps_handle.socket_fd);
+		sh->u.ps_handle.socket_fd = -1;
+		return EXIT_FAILURE;
+	}

Should we provide a path forward for INET6 addresses?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
