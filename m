Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lAQFNUDk010762
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 10:23:30 -0500
Received: from nf-out-0910.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id lAQFNGjm025808
	for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 15:23:17 GMT
Received: by nf-out-0910.google.com with SMTP id k4so865788nfd
        for <selinux@tycho.nsa.gov>; Mon, 26 Nov 2007 07:23:13 -0800 (PST)
Message-ID: <cadfc0e40711260723q36ed7ecatb5a24e99c07accb8@mail.gmail.com>
Date: Mon, 26 Nov 2007 09:23:13 -0600
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>
Subject: [RFC Patch 1/10] PAM Namespace: make polyinstantiated directories module
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch includes a pam module which will ensure the existence, when DAC
and MAC access are allowed, of polyinstantiated directories and instance
directories. The pam_mkpolydir module is meant for use with pam_namespace
and helps to avoid pam session failures which occur if polyinstantiated
directories and instance directories do not exist.


--- Linux-PAM-0.99.8.1/configure.in	2007-10-29 14:30:59.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/configure.in	2007-10-29 14:31:33.000000000 -0600
@@ -497,6 +497,7 @@
 	modules/pam_unix/Makefile modules/pam_userdb/Makefile \
 	modules/pam_warn/Makefile modules/pam_wheel/Makefile \
 	modules/pam_xauth/Makefile doc/Makefile doc/specs/Makefile \
