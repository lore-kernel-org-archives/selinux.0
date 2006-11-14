Message-ID: <4559DB81.7060601@redhat.com>
Date: Tue, 14 Nov 2006 10:06:41 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: SE Linux <selinux@tycho.nsa.gov>, Stephen Smalley <sds@tycho.nsa.gov>
Subject: Multiple small fixes to policycoreutils
Content-Type: multipart/mixed;
 boundary="------------050100020906010105060502"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------050100020906010105060502
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Add newrole audit message on login failure.

Add -fPIE and -pie to build of restorecond.

Add /var/log/wtmp to restorecond.conf watch list

Fix genhomedircon, semanage, semodule_expand man pages.

--------------050100020906010105060502
Content-Type: text/plain;
 name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff"

diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/newrole/newrole.c policycoreutils-1.33.1/newrole/newrole.c
--- nsapolicycoreutils/newrole/newrole.c	2006-11-14 09:46:12.000000000 -0500
+++ policycoreutils-1.33.1/newrole/newrole.c	2006-11-14 09:55:30.000000000 -0500
@@ -1028,6 +1028,7 @@
 	{
 		fprintf(stderr, _("newrole: incorrect password for %s\n"),
 			pw.pw_name);
+		send_audit_message(0, old_context, new_context, ttyn);
 		goto err_close_pam;
 	}
 
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/restorecond/Makefile policycoreutils-1.33.1/restorecond/Makefile
--- nsapolicycoreutils/restorecond/Makefile	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.33.1/restorecond/Makefile	2006-11-14 09:54:05.000000000 -0500
@@ -5,8 +5,9 @@
 INITDIR = $(DESTDIR)/etc/rc.d/init.d
 SELINUXDIR = $(DESTDIR)/etc/selinux
 
-CFLAGS ?= -g -Werror -Wall -W
-override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64
+LDFLAGS ?= -pie
+CFLAGS ?= -g -Werror -Wall -W 
+override CFLAGS += -I$(PREFIX)/include -D_FILE_OFFSET_BITS=64 -fPIE
 LDLIBS += -lselinux -lsepol -L$(PREFIX)/lib
 
 all: restorecond
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/restorecond/restorecond.conf policycoreutils-1.33.1/restorecond/restorecond.conf
--- nsapolicycoreutils/restorecond/restorecond.conf	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.33.1/restorecond/restorecond.conf	2006-11-14 09:54:05.000000000 -0500
@@ -2,5 +2,6 @@
 /etc/samba/secrets.tdb
 /etc/mtab
 /var/run/utmp
+/var/log/wtmp
 ~/public_html
 ~/.mozilla/plugins/libflashplayer.so
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/scripts/genhomedircon.8 policycoreutils-1.33.1/scripts/genhomedircon.8
--- nsapolicycoreutils/scripts/genhomedircon.8	2006-08-28 16:58:19.000000000 -0400
+++ policycoreutils-1.33.1/scripts/genhomedircon.8	2006-11-14 09:54:05.000000000 -0500
@@ -45,35 +45,30 @@
 .SH DESCRIPTION
 .PP
 This utility is used to generate file context configuration entries for 
-user home directories based on their default roles and is run when building 
-the policy. It can also be run when ever the 
-.I /etc/selinux/<<SELINUXTYPE>>/users/local.users
-file is changed 
+user home directories based on their 
+.B prefix 
+entry in the the 
+.B semanage user record.  
+genhomedircon is run when building 
+the policy. It is also run automaticaly when ever the 
+.B semanage 
+utility modifies 
+.B user
+or
+.B login
+records.
 Specifically, we replace HOME_ROOT, HOME_DIR, and ROLE macros in the 
 .I /etc/selinux/<<SELINUXTYPE>>/contexts/files/homedir_template 
-file with generic and user-specific values.
-.I local.users
-file. If a user has more than one role in 
-.I local.users,
-.B genhomedircon
-uses the first role in the list. 
+file with generic and user-specific values.  HOME_ROOT and HOME_DIR is replaced with each distinct location where login users homedirectories are located.  Defaults to /home. ROLE is replaced based on the prefix entry in the 
+.B user
+record.
 .PP 
-If a user is not listed in 
-.I local.users,
-.B genhomedircon
-assumes that the user's home dir will be found in one of the
-HOME_ROOTs. 
-When looking for these users, 
-.B genhomedircon
-only considers real users. "Real" users (as opposed
-to system users) are those whose UID is greater than or equal 
+genhomedircon searches through all password entires for all "login" user home directories, (as opposed
+to system users).  Login users are those whose UID is greater than or equal 
 .I STARTING_UID
 (default 500) and whose login shell is not "/sbin/nologin", or
 "/bin/false". 
 .PP 
-Users who are explicitly defined in 
-.I local.users,
-are always "real" (including root, in the default configuration).
 .SH AUTHOR
 This manual page was originally written by 
 .I Manoj Srivastava <srivasta@debian.org>,
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semanage/semanage.8 policycoreutils-1.33.1/semanage/semanage.8
--- nsapolicycoreutils/semanage/semanage.8	2006-09-14 08:07:24.000000000 -0400
+++ policycoreutils-1.33.1/semanage/semanage.8	2006-11-14 09:54:05.000000000 -0500
@@ -7,7 +7,7 @@
 .br
 .B semanage login \-{a|d|m} [\-sr] login_name
 .br
-.B semanage user \-{a|d|m} [\-LrR] selinux_name
+.B semanage user \-{a|d|m} [\-LrRP] selinux_name
 .br
 .B semanage port \-{a|d|m} [\-tr] [\-p protocol] port | port_range
 .br
@@ -71,6 +71,9 @@
 .I                \-R, \-\-role
 SELinux Roles.  You must enclose multiple roles within quotes, separate by spaces. Or specify \-R multiple times.
 .TP
+.I                \-P, \-\-prefix
+SELinux Prefix.  Prefix added to home_dir_t and home_t for labeling users home directories.
+.TP
 .I                \-s, \-\-seuser     
 SELinux user name
 .TP
diff --exclude-from=exclude --exclude='*.po' --exclude='*.pot' -N -u -r nsapolicycoreutils/semodule_expand/semodule_expand.8 policycoreutils-1.33.1/semodule_expand/semodule_expand.8
--- nsapolicycoreutils/semodule_expand/semodule_expand.8	2006-08-28 16:58:20.000000000 -0400
+++ policycoreutils-1.33.1/semodule_expand/semodule_expand.8	2006-11-14 09:54:05.000000000 -0500
@@ -18,7 +18,7 @@
 .SH "OPTIONS"
 .TP
 .B \-V
-verbose mode
+show version
 .TP
 .B \-c [version]
 policy version to create

--------------050100020906010105060502--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
