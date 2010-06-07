Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o57LrhNW027474
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2010 17:53:43 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with SMTP id o57Lqtfc007610
	for <selinux@tycho.nsa.gov>; Mon, 7 Jun 2010 21:52:56 GMT
Subject: Re: Updated sandbox patch.
From: Steve Lawrence <slawrence@tresys.com>
Reply-To: slawrence@tresys.com
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <4BFE6C30.7070404@redhat.com>
References: <1274209112.2751.70.camel@gorgon>  <4BF44320.3050306@redhat.com>
	 <1274904383.10369.38.camel@gorgon>  <4BFE6C30.7070404@redhat.com>
Content-Type: text/plain
Date: Mon, 07 Jun 2010 17:53:41 -0400
Message-Id: <1275947621.589.11.camel@gorgon>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2010-05-27 at 08:57 -0400, Daniel J Walsh wrote: 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 05/26/2010 04:06 PM, Steve Lawrence wrote:
> > On Wed, 2010-05-19 at 15:59 -0400, Daniel J Walsh wrote:
> > Fixed patch that handles Spaces in homedir.
> 
> > The following patch makes a few updates the the sandbox patch, though I
> > have a question:
> 
> > Is the sandbox.init script needed anymore? It looks like seunshare was
> > changed to now bind mount and make private the necessary directories.
> > The only thing that seems missing is making root rshared. Also, if the
> > init script is obsolete, do the mounts also need the MS_REC flag for
> > recursive bind/private like they are mounted in the init script? e.g.
> 
> The init script is needed for the xguest package/more specifically
> pam_namespace, but also needed for
> mount --make-rshared /
> 
> Whether the init script belongs in policycoreutils is questionable though.
> 
> 
> > mount(dst, dst, NULL, (MS_BIND | MS_REC), NULL)
> > mount(dst, dst, NULL, (MS_PRIVATE | MS_REC), NULL)
> 
> We probably should add these.  Although it is not likely.
> 
> > Changes the following patch makes:
> 
> > sandbox.py
> > - Removes unused 'import commands'
> > - Fixes the chcon function, and replaces the deprecated os.path.walk
> >   with os.walk. I think this way is a bit easier to read too.
> 
> I think chcon should be added to libselinux python bindings and then
> leave the recursive flag.  (restorecon is currently in python bindings._
> 
> > - Removes the 'yum install seunshare' message. This tool is not specific
> >   to RPM based distros.
> 
> People are using seunshare without X now that I have added the -M flag.
>  So I will move it from the -gui package to the base package with
> sandbox and then this should not be necessary.
> > - Remove try/except around -I include to be consistent with the -i
> >   option. If we can't include a file, then this should bail, no matter
> >   if it's being included via -i or -I.
> 
> Ok, I was thinking you could list a whole bunch of files in the -I case
> and if one does not exist, allow it to continue.  But I don't really care.
> > - Fix homedir/tmpdir typo in chcon call
> 
> > sandbox.init (maybe obsoleted?)
> > - Fix restart so it stops and starts
> > - unmount the bind mounts when stopped
> I doubt this will work.  Two many locks in /tmp /home
> > - Abort with failure if any mounts fail
> 
> > seunshare.c
> > - Define the mount flag MS_PRIVATE if it isn't already. The flag is only
> >   defined in the latest glibc but has been in the kernel since 2005.
> > - Simplify an if-statment. Also, I'm not sure the purpose of the
> >   strncmmp in that conditional, so maybe I've oversimplified. 
> This is wrong.  The problem comes about when you mount within the same
> directory.
> 
> seunshare -t /home/dwalsh/sanbox/tmp -h /home/dwalsh/sandbox/home   ...
> 
> seunshare -t /tmp/sandbox/tmp -h /tmp/sandbox/home
> 
> If you do not have the check one of the above will fail.
> 
> In the first example if Homedir is mounted first,
> /home/dwalsh/sanbox/tmp will no longer exist when seunshare attempts to
> mount it on /tmp.
> 
> Similarly, if /tmp is mounted first in the second example.
> /tmp/sandbox/home will no longer exist.
> 
> You have to check to make sure one of the directories is not included in
> the other.
> 
> It seems
> >   like maybe an error should be thrown if tmpdir_s == pw_dir or
> >   homedir_s == "/tmp", but maybe I'm missing something.
> 
> See above.
> 
> I was blowing up because I use
> 
> ~/sandbox/tmp and ~/sandbox/home for my mountpoints.

<snip>

Below is an updated patch that makes a few changes the the latest
Sandbox Patch [1]. This requires the chcon patch [2].

Changes this patch makes:

sandbox.py
- Remove unused 'import commands'
- Uses new chcon method in libselinux [2]
- Removes the 'yum install seunshare' message
- Converts an IOError to a string for printing a warning if a file  
  listed in -I does not exist

sandbox.init
- Print the standard Starting/Stoping messages with the appropriate
  OK/FAIL
- Abort with failure if any mounts fail

seunshare.c
- Add the MS_REC flag during mounts to perform recursive mounts
- Define the mount flags MS_PRIVATE and MS_REC if they aren't already. 
  The flags are only defined in the latest glibc but have been in the 
  kernel since 2005.
- Calls realpath(3) on tmpdir_s and homedir_s. If relative paths are   
  used, it wouldn't correctly detect that tmpdir is inside homedir and 
  change the mount order. This fixes that.

[1] http://marc.info/?l=selinux&m=127429948731841&w=2
[2] http://marc.info/?l=selinux&m=127594712200878&w=2

--- 
policycoreutils/sandbox/sandbox      |   19 ++----------
 policycoreutils/sandbox/sandbox.init |   52 +++++++++++++++++++++++----------
 policycoreutils/sandbox/seunshare.c  |   27 ++++++++++++++---
 3 files changed, 61 insertions(+), 37 deletions(-)

diff --git a/policycoreutils/sandbox/sandbox b/policycoreutils/sandbox/sandbox
index bc7992b..48a26c2 100644
--- a/policycoreutils/sandbox/sandbox
+++ b/policycoreutils/sandbox/sandbox
@@ -24,7 +24,6 @@ import selinux
 import signal
 from tempfile import mkdtemp
 import pwd
-import commands 
 
 PROGNAME = "policycoreutils"
 HOMEDIR=pwd.getpwuid(os.getuid()).pw_dir
@@ -64,14 +63,6 @@ def error_exit(msg):
     sys.stderr.flush()
     sys.exit(1)
 
-def chcon(path, context, recursive=False):
-    """ Restore SELinux context on a given path """
-    mode = os.lstat(path)[stat.ST_MODE]
-    lsetfilecon(path, context)
-    if recursive:
-           os.path.walk(path, lambda arg, dirname, fnames:
-                               map(chcon, [os.path.join(dirname, fname)
-                                                for fname in fnames]), context)
 def copyfile(file, dir, dest):
        import re
        if file.startswith(dir):
@@ -173,10 +164,6 @@ class Sandbox:
            if not os.path.exists("/usr/sbin/seunshare"):
                   raise ValueError(_("""
 /usr/sbin/seunshare is required for the action you want to perform.  
-Install seunshare by executing:
-
-# yum install /usr/sbin/seunshare
-
 """))
 
     def __mount_callback(self, option, opt, value, parser):
@@ -206,7 +193,7 @@ Install seunshare by executing:
                   try:
                          self.__include(option, opt, i[:-1], parser)
                   except IOError, e:
-                         sys.stderr.write(e)
+                         sys.stderr.write(str(e))
            fd.close()
 
     def __copyfiles(self):
@@ -347,14 +334,14 @@ sandbox [-h] [-[X|M] [-l level ] [-H homedir] [-T tempdir]] [-I includefile ] [-
                   os.mkdir(sandboxdir)
 
            if self.__options.homedir:
-                  chcon(self.__options.homedir, self.__filecon, True)
+                  selinux.chcon(self.__options.homedir, self.__filecon, recursive=True)
                   self.__homedir = self.__options.homedir
            else:
                   selinux.setfscreatecon(self.__filecon)
                   self.__homedir = mkdtemp(dir=sandboxdir, prefix=".sandbox")
 
            if self.__options.tmpdir:
-                  chcon(self.__options.homedir, self.__filecon, True)
+                  selinux.chcon(self.__options.tmpdir, self.__filecon, recursive=True)
                   self.__tmpdir = self.__options.tmpdir
            else:
                   selinux.setfscreatecon(self.__filecon)
diff --git a/policycoreutils/sandbox/sandbox.init b/policycoreutils/sandbox/sandbox.init
index 44867d1..ff8b3ef 100644
--- a/policycoreutils/sandbox/sandbox.init
+++ b/policycoreutils/sandbox/sandbox.init
@@ -34,37 +34,57 @@ LOCKFILE=/var/lock/subsys/sandbox
 
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
+}
+
+status() {
 	if [ -f "$LOCKFILE" ]; then 
 	    echo "$base is running"
 	else
 	    echo "$base is stopped"
 	fi
 	exit 0
+}
+
+case "$1" in
+    restart)
+	start && success || failure
+	;;
+
+    start)
+	start && success || failure
+	echo
 	;;
 
     stop)
