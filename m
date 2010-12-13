Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id oBDIkHAa004973
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 13:46:17 -0500
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id oBDIkFCJ009904
	for <selinux@tycho.nsa.gov>; Mon, 13 Dec 2010 18:46:16 GMT
Message-ID: <4D0669F4.2040109@redhat.com>
Date: Mon, 13 Dec 2010 13:46:12 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "'Chad Sellers'" <csellers@tresys.com>
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Sandbox Patch (Resend with patch)
Content-Type: multipart/mixed;
 boundary="------------000602070201000007060104"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000602070201000007060104
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch to sandbox adds cgroups support
Changes seunshare to use file capabilities.
Changes seunshare to mount more secure /tmp
Adds seunshare man page
Changes sandbox.config file name to sandbox.conf
Adds -Es to python scripts to make them more secure
Plus a myriad of fixes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GafQACgkQrlYvE4MpobMflACfS3Qaqw2HrOIK65dhPQ6XEZ3f
QoQAnRD0L+ruA35wzaK+ofREot05O3P8
=zDEe
-----END PGP SIGNATURE-----

--------------000602070201000007060104
Content-Type: text/plain;
 name="sandbox.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sandbox.patch"

diff --git a/policycoreutils/sandbox/Makefile b/policycoreutils/sandbox/Makefile
index ff0ee7c..f89eed6 100644
--- a/policycoreutils/sandbox/Makefile
+++ b/policycoreutils/sandbox/Makefile
@@ -7,8 +7,8 @@ SBINDIR ?= $(PREFIX)/sbin
 MANDIR ?= $(PREFIX)/share/man
 LOCALEDIR ?= /usr/share/locale
 SHAREDIR ?= $(PREFIX)/share/sandbox
-override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\""
-LDLIBS += -lselinux -lcap-ng 
+override CFLAGS += $(LDFLAGS) -I$(PREFIX)/include -DPACKAGE="\"policycoreutils\"" -Wall -Werror -Wextra
+LDLIBS += -lcgroup -lselinux -lcap-ng 
 
 all: sandbox seunshare sandboxX.sh 
 
@@ -20,6 +20,9 @@ install: all
 	install -m 755 sandbox $(BINDIR)
 	-mkdir -p $(MANDIR)/man8
 	install -m 644 sandbox.8 $(MANDIR)/man8/
+	install -m 644 seunshare.8 $(MANDIR)/man8/
+	-mkdir -p $(MANDIR)/man5
+	install -m 644 sandbox.conf.5 $(MANDIR)/man5/
 	-mkdir -p $(SBINDIR)
 	install -m 4755 seunshare $(SBINDIR)/
 	-mkdir -p $(SHAREDIR)
@@ -27,7 +30,7 @@ install: all
 	-mkdir -p $(INITDIR)
 	install -m 755 sandbox.init $(INITDIR)/sandbox
 	-mkdir -p $(SYSCONFDIR)
-	install -m 644 sandbox.config $(SYSCONFDIR)/sandbox
+	install -m 644 sandbox.conf $(SYSCONFDIR)/sandbox
 
 test:
 	@python test_sandbox.py -v
diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index 48a26c2..224b9d1 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -1,5 +1,6 @@
-#! /usr/bin/python -E
+#! /usr/bin/python -Es
 # Authors: Dan Walsh <dwalsh@redhat.com>
+# Authors: Thomas Liu <tliu@fedoraproject.org>
 # Authors: Josh Cogliati
 #
 # Copyright (C) 2009,2010  Red Hat
@@ -19,15 +20,18 @@
 # Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 #
 
-import os, sys, socket, random, fcntl, shutil, re, subprocess
+import os, stat, sys, socket, random, fcntl, shutil, re, subprocess
 import selinux
 import signal
 from tempfile import mkdtemp
 import pwd
+import commands 
+import setools
 
 PROGNAME = "policycoreutils"
 HOMEDIR=pwd.getpwuid(os.getuid()).pw_dir
-
+SEUNSHARE = "/usr/sbin/seunshare"
+SANDBOXSH = "/usr/share/sandbox/sandboxX.sh"
 import gettext
 gettext.bindtextdomain(PROGNAME, "/usr/share/locale")
 gettext.textdomain(PROGNAME)
@@ -41,6 +45,7 @@ except IOError:
        import __builtin__
        __builtin__.__dict__['_'] = unicode
 
+DEFAULT_WINDOWSIZE = "1000x700"
 DEFAULT_TYPE = "sandbox_t"
 DEFAULT_X_TYPE = "sandbox_x_t"
 SAVE_FILES = {}
@@ -63,15 +68,15 @@ def error_exit(msg):
     sys.stderr.flush()
     sys.exit(1)
 
-def copyfile(file, dir, dest):
+def copyfile(file, srcdir, dest):
        import re
