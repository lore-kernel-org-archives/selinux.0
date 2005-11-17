Message-ID: <437CBA8D.8050103@redhat.com>
Date: Thu, 17 Nov 2005 12:14:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, SE Linux <selinux@tycho.nsa.gov>
Subject: Swigify libselinux
Content-Type: multipart/mixed;
 boundary="------------090701010002030100000406"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------090701010002030100000406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


-- 



--------------090701010002030100000406
Content-Type: text/x-patch;
 name="libselinux-rhat.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-rhat.patch"

diff --exclude-from=exclude -N -u -r nsalibselinux/src/Makefile libselinux-1.27.22/src/Makefile
--- nsalibselinux/src/Makefile	2005-11-16 21:39:52.000000000 -0500
+++ libselinux-1.27.22/src/Makefile	2005-11-17 12:05:02.000000000 -0500
@@ -3,25 +3,41 @@
 LIBDIR ?= $(PREFIX)/lib
 SHLIBDIR ?= $(DESTDIR)/lib
 INCLUDEDIR ?= $(PREFIX)/include
+PYINC ?= /usr/include/python2.4
+PYLIB ?= /usr/lib/python2.4
+PYLIBVER ?= python2.4
+PYTHONLIBDIR ?= $(LIBDIR)/python2.4
 
 LIBVERSION = 1
 
-
 LIBA=libselinux.a 
 TARGET=libselinux.so
+SWIGIF= selinuxswig.i
+SWIGCOUT= selinuxswig_wrap.c
+SWIGLOBJ:= $(patsubst %.c,%.lo,$(SWIGCOUT)) 
+SWIGSO=_selinux.so
+SWIGFILES=$(SWIGSO) selinux.py 
 LIBSO=$(TARGET).$(LIBVERSION)
-OBJS= $(patsubst %.c,%.o,$(wildcard *.c))
-LOBJS= $(patsubst %.c,%.lo,$(wildcard *.c))
+OBJS= $(patsubst %.c,%.o,$(filter-out $(SWIGCOUT),$(wildcard *.c))) 
+LOBJS= $(patsubst %.c,%.lo,$(filter-out $(SWIGCOUT),$(wildcard *.c)))
 CFLAGS ?= -Wall -W -Wundef -Wmissing-noreturn -Wmissing-format-attribute
 override CFLAGS += -I../include -I$(INCLUDEDIR) -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64
 RANLIB=ranlib
 
-all: $(LIBA) $(LIBSO)
+SWIG = swig -Wall -python -o $(SWIGCOUT) -outdir ./
+
+all: $(LIBA) $(LIBSO) $(SWIGSO)
 
 $(LIBA):  $(OBJS)
 	$(AR) rcs $@ $^
 	$(RANLIB) $@
 
+$(SWIGLOBJ): $(SWIGCOUT)
+	$(CC) $(CFLAGS) -I$(PYINC) -fpic -DSHARED -c -o $@ $<
+
+$(SWIGSO): $(SWIGLOBJ)
+	$(CC) $(LDFLAGS) -shared -o $@ $< -L. -lselinux -l$(PYLIBVER) -L$(LIBDIR) -Wl,-soname,$@,-z,defs
+
 $(LIBSO): $(LOBJS)
 	$(CC) $(LDFLAGS) -shared -o $@ $^ -ldl -lsepol -L$(LIBDIR) -Wl,-soname,$(LIBSO),-z,defs
 	ln -sf $@ $(TARGET) 
@@ -32,16 +48,26 @@
 %.lo:  %.c policy.h
 	$(CC) $(CFLAGS) -fpic -DSHARED -c -o $@ $<
 
-install: all
+$(SWIGCOUT): $(SWIGIF)
+	$(SWIG) $^
+
+swigify: $(SWIGIF)
+	$(SWIG) $^
+
+install: all install-pywrap
 	test -d $(LIBDIR) || install -m 755 -d $(LIBDIR)
 	install -m 644 $(LIBA) $(LIBDIR)
 	test -d $(SHLIBDIR) || install -m 755 -d $(SHLIBDIR)
 	install -m 755 $(LIBSO) $(SHLIBDIR)
 	cd $(LIBDIR) && ln -sf ../../`basename $(SHLIBDIR)`/$(LIBSO) $(TARGET)
 
+install-pywrap: 
+	test -d $(PYTHONLIBDIR)/site-packages || install -m 755 -d $(PYTHONLIBDIR)/site-packages
+	install -m 755 $(SWIGFILES) $(PYTHONLIBDIR)/site-packages
+
 relabel:
 	/sbin/restorecon $(SHLIBDIR)/$(LIBSO)
 
 clean: 