-	rm -f $LOCKFILE
-	exit 0
+	stop && success || failure
+	echo
+	;;
+
+    status)
+	status
 	;;
 
     *)
diff --git a/policycoreutils/sandbox/seunshare.c b/policycoreutils/sandbox/seunshare.c
index 848f787..ec692e7 100644
--- a/policycoreutils/sandbox/seunshare.c
+++ b/policycoreutils/sandbox/seunshare.c
@@ -31,6 +31,14 @@
 #define _(msgid) (msgid)
 #endif
 
+#ifndef MS_REC
+#define MS_REC 1<<14
+#endif
+
+#ifndef MS_PRIVATE
+#define MS_PRIVATE 1<<18
+#endif
+
 /**
  * This function will drop all capabilities 
  * Returns zero on success, non-zero otherwise
@@ -126,17 +134,17 @@ static int verify_shell(const char *shell_name)
 static int seunshare_mount(const char *src, const char *dst, struct passwd *pwd) {
 	if (verbose)
 		printf("Mount %s on %s\n", src, dst);
-	if (mount(dst, dst,  NULL, MS_BIND, NULL) < 0) {
+	if (mount(dst, dst,  NULL, MS_BIND | MS_REC, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), dst, dst, strerror(errno));
 		return -1;
 	}
 
-	if (mount(dst, dst, NULL, MS_PRIVATE, NULL) < 0) {
+	if (mount(dst, dst, NULL, MS_PRIVATE | MS_REC, NULL) < 0) {
 		fprintf(stderr, _("Failed to make %s private: %s\n"), dst, strerror(errno));
 		return -1;
 	}
 
-	if (mount(src, dst, NULL, MS_BIND, NULL) < 0) {
+	if (mount(src, dst, NULL, MS_BIND | MS_REC, NULL) < 0) {
 		fprintf(stderr, _("Failed to mount %s on %s: %s\n"), src, dst, strerror(errno));
 		return -1;
 	}
@@ -191,11 +199,17 @@ int main(int argc, char **argv) {
 
 		switch (clflag) {
 		case 't':
-			tmpdir_s = optarg;
+			if (!(tmpdir_s = realpath(optarg, NULL))) {
+				fprintf(stderr, _("Invalid mount point %s: %s\n"), optarg, strerror(errno));
+				return -1;
+			}
 			if (verify_mount(tmpdir_s, pwd) < 0) return -1;
 			break;
 		case 'h':
-			homedir_s = optarg;
+			if (!(homedir_s = realpath(optarg, NULL))) {
+				fprintf(stderr, _("Invalid mount point %s: %s\n"), optarg, strerror(errno));
+				return -1;
+			}
 			if (verify_mount(homedir_s, pwd) < 0) return -1;
 			if (verify_mount(pwd->pw_dir, pwd) < 0) return -1;
 			break;
@@ -300,5 +314,8 @@ int main(int argc, char **argv) {
 		waitpid(child, &status, 0);
 	}
 
+	free(tmpdir_s);
+	free(homedir_s);
+
 	return status;
 }
-- 
1.6.2.5


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
