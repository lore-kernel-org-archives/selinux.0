Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id jA45mNMA023136
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 00:48:23 -0500 (EST)
Received: from postoffice9.mail.cornell.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id jA45gTqo014263
	for <selinux@tycho.nsa.gov>; Fri, 4 Nov 2005 05:42:29 GMT
Message-ID: <436AF7BC.5000705@cornell.edu>
Date: Fri, 04 Nov 2005 00:55:08 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@epoch.ncsc.mil>, Joshua Brindle <jbrindle@tresys.com>,
   Karl MacMillan <kmacmillan@tresys.com>, Frank Mayer <mayerf@tresys.com>,
   chris pebenito <cpebenito@tresys.com>, Daniel J Walsh <dwalsh@redhat.com>,
   James Morris <jmorris@redhat.com>, Chad Sellers <csellers@tresys.com>
Subject: [ SELINUX ] [ POLICYCOREUTILS ] Convert setsebool -P to use libsemanage
References: <436915FB.3040500@tresys.com> <1131027033.23420.30.camel@moss-spartans.epoch.ncsc.mil> <436A86E6.4040205@cornell.edu>
In-Reply-To: <436A86E6.4040205@cornell.edu>
Content-Type: multipart/mixed;
 boundary="------------060200080306040400010501"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------060200080306040400010501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


>>
>> Converting setsebool to using libsemanage is the highest priority,
>> followed by a policy package that is based on refpolicy and that has the
>> necessary migration steps in its %post scriptlet.  Everything else is
>> less critical to initial deployment in test1 IMHO.
>
> I'm not sure why it's so critical, given that we already have working 
> boolean support in libselinux. However, if no one else is working on 
> this, I can try to convert the permanent update (-P) to use 
> libsemanage...
Patch attached.
Changes:

- move manpage and setsebools into policycoreutils package
- change manpage not to mention /etc/selinux/?/booleans
- link against libsemanage
- cleanup warnings exposed by -Werror in new Makefile
- implement preservebools=1 via a function similar to the selinux one
- always pass preservebools = 0 to the libselinux fn
- separate code paths for error and success (don't like fallthrough - 
error-prone)
- always return -1 on failure. I highly dislike any creativity with the 
return value. If I could change the retval of all the libselinux and 
libsepol code to be -1 on failure everywhere (or better...using the 
internal status codes), I would be very happy.

Note1:  this does not yet work, because now load_policy tries to 
sabotage my boolean load (by setting preservebools to 1 by default, and 
not loading anything). What should I do about that? Should anything be 
done at all, or should we respect the user load_policy flags in 
/etc/selinux.conf? (which right now I see are undocumented...)

Note2: if I go and force libsemanage to pass -b flag, it works just 
fine, but takes forever (10sec) to complete. It's not my fault, the 
module expand function is just really really slow.






--------------060200080306040400010501
Content-Type: text/x-patch;
 name="setsebools.to_libsemanage.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="setsebools.to_libsemanage.diff"

diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libselinux/man/man8/setsebool.8 new/libselinux/man/man8/setsebool.8
--- old/libselinux/man/man8/setsebool.8	2005-11-04 00:25:58.000000000 -0500
+++ new/libselinux/man/man8/setsebool.8	1969-12-31 19:00:00.000000000 -0500
@@ -1,28 +0,0 @@
-.TH "setsebool" "8" "11 Aug 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
-.SH "NAME"
-setsebool \- set SELinux boolean value
-
-.SH "SYNOPSIS"
-.B setsebool
-.I "[ -P ] boolean value | bool1=val1 bool2=val2 ..."
-
-.SH "DESCRIPTION"
-.B setsebool 
-sets the current state of a particular SELinux boolean or a list of booleans 
-to a given value. The value may be 1 or true to enable the boolean, or 0 or 
-false to disable it. 
-
-Without the -P option, only the current boolean value is 
-affected; the boot-time default settings defined by
-.I /etc/selinux/SELINUXTYPE/booleans
-are not changed. 
-
-If the -P option is given, all pending values are written to
-the boolean file on disk.
-
-.SH AUTHOR	
-This manual page was written by Dan Walsh <dwalsh@redhat.com>.
-The program was written by Tresys Technology.
-
-.SH "SEE ALSO"
-getsebool(8), booleans(8), togglesebool(8)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/libselinux/utils/setsebool.c new/libselinux/utils/setsebool.c
--- old/libselinux/utils/setsebool.c	2005-11-04 00:25:59.000000000 -0500
+++ new/libselinux/utils/setsebool.c	1969-12-31 19:00:00.000000000 -0500
@@ -1,172 +0,0 @@
-#include <unistd.h>
-#include <stdlib.h>
-#include <stdio.h>
-#include <string.h>
-#include <sys/stat.h>
-#include <fcntl.h>
-#include <errno.h>
-#include <syslog.h>
-#include <pwd.h>
-#include <selinux/selinux.h>
-#include <errno.h>
-
-int permanent = 0;
-
-int setbool(char **list, size_t start, size_t end);
-
-
-void usage(void)
-{
-	fputs("\nUsage:  setsebool [ -P ] boolean value | bool1=val1 bool2=val2...\n\n", stderr);
-	exit(1);
-}
-
-int main(int argc, char **argv)
-{
-	size_t rc, start;
-
-	if (argc < 2) 
-		usage();
-
-	if (is_selinux_enabled() <= 0) {
-		fputs("setsebool:  SELinux is disabled.\n", stderr);
-		return 1;
-	}
-
-	if (strcmp(argv[1], "-P") == 0) {
-		permanent = 1;
-		if (argc < 3) 
-			usage();
-		start = 2;
-	}
-	else
-		start = 1;
-
-	/* Check to see which way we are being called. If a '=' is passed,
-	   we'll enforce the list syntax. If not we'll enforce the original
-	   syntax for backward compatibility. */
-	if (strchr(argv[start], '=') == 0) {
-		int len;
-		char *bool_list[1];
-
-		if ((argc - start) != 2)
-			usage();
-
-		/* Add 1 for the '=' */
-		len = strlen(argv[start]) + strlen(argv[start+1]) + 2;
-		bool_list[0]=(char *)malloc(len);
-		if (bool_list[0] == 0) {
-			fputs("Out of memory - aborting\n", stderr);
-			return 1;
-		}
-		snprintf(bool_list[0], len, "%s=%s", argv[start], 
-							argv[start+1]);
-		rc = setbool(bool_list, 0, 1);
-		free(bool_list[0]);
-	}
-	else 
-		rc = setbool(argv, start, argc);
-
-	return rc;
-}
-
-/* Given an array of strings in the form "boolname=value", a start index,
-   and a finish index...walk the list and set the bool. */
-int setbool(char **list, size_t start, size_t end)
-{
-	char *name, *value_ptr;
-	int i=start, value;
-	int ret=0;
-	int j=0;
-	size_t boolcnt=end-start;
-	struct passwd *pwd;
-	SELboolean *vallist=calloc(boolcnt, sizeof(SELboolean));
-	if (!vallist) {
-		fprintf(stderr, 
-			"Error setting booleans: %s\n", strerror(errno));
-		return 1;
-	}
-	while (i < end) {
-		name = list[i];
-		value_ptr = strchr(list[i], '=');
-		if (value_ptr == 0) {
-			fprintf(stderr, 
-			"setsebool: '=' not found in boolean expression %s\n",
-				list[i]);
-			ret=4;
-			goto error_label;
-		}
-		*value_ptr = 0;
-		value_ptr++;
-		if (strcmp(value_ptr, "1") == 0 || 
-				strcasecmp(value_ptr, "true") == 0)
-			value = 1;
-		else if (strcmp(value_ptr, "0") == 0 || 
-				strcasecmp(value_ptr, "false") == 0)
-			value = 0;
-		else {
-			fprintf(stderr, "setsebool: illegal boolean value %s\n",
-				value_ptr);
-			ret=1;
-			goto error_label;
-		}
-
-		vallist[j].value = value;
-		vallist[j].name = strdup(name);
-		if (!vallist[j].name) {
-			fprintf(stderr, 
-				"Error setting boolean %s to value %d (%s)\n", 
-				name, value, strerror(errno));
-			ret= 2;
-			goto error_label;
-		}
-		i++;
-		j++;
-
-		/* Now put it back */
-		value_ptr--;
-		*value_ptr = '=';
-	}
-
-	ret=security_set_boolean_list(boolcnt, vallist, permanent);
-
- error_label:
-	for (i=0; i < boolcnt; i++) 
-		if (vallist[i].name) free(vallist[i].name);
-	free(vallist);
-
-	if (ret) {
-		if (errno==ENOENT) {
-			fprintf(stderr, 
-				"Error setting boolean: Invalid boolean\n");
-		} else {
-			if (errno) 
-				perror("Error setting booleans");
-		}
-		return ret;
-	}
-
-	/* Now log what was done */
-	pwd = getpwuid(getuid());
-	i = start;
-	while (i < end) {
-		/* Error checking shouldn't be needed since we just did
-		   this above and aborted if something went wrong. */
-		name = list[i];
-		value_ptr = strchr(name, '=');
-		*value_ptr = 0;
-		value_ptr++;
-		if (pwd && pwd->pw_name)
-			syslog(LOG_NOTICE, 
-			    "The %s policy boolean was changed to %s by %s",
-				name, value_ptr, pwd->pw_name);
-		else
-			syslog(LOG_NOTICE, 
-			    "The %s policy boolean was changed to %s by uid:%d",
-				name, value_ptr, getuid());
-		i++;
-	}
-
-	return 0;
-}
-
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/policycoreutils/setsebool/setsebool.8 new/policycoreutils/setsebool/setsebool.8
--- old/policycoreutils/setsebool/setsebool.8	1969-12-31 19:00:00.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.8	2005-11-03 23:24:48.000000000 -0500
@@ -0,0 +1,27 @@
+.TH "setsebool" "8" "11 Aug 2004" "dwalsh@redhat.com" "SELinux Command Line documentation"
+.SH "NAME"
+setsebool \- set SELinux boolean value
+
+.SH "SYNOPSIS"
+.B setsebool
+.I "[ -P ] boolean value | bool1=val1 bool2=val2 ..."
+
+.SH "DESCRIPTION"
+.B setsebool 
+sets the current state of a particular SELinux boolean or a list of booleans 
+to a given value. The value may be 1 or true to enable the boolean, or 0 or 
+false to disable it. 
+
+Without the -P option, only the current boolean value is 
+affected; the boot-time default settings defined by
+are not changed. 
+
+If the -P option is given, all pending values are written to
+the boolean file on disk.
+
+.SH AUTHOR	
+This manual page was written by Dan Walsh <dwalsh@redhat.com>.
+The program was written by Tresys Technology.
+
+.SH "SEE ALSO"
+getsebool(8), booleans(8), togglesebool(8)
diff -Naurp --exclude CVS --exclude ChangeLog --exclude VERSION --exclude Makefile old/policycoreutils/setsebool/setsebool.c new/policycoreutils/setsebool/setsebool.c
--- old/policycoreutils/setsebool/setsebool.c	1969-12-31 19:00:00.000000000 -0500
+++ new/policycoreutils/setsebool/setsebool.c	2005-11-03 23:31:37.000000000 -0500
@@ -0,0 +1,232 @@
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <syslog.h>
+#include <pwd.h>
+#include <selinux/selinux.h>
+#include <semanage/booleans_local.h>
+#include <semanage/boolean_record.h>
+#include <errno.h>
+
+int permanent = 0;
+
+int setbool(char **list, size_t start, size_t end);
+
+
+void usage(void)
+{
+	fputs("\nUsage:  setsebool [ -P ] boolean value | bool1=val1 bool2=val2...\n\n", stderr);
+	exit(1);
+}
+
+int main(int argc, char **argv)
+{
+	size_t rc, start;
+
+	if (argc < 2) 
+		usage();
+
+	if (is_selinux_enabled() <= 0) {
+		fputs("setsebool:  SELinux is disabled.\n", stderr);
+		return 1;
+	}
+
+	if (strcmp(argv[1], "-P") == 0) {
+		permanent = 1;
+		if (argc < 3) 
+			usage();
+		start = 2;
+	}
+	else
+		start = 1;
+
+	/* Check to see which way we are being called. If a '=' is passed,
+	   we'll enforce the list syntax. If not we'll enforce the original
+	   syntax for backward compatibility. */
+	if (strchr(argv[start], '=') == 0) {
+		int len;
+		char *bool_list[1];
+
+		if ((argc - start) != 2)
+			usage();
+
+		/* Add 1 for the '=' */
+		len = strlen(argv[start]) + strlen(argv[start+1]) + 2;
+		bool_list[0]=(char *)malloc(len);
+		if (bool_list[0] == 0) {
+			fputs("Out of memory - aborting\n", stderr);
+			return 1;
+		}
+		snprintf(bool_list[0], len, "%s=%s", argv[start], 
+							argv[start+1]);
+		rc = setbool(bool_list, 0, 1);
+		free(bool_list[0]);
+	}
+	else 
+		rc = setbool(argv, start, argc);
+
+	return rc;
+}
+
+/* Helper function: applies permanent changes to policy via libsemanage */
+int semanage_set_boolean_list(size_t boolcnt, SELboolean *boollist) {
+
+	size_t j;
+	semanage_handle_t* handle = NULL;
+	semanage_bool_t* boolean = NULL;
+	semanage_bool_key_t* bool_key = NULL;
+
+	handle = semanage_handle_create();
+	if (handle == NULL) {
+		fprintf(stderr, "Could not create semanage library handle\n"); 
+		goto err;
+	}
+
+	if (semanage_connect(handle) < 0)
+		goto err;
+
+	if (semanage_begin_transaction(handle) < 0)
+		goto err;
+
+	for (j = 0; j < boolcnt; j++) {
+		
+		if (semanage_bool_create(handle, &boolean) < 0)
+			goto err;
+
+		if (semanage_bool_set_name(handle, boolean, boollist[j].name) < 0)
+			goto err;
+
+		semanage_bool_set_value(boolean, boollist[j].value);
+
+		if (semanage_bool_key_extract(handle, boolean, &bool_key) < 0)
+			goto err;
+
+		if (semanage_bool_modify_local(handle, bool_key, boolean) < 0)
+			goto err;
+
+		semanage_bool_key_free(bool_key);
+		bool_key = NULL;
+		boolean = NULL;
+	}	
+
+	if (semanage_commit(handle) < 0)
+		goto err;
+
+	semanage_disconnect(handle);
+	semanage_handle_destroy(handle);
+	return 0;
+
+	err:
+	semanage_bool_key_free(bool_key);
+	semanage_bool_free(boolean);
+	semanage_handle_destroy(handle);
+	fprintf(stderr, "Could not apply permanent policy change");
+	return -1;
+}
+
+/* Given an array of strings in the form "boolname=value", a start index,
+   and a finish index...walk the list and set the bool. */
+int setbool(char **list, size_t start, size_t end)
+{
+	char *name, *value_ptr;
+	int ret=0, j=0, value;
+	size_t i = start;
+	size_t boolcnt=end-start;
+	struct passwd *pwd;
+	SELboolean *vallist=calloc(boolcnt, sizeof(SELboolean));
+	if (!vallist) {
+		fprintf(stderr, 
+			"Error setting booleans: %s\n", strerror(errno));
+		return 1;
+	}
+	while (i < end) {
+		name = list[i];
+		value_ptr = strchr(list[i], '=');
+		if (value_ptr == 0) {
+			fprintf(stderr, 
+			"setsebool: '=' not found in boolean expression %s\n",
+				list[i]);
+			ret=4;
+			goto err;
+		}
+		*value_ptr = 0;
+		value_ptr++;
+		if (strcmp(value_ptr, "1") == 0 || 
+				strcasecmp(value_ptr, "true") == 0)
+			value = 1;
+		else if (strcmp(value_ptr, "0") == 0 || 
+				strcasecmp(value_ptr, "false") == 0)
+			value = 0;
+		else {
+			fprintf(stderr, "setsebool: illegal boolean value %s\n",
+				value_ptr);
+			ret=1;
+			goto err;
+		}
+
+		vallist[j].value = value;
+		vallist[j].name = strdup(name);
+		if (!vallist[j].name) {
+			fprintf(stderr, 
+				"Error setting boolean %s to value %d (%s)\n", 
+				name, value, strerror(errno));
+			ret= 2;
+			goto err;
+		}
+		i++;
+		j++;
+
+		/* Now put it back */
+		value_ptr--;
+		*value_ptr = '=';
+	} 
+
+	if (permanent) {
+		if (semanage_set_boolean_list(boolcnt, vallist) < 0)
+			goto err;
+
+	} else {
+		if (security_set_boolean_list(boolcnt, vallist, 0)) {
+			if (errno == ENOENT) 
+				fprintf(stderr, "Error setting boolean: "
+					"Invalid boolean\n");
+			else if (errno)
+				perror("Error setting booleans");
+
+			goto err;			
+		}
+	}
+
+	/* Now log what was done */
+	pwd = getpwuid(getuid());
+	i = start;
+	while (i < end) {
+		name = list[i];
+		value_ptr = strchr(name, '=');
+		*value_ptr = 0;
+		value_ptr++;
+		if (pwd && pwd->pw_name)
+			syslog(LOG_NOTICE,
+				"The %s policy boolean was changed to %s by %s",
+				name, value_ptr, pwd->pw_name);
+		else
+			syslog(LOG_NOTICE,
+				"The %s policy boolean was changed to %s by uid:%d",
+				name, value_ptr, getuid());
+		i++;
+	}
+
+	return 0;
+				
+	err:
+	for (i=0; i < boolcnt; i++) 
+		if (vallist[i].name) free(vallist[i].name);
+	free(vallist);
+
+	return -1;
+}
+

--------------060200080306040400010501--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