-       if file.startswith(dir):
+       if file.startswith(srcdir):
               dname = os.path.dirname(file)
               bname = os.path.basename(file)
-              if dname == dir:
+              if dname == srcdir:
                      dest = dest + "/" + bname
               else:
-                     newdir = re.sub(dir, dest, dname)
+                     newdir = re.sub(srcdir, dest, dname)
                      if not os.path.exists(newdir):
                             os.makedirs(newdir)
                      dest = newdir + "/" + bname
@@ -81,9 +86,10 @@ def copyfile(file, dir, dest):
                             shutil.copytree(file, dest)
                      else:
                             shutil.copy2(file, dest)
+
               except shutil.Error, elist:
-                     for e in elist:
-                            sys.stderr.write(e[1])
+                     for e in elist.message:
+                            sys.stderr.write(e[2])
                      
               SAVE_FILES[file] = (dest, os.path.getmtime(dest))
 
@@ -161,10 +167,10 @@ class Sandbox:
                   if not self.__options.homedir or not self.__options.tmpdir:
                          self.usage(_("Homedir and tempdir required for level mounts"))
 
-           if not os.path.exists("/usr/sbin/seunshare"):
+           if not os.path.exists(SEUNSHARE):
                   raise ValueError(_("""
-/usr/sbin/seunshare is required for the action you want to perform.  
-"""))
+%s is required for the action you want to perform.  
+""") % SEUNSHARE)
 
     def __mount_callback(self, option, opt, value, parser):
            self.__mount = True
@@ -172,6 +178,15 @@ class Sandbox:
     def __x_callback(self, option, opt, value, parser):
            self.__mount = True
            setattr(parser.values, option.dest, True)
+           if not os.path.exists(SEUNSHARE):
+                  raise ValueError(_("""
+%s is required for the action you want to perform.  
+""") % SEUNSHARE)
+
+           if not os.path.exists(SANDBOXSH):
+                  raise ValueError(_("""
+%s is required for the action you want to perform.  
+""") % SANDBOXSH)
 
     def __validdir(self, option, opt, value, parser):
            if not os.path.isdir(value):
@@ -194,6 +209,8 @@ class Sandbox:
                          self.__include(option, opt, i[:-1], parser)
                   except IOError, e:
                          sys.stderr.write(str(e))
+                  except TypeError, e:
+                         sys.stderr.write(str(e))
            fd.close()
 
     def __copyfiles(self):
@@ -212,13 +229,15 @@ class Sandbox:
 /etc/gdm/Xsession
 """)
            else:
-                  command = " ".join(self.__paths)
+                  command = self.__paths[0] + " "
+                  for p in self.__paths[1:]:
+                         command += "'%s' " % p
                   fd.write("""#! /bin/sh
 #TITLE: %s
 /usr/bin/test -r ~/.xmodmap && /usr/bin/xmodmap ~/.xmodmap
 %s &
 WM_PID=$!
-%s
+dbus-launch --exit-with-session %s
 kill -TERM $WM_PID  2> /dev/null
 """ % (command, wm, command))
            fd.close()
@@ -226,14 +245,25 @@ kill -TERM $WM_PID  2> /dev/null
 
     def usage(self, message = ""):
            error_exit("%s\n%s" % (self.__parser.usage, message))
-
+           
     def __parse_options(self):
         from optparse import OptionParser
+        types = ""
+        try:
+               types = _("""
+Policy defines the following types for use with the -t: 
+\t%s
+""") % "\n\t".join(setools.seinfo(setools.ATTRIBUTE, "sandbox_type")[0]['types'])
+        except RuntimeError:
+               pass
+
         usage = _("""
-sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [[-i file ] ...] [ -t type ] command
+sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [ -w windowsize ] [[-i file ] ...] [ -t type ] command
+
+sandbox [-h] [-l level ] [-[X|M] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [ -w windowsize ] [[-i file ] ...] [ -t type ] -S
+%s
+""") % types
 
-sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-W windowmanager ] [[-i file ] ...] [ -t type ] -S
-""")
         
         parser = OptionParser(version=self.VERSION, usage=usage)
         parser.disable_interspersed_args()
@@ -268,6 +298,10 @@ sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-
                           action="callback", callback=self.__validdir,
                           help=_("alternate /tmp directory to use for mounting"))
 
+        parser.add_option("-w", "--windowsize", dest="windowsize",
+                          type="string", default=DEFAULT_WINDOWSIZE,
+                          help="size of the sandbox window")		
+
         parser.add_option("-W", "--windowmanager", dest="wm",  
                           type="string",
                           default="/usr/bin/matchbox-window-manager -use_titlebar no",
@@ -276,13 +310,17 @@ sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-
         parser.add_option("-l", "--level", dest="level", 
                           help=_("MCS/MLS level for the sandbox"))
 
+        parser.add_option("-C", "--cgroups",
+                         action="store_true", dest="usecgroup", default=False,
+                         help="Use cgroups to limit this sandbox.")
+
         self.__parser=parser
 
         self.__options, cmds = parser.parse_args()
 
         if self.__options.X_ind:
                self.setype = DEFAULT_X_TYPE
-        
+
         if self.__options.setype:
                self.setype = self.__options.setype
 
@@ -299,6 +337,9 @@ sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-
                self.__options.X_ind = True
                self.__homedir = self.__options.homedir
                self.__tmpdir = self.__options.tmpdir
+        elif self.__options.level:
+               self.__homedir = self.__options.homedir
+               self.__tmpdir = self.__options.tmpdir
         else:
                if len(cmds) == 0:
                       self.usage(_("Command required"))
@@ -351,22 +392,24 @@ sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-
 
     def __execute(self):
            try:
-                  if self.__options.X_ind:
-                         xmodmapfile = self.__homedir + "/.xmodmap"
-                         xd = open(xmodmapfile,"w")
-                         subprocess.Popen(["/usr/bin/xmodmap","-pke"],stdout=xd).wait()
-                         xd.close()
-
-                         self.__setup_sandboxrc(self.__options.wm)
-                         
-                         cmds = [ '/usr/sbin/seunshare', "-t", self.__tmpdir, "-h", self.__homedir, "--", self.__execcon, "/usr/share/sandbox/sandboxX.sh" ]
-                         rc = subprocess.Popen(cmds).wait()
-                         return rc
-
+                  cmds = [ SEUNSHARE,  "-Z", self.__execcon ]
+                  if self.__options.usecgroup == True:
+                         cmds.append('-c')
                   if self.__mount:
-                         cmds =  [ '/usr/sbin/seunshare', "-t", self.__tmpdir, "-h", self.__homedir, "--", self.__execcon ] + self.__paths
-                         rc = subprocess.Popen(cmds).wait()
-                         return rc
+                         cmds +=  [ "-t", self.__tmpdir, "-h", self.__homedir ]
+
+                         if self.__options.X_ind:
+                                xmodmapfile = self.__homedir + "/.xmodmap"
+                                xd = open(xmodmapfile,"w")
+                                subprocess.Popen(["/usr/bin/xmodmap","-pke"],stdout=xd).wait()
+                                xd.close()
+
+                                self.__setup_sandboxrc(self.__options.wm)
+
+                                cmds += [ "--", SANDBOXSH, self.__options.windowsize ]
+                         else:
+                                cmds += [ "--" ] + self.__paths
+                         return subprocess.Popen(cmds).wait()
 
                   selinux.setexeccon(self.__execcon)
                   rc = subprocess.Popen(self.__cmds).wait()
diff --git a/policycoreutils/sandbox/sandbox.8 b/policycoreutils/sandbox/sandbox.8
index 1479364..73d33b3 100644
--- a/policycoreutils/sandbox/sandbox.8
+++ b/policycoreutils/sandbox/sandbox.8
@@ -1,10 +1,13 @@
-.TH SANDBOX "8" "May 2009" "chcat" "User Commands"
+.TH SANDBOX "8" "May 2010" "sandbox" "User Commands"
 .SH NAME
 sandbox \- Run cmd under an SELinux sandbox
 .SH SYNOPSIS
 .B sandbox
-[-l level ] [[-M | -X]  -H homedir -T tempdir ] [-I includefile ] [ -W windowmanager ] [[-i file ]...] [ -t type ] cmd
-[-l level ] [[-M | -X]  -H homedir -T tempdir ] [-I includefile ] [ -W windowmanager ] [[-i file ]...] [ -t type ] -S
+[-l level ] [[-M | -X]  -H homedir -T tempdir ] [-I includefile ] [ -W windowmanager ] [ -w windowsize ] [[-i file ]...] [ -t type ] cmd
+
+.br
+.B sandbox
+[-l level ] [[-M | -X]  -H homedir -T tempdir ] [-I includefile ] [ -W windowmanager ] [ -w windowsize ] [[-i file ]...] [ -t type ] -S
 .br
 .SH DESCRIPTION
 .PP
@@ -42,6 +45,12 @@ Use alternate sandbox type, defaults to sandbox_t or sandbox_x_t for -X.
 \fB\-T\ tmpdir
 Use alternate tempory directory to mount on /tmp.  Defaults to tmpfs. Requires -X or -M.
 .TP
+\fB\-S
+Run a full desktop session, Requires level, and home and tmpdir.
+.TP
+\fB\-w windowsize\fR
+Specifies the windowsize when creating an X based Sandbox. The default windowsize is 1000x700. 
+.TP
 \fB\-W windowmanager\fR
 Select alternative window manager to run within 
 .B sandbox -X.
@@ -50,8 +59,17 @@ Default to /usr/bin/matchbox-window-manager.
 \fB\-X\fR 
 Create an X based Sandbox for gui apps, temporary files for
 $HOME and /tmp, secondary Xserver, defaults to sandbox_x_t
+.TP
+\fB\-C\fR
+Use control groups to control this copy of sandbox.  Specify parameters in /etc/sysconfig/sandbox.  Max memory usage and cpu usage are to be specified in percent.  You can specify which CPUs to use by numbering them 0,1,2... etc.
 .PP
 .SH "SEE ALSO"
 .TP
-runcon(1)
+runcon(1), seunshare(8), selinux(8)
 .PP
+
+.SH AUTHOR
+This manual page was written by 
+.I Dan Walsh <dwalsh@redhat.com>
+and
+.I Thomas Liu <tliu@fedoraproject.org>
diff --git a/policycoreutils/sandbox/sandbox.conf b/policycoreutils/sandbox/sandbox.conf
new file mode 100644
index 0000000..7c35808
--- /dev/null
+++ b/policycoreutils/sandbox/sandbox.conf
@@ -0,0 +1,7 @@
+# Space separate list of homedirs
+HOMEDIRS="/home"
+# Control group configuration
+NAME=sandbox
+CPUAFFINITY=ALL
+MEMUSAGE=80%
+CPUUSAGE=80%
diff --git a/policycoreutils/sandbox/sandbox.conf.5 b/policycoreutils/sandbox/sandbox.conf.5
new file mode 100644
index 0000000..ee97e10
--- /dev/null
+++ b/policycoreutils/sandbox/sandbox.conf.5
@@ -0,0 +1,40 @@
+.TH sandbox.conf "5" "June 2010" "sandbox.conf" "Linux System Administration"
+.SH NAME
+sandbox.conf \- user config file for the SELinux sandbox 
+.SH DESCRIPTION
+.PP
+When running sandbox with the -C argument, it will be confined using control groups and a system administrator can specify how the sandbox is confined.
+
+.PP
+Everything after "#" is ignored, as are empty lines.  All arguments should be separated by and equals sign ("=").
+
+.PP
+These keywords are allowed.
+
+.RS
+.TP
+.B NAME
+The name of the sandbox control group.  Default is "sandbox".
+
+.TP
+.B CPUAFFINITY
+Which cpus to assign sandbox to.  The default is ALL, but users can specify a comma-separated list with dashes ("-") to represent ranges.  Ex: 0-2,5
+
+.TP
+.B MEMUSAGE
+How much memory to allow sandbox to use.  The default is 80%.  Users can specify either a percentage or a value in the form of a number followed by one of the suffixes K, M, G to denote kilobytes, megabytes or gigabytes respectively.  Ex: 50% or 100M
+
+.TP
+.B CPUUSAGE
+Percentage of cpu sandbox should be allowed to use.  The default is 80%.  Specify a value followed by a percent sign ("%"). Ex: 50%
+
+
+
+.SH "SEE ALSO"
+.TP
+sandbox(8)
+.PP
+
+.SH AUTHOR
+This manual page was written by 
+.I Thomas Liu <tliu@fedoraproject.org>
diff --git a/policycoreutils/sandbox/sandbox.init b/policycoreutils/sandbox/sandbox.init
index ff8b3ef..8508647 100644
--- a/policycoreutils/sandbox/sandbox.init
+++ b/policycoreutils/sandbox/sandbox.init
@@ -10,17 +10,12 @@
 #
 # chkconfig: 345 1 99
 #
-# Description: sandbox and other apps that want to use pam_namespace 
-#              on /var/tmp, /tmp and home directories, requires this script
-#              to be run at boot time.
-#              This script sets up the / mount point and all of its 
-#              subdirectories as shared. The script sets up
-#              /tmp, /var/tmp, /home and any homedirs listed in 
-#              /etc/sysconfig/sandbox and all of their subdirectories 
-#              as unshared.
-#              All processes that use pam_namespace will see 
-#              modifications to the global mountspace, except for the
-#              unshared directories.
+# description: sandbox, xguest and other apps that want to use pam_namespace \
+#              require this script be run at boot.  This service script does \
+#              not actually run any service but sets up: \
+#              /var/tmp, /tmp and home directories to be used by these tools.\
+#              If you do not use sandbox, xguest or pam_namespace you can turn \
+#              this service off.\
 #
 
 # Source function library.
diff --git a/policycoreutils/sandbox/sandboxX.sh b/policycoreutils/sandbox/sandboxX.sh
index 8338203..7bdef57 100644
--- a/policycoreutils/sandbox/sandboxX.sh
+++ b/policycoreutils/sandbox/sandboxX.sh
@@ -1,13 +1,26 @@
 #!/bin/bash 
 context=`id -Z | secon -t -l -P`
 export TITLE="Sandbox $context -- `grep ^#TITLE: ~/.sandboxrc | /usr/bin/cut -b8-80`"
-export SCREENSIZE="1000x700"
-#export SCREENSIZE=`xdpyinfo | awk  '/dimensions/ {  print $2 }'`
+[ $# -eq 1 ] && export SCREENSIZE="$1" || export SCREENSIZE="1000x700"
 trap "exit 0" HUP
 
 (/usr/bin/Xephyr -title "$TITLE" -terminate -screen $SCREENSIZE -displayfd 5 5>&1 2>/dev/null) | while read D; do 
     export DISPLAY=:$D
-    python -c 'import gtk, os, commands; commands.getstatusoutput("%s/.sandboxrc" % os.environ["HOME"])'
+    cat > ~/seremote << __EOF
+#!/bin/sh
+DISPLAY=$DISPLAY "\$@"
+__EOF
+chmod +x ~/seremote
+    python << __EOF
+import gtk, os, commands
+rc = [-1,'']
+try:
+    rc=commands.getstatusoutput("%s/.sandboxrc" % os.environ["HOME"])
+except:
+    pass
+if rc[0] == 0:
+    print rc[1]
+__EOF
     export EXITCODE=$?
     kill -HUP 0
     break
diff --git a/policycoreutils/sandbox/seunshare.8 b/policycoreutils/sandbox/seunshare.8
new file mode 100644
index 0000000..e7b8991
--- /dev/null
+++ b/policycoreutils/sandbox/seunshare.8
@@ -0,0 +1,37 @@
+.TH SEUNSHARE "8" "May 2010" "seunshare" "User Commands"
+.SH NAME
+seunshare \- Run cmd with alternate homedir, tmpdir and/or SELinux context
+.SH SYNOPSIS
+.B seunshare
+[ -v ] [ -t tmpdir ] [ -h homedir ] [ -Z context ] -- executable [args]
+.br
+.SH DESCRIPTION
+.PP
+Run the 
+.I executable
+within the specified context, using the alternate home directory and /tmp directory.  The seunshare command unshares from the default namespace, then mounts the specified homedir and tmpdir over the default homedir and /tmp. Finally it tells the kernel to execute the application under the specified SELinux context.
+
+.TP
+\fB\-h homedir\fR
+Alternate homedir to be used by the application.  Homedir must be owned by the user.
+.TP
+\fB\-t\ tmpdir
+Use alternate tempory directory to mount on /tmp.  tmpdir must be owned by the user.
+.TP
+\fB\-c cgroups\fR
+Use cgroups to control this copy of seunshare.  Specify parameters in /etc/sysconfig/sandbox.  Max memory usage and cpu usage are to be specified in percent.  You can specify which CPUs to use by numbering them 0,1,2... etc.
+.TP
+\fB\-Z\ context
+Use alternate SELinux context while runing the executable.
+.TP
+\fB\-v\fR
+Verbose output
+.SH "SEE ALSO"
+.TP
+runcon(1), sandbox(8), selinux(8)	
+.PP
+.SH AUTHOR
+This manual page was written by 
+.I Dan Walsh <dwalsh@redhat.com>
+and
+.I Thomas Liu <tliu@fedoraproject.org>
diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index ec692e7..8d8d0e9 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -1,13 +1,21 @@
+/*
+ * Authors: Dan Walsh <dwalsh@redhat.com>
+ * Authors: Thomas Liu <tliu@fedoraproject.org>
+ */
+
+#define _GNU_SOURCE
 #include <signal.h>
 #include <sys/types.h>
+#include <sys/stat.h>
 #include <sys/wait.h>
 #include <syslog.h>
 #include <sys/mount.h>
 #include <pwd.h>
-#define _GNU_SOURCE
 #include <sched.h>
+#include <libcgroup.h>
 #include <string.h>
 #include <stdio.h>
+#include <regex.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <cap-ng.h>
@@ -15,14 +23,11 @@
 #include <limits.h>
 #include <stdlib.h>
 #include <errno.h>
+#include <fcntl.h>
 
 #include <selinux/selinux.h>
 #include <selinux/context.h>	/* for context-mangling functions */
 
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <unistd.h>
-
 #ifdef USE_NLS
 #include <locale.h>		/* for setlocale() */
 #include <libintl.h>		/* for gettext() */
@@ -39,6 +44,12 @@
 #define MS_PRIVATE 1<<18
 #endif
 
+#ifndef PACKAGE
+#define PACKAGE "policycoreutils"	/* the name of this package lang translation */
+#endif
+
+#define BUF_SIZE 1024
+
 /**
  * This function will drop all capabilities 
  * Returns zero on success, non-zero otherwise
@@ -46,9 +57,9 @@
 static int drop_capabilities(uid_t uid)
 {
 	capng_clear(CAPNG_SELECT_BOTH);
-
 	if (capng_lock() < 0) 
 		return -1;
+
 	/* Change uid */
 	if (setresuid(uid, uid, uid)) {
 		fprintf(stderr, _("Error changing uid, aborting.\n"));
@@ -134,42 +145,98 @@ static int verify_shell(const char *shell_name)
 static int seunshare_mount(const char *src, const char *dst, struct passwd *pwd) {
 	if (verbose)
 		printf("Mount %s on %s\n", src, dst);
-	if (mount(dst, dst,  NULL, MS_BIND | MS_REC, NULL) < 0) {
+
+	int flags = MS_REC;
+	if (strcmp("/tmp", dst) == 0) {
+		flags = flags | MS_NODEV | MS_NOSUID | MS_NOEXEC;
+	}
+
+	if (mount(dst, dst,  NULL, MS_BIND | flags, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), dst, dst, strerror(errno));
 		return -1;
 	}
 
-	if (mount(dst, dst, NULL, MS_PRIVATE | MS_REC, NULL) < 0) {
+	if (mount(dst, dst, NULL, MS_PRIVATE | flags, NULL) < 0) {
 		fprintf(stderr, _("Failed to make %s private: %s\n"), dst, strerror(errno));
 		return -1;
 	}
 
-	if (mount(src, dst, NULL, MS_BIND | MS_REC, NULL) < 0) {
+	if (mount(src, dst, NULL, MS_BIND | flags, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
 		return -1;
 	}
 
 	if (verify_mount(dst, pwd) < 0) 
 		return -1;
+
+	if (strcmp("/tmp", dst) == 0) {
+		struct stat sb;
+		int fd = open(dst,O_RDONLY);
+		if ( fd == -1 ) goto err;
+		if (fstat(fd, &sb) == -1) {
+			close(fd);
+			goto err;
+		}
+		if (fchmod(fd, sb.st_mode | S_ISVTX) < 0) {
+			close(fd);
+			goto err;
+		}
+		close(fd);
+	}
+
+	return 0;
+err:
+	fprintf(stderr, _("Invalid mount point %s: %s\n"), src, strerror(errno));
+	return -1;
+}
+
+#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -t tmpdir ] [ -h homedir ] [-Z CONTEXT] --  executable [args] ")
+
+int sandbox_error(const char *string) {
+	fprintf(stderr, string);
+	syslog(LOG_AUTHPRIV | LOG_ALERT, string);
+	exit(-1);
+
 }
 
-#define USAGE_STRING _("USAGE: seunshare [ -v ] [ -t tmpdir ] [ -h homedir ] -- CONTEXT executable [args] ")
+
+int match(const char *string, char *pattern) {
+	int status;
+	regex_t re; 
+	if (regcomp(&re, pattern, REG_EXTENDED|REG_NOSUB) != 0) {
+		return 0;
+	}
+	status = regexec(&re, string, (size_t)0, NULL, 0);
+	regfree(&re);	
+	if (status != 0) {
+		return 0;
+	}
+	return 1;
+}
+
+void config_error() {
+	fprintf(stderr, "Error parsing config file.");
+	exit(-1);
+}
 
 int main(int argc, char **argv) {
 	int rc;
 	int status = -1;
 
-	security_context_t scontext;
+	security_context_t scontext = NULL;
 
 	int flag_index;		/* flag index in argv[] */
 	int clflag;		/* holds codes for command line flags */
 	char *tmpdir_s = NULL;	/* tmpdir spec'd by user in argv[] */
 	char *homedir_s = NULL;	/* homedir spec'd by user in argv[] */
+	int usecgroups = 0;
 
 	const struct option long_options[] = {
 		{"homedir", 1, 0, 'h'},
 		{"tmpdir", 1, 0, 't'},
 		{"verbose", 1, 0, 'v'},
+		{"cgroups", 1, 0, 'c'},
+		{"context", 1, 0, 'Z'},
 		{NULL, 0, 0, 0}
 	};
 
@@ -180,6 +247,12 @@ int main(int argc, char **argv) {
 		return -1;
 	}
 
+#ifdef USE_NLS
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+#endif
+
 	struct passwd *pwd=getpwuid(uid);
 	if (!pwd) {
 		perror(_("getpwduid failed"));
@@ -192,30 +265,30 @@ int main(int argc, char **argv) {
 	}
 
 	while (1) {
-		clflag = getopt_long(argc, argv, "h:t:", long_options,
+		clflag = getopt_long(argc, argv, "cvh:t:c:m:p:Z:", long_options,
 				     &flag_index);
 		if (clflag == -1)
 			break;
 
 		switch (clflag) {
 		case 't':
-			if (!(tmpdir_s = realpath(optarg, NULL))) {
-				fprintf(stderr, _("Invalid mount point %s: %s\n"), optarg, strerror(errno));
-				return -1;
-			}
+			tmpdir_s = optarg;
 			if (verify_mount(tmpdir_s, pwd) < 0) return -1;
 			break;
 		case 'h':
-			if (!(homedir_s = realpath(optarg, NULL))) {
-				fprintf(stderr, _("Invalid mount point %s: %s\n"), optarg, strerror(errno));
-				return -1;
-			}
+			homedir_s = optarg;
 			if (verify_mount(homedir_s, pwd) < 0) return -1;
 			if (verify_mount(pwd->pw_dir, pwd) < 0) return -1;
 			break;
 		case 'v':
 			verbose = 1;
 			break;
+		case 'c':
+			usecgroups = 1;
+			break;
+		case 'Z':
+			scontext = strdup(optarg);
+			break;
 		default:
 			fprintf(stderr, "%s\n", USAGE_STRING);
 			return -1;
@@ -223,21 +296,179 @@ int main(int argc, char **argv) {
 	}
 
 	if (! homedir_s && ! tmpdir_s) {
-		fprintf(stderr, _("Error: tmpdir and/or homedir required \n"),
-			"%s\n", USAGE_STRING);
+		fprintf(stderr, _("Error: tmpdir and/or homedir required \n %s\n"),USAGE_STRING);
 		return -1;
 	}
 
-	if (argc - optind < 2) {
-		fprintf(stderr, _("Error: context and executable required \n"),
-			"%s\n", USAGE_STRING);
+	if (argc - optind < 1) {
+		fprintf(stderr, _("Error: executable required \n %s \n"), USAGE_STRING);
 		return -1;
 	}
 
-	scontext = argv[optind++];
 	
 	if (set_signal_handles())
 		return -1;
+	if (usecgroups) {
+		char *cpus = NULL;	/* which CPUs to use */
+		char *cgroupname = NULL;/* name for the cgroup */
+		char *mem = NULL;	/* string for memory amount to pass to cgroup */
+		int64_t memusage = 0;	/* amount of memory to use max (percent) */
+		int cpupercentage = 0;  /* what percentage of cpu to allow usage */
+		FILE* fp;
+		char buf[BUF_SIZE];
+		char *tok = NULL;
+		const char* fname = "/etc/sysconfig/sandbox";	
+
+		if ((fp = fopen(fname, "rt")) == NULL) {
+			fprintf(stderr, "Error opening sandbox config file.");
+			exit(-1);
+		}
+		while(fgets(buf, BUF_SIZE, fp) != NULL) {
+			/* Skip comments */
+			if (buf[0] == '#') continue;
+			
+			/* Copy the string, ignoring whitespace */
+			int len = strlen(buf);
+			char *str = malloc((len + 1) * sizeof(char));
+
+			int ind = 0;	
+			int i;
+			for (i = 0; i < len; i++) {
+				char cur = buf[i];
+				if (cur != ' ' && cur != '\t') {
+					str[ind] = cur;
+					ind++;
+				}
+			}
+			str[ind] = '\0';
+
+			tok = strtok(str, "=\n");
+			if (tok != NULL) {
+				if (!strcmp(tok, "CPUAFFINITY")) {
+					tok = strtok(NULL, "=\n");
+					cpus = strdup(tok);
+					if (!strcmp(cpus, "ALL")) {
+						cpus = NULL;
+					}
+				} else if (!strcmp(tok, "MEMUSAGE")) {
+					tok = strtok(NULL, "=\n");
+					if (match(tok, "^[0-9]+[kKmMgG%]")) {
+						char *ind = strchr(tok, '%');
+						if (ind != NULL) {
+							*ind = '\0';;
+							memusage = atoi(tok);
+						} else {
+							mem = strdup(tok);
+						}
+					} else {
+						config_error();
+					}
+
+				} else if (!strcmp(tok, "CPUUSAGE")) {
+					tok = strtok(NULL, "=\n");
+					if (match(tok, "^[0-9]+\%")) {
+						char* ind = strchr(tok, '%');
+						*ind = '\0';
+						cpupercentage = atoi(tok);
+					} else {
+						config_error();
+					}
+				} else if (!strcmp(tok, "NAME")) {
+					tok = strtok(NULL, "=\n");
+					cgroupname = strdup(tok);
+				} else {
+					continue;
+				}
+			}
+
+
+		}
+		if (mem == NULL) {
+			long phypz = sysconf(_SC_PHYS_PAGES);
+			long psize = sysconf(_SC_PAGE_SIZE);
+			memusage = phypz * psize * (float) memusage / 100.0;
+		}
+
+		cgroup_init();
+
+		int64_t current_runtime = 0;
+		int64_t current_period = 0 ;
+		int64_t current_mem = 0;
+		char *curr_cpu_path = NULL;
+		char *curr_mem_path = NULL;
+		int ret  = cgroup_get_current_controller_path(getpid(), "cpu", &curr_cpu_path);
+		if (ret) {
+			sandbox_error("Error while trying to get current controller path.\n");
+		} else {
+			struct cgroup *curr = cgroup_new_cgroup(curr_cpu_path);
+			cgroup_get_cgroup(curr);
+			cgroup_get_value_int64(cgroup_get_controller(curr, "cpu"), "cpu.rt_runtime_us", &current_runtime);
+			cgroup_get_value_int64(cgroup_get_controller(curr, "cpu"), "cpu.rt_period_us", &current_period);
+		}   
+
+		ret  = cgroup_get_current_controller_path(getpid(), "memory", &curr_mem_path);
+		if (ret) {
+			sandbox_error("Error while trying to get current controller path.\n");
+		} else {
+			struct cgroup *curr = cgroup_new_cgroup(curr_mem_path);
+			cgroup_get_cgroup(curr);
+			cgroup_get_value_int64(cgroup_get_controller(curr, "memory"), "memory.limit_in_bytes", &current_mem);
+		}   
+
+		if (((float) cpupercentage)  / 100.0> (float)current_runtime / (float) current_period) {
+			sandbox_error("CPU usage restricted!\n");
+			exit(-1);
+		}   
+
+		if (mem == NULL) {	
+			if (memusage > current_mem) {
+				sandbox_error("Attempting to use more memory than allowed!");
+				exit(-1);
+			}
+		}
+	    
+		long nprocs = sysconf(_SC_NPROCESSORS_ONLN);
+
+		struct sched_param sp; 
+		sp.sched_priority = sched_get_priority_min(SCHED_FIFO);
+		sched_setscheduler(getpid(), SCHED_FIFO, &sp);
+		struct cgroup *sandbox_group = cgroup_new_cgroup(cgroupname);
+		cgroup_add_controller(sandbox_group, "memory");
+		cgroup_add_controller(sandbox_group, "cpu");
+
+		if (mem == NULL) {
+			if (memusage > 0) {
+				cgroup_set_value_uint64(cgroup_get_controller(sandbox_group, "memory"), "memory.limit_in_bytes", memusage);
+			}	
+		} else {
+			cgroup_set_value_string(cgroup_get_controller(sandbox_group, "memory"), "memory.limit_in_bytes", mem);
+		}
+		if (cpupercentage > 0) {
+			cgroup_set_value_uint64(cgroup_get_controller(sandbox_group, "cpu"), "cpu.rt_runtime_us",
+						(float) cpupercentage / 100.0 * 60000);
+			cgroup_set_value_uint64(cgroup_get_controller(sandbox_group, "cpu"), "cpu.rt_period_us",60000 * nprocs);
+		}
+		if (cpus != NULL) {
+			cgroup_set_value_string(cgroup_get_controller(sandbox_group, "cpu"), "cgroup.procs",cpus);
+		}
+
+		uint64_t allocated_mem;
+		if (cgroup_get_value_uint64(cgroup_get_controller(sandbox_group, "memory"), "memory.limit_in_bytes", &allocated_mem) > current_mem) {
+			sandbox_error("Attempting to use more memory than allowed!\n");
+			exit(-1);
+		}
+
+
+		int r = cgroup_create_cgroup(sandbox_group, 1);
+		if (r != 0) {
+			sandbox_error("Failed to create group.  Ensure that cgconfig service is running. \n");
+			exit(-1);
+		}
+
+
+		cgroup_attach_task(sandbox_group);
+
+	}
 
         if (unshare(CLONE_NEWNS) < 0) {
 		perror(_("Failed to unshare"));
@@ -286,11 +517,13 @@ int main(int argc, char **argv) {
 			exit(-1);
 		}
 		
-		if (setexeccon(scontext)) {
-			fprintf(stderr, _("Could not set exec context to %s.\n"),
-				scontext);
-			free(display);
-			exit(-1);
+		if (scontext) {
+			if (setexeccon(scontext)) {
+				fprintf(stderr, _("Could not set exec context to %s.\n"),
+					scontext);
+				free(display);
+				exit(-1);
+			}
 		}
 
 		if (display) 
@@ -305,17 +538,14 @@ int main(int argc, char **argv) {
 			perror(_("Failed to change dir to homedir"));
 			exit(-1);
 		}
-		setsid();
 		execv(argv[optind], argv + optind);
 		free(display);
+		freecon(scontext);
 		perror("execv");
 		exit(-1);
 	} else {
 		waitpid(child, &status, 0);
 	}
 
-	free(tmpdir_s);
-	free(homedir_s);
-
 	return status;
 }

--------------000602070201000007060104
Content-Type: application/pgp-signature;
 name="sandbox.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="sandbox.patch.sig"

iEYEABECAAYFAk0GafQACgkQrlYvE4MpobMakgCdGFrd+8bDq/JvtDGaTwmFJ3fEq1kAoNnb
TrQBDSX63uGesOF+NCX3apuQ
--------------000602070201000007060104--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
