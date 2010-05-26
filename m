Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o4QK6PdT007311
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 16:06:25 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id o4QK7jo0005074
	for <selinux@tycho.nsa.gov>; Wed, 26 May 2010 20:07:45 GMT
Subject: Re: Updated sandbox patch.
From: Steve Lawrence <slawrence@tresys.com>
Reply-To: slawrence@tresys.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4BF44320.3050306@redhat.com>
References: <1274209112.2751.70.camel@gorgon>  <4BF44320.3050306@redhat.com>
Content-Type: text/plain
Date: Wed, 26 May 2010 16:06:23 -0400
Message-Id: <1274904383.10369.38.camel@gorgon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2010-05-19 at 15:59 -0400, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Fixed patch that handles Spaces in homedir.
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.14 (GNU/Linux)
> Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/
> 
> iEYEARECAAYFAkv0QyAACgkQrlYvE4MpobNBXQCgmUu92HsN5PiksOTZoGxSp0W+
> 1noAoKoCujFPLHduJ9BP3hrveeXvGKXO
> =iqC+
> -----END PGP SIGNATURE-----


The following patch makes a few updates the the sandbox patch, though I
have a question:

Is the sandbox.init script needed anymore? It looks like seunshare was
changed to now bind mount and make private the necessary directories.
The only thing that seems missing is making root rshared. Also, if the
init script is obsolete, do the mounts also need the MS_REC flag for
recursive bind/private like they are mounted in the init script? e.g.

mount(dst, dst, NULL, (MS_BIND | MS_REC), NULL)
mount(dst, dst, NULL, (MS_PRIVATE | MS_REC), NULL)


Changes the following patch makes:

sandbox.py
- Removes unused 'import commands'
- Fixes the chcon function, and replaces the deprecated os.path.walk
  with os.walk. I think this way is a bit easier to read too.
- Removes the 'yum install seunshare' message. This tool is not specific
  to RPM based distros.
- Remove try/except around -I include to be consistent with the -i
  option. If we can't include a file, then this should bail, no matter
  if it's being included via -i or -I.
- Fix homedir/tmpdir typo in chcon call

sandbox.init (maybe obsoleted?)
- Fix restart so it stops and starts
- unmount the bind mounts when stopped
- Abort with failure if any mounts fail

seunshare.c
- Define the mount flag MS_PRIVATE if it isn't already. The flag is only
  defined in the latest glibc but has been in the kernel since 2005.
- Simplify an if-statment. Also, I'm not sure the purpose of the
  strncmmp in that conditional, so maybe I've oversimplified. It seems
  like maybe an error should be thrown if tmpdir_s == pw_dir or
  homedir_s == "/tmp", but maybe I'm missing something.

---
 policycoreutils/sandbox/sandbox      |   27 +++++---------
 policycoreutils/sandbox/sandbox.init |   65 +++++++++++++++++++++++++---------
 policycoreutils/sandbox/seunshare.c  |   21 +++++------
 3 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index bc7992b..42ebd6c 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -24,7 +24,6 @@ import selinux
 import signal
 from tempfile import mkdtemp
 import pwd
-import commands 
 
 PROGNAME = "policycoreutils"
 HOMEDIR=pwd.getpwuid(os.getuid()).pw_dir
@@ -64,14 +63,13 @@ def error_exit(msg):
     sys.stderr.flush()
     sys.exit(1)
 
-def chcon(path, context, recursive=False):
+def chcon(path, context):
     """ Restore SELinux context on a given path """
-    mode = os.lstat(path)[stat.ST_MODE]
-    lsetfilecon(path, context)
-    if recursive:
-           os.path.walk(path, lambda arg, dirname, fnames:
-                               map(chcon, [os.path.join(dirname, fname)
-                                                for fname in fnames]), context)
+    selinux.lsetfilecon(path, context)
+    for root, dirs, files in os.walk(path):
+        for name in files + dirs:
+            selinux.lsetfilecon(os.path.join(root,name), context)
+
 def copyfile(file, dir, dest):
        import re
        if file.startswith(dir):
@@ -173,10 +171,6 @@ class Sandbox:
            if not os.path.exists("/usr/sbin/seunshare"):
                   raise ValueError(_("""
 /usr/sbin/seunshare is required for the action you want to perform.  
-Install seunshare by executing:
-
-# yum install /usr/sbin/seunshare
-
 """))
 
     def __mount_callback(self, option, opt, value, parser):
@@ -203,10 +197,7 @@ Install seunshare by executing:
     def __includefile(self, option, opt, value, parser):
            fd = open(value, "r")
            for i in fd.readlines():
-                  try:
-                         self.__include(option, opt, i[:-1], parser)
-                  except IOError, e:
-                         sys.stderr.write(e)
+                  self.__include(option, opt, i[:-1], parser)
            fd.close()
 
     def __copyfiles(self):