-	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(TARGET) 
+	-rm -f $(OBJS) $(LOBJS) $(LIBA) $(LIBSO) $(SWIGLOBJ) $(SWIGSO) $(TARGET) 
 
diff --exclude-from=exclude -N -u -r nsalibselinux/src/selinuxswig.i libselinux-1.27.22/src/selinuxswig.i
--- nsalibselinux/src/selinuxswig.i	1969-12-31 19:00:00.000000000 -0500
+++ libselinux-1.27.22/src/selinuxswig.i	2005-11-17 12:02:28.000000000 -0500
@@ -0,0 +1,105 @@
+/* Author: Dan Walsh
+ *
+ * Copyright (C) 2004-2005 Red Hat
+ * 
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+
+%module selinux
+%{
+	#include "selinux/selinux.h"
+%}
+
+extern int is_selinux_enabled(void);
+extern int is_selinux_mls_enabled(void);
+extern int getcon(security_context_t *con);
+extern int setcon(security_context_t con);
+extern int getpidcon(pid_t pid, security_context_t *con);
+extern int getprevcon(security_context_t *con);
+extern int getexeccon(security_context_t *con);
+extern int setexeccon(security_context_t con);
+extern int getfscreatecon(security_context_t *con);
+extern int setfscreatecon(security_context_t context);
+extern int getfilecon(const char *path, security_context_t *con);
+extern int lgetfilecon(const char *path, security_context_t *con);
+extern int fgetfilecon(int fd, security_context_t *con);
+extern int setfilecon(const char *path, security_context_t con);
+extern int lsetfilecon(const char *path, security_context_t con);
+extern int fsetfilecon(int fd, security_context_t con);
+extern int getpeercon(int fd, security_context_t *con);
+extern int selinux_mkload_policy(int preservebools);
+extern int selinux_init_load_policy(int *enforce);
+extern int security_set_boolean_list(size_t boolcnt, 
+				     SELboolean *boollist, 
+				     int permanent);
+extern int security_load_booleans(char *path);
+extern int security_check_context(security_context_t con);
+extern int security_canonicalize_context(security_context_t con,
+					 security_context_t *canoncon);
+extern int security_getenforce(void);
+extern int security_setenforce(int value);
+extern int security_disable(void);
+extern int security_policyvers(void);
+extern int security_get_boolean_names(char ***names, int *len);
+extern int security_get_boolean_pending(const char *name);
+extern int security_get_boolean_active(const char *name);
+extern int security_set_boolean(const char *name, int value);
+extern int security_commit_booleans(void);
+
+/* Set flags controlling operation of matchpathcon_init or matchpathcon. */
+#define MATCHPATHCON_BASEONLY 1 /* Only process the base file_contexts file. */
+#define MATCHPATHCON_NOTRANS  2 /* Do not perform any context translation. */
+extern void set_matchpathcon_flags(unsigned int flags);
+extern int matchpathcon_init(const char *path);
+extern int matchpathcon(const char *path,
+			mode_t mode,
+			security_context_t *con);
+
+extern int matchmediacon(const char *media,
+		 security_context_t *con);
+
+extern int selinux_getenforcemode(int *enforce);
+extern const char *selinux_policy_root(void);
+extern const char *selinux_binary_policy_path(void);
+extern const char *selinux_failsafe_context_path(void);
+extern const char *selinux_removable_context_path(void);
+extern const char *selinux_default_context_path(void);
+extern const char *selinux_user_contexts_path(void);
+extern const char *selinux_file_context_path(void);
+extern const char *selinux_homedir_context_path(void);
+extern const char *selinux_media_context_path(void);
+extern const char *selinux_contexts_path(void);
+extern const char *selinux_booleans_path(void);
+extern const char *selinux_customizable_types_path(void);
+extern const char *selinux_users_path(void);
+extern const char *selinux_usersconf_path(void);
+extern const char *selinux_translations_path(void);
+extern const char *selinux_path(void);
+extern int selinux_check_passwd_access(access_vector_t requested);
+extern int checkPasswdAccess(access_vector_t requested);
+extern int rpm_execcon(unsigned int verified, 
+		       const char *filename, 
+		       char *const argv[], char *const envp[]);
+
+extern int is_context_customizable (security_context_t scontext);
+
+extern int selinux_trans_to_raw_context(security_context_t trans, 
+					security_context_t *rawp);
+extern int selinux_raw_to_trans_context(security_context_t raw, 
+					security_context_t *transp);
+
+extern int getseuserbyname(const char *linuxuser, char **seuser, char **level);
+

--------------090701010002030100000406--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
