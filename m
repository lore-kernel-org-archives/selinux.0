Message-ID: <4C49A225.3000406@redhat.com>
Date: Fri, 23 Jul 2010 10:07:33 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: Second patch on systemd.
Content-Type: multipart/mixed;
 boundary="------------040002010508080304000402"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040002010508080304000402
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This one is intended to handle labeling of directories if they do not
exist. As well as add use_selinux() function to determine is selinux is
enabled, and not do stuff if it is disabled.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEUEARECAAYFAkxJoiUACgkQrlYvE4MpobNa5wCg2/i63NszDUOvHyhmMdyNkkNE
JLcAmMAyIHNFOUWNrBqEuM7JaxjleLU=
=/UUh
-----END PGP SIGNATURE-----

--------------040002010508080304000402
Content-Type: text/plain;
 name="systemd-selinux2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="systemd-selinux2.patch"

diff --git a/src/main.c b/src/main.c
index 964bb9c..841caa5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -31,6 +31,7 @@
 #include <signal.h>
 #include <sys/wait.h>
 #include <fcntl.h>
+#include <selinux/selinux.h>
 
 #include "manager.h"
 #include "log.h"
@@ -857,6 +858,14 @@ int main(int argc, char *argv[]) {
                 if (mount_setup() < 0)
                         goto finish;
 
+	if (use_selinux()) {
+		r = matchpathcon_init(NULL);
+		if (r < 0 && security_getenforce() == 1) {
+			log_error("Failed to initialize SELinux Context ");
+			goto finish;
+		}
+	}
+
         /* Reset all signal handlers. */
         assert_se(reset_all_signal_handlers() == 0);
 
@@ -1049,6 +1058,9 @@ int main(int argc, char *argv[]) {
         }
 
 finish:
+	if (use_selinux())
+		matchpathcon_fini();
+
         if (m)
                 manager_free(m);
 
diff --git a/src/socket-util.c b/src/socket-util.c
index 3a00fcf..3eea4f3 100644
--- a/src/socket-util.c
+++ b/src/socket-util.c
@@ -316,7 +316,7 @@ int socket_address_listen(
         if ((r = socket_address_verify(a)) < 0)
                 return r;
 
-        if (setsockcreatecon(scon) < 0) {
+        if (use_selinux() && setsockcreatecon(scon) < 0) {
                 log_error("Failed to set SELinux context (%s) on socket: %m", scon);
                 if (security_getenforce() == 1)
                         return -errno;
@@ -325,7 +325,8 @@ int socket_address_listen(
         fd = socket(socket_address_family(a), a->type | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
         r = fd < 0 ? -errno : 0;
 
-        setsockcreatecon(NULL);
+	if (use_selinux())
+		setsockcreatecon(NULL);
 
         if (r < 0)
                 return r;
diff --git a/src/socket.c b/src/socket.c
index 82a9348..9a64317 100644
--- a/src/socket.c
+++ b/src/socket.c
@@ -711,8 +711,8 @@ static int fifo_address_create(
 
         mkdir_parents(path, directory_mode);
 
-        if (scon) {
-                if (scon && ((r = selinux_getfileconfrompath(scon, path, "fifo_file", &filecon)) == 0)) {
+        if (use_selinux() && scon) {
+                if (((r = selinux_getfileconfrompath(scon, path, "fifo_file", &filecon)) == 0)) {
                         r = setfscreatecon(filecon);
 
                         if (r < 0) {
@@ -746,7 +746,8 @@ static int fifo_address_create(
                 goto fail;
         }
 
-        setfscreatecon(NULL);
+	if (use_selinux()) 
+		setfscreatecon(NULL);
 
         if (fstat(fd, &st) < 0) {
                 r = -errno;
diff --git a/src/util.c b/src/util.c
index da8a6c3..8a2fbbc 100644
--- a/src/util.c
+++ b/src/util.c
@@ -48,6 +48,7 @@
 #include <pwd.h>
 #include <netinet/ip.h>
 #include <linux/kd.h>
+#include <selinux/selinux.h>
 
 #include "macro.h"
 #include "util.h"
@@ -56,6 +57,45 @@
 #include "log.h"
 #include "strv.h"
 
+static int use_selinux_ind = -1;
+
+inline int use_selinux(void) {
+	if (use_selinux_ind == -1) 
+		use_selinux_ind = (is_selinux_enabled() == 1);
+	return use_selinux_ind;
+}
+
+static int mkdir_selinux(
+	const char *path, 
+	mode_t mode) {
+
+	int r;
+	security_context_t fcon = NULL;
+
+	if (use_selinux()) {
+		r = matchpathcon(path, S_IFDIR, &fcon);
+		if (r == 0) 
+			r = setfscreatecon(fcon);
+	
+		if (r < 0) {
+			log_error("Failed to set security context %s for %s", fcon, path);
+		
+			if (security_getenforce() == 1) 
+				goto finish;
+		}
+	}
+
+	r = mkdir(path, mode);
+
+finish:
+	if (use_selinux()) {
+		setfscreatecon(NULL);
+		freecon(fcon);
+	}
+
+	return r;
+}
+
 bool streq_ptr(const char *a, const char *b) {
 
         /* Like streq(), but tries to make sense of NULL pointers */
@@ -969,7 +1009,7 @@ char *file_in_same_dir(const char *path, const char *filename) {
 int safe_mkdir(const char *path, mode_t mode, uid_t uid, gid_t gid) {
         struct stat st;
 
-        if (mkdir(path, mode) >= 0)
+        if (mkdir_selinux(path, mode) >= 0)
                 if (chmod_and_chown(path, mode, uid, gid) < 0)
                         return -errno;
 
@@ -1012,7 +1052,7 @@ int mkdir_parents(const char *path, mode_t mode) {
                 if (!(t = strndup(path, e - path)))
                         return -ENOMEM;
 
-                r = mkdir(t, mode);
+                r = mkdir_selinux(t, mode);
                 free(t);
 
                 if (r < 0 && errno != EEXIST)
@@ -1028,7 +1068,7 @@ int mkdir_p(const char *path, mode_t mode) {
         if ((r = mkdir_parents(path, mode)) < 0)
                 return r;
 
-        if (mkdir(path, mode) < 0 && errno != EEXIST)
+        if (mkdir_selinux(path, mode) < 0 && errno != EEXIST)
                 return -errno;
 
         return 0;
diff --git a/src/util.h b/src/util.h
index 782adb8..48cf7cd 100644
--- a/src/util.h
+++ b/src/util.h
@@ -360,4 +360,6 @@ int ip_tos_from_string(const char *s);
 const char *signal_to_string(int i);
 int signal_from_string(const char *s);
 
+int use_selinux(void);
+
 #endif

--------------040002010508080304000402
Content-Type: application/pgp-signature;
 name="systemd-selinux2.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="systemd-selinux2.patch.sig"

iEYEABECAAYFAkxJoiUACgkQrlYvE4MpobN8vQCgrXskz2pIpjNeKZDl4bviF7H9yNIAn2b7
Ogk0vwHqJxO28qwvFRTNpUtx
--------------040002010508080304000402--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
