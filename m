Message-ID: <20041104194110.97327.qmail@web50608.mail.yahoo.com>
Date: Thu, 4 Nov 2004 11:41:10 -0800 (PST)
From: Steve G <linux_4ever@yahoo.com>
Subject: setsebool and togglesebool patch
To: SELinux List <SELinux@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-88035231-1099597270=:95837"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0-88035231-1099597270=:95837
Content-Type: text/plain; charset=us-ascii
Content-Id: 
Content-Disposition: inline

Hi,

I've been reviewing the tools distributed in Fedora and have a patch that makes a
few changes. Booleans have a transaction-like interface. But the tools do not do
a rollback if they blow up in the middle of something. For example, suppose I
type in a list of 4 apache booleans I want to toggle, but make a typo in one. 3
of them will get set. Until I correct it, apache would be running with one bool
in the opposite state.

Also, setsebool is used by scripts to set the state of a boolean to a particular
value. As its stands, it is not done in a transactional way because it does not
take a list of name/value pairs. So, there can be a race as parts of a program
get the boolean changed.

Also, an audit record is written by the kernel saying ALL the current values
during a commit, but you don't have a good way of seeing only the changes that
were made by a user.

I've attempted to fix these issues with the attached patch.

togglesebool is updated to do the following:

* It is now all or nothing. Meaning that it toggles all booleans passed or 
none at all.
* It logs to syslog what was done and by whom.

In order to make the rollback code simple, I needed a change to src/booleans.c  
so that it would reject anything except 0 or 1.

setsebool had more changes. Rather than review the patch, you might apply it and
then review the resulting code. setsebool is used by a configuration 
tool to write all booleans to memory. The config tool then writes them to disk. 
So, it was updated to do the following:

* It now takes lists of booleans and treats them in an all or nothing manner. 
All get set or none at all.
* It takes a -P option to tell it to write the configuration to disk
* It logs to syslog what was changed and by whom.
* Preserves the old syntax. Scripts using it as 'setsebool bool value' will 
continue to work.

I also updated all affected man pages to document the new syntax.

Thanks,
-Steve Grubb


		
__________________________________ 
Do you Yahoo!? 
Check out the new Yahoo! Front Page. 
www.yahoo.com 
 

--0-88035231-1099597270=:95837
Content-Type: text/x-patch; name="libselinux-1.17.15-permanent.patch"
Content-Description: libselinux-1.17.15-permanent.patch
Content-Disposition: inline; filename="libselinux-1.17.15-permanent.patch"

diff -ur libselinux-1.17.15.orig/man/man8/setsebool.8 libselinux-1.17.15/man/man8/setsebool.8
--- libselinux-1.17.15.orig/man/man8/setsebool.8	2004-11-01 15:26:37.000000000 -0500
+++ libselinux-1.17.15/man/man8/setsebool.8	2004-11-03 15:34:02.000000000 -0500
@@ -4,16 +4,21 @@
 
 .SH "SYNOPSIS"
 .B setsebool
-.I "boolean value"
+.I "[ -P ] boolean value | bool1=val1 bool2=val2 ..."
 
 .SH "DESCRIPTION"
 .B setsebool 
-sets the current state of a particular SELinux boolean to a given value.
-The value may be 1 or true to enable the boolean, or 0 or false to disable it.
-Only the current boolean value is affected; the boot-time default settings
-defined by
+sets the current state of a particular SELinux boolean or a list of booleans 
+to a given value. The value may be 1 or true to enable the boolean, or 0 or 
+false to disable it. 
+
+Without the -P option, only the current boolean value is 
+affected; the boot-time default settings defined by
 .I /etc/selinux/SELINUXTYPE/booleans
-are not changed by this utility.
+are not changed. 
+
+If the -P option is given, all pending values are written to
+the boolean file on disk.
 
 .SH AUTHOR	
 This manual page was written by Dan Walsh <dwalsh@redhat.com>.
diff -ur libselinux-1.17.15.orig/src/booleans.c libselinux-1.17.15/src/booleans.c
--- libselinux-1.17.15.orig/src/booleans.c	2004-10-15 09:39:33.000000000 -0400
+++ libselinux-1.17.15/src/booleans.c	2004-11-01 16:23:25.000000000 -0500
@@ -165,6 +165,8 @@
 	char buf[2], *fname;
 
 	assert(selinux_mnt);
+	if ( value < 0 || value > 1 )
+		return -1;
 
 	len = strlen(name) + strlen(selinux_mnt) + sizeof(SELINUX_BOOL_DIR);
 	fname = (char*)malloc(sizeof(char) * len);
