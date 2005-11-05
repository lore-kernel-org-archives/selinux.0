Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA56xNMA006045
	for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2005 01:59:23 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA56rId3001085
	for <selinux@tycho.nsa.gov>; Sat, 5 Nov 2005 06:53:18 GMT
Message-ID: <436C59DE.6050408@cornell.edu>
Date: Sat, 05 Nov 2005 02:06:06 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
Subject: [ LIBSEMANAGE ] Runtime control over preservebools argument
References: <436915FB.3040500@tresys.com>	 <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil>	 <436A86E6.4040205@cornell.edu>  <436AF7BC.5000705@cornell.edu>	 <1131110455.23420.187.camel@moss-spartans.epoch.ncsc.mil>	 <436B6E9E.4050108@cornell.edu> <1131113812.23420.236.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1131113812.23420.236.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/mixed;
 boundary="------------030001040500040909020303"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------030001040500040909020303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Stephen Smalley wrote:
> On Fri, 2005-11-04 at 09:22 -0500, Ivan Gyurdiev wrote:
>   
>> So, how do I specify that this is not a transient change, and I want my 
>> booleans loaded into policy immediately?
>>     
>
> Ah, I see - setsebool -P wants to both update the saved settings and
> load the result rather than preserving current settings.  So it wants
> libsemanage to call load_policy with -b, unlike semodule.  Options are:
> - add a semanage interface to set a property on the handle to control
> whether booleans are preserved or not (by altering the args to
> load_policy for that handle), similar to the existing interface for
> controlling whether reloads are performed, or
>   
Editing an argument string for programs in C is... probably one of the 
most uncool patches I've ever written.
I guess the end justifies the means...

Should pass valgrind, and work when called repeatedly with values 0 or 
1. Maybe the reload=0 case is a bit wrong - argument string cannot 
contain "-b" anywhere.

I also fixed the memory leak in setsebool - see other patch (which 
should be applied first).

Now booleans update correctly (minus migration issues - see other mail).
Next: make them update in less than 10 seconds :)


--------------030001040500040909020303
Content-Type: text/x-patch;
 name="libsemanage.preserve_bools.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage.preserve_bools.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/include/semanage/handle.h new/libsemanage/include/semanage/handle.h
--- old/libsemanage/include/semanage/handle.h	2005-10-25 08:25:32.000000000 -0400
+++ new/libsemanage/include/semanage/handle.h	2005-11-05 01:16:44.000000000 -0500
@@ -59,6 +59,10 @@ int semanage_reload_policy(semanage_hand
  * 1 for yes (default), 0 for no */
 void semanage_set_reload(semanage_handle_t *handle, int do_reload);
 
+/* set whether to reload the boolean settings after a commit,
+ * 1 for yes, 0 for no (default */
+int semanage_set_reload_bools(semanage_handle_t *sh, int do_reload);
+
 /* "Connect" to a manager based on the configuration and 
  * associate the provided handle with the connection.
  * If the connect fails then this function returns a negative value, 
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/handle.c new/libsemanage/src/handle.c
--- old/libsemanage/src/handle.c	2005-11-04 23:45:39.000000000 -0500
+++ new/libsemanage/src/handle.c	2005-11-05 01:44:39.000000000 -0500
@@ -25,6 +25,7 @@
 
 #include <stdarg.h>
 #include <assert.h>
+#include <string.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <sys/time.h>
@@ -76,6 +77,38 @@ void semanage_set_reload(semanage_handle
 	return;
 }
 
+int semanage_set_reload_bools(semanage_handle_t *sh, int do_reload) {
+
+	assert(sh != NULL);
+
+	semanage_conf_t* conf = sh->conf;
+
+	if (do_reload) {
+		char* prev_args = conf->load_policy->args;
+		int len = (prev_args == NULL)? 0: strlen(prev_args);
+		char* ptr = (char*) realloc(prev_args, len + 4);
+
+		if (!ptr) {
+			ERR(sh, "out of memory, could not configure "
+				"boolean reload");
+			return STATUS_ERR;
+		}
+		strcpy(ptr + len, " -b");
+		conf->load_policy->args = ptr;
+
+	} else {
+		char* ptr = conf->load_policy->args;
+
+		while(*ptr++) {
+			if (!strcmp(ptr, "-b")) {
+				*ptr++ = ' ';	
+				*ptr++ = ' ';
+			}
+		}
+	}
+	return STATUS_SUCCESS;
+}
+
 void semanage_select_store(semanage_handle_t *sh, char *storename,
 			  enum semanage_connect_type storetype) {
 	
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libsemanage/src/libsemanage.map new/libsemanage/src/libsemanage.map
--- old/libsemanage/src/libsemanage.map	2005-11-03 12:48:03.000000000 -0500
+++ new/libsemanage/src/libsemanage.map	2005-11-05 01:21:21.000000000 -0500
@@ -8,7 +8,7 @@ LIBSEMANAGE_1.0 {
 	  semanage_module_list; semanage_module_info_datum_destroy;
 	  semanage_module_list_nth; semanage_module_get_name;
 	  semanage_module_get_version; semanage_select_store;
-	  semanage_reload_policy; semanage_set_reload;
+	  semanage_reload_policy; semanage_set_reload; semanage_set_reload_bools;
 	  semanage_user_*; semanage_bool_*; semanage_seuser_*;
 	  semanage_iface_*; semanage_context_*;
   local: *;
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	2005-11-05 00:29:59.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2005-11-05 01:49:50.000000000 -0500
@@ -10,6 +10,7 @@
 #include <selinux/selinux.h>
 #include <semanage/booleans_local.h>
 #include <semanage/boolean_record.h>
+#include <semanage/handle.h>
 #include <errno.h>
 
 int permanent = 0;
@@ -113,6 +114,10 @@ int semanage_set_boolean_list(size_t boo
 		boolean = NULL;
 	}	
 
+	semanage_set_reload(handle, 1);
+	if (semanage_set_reload_bools(handle, 1) < 0)
+		goto err;
+
 	if (semanage_commit(handle) < 0)
 		goto err;
 

--------------030001040500040909020303--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
