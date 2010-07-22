Message-ID: <4C4837F2.1070806@redhat.com>
Date: Thu, 22 Jul 2010 08:22:10 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux <selinux@tycho.nsa.gov>
Subject: This is my first patch for systemd
Content-Type: multipart/mixed;
 boundary="------------040909010904070605010605"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------040909010904070605010605
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Wanted to have you guys review before I send it up to systemd.

This patch sets the socket context based on the domain of the daemon
that systemd will start on connection.  It also labels the fifo_file
based off of the daemons label and the label of the directory the
fifo_file will be created in.


The patch does not handle, systemd creating the directories for the
fifo_file.  In the future, their is talk of making /var/run a tmpfs file
system.  This would mean systemd would create /var/run/mysqld/ before
creating /var/run/mysqld/mysqld.socket.  Additional SELinux controls
would have to be added to systemd to get this correct.  Not sure if the
correct thing to do is at selabel or use
selinux_getfileconfrompath(daemon, parentdir, "dir")



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkxIN/IACgkQrlYvE4MpobNKsgCfRln4hH0J+gLEMyB39HiDbYHE
kggAoM/i43XMzUffcwXAt15iCLHlsJOu
=GN2k
-----END PGP SIGNATURE-----

--------------040909010904070605010605
Content-Type: text/plain;
 name="systemd-selinux.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="systemd-selinux.patch"

diff --git a/Makefile.am b/Makefile.am
index 4dcecc5..31499ba 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -298,7 +298,8 @@ libsystemd_core_la_LIBADD = \
 	$(DBUS_LIBS) \
 	$(UDEV_LIBS) \
 	$(LIBWRAP_LIBS) \
-	$(PAM_LIBS)
+	$(PAM_LIBS) \
+	$(SELINUX_LIBS) 
 
 # This is needed because automake is buggy in how it generates the
 # rules for C programs, but not Vala programs.  We therefore can't
diff --git a/configure.ac b/configure.ac
index 03feb43..4c75f66 100644
--- a/configure.ac
+++ b/configure.ac
@@ -105,6 +105,11 @@ PKG_CHECK_MODULES(DBUS, [ dbus-1 >= 1.3.2 ])
 AC_SUBST(DBUS_CFLAGS)
 AC_SUBST(DBUS_LIBS)
 
+PKG_CHECK_MODULES(SELINUX, [ libselinux >= 2.0.96 ])
+AC_SUBST(SELINUX_CFLAGS)
+AC_SUBST(SELINUX_LIBS)
+AC_SEARCH_LIBS([is_selinux_enabled], [selinux], [], [AC_MSG_ERROR([*** libselinux library not found])])
+
 PKG_CHECK_MODULES(DBUSGLIB, [ dbus-glib-1 ])
 AC_SUBST(DBUSGLIB_CFLAGS)
 AC_SUBST(DBUSGLIB_LIBS)
diff --git a/src/socket-util.c b/src/socket-util.c
index 442abfe..7712b8b 100644
--- a/src/socket-util.c
+++ b/src/socket-util.c
@@ -29,6 +29,7 @@
 #include <net/if.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <selinux/selinux.h>
 
 #include "macro.h"
 #include "util.h"