diff -ur libselinux-1.17.15.orig/utils/getsebool.c libselinux-1.17.15/utils/getsebool.c
--- libselinux-1.17.15.orig/utils/getsebool.c	2004-11-01 15:26:37.000000000 -0500
+++ libselinux-1.17.15/utils/getsebool.c	2004-11-02 16:08:00.000000000 -0500
@@ -30,7 +30,9 @@
 			errno = 0;
 			rc = security_get_boolean_names(&names, &len);
 			if (rc) {
-				fprintf(stderr, "%s:  Unable to get boolean names:  %s\n", argv[0], strerror(errno));
+				fprintf(stderr, 
+				    "%s:  Unable to get boolean names:  %s\n", 
+				    argv[0], strerror(errno));
 				return 1;
 			}
 			if (!len) {
diff -ur libselinux-1.17.15.orig/utils/setsebool.c libselinux-1.17.15/utils/setsebool.c
--- libselinux-1.17.15.orig/utils/setsebool.c	2004-11-01 15:26:37.000000000 -0500
+++ libselinux-1.17.15/utils/setsebool.c	2004-11-04 11:16:05.000000000 -0500
@@ -2,46 +2,205 @@
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <syslog.h>
+#include <pwd.h>
 #include <selinux/selinux.h>
 
+int permanent = 0;
+
+int setbool(char **list, int start, int end);
+void rollback(char *list[], int start, int end);
+
+
+void usage(void)
+{
+	fputs("\nUsage:  setsebool [ -P ] boolean value | bool1=val1 bool2=val2...\n\n", stderr);
+	exit(1);
+}
 
 int main(int argc, char **argv)
 {
-	int rc, value;
+	int rc, start;
 
-	if (argc != 3) {
-		fprintf(stderr, "usage:  %s boolean value\n", argv[0]);
-		return 1;
-	}
+	if (argc < 2) 
+		usage();
 
 	if (is_selinux_enabled() <= 0) {
-		fprintf(stderr, "%s:  SELinux is disabled\n", argv[0]);
+		fputs("setsebool:  SELinux is disabled.\n", stderr);
 		return 1;
 	}
 
-	if (strcmp(argv[2], "1") == 0 || strcasecmp(argv[2], "true") == 0)
-		value = 1;
-	else if (strcmp(argv[2], "0") == 0 || strcasecmp(argv[2], "false") == 0)
-		value = 0;
-	else {
-		fprintf(stderr, "%s:  illegal boolean value %s\n", argv[0], argv[2]);
-		return 1;
+	if (strcmp(argv[1], "-P") == 0) {
+		permanent = 1;
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
 	}
+	else 
+		rc = setbool(argv, start, argc);
 
-	rc = security_set_boolean(argv[1], value);
+	return rc;
+}
 
-	if (rc) {
-		fprintf(stderr, "error setting boolean %s to value %d\n",
-			argv[1], value);
-		return 2;
+/* Given an array of strings in the form "boolname=value", a start index,
+   and a finish index...walk the list and set the bool. */
+int setbool(char **list, int start, int end)
+{
+	char *name, *value_ptr;
+	int i=start, value;
+	struct passwd *pwd;
+
+	while (i < end) {
+		name = list[i];
+		value_ptr = strchr(list[i], '=');
+		if (value_ptr == 0) {
+			fprintf(stderr, 
+			"setsebool: '=' not found in boolean expression %s\n",
+				list[i]);
+			rollback(list, start, i);
+			return 4;
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
+			rollback(list, start, i);
+			return 1;
+		}
+
+		if(security_set_boolean(name, value)) {
+			fprintf(stderr, 
+				"Error setting boolean %s to value %d (%s)\n", 
+				name, value, strerror(errno));
+			rollback(list, start, i);
+			return 2;
+		}
+		i++;
+
+		/* Now put it back */
+		value_ptr--;
+		*value_ptr = '=';
 	}
 
-	rc = security_commit_booleans();
+	/* At this point we know that everything is good. Let's write
+	   the file if the -P option was given. */
+	if (permanent) {
+		char **names;
+		const char *bool_file;
+		int rc, len, fd, j;
+
+		rc = security_get_boolean_names(&names, &len);
+		if (rc) {
+			fprintf(stderr,
+				"Unable to get boolean names:  %s\n",
+				strerror(errno));
+			rollback(list, start, i);
+			return 5;
+		}
+
+		if (!len) {
+			fprintf(stderr, 
+			"Unable to get the boolean list from kernel - exiting\n"
+				);
+			rollback(list, start, i);
+			return 6;
+		}
+
+		/* Open file */
+		bool_file = selinux_booleans_path();
+		fd = open(bool_file, O_CREAT | O_TRUNC | O_WRONLY, 
+							S_IRUSR | S_IWUSR);
+		if (fd < 0) {
+			fprintf(stderr, 
+				"Error creating boolean file %s\n", 
+				bool_file);
+			rollback(list, start, i);
+			return 7;
+			
+		}
+
+		/* Walk the list in pending memory, writing each to the file */
+		for (j=0; j<len; j++) {
+			char val_str[72];
+			int pending = security_get_boolean_pending(names[j]);
+			snprintf(val_str, sizeof(val_str), "%s=%d\n", 
+							names[j], pending);
+			write(fd, val_str, strlen(val_str));
+		}
 
-	if (rc) {
-		fputs("error committing booleans", stderr);
+		close(fd);
+		syslog(LOG_NOTICE, "%s has been updated.", bool_file);
+	}
+	
+	/* OK, let's do the commit */
+	if (security_commit_booleans()) {
+		fputs("Error committing booleans\n", stderr);
 		return 3;
 	}
 
+	/* Now log what was done */
+	pwd = getpwuid(getuid());
+	i = start;
+	while (i < end) {
+		/* Error checking shouldn't be needed since we just did
+		   this above and aborted if something went wrong. */
+		name = list[i];
+		value_ptr = strchr(name, '=');
+		*value_ptr = 0;
+		value_ptr++;
+		if (pwd && pwd->pw_name)
+			syslog(LOG_NOTICE, 
+			    "The %s policy boolean was changed to %s by %s",
+				name, value_ptr, pwd->pw_name);
+		else
+			syslog(LOG_NOTICE, 
+			    "The %s policy boolean was changed to %s by uid:%d",
+				name, value_ptr, getuid());
+		i++;
+	}
+
 	return 0;
 }
+
+void rollback(char *list[], int start, int end)
+{
+	int i;
+
+        for(i=start; i<end; i++)
+                security_set_boolean(list[i],
+                        security_get_boolean_active(list[i]));
+}
+
diff -ur libselinux-1.17.15.orig/utils/togglesebool.c libselinux-1.17.15/utils/togglesebool.c
--- libselinux-1.17.15.orig/utils/togglesebool.c	2004-10-15 09:39:33.000000000 -0400
+++ libselinux-1.17.15/utils/togglesebool.c	2004-11-04 11:17:30.000000000 -0500
@@ -3,20 +3,35 @@
  * Distributed under the terms of the GNU General Public License v2
  * $Header: /var/cvsroot/gentoo-projects/hardened/policycoreutils-extra/src/toggle_bool.c,v 1.2 2004/06/18 04:09:04 pebenito Exp $
  */
+#include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <libgen.h>
 #include <errno.h>
 #include <selinux/selinux.h>
+#include <syslog.h>
+#include <pwd.h>
 #include <string.h>
 
+/* Attempt to rollback the transaction. No need to check error
+   codes since this is rolling back something that blew up. */
+void rollback(int argc, char **argv)
+{
+	int i;
+
+	for(i=1; i<argc; i++) 
+		security_set_boolean(argv[i], 
+			security_get_boolean_active(argv[i]));
+	exit(1);
+}
+
 int main(int argc, char **argv) {
 
 	int rc, i, commit=0;
 
 	if (is_selinux_enabled() <= 0) {
 		fprintf(stderr, "%s:  SELinux is disabled\n", argv[0]);
-		exit(1);
+		return 1;
 	}
 
 	if(argc < 2) {
@@ -33,7 +48,9 @@
 					printf("inactive\n");
 					commit++;
 				} else {
-					printf("%s\n",strerror(errno));
+					printf("%s - rolling back all changes\n"
+						,strerror(errno));
+					rollback(i, argv);
 				}
 				break;
 			case 0:
@@ -41,26 +58,41 @@
 					printf("active\n");
 					commit++;
 				} else {
-					printf("%s\n",strerror(errno));
+					printf("%s - rolling back all changes\n"
+						,strerror(errno));
+					rollback(i, argv);
 				}
 				break;
 			default:
 				if(errno==ENOENT)
-					printf("Boolean does not exist\n");
+					printf("Boolean does not exist - rolling back all changes.\n");
 				else
-					printf("%s\n",strerror(errno));
-				break;
+					printf("%s - rolling back all changes.\n",strerror(errno));
+				rollback(i, argv);
+				break; /* Not reached. */
 		}
 	}
 
 	if(commit > 0) {
 		if(security_commit_booleans() < 0) {
-			printf("Commit failed. (%s)  No change to booleans.\n",strerror(errno));
-			return 1;
+			printf("Commit failed. (%s)  No change to booleans.\n",
+						strerror(errno));
 		} else {
+			/* syslog all the changes */
+			struct passwd *pwd = getpwuid(getuid());
+			for(i=1; i<argc; i++) {
+		                if (pwd && pwd->pw_name)
+                		        syslog(LOG_NOTICE,
+                            			"The %s policy boolean was toggled by %s",
+                                		argv[i], pwd->pw_name);
+		                else
+                		        syslog(LOG_NOTICE,
+						"The %s policy boolean was toggled by uid:%d",
+						argv[i], getuid());
+
+			}
 			return 0;
 		}
-	} else {
-		return 1;
-	}
+	} 
+	return 1;
 }

--0-88035231-1099597270=:95837--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
