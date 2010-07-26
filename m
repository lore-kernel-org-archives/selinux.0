Message-ID: <4C4DF1B4.2020308@redhat.com>
Date: Mon, 26 Jul 2010 16:36:04 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: The third patch for systemd.
Content-Type: multipart/mixed;
 boundary="------------040501080704020003000601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040501080704020003000601
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch makes SELinux optional and moves all of the functions to util.c.

Covers them under a wraper of label_*.

Also switches out matchpathcon for selabel calls.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxN8bQACgkQrlYvE4MpobNcPgCcCCyDg6UcBQQLnJRO0E/RJs6m
LS4AnA/48iOpNqhk53OItY8RxWlXYbzZ
=H8yt
-----END PGP SIGNATURE-----

--------------040501080704020003000601
Content-Type: text/plain;
 name="systemd-selinux3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="systemd-selinux3.patch"

diff --git a/configure.ac b/configure.ac
index 14622e4..e17f129 100644
--- a/configure.ac
+++ b/configure.ac
@@ -105,15 +105,26 @@ PKG_CHECK_MODULES(DBUS, [ dbus-1 >= 1.3.2 ])
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
-PKG_CHECK_MODULES(SELINUX, [ libselinux ])
-AC_SUBST(SELINUX_CFLAGS)
-AC_SUBST(SELINUX_LIBS)
-AC_SEARCH_LIBS([is_selinux_enabled], [selinux], [], [AC_MSG_ERROR([*** libselinux library not found])])
-
 PKG_CHECK_MODULES(DBUSGLIB, [ dbus-glib-1 ])
 AC_SUBST(DBUSGLIB_CFLAGS)
 AC_SUBST(DBUSGLIB_LIBS)
 