@@ -305,7 +306,7 @@ int socket_address_listen(
                 bool free_bind,
                 mode_t directory_mode,
                 mode_t socket_mode,
-                /* FIXME SELINUX: pass SELinux context object here */
+                security_context_t scon,
                 int *ret) {
 
         int r, fd, one;
@@ -315,8 +316,12 @@ int socket_address_listen(
         if ((r = socket_address_verify(a)) < 0)
                 return r;
 
-        /* FIXME SELINUX: The socket() here should be done with the
-         * right SELinux context set */
+        if (scon && setsockcreatecon(scon) < 0) {
+                log_error("Failed to set SELinux context (%s) on socket:", scon);
+                if (security_getenforce() == 1) {
+                        return -errno;
+                }
+        }
 
         if ((fd = socket(socket_address_family(a), a->type | SOCK_NONBLOCK | SOCK_CLOEXEC, 0)) < 0)
                 return -errno;
diff --git a/src/socket-util.h b/src/socket-util.h
index 68c579b..841570f 100644
--- a/src/socket-util.h
+++ b/src/socket-util.h
@@ -26,6 +26,7 @@
 #include <netinet/in.h>
 #include <sys/un.h>
 #include <net/if.h>
+#include <selinux/selinux.h>
 
 #include "macro.h"
 #include "util.h"
@@ -71,7 +72,7 @@ int socket_address_listen(
                 bool free_bind,
                 mode_t directory_mode,
                 mode_t socket_mode,
-                /* FIXME SELINUX: pass SELinux context object here */
+                security_context_t scon,
                 int *ret);
 
 bool socket_address_is(const SocketAddress *a, const char *s, int type);
diff --git a/src/socket.c b/src/socket.c
index b06ba09..f1f378c 100644
--- a/src/socket.c
+++ b/src/socket.c
@@ -27,6 +27,7 @@
 #include <sys/epoll.h>
 #include <signal.h>
 #include <arpa/inet.h>
+#include <selinux/selinux.h>
 
 #include "unit.h"
 #include "socket.h"
@@ -642,24 +643,85 @@ static void socket_apply_fifo_options(Socket *s, int fd) {
                         log_warning("F_SETPIPE_SZ: %m");
 }
 
+static int selinux_getconfromexe(
+        const char *exe, 
+        security_context_t *newcon) {
+
+        security_context_t mycon = NULL, fcon = NULL;
+        security_class_t sclass;
+        int r = 0;
+
+        r = getcon(&mycon);
+        if (r < 0) 
+                goto fail;
+
+	r = getfilecon(exe, &fcon);
+        if (r < 0) 
+                goto fail;
+
+        sclass = string_to_security_class("process");
+        r = security_compute_create(mycon, fcon, sclass, newcon);
+
+fail:
+        if (r < 0) 
+		r = -errno;
+
+        freecon(mycon);
+        freecon(fcon);
+        return r;
+}
+
+static int selinux_getfileconfrompath(
+        const security_context_t scon, 
+        const char *path, 
+        const char *class, 
+        security_context_t *fcon) {
+
+        security_context_t dir_con = NULL;
+        security_class_t sclass;
+        int r = 0;
+
+        r = getfilecon(path, &dir_con);
+        if (r >= 0) {
+                sclass = string_to_security_class(class);
+                r = security_compute_create(scon, dir_con, sclass, fcon);
+        }
+        if (r < 0) 
+		r = -errno;
+
+        freecon(dir_con);
+        return r;
+}
+
 static int fifo_address_create(
                 const char *path,
                 mode_t directory_mode,
                 mode_t socket_mode,
-                /* FIXME SELINUX: pass SELinux context object here */
+                security_context_t scon,
                 int *_fd) {
 
-        int fd = -1, r;
+        int fd = -1, r = 0;
         struct stat st;
         mode_t old_mask;
+        security_context_t filecon = NULL;
 
         assert(path);
         assert(_fd);
 
         mkdir_parents(path, directory_mode);
 
-        /* FIXME SELINUX: The mkfifo here should be done with
-         * the right SELinux context set */
+        if (scon && ((r = selinux_getfileconfrompath(scon, path, "FIFO_FILE", &filecon))  == 0)) {
+                r = setfscreatecon(filecon);
+                if ( r < 0 ) {
+                        log_error("Failed to set SELinux file context (%s) on %s:", scon, path);
+			r = -errno;
+                }
+
+                freecon(filecon);
+        }
+
+        if ( r < 0  && security_getenforce() == 1) 
+                goto fail;
 
         /* Enforce the right access mode for the fifo */
         old_mask = umask(~ socket_mode);
@@ -707,6 +769,7 @@ fail:
 static int socket_open_fds(Socket *s) {
         SocketPort *p;
         int r;
+        security_context_t scon = NULL;
 
         assert(s);
 
@@ -726,6 +789,13 @@ static int socket_open_fds(Socket *s) {
                   s->service->exec_command[SERVICE_EXEC_START]->path);
         */
 
+        if (selinux_getconfromexe(s->service->exec_command[SERVICE_EXEC_START]->path, &scon) < 0) {
+                log_error("Failed to get SELinux exec context for %s \n", s->service->exec_command[SERVICE_EXEC_START]->path);
+                if (security_getenforce() == 1)
+                        return -errno;
+        }
+
+        log_debug("%s %s\n", s->service->exec_command[SERVICE_EXEC_START]->path, scon);
         LIST_FOREACH(port, p, s->ports) {
 
                 if (p->fd >= 0)
@@ -741,7 +811,7 @@ static int socket_open_fds(Socket *s) {
                                              s->free_bind,
                                              s->directory_mode,
                                              s->socket_mode,
-                                             /* FIXME SELINUX: Pass the SELinux context object here */
+                                             scon, 
                                              &p->fd)) < 0)
                                 goto rollback;
 
@@ -753,7 +823,7 @@ static int socket_open_fds(Socket *s) {
                                              p->path,
                                              s->directory_mode,
                                              s->socket_mode,
-                                             /* FIXME SELINUX: Pass the SELinux context object here */
+                                             scon, 
                                              &p->fd)) < 0)
                                 goto rollback;
 
@@ -763,10 +833,12 @@ static int socket_open_fds(Socket *s) {
                         assert_not_reached("Unknown port type");
         }
 
+        freecon(scon);
         return 0;
 
 rollback:
         socket_close_fds(s);
+        freecon(scon);
         return r;
 }
 

--------------040909010904070605010605
Content-Type: application/pgp-signature;
 name="systemd-selinux.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="systemd-selinux.patch.sig"

iEYEABECAAYFAkxIN/IACgkQrlYvE4MpobNCIQCeOHyUW1x5ZsLpnPxaEqR3RkHSzfoAoKYz
9kKnTNICPWT9TCLkAW2Xunia
--------------040909010904070605010605--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