+	modules/pam_mkpolydir/Makefile \
 	doc/man/Makefile doc/sag/Makefile doc/adg/Makefile \
 	doc/mwg/Makefile examples/Makefile tests/Makefile \
 	xtests/Makefile)
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/argv_parse.c
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/argv_parse.c
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/argv_parse.c	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/argv_parse.c	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,164 @@
+/*
+ * argv_parse.c --- utility function for parsing a string into a
+ * 	argc, argv array.
+ *
+ * This file defines a function argv_parse() which parsing a
+ * passed-in string, handling double quotes and backslashes, and
+ * creates an allocated argv vector which can be freed using the
+ * argv_free() function.
+ *
+ * See argv_parse.h for the formal definition of the functions.
+ *
+ * Copyright 1999 by Theodore Ts'o.
+ *
+ * Permission to use, copy, modify, and distribute this software for
+ * any purpose with or without fee is hereby granted, provided that
+ * the above copyright notice and this permission notice appear in all
+ * copies.  THE SOFTWARE IS PROVIDED "AS IS" AND THEODORE TS'O (THE
+ * AUTHOR) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
+ * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
+ * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
+ * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
+ * IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.  (Isn't
+ * it sick that the U.S. culture of lawsuit-happy lawyers requires
+ * this kind of disclaimer?)
+ *
+ * Version 1.1, modified 2/27/1999
+ */
+
+#include <stdlib.h>
+#include <ctype.h>
+#include <string.h>
+#include "argv_parse.h"
+
+#define STATE_WHITESPACE	1
+#define STATE_TOKEN		2
+#define STATE_QUOTED		3
+
+/*
+ * Returns 0 on success, -1 on failure.
+ */
+int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv)
+{
+	int	argc = 0, max_argc = 0;
+	char 	**argv, **new_argv, *buf, ch;
+	char	*cp = 0, *outcp = 0;
+	int	state = STATE_WHITESPACE;
+
+	buf = malloc(strlen(in_buf)+1);
+	if (!buf)
+		return -1;
+
+	max_argc = 0; argc = 0; argv = 0;
+	outcp = buf;
+	for (cp = in_buf; (ch = *cp); cp++) {
+		if (state == STATE_WHITESPACE) {
+			if (isspace((int) ch))
+				continue;
+			/* Not whitespace, so start a new token */
+			state = STATE_TOKEN;
+			if (argc >= max_argc) {
+				max_argc += 3;
+				new_argv = realloc(argv,
+						  (max_argc+1)*sizeof(char *));
+				if (!new_argv) {
+					if (argv) free(argv);
+					free(buf);
+					return -1;
+				}
+				argv = new_argv;
+			}
+			argv[argc++] = outcp;
+		}
+		if (state == STATE_QUOTED) {
+			if (ch == '"')
+				state = STATE_TOKEN;
+			else
+				*outcp++ = ch;
+			continue;
+		}
+		/* Must be processing characters in a word */
+		if (isspace((int) ch)) {
+			/*
+			 * Terminate the current word and start
+			 * looking for the beginning of the next word.
+			 */
+			*outcp++ = 0;
+			state = STATE_WHITESPACE;
+			continue;
+		}
+		if (ch == '"') {
+			state = STATE_QUOTED;
+			continue;
+		}
+		if (ch == '\\') {
+			ch = *++cp;
+			switch (ch) {
+			case '\0':
+				ch = '\\'; cp--; break;
+			case 'n':
+				ch = '\n'; break;
+			case 't':
+				ch = '\t'; break;
+			case 'b':
+				ch = '\b'; break;
+			}
+		}
+		*outcp++ = ch;
+	}
+	if (state != STATE_WHITESPACE)
+		*outcp++ = '\0';
+	if (argv == 0) {
+		argv = malloc(sizeof(char *));
+		free(buf);
+	}
+	argv[argc] = 0;
+	if (ret_argc)
+		*ret_argc = argc;
+	if (ret_argv)
+		*ret_argv = argv;
+	return 0;
+}
+
+void argv_free(char **argv)
+{
+	if (*argv)
+		free(*argv);
+	free(argv);
+}
+
+#ifdef DEBUG
+/*
+ * For debugging
+ */
+
+#include <stdio.h>
+
+int main(int argc, char **argv)
+{
+	int	ac, ret;
+	char	**av, **cpp;
+	char	buf[256];
+
+	while (!feof(stdin)) {
+		if (fgets(buf, sizeof(buf), stdin) == NULL)
+			break;
+		ret = argv_parse(buf, &ac, &av);
+		if (ret != 0) {
+			printf("Argv_parse returned %d!\n", ret);
+			continue;
+		}
+		printf("Argv_parse returned %d arguments...\n", ac);
+		for (cpp = av; *cpp; cpp++) {
+			if (cpp != av)
+				printf(", ");
+			printf("'%s'", *cpp);
+		}
+		printf("\n");
+		argv_free(av);
+	}
+	exit(0);
+}
+#endif
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/argv_parse.h
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/argv_parse.h
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/argv_parse.h	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/argv_parse.h	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,43 @@
+/*
+ * argv_parse.h --- header file for the argv parser.
+ *
+ * This file defines the interface for the functions argv_parse() and
+ * argv_free().
+ *
+ ***********************************************************************
+ * int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv)
+ *
+ * This function takes as its first argument a string which it will
+ * parse into an argv argument vector, with each white-space separated
+ * word placed into its own slot in the argv.  This function handles
+ * double quotes and backslashes so that the parsed words can contain
+ * special characters.   The count of the number words found in the
+ * parsed string, as well as the argument vector, are returned into
+ * ret_argc and ret_argv, respectively.
+ ***********************************************************************
+ * extern void argv_free(char **argv);
+ *
+ * This function frees the argument vector created by argv_parse().
+ ***********************************************************************
+ *
+ * Copyright 1999 by Theodore Ts'o.
+ *
+ * Permission to use, copy, modify, and distribute this software for
+ * any purpose with or without fee is hereby granted, provided that
+ * the above copyright notice and this permission notice appear in all
+ * copies.  THE SOFTWARE IS PROVIDED "AS IS" AND THEODORE TS'O (THE
+ * AUTHOR) DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
+ * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS.
+ * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
+ * INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER
+ * RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
+ * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR
+ * IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.  (Isn't
+ * it sick that the U.S. culture of lawsuit-happy lawyers requires
+ * this kind of disclaimer?)
+ *
+ * Version 1.1, modified 2/27/1999
+ */
+
+extern int argv_parse(char *in_buf, int *ret_argc, char ***ret_argv);
+extern void argv_free(char **argv);
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/Makefile.am
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/Makefile.am
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/Makefile.am	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/Makefile.am	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,33 @@
+#
+# Copyright (c) 2007 Ted X. Toth <tedx@gmail.com>
+#
+
+CLEANFILES = *~
+
+EXTRA_DIST = README $(MANS) $(XMLS) tst-pam_mkpolydir
+
+man_MANS = pam_mkpolydir.8
+
+XMLS = README.xml pam_mkpolydir.8.xml
+
+TESTS = tst-pam_mkpolydir
+
+securelibdir = $(SECUREDIR)
+secureconfdir = $(SCONFIGDIR)
+
+AM_CFLAGS = -I$(top_srcdir)/libpam/include -I$(top_srcdir)/libpamc/include
+AM_LDFLAGS = -no-undefined -avoid-version -module \
+	-L$(top_builddir)/libpam -lpam -lselinux
+if HAVE_VERSIONING
+  AM_LDFLAGS += -Wl,--version-script=$(srcdir)/../modules.map
+endif
+
+securelib_LTLIBRARIES = pam_mkpolydir.la
+pam_mkpolydir_la_SOURCES = pam_mkpolydir.c argv_parse.c argv_parse.h
+
+if ENABLE_REGENERATE_MAN
+noinst_DATA = README
+README: pam_mkpolydir.8.xml
+-include $(top_srcdir)/Make.xml.rules
+endif
+
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/Makefile.in
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/Makefile.in
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/Makefile.in	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/Makefile.in	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,675 @@
+# Makefile.in generated by automake 1.9.6 from Makefile.am.
+# @configure_input@
+
+# Copyright (C) 1994, 1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002,
+# 2003, 2004, 2005  Free Software Foundation, Inc.
+# This Makefile.in is free software; the Free Software Foundation
+# gives unlimited permission to copy and/or distribute it,
+# with or without modifications, as long as this notice is preserved.
+
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY, to the extent permitted by law; without
+# even the implied warranty of MERCHANTABILITY or FITNESS FOR A
+# PARTICULAR PURPOSE.
+
+@SET_MAKE@
+
+#
+# Copyright (c) 2005, 2006 Thorsten Kukuk <kukuk@suse.de>
+#
+
+
+srcdir = @srcdir@
+top_srcdir = @top_srcdir@
+VPATH = @srcdir@
+pkgdatadir = $(datadir)/@PACKAGE@
+pkglibdir = $(libdir)/@PACKAGE@
+pkgincludedir = $(includedir)/@PACKAGE@
+top_builddir = ../..
+am__cd = CDPATH="$${ZSH_VERSION+.}$(PATH_SEPARATOR)" && cd
+INSTALL = @INSTALL@
+install_sh_DATA = $(install_sh) -c -m 644
+install_sh_PROGRAM = $(install_sh) -c
+install_sh_SCRIPT = $(install_sh) -c
+INSTALL_HEADER = $(INSTALL_DATA)
+transform = $(program_transform_name)
+NORMAL_INSTALL = :
+PRE_INSTALL = :
+POST_INSTALL = :
+NORMAL_UNINSTALL = :
+PRE_UNINSTALL = :
+POST_UNINSTALL = :
+build_triplet = @build@
+host_triplet = @host@
+@HAVE_VERSIONING_TRUE@am__append_1 =
-Wl,--version-script=$(srcdir)/../modules.map
+subdir = modules/pam_mkpolydir
+DIST_COMMON = README $(srcdir)/Makefile.am $(srcdir)/Makefile.in
+ACLOCAL_M4 = $(top_srcdir)/aclocal.m4
+am__aclocal_m4_deps = $(top_srcdir)/m4/gettext.m4 \
+	$(top_srcdir)/m4/iconv.m4 \
+	$(top_srcdir)/m4/jh_path_xml_catalog.m4 \
+	$(top_srcdir)/m4/ld-O1.m4 $(top_srcdir)/m4/ld-as-needed.m4 \
+	$(top_srcdir)/m4/lib-ld.m4 $(top_srcdir)/m4/lib-link.m4 \
+	$(top_srcdir)/m4/lib-prefix.m4 $(top_srcdir)/m4/libprelude.m4 \
+	$(top_srcdir)/m4/nls.m4 $(top_srcdir)/m4/po.m4 \
+	$(top_srcdir)/m4/progtest.m4 $(top_srcdir)/acinclude.m4 \
+	$(top_srcdir)/configure.in
+am__configure_deps = $(am__aclocal_m4_deps) $(CONFIGURE_DEPENDENCIES) \
+	$(ACLOCAL_M4)
+mkinstalldirs = $(SHELL) $(top_srcdir)/mkinstalldirs
+CONFIG_HEADER = $(top_builddir)/config.h
+CONFIG_CLEAN_FILES =
+am__vpath_adj_setup = srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`;
+am__vpath_adj = case $$p in \
+    $(srcdir)/*) f=`echo "$$p" | sed "s|^$$srcdirstrip/||"`;; \
+    *) f=$$p;; \
+  esac;
+am__strip_dir = `echo $$p | sed -e 's|^.*/||'`;
+am__installdirs = "$(DESTDIR)$(securelibdir)" "$(DESTDIR)$(man8dir)"
+securelibLTLIBRARIES_INSTALL = $(INSTALL)
+LTLIBRARIES = $(securelib_LTLIBRARIES)
+pam_mkpolydir_la_LIBADD =
+am_pam_mkpolydir_la_OBJECTS = pam_mkpolydir.lo argv_parse.lo
+pam_mkpolydir_la_OBJECTS = $(am_pam_mkpolydir_la_OBJECTS)
+DEFAULT_INCLUDES = -I. -I$(srcdir) -I$(top_builddir)
+depcomp = $(SHELL) $(top_srcdir)/depcomp
+am__depfiles_maybe = depfiles
+COMPILE = $(CC) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
+	$(CPPFLAGS) $(AM_CFLAGS) $(CFLAGS)
+LTCOMPILE = $(LIBTOOL) --tag=CC --mode=compile $(CC) $(DEFS) \
+	$(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) $(CPPFLAGS) \
+	$(AM_CFLAGS) $(CFLAGS)
+CCLD = $(CC)
+LINK = $(LIBTOOL) --tag=CC --mode=link $(CCLD) $(AM_CFLAGS) $(CFLAGS) \
+	$(AM_LDFLAGS) $(LDFLAGS) -o $@
+SOURCES = $(pam_mkpolydir_la_SOURCES)
+DIST_SOURCES = $(pam_mkpolydir_la_SOURCES)
+man8dir = $(mandir)/man8
+NROFF = nroff
+MANS = $(man_MANS)
+DATA = $(noinst_DATA)
+ETAGS = etags
+CTAGS = ctags
+DISTFILES = $(DIST_COMMON) $(DIST_SOURCES) $(TEXINFOS) $(EXTRA_DIST)
+ACLOCAL = @ACLOCAL@
+AMDEP_FALSE = @AMDEP_FALSE@
+AMDEP_TRUE = @AMDEP_TRUE@
+AMTAR = @AMTAR@
+AR = @AR@
+AUTOCONF = @AUTOCONF@
+AUTOHEADER = @AUTOHEADER@
+AUTOMAKE = @AUTOMAKE@
+AWK = @AWK@
+BROWSER = @BROWSER@
+CC = @CC@
+CCDEPMODE = @CCDEPMODE@
+CFLAGS = @CFLAGS@
+CPP = @CPP@
+CPPFLAGS = @CPPFLAGS@
+CXX = @CXX@
+CXXCPP = @CXXCPP@
+CXXDEPMODE = @CXXDEPMODE@
+CXXFLAGS = @CXXFLAGS@
+CYGPATH_W = @CYGPATH_W@
+DEFS = @DEFS@
+DEPDIR = @DEPDIR@
+DOCDIR = @DOCDIR@
+ECHO = @ECHO@
+ECHO_C = @ECHO_C@
+ECHO_N = @ECHO_N@
+ECHO_T = @ECHO_T@
+EGREP = @EGREP@
+ENABLE_GENERATE_PDF_FALSE = @ENABLE_GENERATE_PDF_FALSE@
+ENABLE_GENERATE_PDF_TRUE = @ENABLE_GENERATE_PDF_TRUE@
+ENABLE_REGENERATE_MAN_FALSE = @ENABLE_REGENERATE_MAN_FALSE@
+ENABLE_REGENERATE_MAN_TRUE = @ENABLE_REGENERATE_MAN_TRUE@
+EXEEXT = @EXEEXT@
+F77 = @F77@
+FFLAGS = @FFLAGS@
+FO2PDF = @FO2PDF@
+GMSGFMT = @GMSGFMT@
+GMSGFMT_015 = @GMSGFMT_015@
+HAVE_KEY_MANAGEMENT = @HAVE_KEY_MANAGEMENT@
+HAVE_KEY_MANAGEMENT_FALSE = @HAVE_KEY_MANAGEMENT_FALSE@
+HAVE_KEY_MANAGEMENT_TRUE = @HAVE_KEY_MANAGEMENT_TRUE@
+HAVE_LIBCRACK_FALSE = @HAVE_LIBCRACK_FALSE@
+HAVE_LIBCRACK_TRUE = @HAVE_LIBCRACK_TRUE@
+HAVE_LIBDB_FALSE = @HAVE_LIBDB_FALSE@
+HAVE_LIBDB_TRUE = @HAVE_LIBDB_TRUE@
+HAVE_LIBSELINUX_FALSE = @HAVE_LIBSELINUX_FALSE@
+HAVE_LIBSELINUX_TRUE = @HAVE_LIBSELINUX_TRUE@
+HAVE_UNSHARE_FALSE = @HAVE_UNSHARE_FALSE@
+HAVE_UNSHARE_TRUE = @HAVE_UNSHARE_TRUE@
+HAVE_VERSIONING_FALSE = @HAVE_VERSIONING_FALSE@
+HAVE_VERSIONING_TRUE = @HAVE_VERSIONING_TRUE@
+INSTALL_DATA = @INSTALL_DATA@
+INSTALL_PROGRAM = @INSTALL_PROGRAM@
+INSTALL_SCRIPT = @INSTALL_SCRIPT@
+INSTALL_STRIP_PROGRAM = @INSTALL_STRIP_PROGRAM@
+INTLLIBS = @INTLLIBS@
+INTL_MACOSX_LIBS = @INTL_MACOSX_LIBS@
+LDFLAGS = @LDFLAGS@
+LEX = @LEX@
+LEXLIB = @LEXLIB@
+LEX_OUTPUT_ROOT = @LEX_OUTPUT_ROOT@
+LIBAUDIT = @LIBAUDIT@
+LIBCRACK = @LIBCRACK@
+LIBCRYPT = @LIBCRYPT@
+LIBDB = @LIBDB@
+LIBDL = @LIBDL@
+LIBICONV = @LIBICONV@
+LIBINTL = @LIBINTL@
+LIBNSL = @LIBNSL@
+LIBOBJS = @LIBOBJS@
+LIBPRELUDE_CFLAGS = @LIBPRELUDE_CFLAGS@
+LIBPRELUDE_CONFIG = @LIBPRELUDE_CONFIG@
+LIBPRELUDE_CONFIG_PREFIX = @LIBPRELUDE_CONFIG_PREFIX@
+LIBPRELUDE_LDFLAGS = @LIBPRELUDE_LDFLAGS@
+LIBPRELUDE_LIBS = @LIBPRELUDE_LIBS@
+LIBPRELUDE_PREFIX = @LIBPRELUDE_PREFIX@
+LIBPRELUDE_PTHREAD_CFLAGS = @LIBPRELUDE_PTHREAD_CFLAGS@
+LIBS = @LIBS@
+LIBSELINUX = @LIBSELINUX@
+LIBTOOL = @LIBTOOL@
+LN_S = @LN_S@
+LTLIBICONV = @LTLIBICONV@
+LTLIBINTL = @LTLIBINTL@
+LTLIBOBJS = @LTLIBOBJS@
+MAKEINFO = @MAKEINFO@
+MSGFMT = @MSGFMT@
+MSGFMT_015 = @MSGFMT_015@
+MSGMERGE = @MSGMERGE@
+OBJEXT = @OBJEXT@
+PACKAGE = @PACKAGE@
+PACKAGE_BUGREPORT = @PACKAGE_BUGREPORT@
+PACKAGE_NAME = @PACKAGE_NAME@
+PACKAGE_STRING = @PACKAGE_STRING@
+PACKAGE_TARNAME = @PACKAGE_TARNAME@
+PACKAGE_VERSION = @PACKAGE_VERSION@
+PAM_READ_BOTH_CONFS = @PAM_READ_BOTH_CONFS@
+PATH_SEPARATOR = @PATH_SEPARATOR@
+PIE_CFLAGS = @PIE_CFLAGS@
+PIE_LDFLAGS = @PIE_LDFLAGS@
+POSUB = @POSUB@
+RANLIB = @RANLIB@
+SCONFIGDIR = @SCONFIGDIR@
+SECUREDIR = @SECUREDIR@
+SED = @SED@
+SET_MAKE = @SET_MAKE@
+SHELL = @SHELL@
+STATIC_MODULES_FALSE = @STATIC_MODULES_FALSE@
+STATIC_MODULES_TRUE = @STATIC_MODULES_TRUE@
+STRIP = @STRIP@
+USE_NLS = @USE_NLS@
+VERSION = @VERSION@
+WITH_DEBUG = @WITH_DEBUG@
+WITH_PAMLOCKING = @WITH_PAMLOCKING@
+XGETTEXT = @XGETTEXT@
+XGETTEXT_015 = @XGETTEXT_015@
+XMLCATALOG = @XMLCATALOG@
+XMLLINT = @XMLLINT@
+XML_CATALOG_FILE = @XML_CATALOG_FILE@
+XSLTPROC = @XSLTPROC@
+YACC = @YACC@
+ac_ct_AR = @ac_ct_AR@
+ac_ct_CC = @ac_ct_CC@
+ac_ct_CXX = @ac_ct_CXX@
+ac_ct_F77 = @ac_ct_F77@
+ac_ct_RANLIB = @ac_ct_RANLIB@
+ac_ct_STRIP = @ac_ct_STRIP@
+am__fastdepCC_FALSE = @am__fastdepCC_FALSE@
+am__fastdepCC_TRUE = @am__fastdepCC_TRUE@
+am__fastdepCXX_FALSE = @am__fastdepCXX_FALSE@
+am__fastdepCXX_TRUE = @am__fastdepCXX_TRUE@
+am__include = @am__include@
+am__leading_dot = @am__leading_dot@
+am__quote = @am__quote@
+am__tar = @am__tar@
+am__untar = @am__untar@
+bindir = @bindir@
+build = @build@
+build_alias = @build_alias@
+build_cpu = @build_cpu@
+build_os = @build_os@
+build_vendor = @build_vendor@
+datadir = @datadir@
+exec_prefix = @exec_prefix@
+host = @host@
+host_alias = @host_alias@
+host_cpu = @host_cpu@
+host_os = @host_os@
+host_vendor = @host_vendor@
+includedir = @includedir@
+infodir = @infodir@
+install_sh = @install_sh@
+libc_cv_fpie = @libc_cv_fpie@
+libdir = @libdir@
+libexecdir = @libexecdir@
+localedir = @localedir@
+localstatedir = @localstatedir@
+mandir = @mandir@
+mkdir_p = @mkdir_p@
+oldincludedir = @oldincludedir@
+pam_cv_ld_as_needed = @pam_cv_ld_as_needed@
+pam_xauth_path = @pam_xauth_path@
+prefix = @prefix@
+program_transform_name = @program_transform_name@
+sbindir = @sbindir@
+sharedstatedir = @sharedstatedir@
+sysconfdir = @sysconfdir@
+target_alias = @target_alias@
+CLEANFILES = *~
+EXTRA_DIST = README $(MANS) $(XMLS) tst-pam_mkpolydir
+man_MANS = pam_mkpolydir.8
+XMLS = README.xml pam_mkpolydir.8.xml
+TESTS = tst-pam_mkpolydir
+securelibdir = $(SECUREDIR)
+secureconfdir = $(SCONFIGDIR)
+AM_CFLAGS = -I$(top_srcdir)/libpam/include -I$(top_srcdir)/libpamc/include
+AM_LDFLAGS = -no-undefined -avoid-version -module \
+	-L$(top_builddir)/libpam -lpam -lselinux $(am__append_1)
+securelib_LTLIBRARIES = pam_mkpolydir.la
+pam_mkpolydir_la_SOURCES = pam_mkpolydir.c argv_parse.c argv_parse.h
+@ENABLE_REGENERATE_MAN_TRUE@noinst_DATA = README
+all: all-am
+
+.SUFFIXES:
+.SUFFIXES: .c .lo .o .obj
+$(srcdir)/Makefile.in:  $(srcdir)/Makefile.am  $(am__configure_deps)
+	@for dep in $?; do \
+	  case '$(am__configure_deps)' in \
+	    *$$dep*) \
+	      cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh \
+		&& exit 0; \
+	      exit 1;; \
+	  esac; \
+	done; \
+	echo ' cd $(top_srcdir) && $(AUTOMAKE) --gnu
modules/pam_mkpolydir/Makefile'; \
+	cd $(top_srcdir) && \
+	  $(AUTOMAKE) --gnu  modules/pam_mkpolydir/Makefile
+.PRECIOUS: Makefile
+Makefile: $(srcdir)/Makefile.in $(top_builddir)/config.status
+	@case '$?' in \
+	  *config.status*) \
+	    cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh;; \
+	  *) \
+	    echo ' cd $(top_builddir) && $(SHELL) ./config.status
$(subdir)/$@ $(am__depfiles_maybe)'; \
+	    cd $(top_builddir) && $(SHELL) ./config.status $(subdir)/$@
$(am__depfiles_maybe);; \
+	esac;
+
+$(top_builddir)/config.status: $(top_srcdir)/configure
$(CONFIG_STATUS_DEPENDENCIES)
+	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
+
+$(top_srcdir)/configure:  $(am__configure_deps)
+	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
+$(ACLOCAL_M4):  $(am__aclocal_m4_deps)
+	cd $(top_builddir) && $(MAKE) $(AM_MAKEFLAGS) am--refresh
+install-securelibLTLIBRARIES: $(securelib_LTLIBRARIES)
+	@$(NORMAL_INSTALL)
+	test -z "$(securelibdir)" || $(mkdir_p) "$(DESTDIR)$(securelibdir)"
+	@list='$(securelib_LTLIBRARIES)'; for p in $$list; do \
+	  if test -f $$p; then \
+	    f=$(am__strip_dir) \
+	    echo " $(LIBTOOL) --mode=install $(securelibLTLIBRARIES_INSTALL)
$(INSTALL_STRIP_FLAG) '$$p' '$(DESTDIR)$(securelibdir)/$$f'"; \
+	    $(LIBTOOL) --mode=install $(securelibLTLIBRARIES_INSTALL)
$(INSTALL_STRIP_FLAG) "$$p" "$(DESTDIR)$(securelibdir)/$$f"; \
+	  else :; fi; \
+	done
+
+uninstall-securelibLTLIBRARIES:
+	@$(NORMAL_UNINSTALL)
+	@set -x; list='$(securelib_LTLIBRARIES)'; for p in $$list; do \
+	  p=$(am__strip_dir) \
+	  echo " $(LIBTOOL) --mode=uninstall rm -f '$(DESTDIR)$(securelibdir)/$$p'"; \
+	  $(LIBTOOL) --mode=uninstall rm -f "$(DESTDIR)$(securelibdir)/$$p"; \
+	done
+
+clean-securelibLTLIBRARIES:
+	-test -z "$(securelib_LTLIBRARIES)" || rm -f $(securelib_LTLIBRARIES)
+	@list='$(securelib_LTLIBRARIES)'; for p in $$list; do \
+	  dir="`echo $$p | sed -e 's|/[^/]*$$||'`"; \
+	  test "$$dir" != "$$p" || dir=.; \
+	  echo "rm -f \"$${dir}/so_locations\""; \
+	  rm -f "$${dir}/so_locations"; \
+	done
+pam_mkpolydir.la: $(pam_mkpolydir_la_OBJECTS) $(pam_mkpolydir_la_DEPENDENCIES)
+	$(LINK) -rpath $(securelibdir) $(pam_mkpolydir_la_LDFLAGS)
$(pam_mkpolydir_la_OBJECTS) $(pam_mkpolydir_la_LIBADD) $(LIBS)
+
+mostlyclean-compile:
+	-rm -f *.$(OBJEXT)
+
+distclean-compile:
+	-rm -f *.tab.c
+
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/argv_parse.Plo@am__quote@
+@AMDEP_TRUE@@am__include@ @am__quote@./$(DEPDIR)/pam_mkpolydir.Plo@am__quote@
+
+.c.o:
+@am__fastdepCC_TRUE@	if $(COMPILE) -MT $@ -MD -MP -MF
"$(DEPDIR)/$*.Tpo" -c -o $@ $<; \
+@am__fastdepCC_TRUE@	then mv -f "$(DEPDIR)/$*.Tpo" "$(DEPDIR)/$*.Po";
else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=no
@AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE)
$(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(COMPILE) -c $<
+
+.c.obj:
+@am__fastdepCC_TRUE@	if $(COMPILE) -MT $@ -MD -MP -MF
"$(DEPDIR)/$*.Tpo" -c -o $@ `$(CYGPATH_W) '$<'`; \
+@am__fastdepCC_TRUE@	then mv -f "$(DEPDIR)/$*.Tpo" "$(DEPDIR)/$*.Po";
else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=no
@AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE)
$(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(COMPILE) -c `$(CYGPATH_W) '$<'`
+
+.c.lo:
+@am__fastdepCC_TRUE@	if $(LTCOMPILE) -MT $@ -MD -MP -MF
"$(DEPDIR)/$*.Tpo" -c -o $@ $<; \
+@am__fastdepCC_TRUE@	then mv -f "$(DEPDIR)/$*.Tpo"
"$(DEPDIR)/$*.Plo"; else rm -f "$(DEPDIR)/$*.Tpo"; exit 1; fi
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	source='$<' object='$@' libtool=yes
@AMDEPBACKSLASH@
+@AMDEP_TRUE@@am__fastdepCC_FALSE@	DEPDIR=$(DEPDIR) $(CCDEPMODE)
$(depcomp) @AMDEPBACKSLASH@
+@am__fastdepCC_FALSE@	$(LTCOMPILE) -c -o $@ $<
+
+mostlyclean-libtool:
+	-rm -f *.lo
+
+clean-libtool:
+	-rm -rf .libs _libs
+
+distclean-libtool:
+	-rm -f libtool
+uninstall-info-am:
+install-man8: $(man8_MANS) $(man_MANS)
+	@$(NORMAL_INSTALL)
+	test -z "$(man8dir)" || $(mkdir_p) "$(DESTDIR)$(man8dir)"
+	@list='$(man8_MANS) $(dist_man8_MANS) $(nodist_man8_MANS)'; \
+	l2='$(man_MANS) $(dist_man_MANS) $(nodist_man_MANS)'; \
+	for i in $$l2; do \
+	  case "$$i" in \
+	    *.8*) list="$$list $$i" ;; \
+	  esac; \
+	done; \
+	for i in $$list; do \
+	  if test -f $(srcdir)/$$i; then file=$(srcdir)/$$i; \
+	  else file=$$i; fi; \
+	  ext=`echo $$i | sed -e 's/^.*\\.//'`; \
+	  case "$$ext" in \
+	    8*) ;; \
+	    *) ext='8' ;; \
+	  esac; \
+	  inst=`echo $$i | sed -e 's/\\.[0-9a-z]*$$//'`; \
+	  inst=`echo $$inst | sed -e 's/^.*\///'`; \
+	  inst=`echo $$inst | sed '$(transform)'`.$$ext; \
+	  echo " $(INSTALL_DATA) '$$file' '$(DESTDIR)$(man8dir)/$$inst'"; \
+	  $(INSTALL_DATA) "$$file" "$(DESTDIR)$(man8dir)/$$inst"; \
+	done
+uninstall-man8:
+	@$(NORMAL_UNINSTALL)
+	@list='$(man8_MANS) $(dist_man8_MANS) $(nodist_man8_MANS)'; \
+	l2='$(man_MANS) $(dist_man_MANS) $(nodist_man_MANS)'; \
+	for i in $$l2; do \
+	  case "$$i" in \
+	    *.8*) list="$$list $$i" ;; \
+	  esac; \
+	done; \
+	for i in $$list; do \
+	  ext=`echo $$i | sed -e 's/^.*\\.//'`; \
+	  case "$$ext" in \
+	    8*) ;; \
+	    *) ext='8' ;; \
+	  esac; \
+	  inst=`echo $$i | sed -e 's/\\.[0-9a-z]*$$//'`; \
+	  inst=`echo $$inst | sed -e 's/^.*\///'`; \
+	  inst=`echo $$inst | sed '$(transform)'`.$$ext; \
+	  echo " rm -f '$(DESTDIR)$(man8dir)/$$inst'"; \
+	  rm -f "$(DESTDIR)$(man8dir)/$$inst"; \
+	done
+
+ID: $(HEADERS) $(SOURCES) $(LISP) $(TAGS_FILES)
+	list='$(SOURCES) $(HEADERS) $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '    { files[$$0] = 1; } \
+	       END { for (i in files) print i; }'`; \
+	mkid -fID $$unique
+tags: TAGS
+
+TAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
+		$(TAGS_FILES) $(LISP)
+	tags=; \
+	here=`pwd`; \
+	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '    { files[$$0] = 1; } \
+	       END { for (i in files) print i; }'`; \
+	if test -z "$(ETAGS_ARGS)$$tags$$unique"; then :; else \
+	  test -n "$$unique" || unique=$$empty_fix; \
+	  $(ETAGS) $(ETAGSFLAGS) $(AM_ETAGSFLAGS) $(ETAGS_ARGS) \
+	    $$tags $$unique; \
+	fi
+ctags: CTAGS
+CTAGS:  $(HEADERS) $(SOURCES)  $(TAGS_DEPENDENCIES) \
+		$(TAGS_FILES) $(LISP)
+	tags=; \
+	here=`pwd`; \
+	list='$(SOURCES) $(HEADERS)  $(LISP) $(TAGS_FILES)'; \
+	unique=`for i in $$list; do \
+	    if test -f "$$i"; then echo $$i; else echo $(srcdir)/$$i; fi; \
+	  done | \
+	  $(AWK) '    { files[$$0] = 1; } \
+	       END { for (i in files) print i; }'`; \
+	test -z "$(CTAGS_ARGS)$$tags$$unique" \
+	  || $(CTAGS) $(CTAGSFLAGS) $(AM_CTAGSFLAGS) $(CTAGS_ARGS) \
+	     $$tags $$unique
+
+GTAGS:
+	here=`$(am__cd) $(top_builddir) && pwd` \
+	  && cd $(top_srcdir) \
+	  && gtags -i $(GTAGS_ARGS) $$here
+
+distclean-tags:
+	-rm -f TAGS ID GTAGS GRTAGS GSYMS GPATH tags
+
+check-TESTS: $(TESTS)
+	@failed=0; all=0; xfail=0; xpass=0; skip=0; \
+	srcdir=$(srcdir); export srcdir; \
+	list='$(TESTS)'; \
+	if test -n "$$list"; then \
+	  for tst in $$list; do \
+	    if test -f ./$$tst; then dir=./; \
+	    elif test -f $$tst; then dir=; \
+	    else dir="$(srcdir)/"; fi; \
+	    if $(TESTS_ENVIRONMENT) $${dir}$$tst; then \
+	      all=`expr $$all + 1`; \
+	      case " $(XFAIL_TESTS) " in \
+	      *" $$tst "*) \
+		xpass=`expr $$xpass + 1`; \
+		failed=`expr $$failed + 1`; \
+		echo "XPASS: $$tst"; \
+	      ;; \
+	      *) \
+		echo "PASS: $$tst"; \
+	      ;; \
+	      esac; \
+	    elif test $$? -ne 77; then \
+	      all=`expr $$all + 1`; \
+	      case " $(XFAIL_TESTS) " in \
+	      *" $$tst "*) \
+		xfail=`expr $$xfail + 1`; \
+		echo "XFAIL: $$tst"; \
+	      ;; \
+	      *) \
+		failed=`expr $$failed + 1`; \
+		echo "FAIL: $$tst"; \
+	      ;; \
+	      esac; \
+	    else \
+	      skip=`expr $$skip + 1`; \
+	      echo "SKIP: $$tst"; \
+	    fi; \
+	  done; \
+	  if test "$$failed" -eq 0; then \
+	    if test "$$xfail" -eq 0; then \
+	      banner="All $$all tests passed"; \
+	    else \
+	      banner="All $$all tests behaved as expected ($$xfail expected
failures)"; \
+	    fi; \
+	  else \
+	    if test "$$xpass" -eq 0; then \
+	      banner="$$failed of $$all tests failed"; \
+	    else \
+	      banner="$$failed of $$all tests did not behave as expected
($$xpass unexpected passes)"; \
+	    fi; \
+	  fi; \
+	  dashes="$$banner"; \
+	  skipped=""; \
+	  if test "$$skip" -ne 0; then \
+	    skipped="($$skip tests were not run)"; \
+	    test `echo "$$skipped" | wc -c` -le `echo "$$banner" | wc -c` || \
+	      dashes="$$skipped"; \
+	  fi; \
+	  report=""; \
+	  if test "$$failed" -ne 0 && test -n "$(PACKAGE_BUGREPORT)"; then \
+	    report="Please report to $(PACKAGE_BUGREPORT)"; \
+	    test `echo "$$report" | wc -c` -le `echo "$$banner" | wc -c` || \
+	      dashes="$$report"; \
+	  fi; \
+	  dashes=`echo "$$dashes" | sed s/./=/g`; \
+	  echo "$$dashes"; \
+	  echo "$$banner"; \
+	  test -z "$$skipped" || echo "$$skipped"; \
+	  test -z "$$report" || echo "$$report"; \
+	  echo "$$dashes"; \
+	  test "$$failed" -eq 0; \
+	else :; fi
+
+distdir: $(DISTFILES)
+	@srcdirstrip=`echo "$(srcdir)" | sed 's|.|.|g'`; \
+	topsrcdirstrip=`echo "$(top_srcdir)" | sed 's|.|.|g'`; \
+	list='$(DISTFILES)'; for file in $$list; do \
+	  case $$file in \
+	    $(srcdir)/*) file=`echo "$$file" | sed "s|^$$srcdirstrip/||"`;; \
+	    $(top_srcdir)/*) file=`echo "$$file" | sed
"s|^$$topsrcdirstrip/|$(top_builddir)/|"`;; \
+	  esac; \
+	  if test -f $$file || test -d $$file; then d=.; else d=$(srcdir); fi; \
+	  dir=`echo "$$file" | sed -e 's,/[^/]*$$,,'`; \
+	  if test "$$dir" != "$$file" && test "$$dir" != "."; then \
+	    dir="/$$dir"; \
+	    $(mkdir_p) "$(distdir)$$dir"; \
+	  else \
+	    dir=''; \
+	  fi; \
+	  if test -d $$d/$$file; then \
+	    if test -d $(srcdir)/$$file && test $$d != $(srcdir); then \
+	      cp -pR $(srcdir)/$$file $(distdir)$$dir || exit 1; \
+	    fi; \
+	    cp -pR $$d/$$file $(distdir)$$dir || exit 1; \
+	  else \
+	    test -f $(distdir)/$$file \
+	    || cp -p $$d/$$file $(distdir)/$$file \
+	    || exit 1; \
+	  fi; \
+	done
+check-am: all-am
+	$(MAKE) $(AM_MAKEFLAGS) check-TESTS
+check: check-am
+all-am: Makefile $(LTLIBRARIES) $(MANS) $(DATA)
+installdirs:
+	for dir in "$(DESTDIR)$(securelibdir)" "$(DESTDIR)$(man8dir)"; do \
+	  test -z "$$dir" || $(mkdir_p) "$$dir"; \
+	done
+install: install-am
+install-exec: install-exec-am
+install-data: install-data-am
+uninstall: uninstall-am
+
+install-am: all-am
+	@$(MAKE) $(AM_MAKEFLAGS) install-exec-am install-data-am
+
+installcheck: installcheck-am
+install-strip:
+	$(MAKE) $(AM_MAKEFLAGS) INSTALL_PROGRAM="$(INSTALL_STRIP_PROGRAM)" \
+	  install_sh_PROGRAM="$(INSTALL_STRIP_PROGRAM)" INSTALL_STRIP_FLAG=-s \
+	  `test -z '$(STRIP)' || \
+	    echo "INSTALL_PROGRAM_ENV=STRIPPROG='$(STRIP)'"` install
+mostlyclean-generic:
+
+clean-generic:
+	-test -z "$(CLEANFILES)" || rm -f $(CLEANFILES)
+
+distclean-generic:
+	-test -z "$(CONFIG_CLEAN_FILES)" || rm -f $(CONFIG_CLEAN_FILES)
+
+maintainer-clean-generic:
+	@echo "This command is intended for maintainers to use"
+	@echo "it deletes files that may require special tools to rebuild."
+clean: clean-am
+
+clean-am: clean-generic clean-libtool clean-securelibLTLIBRARIES \
+	mostlyclean-am
+
+distclean: distclean-am
+	-rm -rf ./$(DEPDIR)
+	-rm -f Makefile
+distclean-am: clean-am distclean-compile distclean-generic \
+	distclean-libtool distclean-tags
+
+dvi: dvi-am
+
+dvi-am:
+
+html: html-am
+
+info: info-am
+
+info-am:
+
+install-data-am: install-man install-securelibLTLIBRARIES
+
+install-exec-am:
+
+install-info: install-info-am
+
+install-man: install-man8
+
+installcheck-am:
+
+maintainer-clean: maintainer-clean-am
+	-rm -rf ./$(DEPDIR)
+	-rm -f Makefile
+maintainer-clean-am: distclean-am maintainer-clean-generic
+
+mostlyclean: mostlyclean-am
+
+mostlyclean-am: mostlyclean-compile mostlyclean-generic \
+	mostlyclean-libtool
+
+pdf: pdf-am
+
+pdf-am:
+
+ps: ps-am
+
+ps-am:
+
+uninstall-am: uninstall-info-am uninstall-man \
+	uninstall-securelibLTLIBRARIES
+
+uninstall-man: uninstall-man8
+
+.PHONY: CTAGS GTAGS all all-am check check-TESTS check-am clean \
+	clean-generic clean-libtool clean-securelibLTLIBRARIES ctags \
+	distclean distclean-compile distclean-generic \
+	distclean-libtool distclean-tags distdir dvi dvi-am html \
+	html-am info info-am install install-am install-data \
+	install-data-am install-exec install-exec-am install-info \
+	install-info-am install-man install-man8 \
+	install-securelibLTLIBRARIES install-strip installcheck \
+	installcheck-am installdirs maintainer-clean \
+	maintainer-clean-generic mostlyclean mostlyclean-compile \
+	mostlyclean-generic mostlyclean-libtool pdf pdf-am ps ps-am \
+	tags uninstall uninstall-am uninstall-info-am uninstall-man \
+	uninstall-man8 uninstall-securelibLTLIBRARIES
+
+@ENABLE_REGENERATE_MAN_TRUE@README: pam_mkpolydir.8.xml
+@ENABLE_REGENERATE_MAN_TRUE@-include $(top_srcdir)/Make.xml.rules
+# Tell versions [3.59,3.63) of GNU make to not export all variables.
+# Otherwise a system limit (for SysV at least) may be exceeded.
+.NOEXPORT:
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/pam_mkpolydir.8
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/pam_mkpolydir.8
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/pam_mkpolydir.8	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/pam_mkpolydir.8	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,91 @@
+.\"     Title: pam_mkpolydir
+.\"    Author:
+.\" Generator: DocBook XSL Stylesheets v1.70.1 <http://docbook.sf.net/>
+.\"      Date: 06/02/2006
+.\"    Manual: Linux\-PAM Manual
+.\"    Source: Linux\-PAM Manual
+.\"
+.TH "PAM_MKPOLYDIR" "8" "06/02/2006" "Linux\-PAM Manual" "Linux\-PAM Manual"
+.\" disable hyphenation
+.nh
+.\" disable justification (adjust text to left margin only)
+.ad l
+.SH "NAME"
+pam_mkpolydir \- PAM module to create users poly directory
+.SH "SYNOPSIS"
+.HP 17
+\fBpam_mkpolydir.so\fR [silent] [debug]
+.SH "DESCRIPTION"
+.PP
+The pam_mkpolydir PAM module will create a users polyinstantiated
directories if they does not exist when the session begins. This
allows users to be present in central database (such as NIS, kerberos
or LDAP) without using a distributed file system or pre\-creating a
large number of directories. The skeleton directory (usually
+\fI/etc/skel/\fR) is used to copy default files and also set's a
umask for the creation.
+.PP
+The new users home directory will not be removed after logout of the user.
+.SH "OPTIONS"
+.TP 3n
+\fBsilent\fR
+Don't print informative messages.
+.TP 3n
+\fBumask=\fR\fB\fImask\fR\fR
+The user file\-creation mask is set to
+\fImask\fR. The default value of mask is 0022.
+.TP 3n
+\fBskel=\fR\fB\fI/path/to/skel/directory\fR\fR
+Indicate an alternative
+\fIskel\fR
+directory to override the default
+\fI/etc/skel\fR.
+.SH "MODULE SERVICES PROVIDED"
+.PP
+Only the
+\fBsession\fR
+service is supported.
+.SH "RETURN VALUES"
+.TP 3n
+PAM_BUF_ERR
+Memory buffer error.
+.TP 3n
+PAM_CRED_INSUFFICIENT
+Insufficient credentials to access authentication data.
+.TP 3n
+PAM_PERM_DENIED
+Not enough permissions to create the new directory or read the skel directory.
+.TP 3n
+PAM_USER_UNKNOWN
+User not known to the underlying authentication module.
+.TP 3n
+PAM_SUCCESS
+Environment variables were set.
+.SH "FILES"
+.TP 3n
+\fI/etc/skel\fR
+Default skel directory
+.SH "EXAMPLES"
+.PP
+A sample /etc/pam.d/login file:
+.sp
+.RS 3n
+.nf
+  auth       requisite   pam_securetty.so
+  auth       sufficient  pam_ldap.so
+  auth       required    pam_unix.so
+  auth       required    pam_nologin.so
+  account    sufficient  pam_ldap.so
+  account    required    pam_unix.so
+  password   required    pam_unix.so
+  session    required    pam_mkpolydir.so
+  session    required    pam_unix.so
+  session    optional    pam_lastlog.so
+  session    optional    pam_mail.so standard
+
+.fi
+.RE
+.sp
+.SH "SEE ALSO"
+.PP
+
+\fBpam.d\fR(8),
+\fBpam\fR(8).
+.SH "AUTHOR"
+.PP
+pam_mkpolydir was written by Ted X Toth <txtoth@gmail.com>.
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/pam_mkpolydir.8.xml
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/pam_mkpolydir.8.xml
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/pam_mkpolydir.8.xml	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/pam_mkpolydir.8.xml	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,161 @@
+<?xml version="1.0" encoding="ISO-8859-1"?>
+<!DOCTYPE refentry PUBLIC "-//OASIS//DTD DocBook XML V4.1.2//EN"
+                   "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd">
+
+<refentry id='pam_mkpolydir'>
+
+  <refmeta>
+    <refentrytitle>pam_mkpolydir</refentrytitle>
+    <manvolnum>8</manvolnum>
+    <refmiscinfo class='setdesc'>Linux-PAM Manual</refmiscinfo>
+  </refmeta>
+
+  <refnamediv id='pam_mkpolydir-name'>
+    <refname>pam_mkpolydir</refname>
+    <refpurpose>
+      PAM module to create users polyinstantiated directories
+    </refpurpose>
+  </refnamediv>
+
+<!-- body begins here -->
+
+  <refsynopsisdiv>
+    <cmdsynopsis id="pam_mkpolydir-cmdsynopsis">
+      <command>pam_mkpolydir.so</command>
+      <arg choice="opt">
+        silent
+      </arg>
+      <arg choice="opt">
+        debug
+      </arg>
+    </cmdsynopsis>
+  </refsynopsisdiv>
+
+
+  <refsect1 id="pam_mkpolydir-description">
+    <title>DESCRIPTION</title>
+    <para>
+      The pam_mkpolydir PAM module will create a users
polyinstantiated directories
+      if they does not exist when the session begins. This allows users
+      to be present in central database (such as NIS, kerberos or LDAP)
+      without using a distributed file system or pre-creating a large
+      number of directories.
+    </para>
+    <para>
+      The new users polyinstantiated directories will not be removed
after logout
+      of the user.
+    </para>
+  </refsect1>
+
+  <refsect1 id="pam_mkpolydir-options">
+    <title>OPTIONS</title>
+    <variablelist>
+
+      <varlistentry>
+        <term>
+          <option>silent</option>
+        </term>
+        <listitem>
+          <para>
+            Don't print informative messages.
+          </para>
+        </listitem>
+      </varlistentry>
+
+    </variablelist>
+  </refsect1>
+
+  <refsect1 id="pam_mkpolydir-services">
+    <title>MODULE SERVICES PROVIDED</title>
+    <para>
+      Only the <option>session</option> service is supported.
+    </para>
+  </refsect1>
+
+  <refsect1 id="pam_mkpolydir-return_values">
+    <title>RETURN VALUES</title>
+    <variablelist>
+      <varlistentry>
+        <term>PAM_BUF_ERR</term>
+        <listitem>
+           <para>
+             Memory buffer error.
+          </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>PAM_CRED_INSUFFICIENT</term>
+        <listitem>
+           <para>
+             Insufficient credentials to access authentication data.
+          </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>PAM_PERM_DENIED</term>
+        <listitem>
+           <para>
+             Not enough permissions to create the new directory
+             or read the skel directory.
+          </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>PAM_USER_UNKNOWN</term>
+        <listitem>
+           <para>
+             User not known to the underlying authentication module.
+          </para>
+        </listitem>
+      </varlistentry>
+      <varlistentry>
+        <term>PAM_SUCCESS</term>
+        <listitem>
+           <para>
+             Environment variables were set.
+          </para>
+        </listitem>
+      </varlistentry>
+    </variablelist>
+  </refsect1>
+
+  <refsect1 id='pam_mkpolydir-examples'>
+    <title>EXAMPLES</title>
+    <para>
+      A sample /etc/pam.d/login file:
+      <programlisting>
+  auth       requisite   pam_securetty.so
+  auth       sufficient  pam_ldap.so
+  auth       required    pam_unix.so
+  auth       required    pam_nologin.so
+  account    sufficient  pam_ldap.so
+  account    required    pam_unix.so
+  password   required    pam_unix.so
+  session    required    pam_mkpolydir.so
+  session    required    pam_unix.so
+  session    optional    pam_lastlog.so
+  session    optional    pam_mail.so standard
+      </programlisting>
+    </para>
+  </refsect1>
+
+
+  <refsect1 id="pam_mkpolydir-see_also">
+    <title>SEE ALSO</title>
+    <para>
+      <citerefentry>
+        <refentrytitle>pam.d</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>,
+      <citerefentry>
+        <refentrytitle>pam</refentrytitle><manvolnum>8</manvolnum>
+      </citerefentry>.
+    </para>
+  </refsect1>
+
+  <refsect1 id="pam_mkpolydir-author">
+    <title>AUTHOR</title>
+    <para>
+      pam_mkpolydir was adapted from pam_mkhomedir wriiten by Jason
Gunthorpe &lt;jgg@debian.org&gt; by Ted X Toth
&lt;txtoth@gmail.com&gt;.
+    </para>
+  </refsect1>
+</refentry>
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/pam_mkpolydir.c	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/pam_mkpolydir.c	2007-11-14
15:58:15.000000000 -0600
@@ -0,0 +1,896 @@
+/* PAM Make Poly Dir module
+
+   This module will create a users polyinstantiated directories if they does
+   not exist when the session begins. This allows users to be present in
+   central database (such as nis, kerb or ldap) without using a distributed
+   file system or pre-creating a large number of directories.
+
+   Here is a sample /etc/pam.d/login file for Debian GNU/Linux
+   2.1:
+
+   auth       requisite  pam_securetty.so
+   auth       sufficient pam_ldap.so
+   auth       required   pam_unix.so
+   auth       optional   pam_group.so
+   auth       optional   pam_mail.so
+   account    requisite  pam_time.so
+   account    sufficient pam_ldap.so
+   account    required   pam_unix.so
+   session    required   pam_mkhomedir.so skel=/etc/skel/ umask=0022
+   session    required   pam_mkpolydir.so
+   session    required   pam_unix.so
+   session    optional   pam_lastlog.so
+   password   required   pam_unix.so
+
+   Released under the GNU LGPL version 2 or later
+   Written by Ted X Toth <txtoth@gmail.com>
+   Structure taken from pam_mkhomedir by Jason Gunthorpe
<jgg@debian.org> Feb 1999
+*/
+
+#include "config.h"
+
+#include <stdarg.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <pwd.h>
+#include <grp.h>
+#include <errno.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <dirent.h>
+#include <syslog.h>
+#include <ctype.h>
+#include "argv_parse.h"
+#include <stdio_ext.h>
+#include <limits.h>
+
+#include <selinux/selinux.h>
+#include <selinux/av_permissions.h>
+/*
+ * here, we make a definition for the externally accessible function
+ * in this file (this definition is required for static a module
+ * but strongly encouraged generally) it is used to instruct the
+ * modules include file to define the function prototypes.
+ */
+
+#define PAM_SM_SESSION
+
+#include <security/pam_modules.h>
+#include <security/_pam_macros.h>
+#include <security/pam_modutil.h>
+#include <security/pam_ext.h>
+
+
+/* argument parsing */
+#define MKPOLYDIR_DEBUG      020	/* keep quiet about things */
+#define MKPOLYDIR_QUIET      040	/* keep quiet about things */
+#define PAMNS_NO_PAM_USER 1
+#define PAMNS_UNKNOWN_USER 2
+#define PAMNS_PARSE_CONFIG_ERROR 3
+#define PAM_NAMESPACE_CONFIG "/etc/security/namespace.conf"
+
+static unsigned int module_umask = 0022;
+static int ctrl = 0;
+
+struct polydir_s {
+        char dir[PATH_MAX];    	       	/* directory to polyinstantiate */
+        char instance_dir[PATH_MAX];	/* prefix for instance dir path name */
+        unsigned int num_uids;		/* number of override uids */
+        uid_t *uid;				/* list of override uids */
+        uid_t pw_uid;
+        gid_t gr_gid;
+        mode_t mode;
+        int exclusive;			/* polyinstatiate exclusively for override uids */
+        struct polydir_s *next;		/* pointer to the next polydir entry */
+};
+
+struct instance_data {
+        pam_handle_t *pamh;		/* The pam handle for this instance */
+        struct polydir_s *polydirs_ptr; /* The linked list pointer */
+        const char *user;		/* User name */
+        uid_t uid;			/* The uid of the user */
+        unsigned long flags;		/* Flags for debug, selinux etc */
+};
+
+/*
+ * Copies the contents of ent into pent
+ */
+static int copy_ent(const struct polydir_s *ent, struct polydir_s *pent)
+{
+	strcpy(pent->dir, ent->dir);
+	strcpy(pent->instance_dir, ent->instance_dir);
+	pent->num_uids = ent->num_uids;
+	pent->exclusive = ent->exclusive;
+	if (ent->num_uids) {
+		pent->uid = malloc(ent->num_uids * sizeof(uid_t));
+		if (!(pent->uid)) {
+			return -1;
+		}
+                memcpy(pent->uid, ent->uid, ent->num_uids * sizeof(uid_t));
+	} else
+		pent->uid = NULL;
+        pent->pw_uid = ent->pw_uid;
+        pent->gr_gid = ent->gr_gid;
+        pent->mode = ent->mode;
+	return 0;
+}
+
+/*
+ * Adds an entry for a polyinstantiated directory to the linked list of
+ * polyinstantiated directories. It is called from process_line() while
+ * parsing the namespace configuration file.
+ */
+static int add_polydir_entry(struct instance_data *idata,
+                             const struct polydir_s *ent)
+{
+        struct polydir_s *pent;
+        int rc = 0;
+
+        /*
+         * Allocate an entry to hold information about a directory to
+         * polyinstantiate, populate it with information from 2nd argument
+         * and add the entry to the linked list of polyinstantiated
+         * directories.
+         */
+        pent = malloc(sizeof(struct polydir_s));
+	if (!pent) {
+                pam_syslog(idata->pamh, LOG_ERR, "out of memory");
+		return -1;
+	}
+        /* Make copy */
+	rc = copy_ent(ent, pent);
+	if(rc < 0) {
+                pam_syslog(idata->pamh, LOG_ERR, "out of memory");
+		goto out_clean;
+        }
+
+        /* Now attach to linked list */
+        pent->next = NULL;
+        if (idata->polydirs_ptr == NULL)
+                idata->polydirs_ptr = pent;
+        else {
+                struct polydir_s *tail;
+
+                tail = idata->polydirs_ptr;
+                while (tail->next)
+                        tail = tail->next;
+                tail->next = pent;
+        }
+        return 0;
+out_clean:
+	free(pent);
+	return rc;
+}
+
+
+/*
+ * Deletes all the entries in the linked list.
+ */
+static void del_polydir_list(struct polydir_s *polydirs_ptr)
+{
+        struct polydir_s *dptr = polydirs_ptr;
+
+	while (dptr) {
+        	struct polydir_s *tptr = dptr;
+		dptr = dptr->next;
+            	free(tptr->uid);
+		free(tptr);
+	}
+}
+
+
+/*
+ * This funtion returns true if a given uid is present in the polyinstantiated
+ * directory's list of override uids. If the uid is one of the override
+ * uids for the polyinstantiated directory, polyinstantiation is not
+ * performed for that user for that directory.
+ * If exclusive is set the returned values are opposite.
+ */
+static int ns_override(struct polydir_s *polyptr, struct instance_data *idata,
+                       uid_t uid)
+{
+        unsigned int i;
+
+        for (i = 0; i < polyptr->num_uids; i++)
+                if (uid == polyptr->uid[i]) {
+                        if (idata->flags & MKPOLYDIR_DEBUG) {
+                                pam_syslog(idata->pamh, LOG_DEBUG,
+                                           "ns override in dir %s for uid %d",
+                                           polyptr->dir, uid);
+                        }
+                        return !polyptr->exclusive;
+                }
+
+        return polyptr->exclusive;
+}
+
+static int can_create_dir(const char *dir,
+                          struct instance_data *idata) {
+        int retval;
+        security_context_t scon = NULL;
+        security_context_t dircon = NULL;
+
+        retval = matchpathcon(dir, (mode_t)0, &dircon);
+        if (retval < 0 || dircon == NULL) {
+                matchpathcon_fini();
+                pam_syslog(idata->pamh, LOG_WARNING,
+                           "Unable to get default context for
directory %s, check your policy: %m.", dir);
+                return 0;
+        }
+        matchpathcon_fini();
+
+        retval = getcon(&scon);
+        if (retval < 0 || scon == NULL) {
+                freecon(dircon);
+                pam_syslog(idata->pamh, LOG_ERR,
+                           "Error getting context, %m");
+                return 0;
+        }
+        /*
+         * If you aren't going to be able to create the directory
+         * there isn't any point in putting the directory in the
+         * list of directories.
+         */
+        struct av_decision avd;
+        unsigned int bit = DIR__CREATE;
+        retval = security_compute_av(scon, dircon,
+                                     string_to_security_class("dir"),
bit, &avd);
+        if (retval || (!(bit & avd.allowed))) {
+                if (security_getenforce()) {
+                        freecon(scon);
+                        freecon(dircon);
+                        pam_syslog(idata->pamh, LOG_WARNING,
+                                   "Creation of %s denied by policy.", dir);
+                        return 0;
+                }
+                else {
+                        pam_syslog(idata->pamh, LOG_WARNING,
+                                   "Creation of %s will fail in
enforcing mode.", dir);
+                }
+        }
+        freecon(scon);
+        freecon(dircon);
+        return 1;
+}
+
+/*
+ * Called from parse_config_file, this function processes a single line
+ * of the namespace configuration file. It skips over comments and incomplete
+ * or malformed lines. It processes a valid line with information on
+ * polyinstantiating a directory by populating appropriate fields of a
+ * polyinstatiated directory structure and then calling add_polydir_entry to
+ * add that entry to the linked list of polyinstantiated directories.
+ */
+static int process_line(char *line, const char *home,
+			struct instance_data *idata)
+{
+        const char *dir, *instance_dir;
+        const char *uids;
+        const char *mode, *user, *group;
+        char *tptr;
+        struct polydir_s poly;
+        int retval = 0;
+        int num_config_options = 0;
+        char **config_options = NULL;
+        struct stat statbuf;
+        uid_t *uidptr;
+        char *saveptr, *token;
+        char *ustr, *sstr;
+        int count;
+
+        poly.uid = NULL;
+        poly.num_uids = 0;
+        poly.exclusive = 0;
+
+        /*
+         * skip the leading white space
+         */
+        while (*line && isspace(*line))
+                line++;
+
+        /*
+         * Rip off the comments
+         */
+        tptr = strchr(line, '#');
+        if (tptr)
+                *tptr = '\0';
+
+        /*
+         * Rip off the newline char
+         */
+        tptr = strchr(line, '\n');
+        if (tptr)
+                *tptr = '\0';
+
+        /*
+         * Anything left ?
+         */
+        if (line[0] == 0)
+                return 0;
+
+        /*
+         * Initialize and scan the five strings from the line from the
+         * namespace configuration file.
+         */
+        retval = argv_parse(line, &num_config_options, &config_options);
+        if (retval != 0) {
+                pam_syslog(idata->pamh, LOG_NOTICE, "Error parsing
configuration line");
+                goto skipping;
+        }
+
+
+        dir = config_options[0];
+        if (num_config_options < 1 || dir == NULL) {
+                pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line
missing polydir");
+                goto skipping;
+        }
+
+        instance_dir = config_options[1];
+        if (num_config_options < 2 || instance_dir == NULL) {
+                pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line
missing instance_dir");
+                goto skipping;
+        }
+
+        /*
+         * Use 'none' to indicate no
+         * override users for polyinstantiation of that directory. If
+         * any of the other fields are blank, the line is incomplete so
+         * skip it.
+         */
+        uids = config_options[3];
+
+        /*
+         * If the line in namespace.conf for a directory to polyinstantiate
+         * contains a list of override users (users for whom polyinstantiation
+         * is not performed), read the user ids, convert names into uids, and
+         * add to polyinstantiated directory structure.
+         */
+        if (num_config_options >= 4 && uids) {
+                if (strcmp(uids, "none") != 0) {
+
+                        sstr = uids;
+                        if (*uids == '~') {
+                                poly.exclusive = 1;
+                                uids++;
+                        }
+
+                        for (count = 0, ustr = uids; ; count++, ustr = NULL) {
+                                token = strtok_r(ustr, ",", &saveptr);
+                                if (token == NULL)
+                                        break;
+                        }
+
+                        if (count == 0) {
+                                pam_syslog(idata->pamh, LOG_NOTICE,
"Invalid override list %s", sstr);
+                                goto skipping;
+                        }
+
+                        poly.num_uids = count;
+                        poly.uid = malloc(count * sizeof(uid_t));
+                        if (poly.uid == NULL) {
+                                pam_syslog(idata->pamh, LOG_NOTICE,
"out of memory");
+                                goto skipping;
+                        }
+                        uidptr = poly.uid;
+
+                        for (ustr = uids; ;ustr = NULL) {
+                                struct passwd *pwd;
+                                token = strtok_r(ustr, ",", &saveptr);
+                                if (token == NULL)
+                                        break;
+
+                                pwd = getpwnam(token);
+                                if (pwd == NULL) {
+                                        pam_syslog(idata->pamh,
LOG_ERR, "Unknown user %s in configuration", token);
+                                        poly.num_uids--;	
+                                } else {
+                                        if (pwd->pw_uid == idata->uid) {
+                                                /*
+                                                 * Why put it in the
list if this
+                                                 * user doesn't polyinstiate it
+                                                 */
+                                                free(poly.uid);
+                                                goto out;
+                                        }
+                                        *uidptr = pwd->pw_uid;
+                                        uidptr++;
+                                }
+                        }
+                }
+        } else {
+                pam_syslog(idata->pamh, LOG_NOTICE, "Invalid line
missing override list or 'none'");
+                goto skipping;
+
+        }
+
+        poly.pw_uid = (uid_t)ULONG_MAX;
+        poly.gr_gid = (gid_t)ULONG_MAX;
+        poly.mode = (mode_t)ULONG_MAX;
+        if (num_config_options > 5) {
+                if (num_config_options < 8) {
+                        pam_syslog(idata->pamh, LOG_NOTICE, "Invalid
line too few options");
+                        goto skipping;
+                }
+                user = config_options[5];
+                if (strcmp(user, "-1") != 0) {
+                        struct passwd *pw = getpwnam(user);
+                        poly.pw_uid = pw->pw_uid;
+                }
+
+                group = config_options[6];
+                if (strcmp(group, "-1") != 0) {
+                        struct group *gr = getgrnam(group);
+                        poly.gr_gid = gr->gr_gid;
+                }
+
+                mode = config_options[7];
+                if (strcmp(mode, "-1") != 0) {
+                        sscanf(mode, "%o", &poly.mode);
+                }
+
+                if (idata->flags & MKPOLYDIR_DEBUG)
+                        pam_syslog(idata->pamh, LOG_DEBUG,
+                                   "Use uid %d gid %d mode %o when
creating %s",
+                                   poly.pw_uid, poly.gr_gid, poly.mode, dir);
+
+        }
+        /*
+         * If the directory being polyinstantiated is the home directory
+         * of the user who is establishing a session, we have to swap
+         * the "$HOME" string with the user's home directory that is
+         * passed in as an argument.
+         */
+        if (strncmp(dir, "$HOME", 5) == 0) {
+                char *expanded = alloca(strlen(home) + strlen(dir) - 5 + 1);
+                sprintf(expanded, "%s%s", home, dir + 5);
+                dir = expanded;
+        }
+        /*
+         * Expand $HOME and $USER in instance dir prefix
+         */
+        if ((tptr = strstr(instance_dir, "$USER")) != 0) {
+                char *expanded = alloca(strlen(idata->user) +
strlen(instance_dir)-5+1);
+                *tptr = 0;
+                sprintf(expanded, "%s%s%s", instance_dir, idata->user, tptr+5);
+                instance_dir = expanded;
+        }
+        if ((tptr = strstr(instance_dir, "$HOME")) != 0) {
+                char *expanded = alloca(strlen(home)+strlen(instance_dir)-5+1);
+                *tptr = 0;
+                sprintf(expanded, "%s%s%s", instance_dir, home, tptr+5);
+                instance_dir = expanded;
+        }
+
+        /*
+         * Ensure that all pathnames are absolute path names.
+         */
+        if ((dir[0] != '/') || (instance_dir[0] != '/')) {
+                pam_syslog(idata->pamh, LOG_NOTICE,"Pathnames must
start with '/'");
+                pam_syslog(idata->pamh, LOG_NOTICE,"Pathnames '%s'
'%s'", dir, instance_dir);
+                goto skipping;
+        }
+        if (strstr(dir, "..") || strstr(instance_dir, "..")) {
+                pam_syslog(idata->pamh, LOG_NOTICE,"Pathnames must
not contain '..'");
+                goto skipping;
+        }
+
+        /*
+         * Make sure these directories exist otherwise there is no point
+         * in continuing.
+         */
+        if (stat(dir, &statbuf) < 0) {
+                if (!can_create_dir(dir, idata)) {
+                        pam_syslog(idata->pamh, LOG_WARNING, "By
policy process cannot create %s, %m.", dir);
+                        free(poly.uid);
+                        retval = PAM_SUCCESS;
+                        goto out;
+                }
+        }
+        if (stat(instance_dir, &statbuf) < 0) {
+                if (!can_create_dir(instance_dir, idata)) {
+                        pam_syslog(idata->pamh, LOG_WARNING, "By
policy process cannot create %s, %m.", instance_dir);
+                        free(poly.uid);
+                        retval = PAM_SUCCESS;
+                        goto out;
+                }
+        }
+
+        /*
+         * Populate polyinstantiated directory structure with appropriate
+         * pathnames with which to polyinstantiate.
+         */
+        if (strlen(dir) >= sizeof(poly.dir)
+            || strlen(instance_dir) >= sizeof(poly.instance_dir)) {
+                pam_syslog(idata->pamh, LOG_NOTICE, "Pathnames too long");
+        }
+        strcpy(poly.dir, dir);
+        strcpy(poly.instance_dir, instance_dir);
+
+        /*
+         * Add polyinstantiated directory structure to the linked list
+         * of all polyinstantiated directory structures.
+         */
+        if (add_polydir_entry(idata, &poly) < 0) {
+                pam_syslog(idata->pamh, LOG_ERR, "Allocation Error");
+                retval = PAM_SERVICE_ERR;
+        }
+        free(poly.uid);
+
+        goto out;
+
+skipping:
+        retval = PAM_SERVICE_ERR;
+out:
+        argv_free(config_options);
+        return retval;
+}
+
+/*
+ * Parses /etc/security/namespace.conf file to build a linked list of
+ * polyinstantiated directory structures of type polydir_s. Each entry
+ * in the linked list contains information needed to polyinstantiate
+ * one directory.
+ */
+static int parse_config_file(struct instance_data *idata)
+{
+        FILE *fil;
+        char *home;
+        struct passwd *cpwd;
+        char *line = NULL;
+        int retval;
+        size_t len = 0;
+
+        if (idata->flags & MKPOLYDIR_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG, "Parsing config file %s",
+                           PAM_NAMESPACE_CONFIG);
+
+        /*
+         * Extract the user's home directory to resolve $HOME entries
+         * in the namespace configuration file.
+         */
+        cpwd = pam_modutil_getpwnam(idata->pamh, idata->user);
+        if (!cpwd) {
+                pam_syslog(idata->pamh, LOG_ERR,
+                           "Error getting home dir for '%s'", idata->user);
+                return PAM_SESSION_ERR;
+        }
+        home = strdupa(cpwd->pw_dir);
+
+        /*
+         * Open configuration file, read one line at a time and call
+         * process_line to process each line.
+         */
+        fil = fopen(PAM_NAMESPACE_CONFIG, "r");
+        if (fil == NULL) {
+                pam_syslog(idata->pamh, LOG_ERR, "Error opening config file");
+                return PAM_SERVICE_ERR;
+        }
+
+        /* Use unlocked IO */
+        __fsetlocking(fil, FSETLOCKING_BYCALLER);
+
+        /* loop reading the file */
+        while (getline(&line, &len, fil) > 0) {
+                retval = process_line(line, home, idata);
+                if (retval) {
+                        pam_syslog(idata->pamh, LOG_ERR,
+                                   "Error processing conf file line %s", line);
+                        fclose(fil);
+                        free(line);
+                        return PAM_SERVICE_ERR;
+                }
+        }
+        fclose(fil);
+        free(line);
+
+        return PAM_SUCCESS;
+}
+
+static int setup_instance_data(struct instance_data *idata, int item_type)
+{
+        int retval;
+        char *user_name;
+        struct passwd *pwd;
+
+        if (idata->flags & MKPOLYDIR_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for pid %d",
+                           getpid());
+        /*
+         * Lookup user and fill struct items
+         */
+        retval = pam_get_item(idata->pamh, item_type, (void*) &user_name );
+        if ( user_name == NULL || retval != PAM_SUCCESS ) {
+                pam_syslog(idata->pamh, LOG_ERR, "No pam user name");
+                idata->user = NULL;
+                return PAMNS_NO_PAM_USER;
+        }
+        if (idata->flags & MKPOLYDIR_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for user %s",
+                           user_name);
+
+        pwd = pam_modutil_getpwnam(idata->pamh, user_name);
+        if (!pwd) {
+                pam_syslog(idata->pamh, LOG_ERR, "user unknown '%s'",
user_name);
+                return PAMNS_UNKNOWN_USER;
+        }
+
+        if (idata->flags & MKPOLYDIR_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for uid %d",
+                           pwd->pw_uid);
+        /*
+         * Add the user info to the instance data so we can refer to
them later.
+         */
+        idata->user = user_name;
+        idata->uid = pwd->pw_uid;
+
+        /*
+         * Parse namespace configuration file which lists directories to
+         * polyinstantiate, directory where instance directories are to
+         * be created for polyinstantiation.
+         */
+        retval = parse_config_file(idata);
+        if (retval != PAM_SUCCESS) {
+                del_polydir_list(idata->polydirs_ptr);
+                return PAMNS_PARSE_CONFIG_ERROR;
+        }
+        if (idata->flags & MKPOLYDIR_DEBUG)
+                pam_syslog(idata->pamh, LOG_DEBUG,
"setup_instance_data for %s returning %d",
+                           user_name, retval);
+        return retval;
+}
+
+static int
+_pam_parse (const pam_handle_t *pamh, int flags, int argc, const char **argv)
+{
+
+        /* does the appliction require quiet? */
+        if ((flags & PAM_SILENT) == PAM_SILENT)
+                ctrl |= MKPOLYDIR_QUIET;
+
+        /* step through arguments */
+        for (; argc-- > 0; ++argv) {
+                if (!strcmp(*argv, "silent"))
+                        ctrl |= MKPOLYDIR_QUIET;
+                else if (!strcmp(*argv,"debug"))
+                        ctrl |= MKPOLYDIR_DEBUG;
+		else if (!strncmp(*argv,"umask=",6))
+		        module_umask = strtol(*argv+6,0,0);
+                else
+                        pam_syslog(pamh, LOG_ERR, "unknown option: %s", *argv);
+        }
+
+        D(("ctrl = %o", ctrl));
+        return ctrl;
+}
+
+static int
+create_polydir(char *dir, struct polydir_s *pptr, pam_handle_t *
pamh, int debug, uid_t uid, gid_t gid)
+{
+        mode_t my_mode;
+        int rc;
+        security_context_t dircon;
+        char *my_dir;
+
+        if (pptr->mode != (mode_t)ULONG_MAX)
+                my_mode = pptr->mode;
+        else
+                my_mode = 0777 & (~module_umask);
+
+        rc = mkdir(dir, my_mode);
+        if (rc == EACCES) {
+                pam_syslog(pamh, LOG_ERR,
+                           "Error creating directory %s: %m, but
continuing.", dir);
+                return PAM_SUCCESS;
+        } else if (rc != 0) {
+                pam_syslog(pamh, LOG_ERR,
+                           "Error creating directory %s: %m.", dir);
+                return PAM_SESSION_ERR;
+        }
+
+        if (debug)
+                pam_syslog(pamh, LOG_DEBUG,
+                           "Created directory %s.", dir);
+
+        if (chmod(dir, my_mode) != 0) {
+                pam_syslog(pamh, LOG_ERR,
+                           "Error changing mode of directory %s: %m.", dir);
+                return PAM_SESSION_ERR;
+        }
+
+        if (pptr->pw_uid != (uid_t)ULONG_MAX || pptr->gr_gid !=
(gid_t)ULONG_MAX) {
+                if (chown(dir, pptr->pw_uid, pptr->gr_gid) != 0) {
+                        pam_syslog(pamh, LOG_ERR,
+                                   "Unable to change owner on
directory %s: %m", dir);
+                        return PAM_PERM_DENIED;
+                }
+                if (debug)
+                        pam_syslog(pamh, LOG_DEBUG,
+                                   "Set owner %d group %d from
configuration.", pptr->pw_uid, pptr->gr_gid);
+
+        } else {
+                if (chown(dir, uid, gid) != 0) {
+                        pam_syslog(pamh, LOG_ERR,
+                                   "Unable to change owner on
directory %s: %m", dir);
+                        return PAM_PERM_DENIED;
+                }
+                if (debug)
+                        pam_syslog(pamh, LOG_DEBUG,
+                                   "Set %s owner %d group %d.", dir, uid, gid);
+
+        }
+
+
+        asprintf(&my_dir, "%s", dir);
+        if (my_dir[strlen(my_dir)-1] == '/')
+                my_dir[strlen(my_dir)-1] = '\0';
+
+        rc = matchpathcon(my_dir, my_mode, &dircon);
+        if (rc) {
+                matchpathcon_fini();
+                pam_syslog(pamh, LOG_WARNING,
+                           "Unable to get default context for
directory %s, check your policy: %m.", my_dir);
+                free(my_dir);
+                return 0;
+        }
+
+        matchpathcon_fini();
+
+        if (debug)
+                pam_syslog(pamh, LOG_DEBUG,
+                           "setfilecon for %s to %s.", my_dir, (char*)dircon);
+
+        rc = setfilecon(my_dir, dircon);
+        if (rc) {
+                pam_syslog(pamh, LOG_ERR,
+                           "Error setting default context for
directory %s: %m.", my_dir);
+                free(my_dir);
+                freecon(dircon);
+                return PAM_SESSION_ERR;
+        }
+
+        if (debug)
+                pam_syslog(pamh, LOG_DEBUG,
+                           "Set %s context %s.", my_dir, dircon);
+        free(my_dir);
+        freecon(dircon);
+        return 0;
+}
+
+static int
+create_polydirs(const struct passwd *pwd,
+                struct instance_data *idata)
+{
+        struct polydir_s *pptr;
+        struct stat st, parent_st;
+        char *parent = NULL;
+        char *cp;
+        int rc;
+
+        set_matchpathcon_flags(MATCHPATHCON_VALIDATE | MATCHPATHCON_NOTRANS);
+        /* Load the file contexts configuration and check it. */
+        for (pptr = idata->polydirs_ptr; pptr; pptr = pptr->next) {
+
+                if (ns_override(pptr, idata, pwd->pw_uid)) {
+                        return PAM_SUCCESS;
+                }
+                /* Does the directory to be polyinstantiated exist? */
+                if (stat(pptr->dir, &st) < 0) {
+                        /* No so make it in the image of its' parent */
+                        parent = strdup (pptr->dir);
+
+                        if (parent == NULL)
+                                return PAM_BUF_ERR;
+
+                        pam_syslog(idata->pamh, LOG_DEBUG,
+                                   "Process %s.", pptr->dir);
+                        cp = strrchr (parent, '/');
+
+                        if (cp != NULL) {
+                                *cp++ = '\0';
+                                if (stat(parent, &parent_st) == -1 &&
errno == ENOENT) {
+                                        pam_syslog(idata->pamh, LOG_ERR,
+                                                   "Error stating
directory %s: %m.", parent);
+                                        free (parent);
+                                        return PAM_SESSION_ERR;
+                                } else {
+                                        if ((rc =
create_polydir(pptr->dir, pptr, idata->pamh, idata->flags &
MKPOLYDIR_DEBUG, parent_st.st_uid, parent_st.st_gid)) != 0) {
+                                                free(parent);
+                                                return rc;
+                                        }
+                                }
+                        } else {
+                                pam_syslog(idata->pamh, LOG_ERR,
+                                           "Error getting parent of
directory %s.", parent);
+                                free (parent);
+                                return PAM_SESSION_ERR;
+
+                        }
+                        free (parent);
+                }
+
+                /* Does the polyinstantiated instance directory exist? */
+                if (stat(pptr->instance_dir, &st) != 0)
+                        if ((rc = create_polydir(pptr->instance_dir,
pptr, idata->pamh, idata->flags & MKPOLYDIR_DEBUG, pwd->pw_uid,
pwd->pw_gid)) != 0)
+                                return rc;
+
+
+        }
+        return PAM_SUCCESS;
+}
+
+/* --- authentication management functions (only) --- */
+
+PAM_EXTERN int
+pam_sm_open_session (pam_handle_t *pamh, int flags, int argc,
+		     const char **argv)
+{
+        int retval;
+        const void *user;
+        const struct passwd *pwd;
+        struct instance_data idata;
+
+        /* Parse the flag values */
+        ctrl = _pam_parse(pamh, flags, argc, argv);
+
+        /* init instance data */
+        idata.flags = ctrl;
+        idata.polydirs_ptr = NULL;
+        idata.pamh = pamh;
+        retval = setup_instance_data(&idata, PAM_USER);
+        if (retval)
+                return PAM_SESSION_ERR;
+
+        /* Determine the user name so we can get the poly directory */
+        retval = pam_get_item(pamh, PAM_USER, &user);
+        if (retval != PAM_SUCCESS || user == NULL || *(const char
*)user == '\0') {
+                pam_syslog(pamh, LOG_NOTICE, "user unknown");
+                return PAM_USER_UNKNOWN;
+        }
+
+        /* Get the password entry */
+        pwd = pam_modutil_getpwnam (pamh, user);
+        if (pwd == NULL) {
+                D(("couldn't identify user %s", user));
+                return PAM_CRED_INSUFFICIENT;
+        }
+
+        retval =  create_polydirs(pwd, &idata);
+
+        if (ctrl & MKPOLYDIR_DEBUG)
+                if (retval == PAM_SUCCESS) {
+                        pam_syslog(pamh, LOG_DEBUG,
+                                   "Returned PAM_SUCCESS.");
+                } else {
+                        pam_syslog(pamh, LOG_DEBUG,
+                                   "Returned %d.", retval);
+                }
+
+        return retval;
+}
+
+/* Ignore */
+PAM_EXTERN
+int pam_sm_close_session (pam_handle_t * pamh UNUSED, int flags UNUSED,
+			  int argc UNUSED, const char **argv UNUSED)
+{
+        return PAM_SUCCESS;
+}
+
+#ifdef PAM_STATIC
+
+/* static module data */
+struct pam_module _pam_mkpolydir_modstruct =
+{
+        "pam_mkpolydir",
+        NULL,
+        NULL,
+        NULL,
+        pam_sm_open_session,
+        pam_sm_close_session,
+        NULL,
+};
+
+#endif
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/README
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/README
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/README	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/README	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,36 @@
+pam_mkpolydir ― PAM module to create users polyinstantiated directory
+
+━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
+
+DESCRIPTION
+
+The pam_mkpolydir PAM module will create a users polyinstantiated directories
+if they does not exist when the session begins. This allows users to be
+present in central database (such as NIS, kerberos or LDAP) without using a
+distributed file system or pre-creating a large number of directories.
+
+The new users polyinstantiated directories will not be removed after logout of
+the user.
+
+EXAMPLES
+
+A sample /etc/pam.d/login file:
+
+  auth       requisite   pam_securetty.so
+  auth       sufficient  pam_ldap.so
+  auth       required    pam_unix.so
+  auth       required    pam_nologin.so
+  account    sufficient  pam_ldap.so
+  account    required    pam_unix.so
+  password   required    pam_unix.so
+  session    required    pam_mkpolydir.so
+  session    required    pam_unix.so
+  session    optional    pam_lastlog.so
+  session    optional    pam_mail.so standard
+
+
+AUTHOR
+
+pam_mkpolydir was adapted from pam_mkhomedir wriiten by Jason Gunthorpe
+<jgg@debian.org> by Ted X Toth <txtoth@gmail.com>.
+
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/README.xml
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/README.xml
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/README.xml	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/README.xml	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,36 @@
+<?xml version="1.0" encoding='UTF-8'?>
+<!DOCTYPE article PUBLIC "-//OASIS//DTD DocBook XML V4.3//EN"
+"http://www.docbook.org/xml/4.3/docbookx.dtd"
+[
+<!--
+<!ENTITY pamaccess SYSTEM "pam_mkpolydir.8.xml">
+-->
+]>
+
+<article>
+
+  <articleinfo>
+
+    <title>
+      <xi:include xmlns:xi="http://www.w3.org/2001/XInclude"
+      href="pam_mkpolydir.8.xml" xpointer='xpointer(//refnamediv[@id
= "pam_mkpolydir-name"]/*)'/>
+    </title>
+
+  </articleinfo>
+
+  <section>
+    <xi:include xmlns:xi="http://www.w3.org/2001/XInclude"
+      href="pam_mkpolydir.8.xml" xpointer='xpointer(//refsect1[@id =
"pam_mkpolydir-description"]/*)'/>
+  </section>
+
+  <section>
+    <xi:include xmlns:xi="http://www.w3.org/2001/XInclude"
+      href="pam_mkpolydir.8.xml" xpointer='xpointer(//refsect1[@id =
"pam_mkpolydir-examples"]/*)'/>
+  </section>
+
+  <section>
+    <xi:include xmlns:xi="http://www.w3.org/2001/XInclude"
+      href="pam_mkpolydir.8.xml" xpointer='xpointer(//refsect1[@id =
"pam_mkpolydir-author"]/*)'/>
+  </section>
+
+</article>
diff -ruN Linux-PAM-0.99.8.1/modules/pam_mkpolydir/tst-pam_mkpolydir
Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/tst-pam_mkpolydir
--- Linux-PAM-0.99.8.1/modules/pam_mkpolydir/tst-pam_mkpolydir	1969-12-31
18:00:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/pam_mkpolydir/tst-pam_mkpolydir	2007-10-29
14:54:14.000000000 -0600
@@ -0,0 +1,2 @@
+#!/bin/sh
+../../tests/tst-dlopen .libs/pam_mkpolydir.so
--- Linux-PAM-0.99.8.1/modules/Makefile.am	2007-11-08 12:44:00.000000000 -0600
+++ Linux-PAM-0.99.8.1.new/modules/Makefile.am	2007-11-08
12:44:58.000000000 -0600
@@ -11,7 +11,7 @@
 	pam_securetty pam_selinux pam_shells pam_stress pam_succeed_if \
 	pam_tally pam_time pam_umask pam_unix pam_userdb pam_warn \
 	pam_wheel pam_xauth pam_exec pam_namespace pam_loginuid \
-	pam_faildelay
+	pam_faildelay pam_mkpolydir

 CLEANFILES = *~

--- Linux-PAM-0.99.8.1/modules/Makefile.in	2007-07-10 04:40:52.000000000 -0500
+++ Linux-PAM-0.99.8.1.new/modules/Makefile.in	2007-11-08
12:45:23.000000000 -0600
@@ -230,7 +230,7 @@
 	pam_securetty pam_selinux pam_shells pam_stress pam_succeed_if \
 	pam_tally pam_time pam_umask pam_unix pam_userdb pam_warn \
 	pam_wheel pam_xauth pam_exec pam_namespace pam_loginuid \
-	pam_faildelay
+	pam_faildelay pam_mkpolydir

 CLEANFILES = *~
 EXTRA_DIST = modules.map

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