+have_selinux=no
+AC_ARG_ENABLE(selinux, AS_HELP_STRING([--disable-selinux], [disable SELINUX support]))
+if test "x$enable_selinux" != "xno"; then
+	# not using PKG_CHECK_MODULES as for some reason libselinux didn't
+	# install any pkg-config modules here
+	AC_SEARCH_LIBS([getcon], [selinux],
+                [AC_DEFINE(HAVE_SELINUX, 1, [Define if SELINUX is available]) have_selinux=yes],
+		have_selinux=no)
+        AC_SUBST(SELINUX_CFLAGS)
+        AC_SUBST(SELINUX_LIBS)
+        if test "x$have_selinux" = xno -a "x$enable_selinux" = xyes; then
+             AC_MSG_ERROR([*** selinux support requested but libraries not found])
+        fi
+fi
+AM_CONDITIONAL(HAVE_SELINUX, [test "$have_selinux" = "yes"])
+
 AC_ARG_ENABLE([tcpwrap],
         AS_HELP_STRING([--disable-tcpwrap],[Disable optional TCP wrappers support]),
                 [case "${enableval}" in
diff --git a/src/main.c b/src/main.c
index e67d222..99b8811 100644
--- a/src/main.c
+++ b/src/main.c
@@ -836,6 +836,9 @@ int main(int argc, char *argv[]) {
                 return 1;
         }
 
+	if (label_init() < 0)
+		return 1;
+
         log_show_color(isatty(STDERR_FILENO) > 0);
         log_show_location(false);
         log_set_max_level(LOG_INFO);
@@ -1113,5 +1116,7 @@ finish:
         if (getpid() == 1)
                 freeze();
 
+	label_finish();
+
         return retval;
 }
diff --git a/src/socket-util.c b/src/socket-util.c
index 3a00fcf..d1f3e7b 100644
--- a/src/socket-util.c
+++ b/src/socket-util.c
@@ -29,7 +29,6 @@
 #include <net/if.h>
 #include <sys/types.h>
 #include <sys/stat.h>
-#include <selinux/selinux.h>
 
 #include "macro.h"
 #include "util.h"
@@ -306,7 +305,7 @@ int socket_address_listen(
                 bool free_bind,
                 mode_t directory_mode,
                 mode_t socket_mode,
-                security_context_t scon,
+                const char *label,
                 int *ret) {
 
         int r, fd, one;
@@ -316,16 +315,15 @@ int socket_address_listen(
         if ((r = socket_address_verify(a)) < 0)
                 return r;
 
-        if (setsockcreatecon(scon) < 0) {
-                log_error("Failed to set SELinux context (%s) on socket: %m", scon);
-                if (security_getenforce() == 1)
-                        return -errno;
-        }
+	r = label_socket_set(label);
+	if (r < 0)
+		return r;
 
         fd = socket(socket_address_family(a), a->type | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
         r = fd < 0 ? -errno : 0;
 
-        setsockcreatecon(NULL);
+	
+	label_socket_clear();
 
         if (r < 0)
                 return r;
diff --git a/src/socket-util.h b/src/socket-util.h
index 841570f..86c9e47 100644
--- a/src/socket-util.h
+++ b/src/socket-util.h
@@ -26,7 +26,6 @@
 #include <netinet/in.h>
 #include <sys/un.h>
 #include <net/if.h>
-#include <selinux/selinux.h>
 
 #include "macro.h"
 #include "util.h"
@@ -72,7 +71,7 @@ int socket_address_listen(
                 bool free_bind,
                 mode_t directory_mode,
                 mode_t socket_mode,
-                security_context_t scon,
+                const char *label,
                 int *ret);
 
 bool socket_address_is(const SocketAddress *a, const char *s, int type);
diff --git a/src/socket.c b/src/socket.c
index 82a9348..3e5e19d 100644
--- a/src/socket.c
+++ b/src/socket.c
@@ -27,7 +27,6 @@
 #include <sys/epoll.h>
 #include <signal.h>
 #include <arpa/inet.h>
-#include <selinux/selinux.h>
 
 #include "unit.h"
 #include "socket.h"
@@ -643,89 +642,25 @@ static void socket_apply_fifo_options(Socket *s, int fd) {
                         log_warning("F_SETPIPE_SZ: %m");
 }
 
-static int selinux_getconfromexe(
-                const char *exe,
-                security_context_t *newcon) {
-
-        security_context_t mycon = NULL, fcon = NULL;
-        security_class_t sclass;
-        int r = 0;
-
-        r = getcon(&mycon);
-        if (r < 0)
-                goto fail;
-
-        r = getfilecon(exe, &fcon);
-        if (r < 0)
-                goto fail;
-
-        sclass = string_to_security_class("process");
-        r = security_compute_create(mycon, fcon, sclass, newcon);
-
-fail:
-        if (r < 0)
-                r = -errno;
-
-        freecon(mycon);
-        freecon(fcon);
-        return r;
-}
-
-static int selinux_getfileconfrompath(
-                const security_context_t scon,
-                const char *path,
-                const char *class,
-                security_context_t *fcon) {
-
-        security_context_t dir_con = NULL;
-        security_class_t sclass;
-        int r = 0;
-
-        r = getfilecon(path, &dir_con);
-        if (r >= 0) {
-                r = -1;
-                if ((sclass = string_to_security_class(class)) != 0)
-                        r = security_compute_create(scon, dir_con, sclass, fcon);
-        }
-        if (r < 0)
-                r = -errno;
-
-        freecon(dir_con);
-        return r;
-}
 
 static int fifo_address_create(
                 const char *path,
                 mode_t directory_mode,
                 mode_t socket_mode,
-                security_context_t scon,
+                const char *label,
                 int *_fd) {
 
         int fd = -1, r = 0;
         struct stat st;
         mode_t old_mask;
-        security_context_t filecon = NULL;
 
         assert(path);
         assert(_fd);
 
         mkdir_parents(path, directory_mode);
 
-        if (scon) {
-                if (scon && ((r = selinux_getfileconfrompath(scon, path, "fifo_file", &filecon)) == 0)) {
-                        r = setfscreatecon(filecon);
-
-                        if (r < 0) {
-                                log_error("Failed to set SELinux file context (%s) on %s: %m", scon, path);
-                                r = -errno;
-                        }
-
-                        freecon(filecon);
-                }
-
-                if (r < 0  && security_getenforce() == 1)
-                        goto fail;
-        }
+	if ((r = label_fifofile_set(label, path)) < 0)
+		goto fail;
 
         /* Enforce the right access mode for the fifo */
         old_mask = umask(~ socket_mode);
@@ -746,7 +681,7 @@ static int fifo_address_create(
                 goto fail;
         }
 
-        setfscreatecon(NULL);
+	label_file_clear();
 
         if (fstat(fd, &st) < 0) {
                 r = -errno;
@@ -766,7 +701,7 @@ static int fifo_address_create(
         return 0;
 
 fail:
-        setfscreatecon(NULL);
+	label_file_clear();
         if (fd >= 0)
                 close_nointr_nofail(fd);
 
@@ -776,20 +711,16 @@ fail:
 static int socket_open_fds(Socket *s) {
         SocketPort *p;
         int r;
-        security_context_t scon = NULL;
+	char *label = NULL;
 
         assert(s);
 
         if ((r = socket_instantiate_service(s)) < 0)
                 return r;
 
-        if (selinux_getconfromexe(s->service->exec_command[SERVICE_EXEC_START]->path, &scon) < 0) {
-                log_error("Failed to get SELinux exec context for %s \n", s->service->exec_command[SERVICE_EXEC_START]->path);
-                if (security_getenforce() == 1)
-                        return -errno;
-        }
+	if ((r = label_get_socket_label_from_exe(s->service->exec_command[SERVICE_EXEC_START]->path, &label)) < 0)
+		return r;
 
-        log_debug("SELinux Socket context for %s set to %s\n", s->service->exec_command[SERVICE_EXEC_START]->path, scon);
         LIST_FOREACH(port, p, s->ports) {
 
                 if (p->fd >= 0)
@@ -805,7 +736,7 @@ static int socket_open_fds(Socket *s) {
                                              s->free_bind,
                                              s->directory_mode,
                                              s->socket_mode,
-                                             scon,
+                                             label,
                                              &p->fd)) < 0)
                                 goto rollback;
 
@@ -817,7 +748,7 @@ static int socket_open_fds(Socket *s) {
                                              p->path,
                                              s->directory_mode,
                                              s->socket_mode,
-                                             scon,
+                                             label,
                                              &p->fd)) < 0)
                                 goto rollback;
 
@@ -827,12 +758,12 @@ static int socket_open_fds(Socket *s) {
                         assert_not_reached("Unknown port type");
         }
 
-        freecon(scon);
+        label_free(label);
         return 0;
 
 rollback:
         socket_close_fds(s);
-        freecon(scon);
+        label_free(label);
         return r;
 }
 
diff --git a/src/util.c b/src/util.c
index da8a6c3..ba1b658 100644
--- a/src/util.c
+++ b/src/util.c
@@ -48,6 +48,10 @@
 #include <pwd.h>
 #include <netinet/ip.h>
 #include <linux/kd.h>
+#ifdef HAVE_SELINUX
+#include <selinux/selinux.h>
+#include <selinux/label.h>
+#endif
 
 #include "macro.h"
 #include "util.h"
@@ -56,6 +60,216 @@
 #include "log.h"
 #include "strv.h"
 
+#if HAVE_SELINUX
+static int use_selinux_ind = -1;
+static struct selabel_handle *label_hnd;
+
+static inline int use_selinux(void) {
+	if (use_selinux_ind == -1) 
+		use_selinux_ind = (is_selinux_enabled() == 1);
+	return use_selinux_ind;
+}
+
+static int label_get_file_label_from_path(
+                const char *label,
+                const char *path,
+                const char *class,
+                security_context_t *fcon) {
+
+        security_context_t dir_con = NULL;
+        security_class_t sclass;
+        int r = 0;
+
+        r = getfilecon(path, &dir_con);
+        if (r >= 0) {
+                r = -1;
+                if ((sclass = string_to_security_class(class)) != 0)
+                        r = security_compute_create((security_context_t)label, dir_con, sclass, fcon);
+        }
+        if (r < 0)
+                r = -errno;
+
+        freecon(dir_con);
+        return r;
+}
+
+#endif
+
+int label_init(void) {
+	int r = 0;
+
+#if HAVE_SELINUX
+	if (use_selinux()) {
+		label_hnd = selabel_open(SELABEL_CTX_FILE, NULL, 0);
+		if (label_hnd != 0 && security_getenforce() == 1) {
+			log_error("Failed to initialize SELinux Context ");
+			r = -errno;
+		} else {
+			r = 0;
+		}
+	}
+#endif
+
+	return r;
+}
+
+void label_finish(void) {
+
+#if HAVE_SELINUX
+	if (use_selinux())
+		selabel_close(label_hnd);
+#endif
+
+}
+
+int label_get_socket_label_from_exe(
+	const char *exe,
+	char **label) {
+	int r = 0;
+
+#if HAVE_SELINUX
+        security_context_t mycon = NULL, fcon = NULL;
+        security_class_t sclass;
+      
+        r = getcon(&mycon);
+        if (r < 0)
+                goto fail;
+
+        r = getfilecon(exe, &fcon);
+        if (r < 0)
+                goto fail;
+
+        sclass = string_to_security_class("process");
+        r = security_compute_create(mycon, fcon, sclass, (security_context_t *) label);
+	if (r == 0)
+		log_debug("SELinux Socket context for %s will be set to %s\n", exe, *label);
+
+fail:
+	if (r< 0 && security_getenforce() == 1)
+                r = -errno;
+
+        freecon(mycon);
+        freecon(fcon);
+#endif
+
+        return r;
+}
+
+int label_fifofile_set(const char *label, const char *path) {
+	int r = 0;
+
+#if HAVE_SELINUX
+	security_context_t filecon = NULL;
+	if (use_selinux() && label) {
+                if (((r = label_get_file_label_from_path(label, path, "fifo_file", &filecon)) == 0)) {
+                        if ((r = setfscreatecon(filecon)) < 0) {
+                                log_error("Failed to set SELinux file context (%s) on %s", label, path);
+                                r = -errno;
+                        }
+			
+                        freecon(filecon);
+                }
+		
+                if (r < 0  && security_getenforce() == 0)
+			r = 0;
+        }
+#endif
+
+	return r;
+}
+
+int label_socket_set(const char *label) {
+
+#if HAVE_SELINUX
+	if (use_selinux() && setsockcreatecon((security_context_t) label) < 0) {
+                log_error("Failed to set SELinux context (%s) on socket: %m", label);
+                if (security_getenforce() == 1)
+                        return -errno;
+        }
+#endif
+
+	return 0;
+}
+
+void label_file_clear(void) {
+
+#if HAVE_SELINUX
+	if (use_selinux()) 
+		setfscreatecon(NULL);
+#endif
+
+	return;
+}
+
+void label_free(const char *label) {
+
+#if HAVE_SELINUX
+	if (use_selinux()) 
+		freecon((security_context_t) label);
+#endif
+
+	return;
+}
+
+void label_socket_clear(void) {
+
+#if HAVE_SELINUX
+	if (use_selinux())
+		setsockcreatecon(NULL);
+#endif
+
+	return;
+}
+
+static int label_mkdir(
+	const char *path, 
+	mode_t mode) {
+
+#if HAVE_SELINUX
+	int r;
+	security_context_t fcon = NULL;
+
+	if (use_selinux()) {
+		if (path[0] == '/') {
+			r = selabel_lookup_raw(label_hnd, &fcon, path, mode);
+		}
+		else {
+			char *cwd = NULL; 
+			char *newpath=NULL;
+			cwd = getcwd(NULL,0);
+			if ((! cwd) || (asprintf(&newpath, "%s/%s",cwd,path) < 0)) {
+				free(cwd);
+				return -errno;
+			}
+			r = selabel_lookup_raw(label_hnd, &fcon, newpath, mode);
+			free(cwd);
+			free(newpath);
+		}
+
+		if (r == 0) 
+			r = setfscreatecon(fcon);
+	
+		if ((r < 0) && (errno != ENOENT)) {
+			log_error("Failed to set security context %s for %s", fcon, path);
+		
+			if (security_getenforce() == 1) 
+				goto finish;
+		}
+	}
+	r = mkdir(path, mode);
+
+finish:
+	if (use_selinux()) {
+		setfscreatecon(NULL);
+		freecon(fcon);
+	}
+
+	return r;
+#else
+	return mkdir(path, mode);
+#endif
+}
+
 bool streq_ptr(const char *a, const char *b) {
 
         /* Like streq(), but tries to make sense of NULL pointers */
@@ -969,7 +1183,7 @@ char *file_in_same_dir(const char *path, const char *filename) {
 int safe_mkdir(const char *path, mode_t mode, uid_t uid, gid_t gid) {
         struct stat st;
 
-        if (mkdir(path, mode) >= 0)
+        if (label_mkdir(path, mode) >= 0)
                 if (chmod_and_chown(path, mode, uid, gid) < 0)
                         return -errno;
 
@@ -1012,7 +1226,7 @@ int mkdir_parents(const char *path, mode_t mode) {
                 if (!(t = strndup(path, e - path)))
                         return -ENOMEM;
 
-                r = mkdir(t, mode);
+                r = label_mkdir(t, mode);
                 free(t);
 
                 if (r < 0 && errno != EEXIST)
@@ -1028,7 +1242,7 @@ int mkdir_p(const char *path, mode_t mode) {
         if ((r = mkdir_parents(path, mode)) < 0)
                 return r;
 
-        if (mkdir(path, mode) < 0 && errno != EEXIST)
+        if (label_mkdir(path, mode) < 0 && errno != EEXIST)
                 return -errno;
 
         return 0;
diff --git a/src/util.h b/src/util.h
index 782adb8..dbfbc28 100644
--- a/src/util.h
+++ b/src/util.h
@@ -360,4 +360,13 @@ int ip_tos_from_string(const char *s);
 const char *signal_to_string(int i);
 int signal_from_string(const char *s);
 
+int label_init(void);
+void label_finish(void);
+int label_socket_set(const char *label);
+void label_socket_clear(void);
+int label_fifofile_set(const char *label, const char *path);
+void label_file_clear(void);
+void label_free(const char *label);
+int label_get_socket_label_from_exe(const char *exe, char **label);
+
 #endif

--------------040501080704020003000601
Content-Type: application/pgp-signature;
 name="systemd-selinux3.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="systemd-selinux3.patch.sig"

iEYEABECAAYFAkxN8bQACgkQrlYvE4MpobPyygCcCAyEn938QmKzBZYPKt9KyYxkIWwAoKwO
/1APwKqfRZrERY2px6tMtnvd
--------------040501080704020003000601--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