@@ -347,14 +338,14 @@ sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-
                   os.mkdir(sandboxdir)
 
            if self.__options.homedir:
-                  chcon(self.__options.homedir, self.__filecon, True)
+                  chcon(self.__options.homedir, self.__filecon)
                   self.__homedir = self.__options.homedir
            else:
                   selinux.setfscreatecon(self.__filecon)
                   self.__homedir = mkdtemp(dir=sandboxdir, prefix=".sandbox")
 
            if self.__options.tmpdir:
-                  chcon(self.__options.homedir, self.__filecon, True)
+                  chcon(self.__options.tmpdir, self.__filecon)
                   self.__tmpdir = self.__options.tmpdir
            else:
                   selinux.setfscreatecon(self.__filecon)
diff --git a/policycoreutils/sandbox/sandbox.init b/policycoreutils/sandbox/sandbox.init
index 44867d1..d4e99a0 100644
--- a/policycoreutils/sandbox/sandbox.init
+++ b/policycoreutils/sandbox/sandbox.init
@@ -34,37 +34,68 @@ LOCKFILE=/var/lock/subsys/sandbox
 
 base=${0##*/}
 
-case "$1" in
-    restart)
-    start)
-	[ -f "$LOCKFILE" ] && exit 0
+start() {
+	echo -n "Starting sandbox"
+
+	[ -f "$LOCKFILE" ] && return 1
 
 	touch $LOCKFILE
-	mount --make-rshared /
-	mount --rbind /tmp /tmp
-	mount --rbind /var/tmp /var/tmp
-	mount --make-private /tmp
-	mount --make-private /var/tmp
+	mount --make-rshared / || return $? 
+	mount --rbind /tmp /tmp || return $?
+	mount --rbind /var/tmp /var/tmp || return $?
+	mount --make-private /tmp || return $?
+	mount --make-private /var/tmp || return $?
 	for h in $HOMEDIRS; do
-	    mount --rbind $h $h 
-	    mount --make-private $h
+	    mount --rbind $h $h || return $?
+	    mount --make-private $h || return $?
 	done
 
-	exit $?
-	;;
+	return 0
+}
 
-    status)
+stop() {
+	echo -n "Stopping sandbox"
+
+	[ -f "$LOCKFILE" ] || return 1
+
+	rm -f "$LOCKFILE"
+	umount /tmp || return $?
+	umount /var/tmp || return $?
+	for h in $HOMEDIRS; do
+	    umount $h || return $?
+	done
+}
+
+restart() {
+	stop && success || failure
+	echo
+	start && success || failure
+	echo
+}
+
+status() {
 	if [ -f "$LOCKFILE" ]; then 
 	    echo "$base is running"
 	else
 	    echo "$base is stopped"
 	fi
 	exit 0
-	;;
+}
 
+case "$1" in
+    start)
+	start && success || failure
+	echo
+	;;
     stop)
-	rm -f $LOCKFILE
-	exit 0
+	stop && success || failure
+	echo
+	;;
+    restart)
+	restart
+	;;
+    status)
+	status
 	;;
 
     *)
diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index 848f787..9878e9a 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -31,6 +31,10 @@
 #define _(msgid) (msgid)
 #endif
 
+#ifndef MS_PRIVATE
+#define MS_PRIVATE 1<<18
+#endif
+
 /**
  * This function will drop all capabilities 
  * Returns zero on success, non-zero otherwise
@@ -230,19 +234,14 @@ int main(int argc, char **argv) {
 		return -1;
 	}
 
-	if (homedir_s && tmpdir_s && (strncmp(pwd->pw_dir, tmpdir_s, strlen(pwd->pw_dir)) == 0)) {
-	    if (seunshare_mount(tmpdir_s, "/tmp", pwd) < 0)
-		    return -1;
-	    if (seunshare_mount(homedir_s, pwd->pw_dir, pwd) < 0)
-		    return -1;
-	} else {			
-		if (homedir_s && seunshare_mount(homedir_s, pwd->pw_dir, pwd) < 0)
-				return -1;
-				
-		if (tmpdir_s && seunshare_mount(tmpdir_s, "/tmp", pwd) < 0)
-				return -1;
+	if (tmpdir_s && seunshare_mount(tmpdir_s, "/tmp", pwd) < 0) {
+		return -1;
 	}
 
+	if (homedir_s && seunshare_mount(homedir_s, pwd->pw_dir, pwd) < 0) {
+		return -1;
+	}
+				
 	if (drop_capabilities(uid)) {
 		perror(_("Failed to drop all capabilities"));
 		return -1;
-- 
1.6.6.1

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
