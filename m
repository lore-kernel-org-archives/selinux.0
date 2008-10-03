Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m93NgJLT013573
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 19:42:19 -0400
Received: from hs-out-0708.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m93NfCoA014372
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 23:41:12 GMT
Received: by hs-out-0708.google.com with SMTP id k27so626381hsc.2
        for <selinux@tycho.nsa.gov>; Fri, 03 Oct 2008 16:42:19 -0700 (PDT)
Message-ID: <48E6ADCC.5020803@gmail.com>
Date: Fri, 03 Oct 2008 19:42:04 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
MIME-Version: 1.0
To: Jason Tang <jtang@tresys.com>
CC: selinux@tycho.nsa.gov, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [autotools][patch] AC_INIT VERSION info fix + checkpolicy test
References: <48E2716E.2050106@manicmethod.com> <06A6610D4F464D4EBEAFBF2C5F86911E669859@exchange2.columbia.tresys.com>
In-Reply-To: <06A6610D4F464D4EBEAFBF2C5F86911E669859@exchange2.columbia.tresys.com>
Content-Type: multipart/mixed;
 boundary="------------000708000607080905020909"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------000708000607080905020909
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jason Tang wrote:
> Subject: [autotools][patch] AC_INIT VERSION info fix + checkpolicy test
> Date: Tue, 30 Sep 2008 13:17:55 -0400
> From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
> To: owner-selinux@tycho.nsa.gov
> CC: Joshua Brindle <method@manicmethod.com>
>
>   
>> Changelog.
>> 1. AC_INIT gets version string from $srcdir/VERSION file
>> 2. checkpolicy tests are now being built with --enable-tests
>>     
>
> With this patch applied against the current autotools branch on git, the following issues seem to exist:
>
> libsepol:
> 1. Version information is in both configure.ac as well as the VERSION file.  Consider having configure.ac generate the VERSION file via a @VERSION@ substitution in AC_CONFIG_FILE.
> 2. Default behavior of libsepol should be to enable_tests.
> 3. Syntax of subsequent AM_CONDITIONAL is incorrect; there is a stray right bracket.
> 4. Actual library and symlink will be installed to $(LIBDIR).  The current model is to place library at /lib and symlink at /usr/lib.
> 5. No Makefile.am for tests subdirectory.
>
>   
1,2,3 -> Fixed with attached libsepol-fixes.patch
  -1- The VERSION file is deleted, it is redundant. From
      now on the only file that will track the version string
      will be configure.ac for all packages
     
4. -> This is an issue for the distro maintainer, not the package 
maintainer.

5 -> I dont understand how to build the tests for libsepol. Can someone 
explain the libsepol/tests/Makefile from the master branch to me? I have 
just stubbed it out for now

// make distcheck OK after patch
> libselinux:
> 1. No Ruby support in configure.ac.
> 2. By default, configure.ac will not enable Python.  This is because $with_python is set to the default ("no"), but then it does not actually guess the Python site folder despite what the help message claims.
> 3. Consider using the ac_pkg_swig package (http://autoconf-archive.cryp.to/ac_pkg_swig.html) to detect if SWIG and Python are installed.
> 4. In utils/Makefile.am, instead of $(builddir)/.., this should simply be $(top_builddir).  Likewise, consider $(top_srcdir) instead of $(srcdir)/...
> 5. In src/Makefile.am, private header files are not included.
> 6. Actual library and symlink will be installed to $(LIBDIR).  The current model is to place library at /lib and symlink at /usr/lib.
>
>   

1 -> I'm not going to address this one. If someone knows how to use 
ruby, go ahead and add it.

2 -> You seem to be mixing 2 very different things here.
  -1- $with_python refers to building code that needs python
      support and yes, by default, it is set to no.
      Python is extra functionality, it is not a mandatory
      dependency, use --with-python=/path/to/include/python2.4
      if you want these python features from libselinux
  -2- The python site-packages folder is indeed guessed if
      one is not specified, why do you say differently?
      Did you look at the resulting/guessed site-packages
      folder after running configure without specifying
      --with-python-site?
      libselinux-fixes.patch stops the WARNING message
      from being displayed if the libpy* cannot be built

3 -> Like I said previously, can you give me the logs from
     the machine you claim fails the swig checks?

4 -> Fixed with attached libselinux-fixes.patch

5 -> Not sure what you mean

6 -> As in libsepol, this is a distro maintainer policy, not one to be 
enforced by the build system.

// make distcheck OK after patch
> libsemanage:
> 1. Instead of using AC_SEARCH_LIBS in configure.ac, why not use AC_CHECK_LIB?  There are no alternatives to libselinux, libsepol, and libustr, respectively, AC_CHECK_LIB would be simpler.
> 2. Defining HAVE_SELINUX_SELINUX_H and its kin are unnecessary.  In no case would it be possible to compile libsemanage without having these defines be false.
> 3. By default, configure.ac will not enable Python.  This is because $with_python is set to the default ("no").
> 4. Consider using the ac_pkg_swig package (http://autoconf-archive.cryp.to/ac_pkg_swig.html) to detect if SWIG and Python are installed.
> 5. No Makefile.am for tests subdirectory.
> 6. In src/Makefile.am, private header files are not included.
> 7. Actual library and symlink will be installed to $(LIBDIR).  The current model is to place library at /lib and symlink at /usr/lib.
>
>
>   

1,2 -> Fixed with attached libsemanage-fixes.patch

3 -> Yup, that's true. Python is not needed for libsemanage. If you need 
this extra functionality (ie, libpysemanage), then specify the headers 
you want to build with.
./configure --with-python=/these/guys/include/python2.4

4 -> Why? Whats wrong with the current test?

5 -> Fixed with attached libsemanage-fixes.patch
  -1- I have not tested the tests. CUnit header checks may
      also be needed in configure.ac

6 -> Not sure what you mean

7 -> Again this is a site policy and no concern of the package 
maintainer. The distro maintainer adjusts these sort of things according 
to the policies of the distro.

// make distcheck OK after patch

phew....that was some work...

I've attached my quilt series file along with the patches. So that you 
can apply them in stack, as i had them.

Thanks again Jason for taking such a close look at the autotools branch.

5 patches! have fun Josh.

Vikram



--------------000708000607080905020909
Content-Type: text/x-patch;
 name="ac-init-VERSION.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac-init-VERSION.patch"

diff --git a/checkpolicy/Makefile.am b/checkpolicy/Makefile.am
index fdc936e..3534673 100644
--- a/checkpolicy/Makefile.am
+++ b/checkpolicy/Makefile.am
@@ -1,4 +1,6 @@
-bin_PROGRAMS		= checkmodule checkpolicy $(extras)
+SUBDIRS			= test
+bin_PROGRAMS		= checkmodule checkpolicy
+
 checkmodule_SOURCES	= $(COMMONSRC)  checkmodule.c
 checkmodule_DEPENDENCIES= $(LIBSEPOL_A_PATH)
 checkmodule_LDADD	= $(LIBSEPOL_A_PATH)
@@ -12,12 +14,9 @@ AM_LDFLAGS		= -Wl,--as-needed
 COMMONSRC		= \
 	queue.c		module_compiler.c \
 	parse_util.c	policy_define.c \
-	policy_parse.y	policy_scan.l
+	policy_parse.y	policy_scan.l \
+	module_compiler.h 
 
 y.tab.h y.tab.c : policy_parse.y
 	$(YACC) -d $<
 
-extras	=
-if BUILD_tests
-extras	+= dispol dismod
-endif
diff --git a/checkpolicy/configure.ac b/checkpolicy/configure.ac
index 7a484a4..27e4473 100644
--- a/checkpolicy/configure.ac
+++ b/checkpolicy/configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([checkpolicy], VERSION, BUG-REPORT-ADDRESS)
+AC_INIT([checkpolicy], VERSION, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([module_compiler.h])
 AC_CONFIG_HEADER([config.h])
@@ -85,7 +85,7 @@ AC_ARG_ENABLE([tests],
 	[enable_tests=no]
 )
 
-AM_CONDITIONAL([BUILD_tests],[test "$enable_tests]" = "yes"])
+AM_CONDITIONAL([BUILD_tests],[test "$enable_tests" = "yes"])
 		
 # Checks for header files.
 AC_HEADER_STDC
@@ -114,7 +114,14 @@ AC_FUNC_MMAP
 AC_FUNC_REALLOC
 AC_CHECK_FUNCS([memset strcasecmp strchr strdup strerror strtol strtoul])
 
-AC_CONFIG_FILES([Makefile])
+AC_CONFIG_FILES([Makefile test/Makefile])
+
+# Pickup the version info from the source directory if available
+VERSION=`cat $srcdir/VERSION`
+if test "$VERSION" = "" ; then
+        VERSION=git
+fi
+
 AC_OUTPUT
 
 PRINT='echo -n -e '
diff --git a/checkpolicy/test/Makefile.am b/checkpolicy/test/Makefile.am
new file mode 100644
index 0000000..34bccc5
--- /dev/null
+++ b/checkpolicy/test/Makefile.am
@@ -0,0 +1,9 @@
+noinst_PROGRAMS = $(c_extras)
+c_extras = 
+if BUILD_tests
+c_extras  += dispol dismod
+endif
+
+dispol_LDADD	= $(LIBSEPOL_A_PATH)
+dismod_LDADD	= $(LIBSEPOL_A_PATH)
+AM_LDFLAGS	= -lselinux
diff --git a/libselinux/configure.ac b/libselinux/configure.ac
index a437404..daa7607 100644
--- a/libselinux/configure.ac
+++ b/libselinux/configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([libselinux], [VERSION], BUG-REPORT-ADDRESS)
+AC_INIT([libselinux], VERSION, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([utils/compute_create.c])
 AC_CONFIG_HEADER([config.h])
@@ -199,9 +199,10 @@ AC_CONFIG_FILES([Makefile
 		man/Makefile
 		include/Makefile])
 
+# Pickup the version info from the source directory if available
 VERSION=`cat $srcdir/VERSION`
 if test "$VERSION" = "" ; then
-	VERSION=svn
+	VERSION=git
 fi
 
 AC_OUTPUT
diff --git a/libsemanage/configure.ac b/libsemanage/configure.ac
index 1b70dc9..f1a246e 100644
--- a/libsemanage/configure.ac
+++ b/libsemanage/configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(libsemanage, VERSION, BUG-REPORT-ADDRESS)
+AC_INIT(libsemanage, VERSION, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([src/modules.c])
 AC_CONFIG_HEADER([config.h])
@@ -151,10 +151,10 @@ AC_CONFIG_FILES([Makefile
                  include/Makefile
                  man/Makefile])
 
-
+# Pickup the version info from the source directory if available
 VERSION=`cat $srcdir/VERSION`
 if test "$VERSION" = "" ; then
-	VERSION=svn
+	VERSION=git
 fi
 AC_OUTPUT
 
diff --git a/libsepol/src/Makefile.am b/libsepol/src/Makefile.am
index 55c8d8e..ec74fec 100644
--- a/libsepol/src/Makefile.am
+++ b/libsepol/src/Makefile.am
@@ -4,24 +4,15 @@ COMMONSRC		= assertion.c conditional.c ebitmap.c hashtab.c \
 			module.c policydb_convert.c services.c util.c \
 			avtab.c context.c genbools.c iface_record.c \
 			node_record.c  policydb_public.c sidtab.c write.c \
-			boolean_record.c context_record.c genusers.c interfaces.c \
-			nodes.c port_record.c symtab.c booleans.c \
-			debug.c handle.c link.c polcaps.c ports.c user_record.c \
-	av_permissions.h \
-	boolean_internal.h \
-	context.h \
-	context_internal.h \
-	debug.h \
-	dso.h \
-	handle.h \
-	iface_internal.h \
-	mls.h \
-	module_internal.h \
-	node_internal.h \
-	policydb_internal.h \
-	port_internal.h \
-	private.h \
-	user_internal.h
+			boolean_record.c context_record.c genusers.c \
+			interfaces.c nodes.c port_record.c symtab.c \
+			booleans.c debug.c handle.c link.c polcaps.c \
+			ports.c user_record.c av_permissions.h \
+			boolean_internal.h context.h context_internal.h \
+			debug.h dso.h handle.h iface_internal.h mls.h \
+			module_internal.h node_internal.h policydb_internal.h \
+			port_internal.h private.h user_internal.h
+
 lib_LTLIBRARIES		= libsepol.la
 libsepol_la_SOURCES	= $(COMMONSRC)
 libsepol_la_CPPFLAGS	= \
diff --git a/policycoreutils/configure.ac b/policycoreutils/configure.ac
index 36df796..25fd761 100644
--- a/policycoreutils/configure.ac
+++ b/policycoreutils/configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(policycoreutils, VERSION, BUG-REPORT-ADDRESS)
+AC_INIT(policycoreutils, VERSION, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([run_init/run_init.c])
 AC_CONFIG_HEADER([config.h])
@@ -219,10 +219,10 @@ AC_CONFIG_FILES([
 	setfiles/Makefile
 	Makefile])
 
-
+# Pickup the version info from the source directory if available
 VERSION=`cat $srcdir/VERSION`
 if test "$VERSION" = "" ; then
-        VERSION=svn
+        VERSION=git
 fi
 
 AC_OUTPUT
diff --git a/sepolgen/configure.ac b/sepolgen/configure.ac
index 894f338..d4a61d0 100644
--- a/sepolgen/configure.ac
+++ b/sepolgen/configure.ac
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(sepolgen, VERSION, BUG-REPORT-ADDRESS)
+AC_INIT(sepolgen, VERSION, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 
 
@@ -29,10 +29,10 @@ AC_CONFIG_FILES([Makefile
                  src/share/Makefile])
 
 
-
+# Pickup the version info from the source directory if available
 VERSION=`cat $srcdir/VERSION`
 if test "$VERSION" = "" ; then
-        VERSION=svn
+        VERSION=git
 fi
 
 AC_OUTPUT

--------------000708000607080905020909
Content-Type: text/x-patch;
 name="libselinux-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libselinux-fixes.patch"

Index: selinux-git/libselinux/utils/Makefile.am
===================================================================
--- selinux-git.orig/libselinux/utils/Makefile.am	2008-10-03 17:10:29.000000000 -0400
+++ selinux-git/libselinux/utils/Makefile.am	2008-10-03 17:26:08.000000000 -0400
@@ -16,6 +16,6 @@
 endif
 
 bin_PROGRAMS	= $(BUILDS)
-AM_LDFLAGS	= -Wl,--as-needed -lselinux -L$(builddir)/../src
-AM_CPPFLAGS	= -I$(srcdir)/../include
-BUILT_SOURCES	= $(builddir)/../src/libselinux.la
+AM_LDFLAGS	= -Wl,--as-needed -lselinux -L$(top_builddir)/src
+AM_CPPFLAGS	= -I$(top_srcdir)/include
+BUILT_SOURCES	= $(top_builddir)/src/libselinux.la
Index: selinux-git/libselinux/configure.ac
===================================================================
--- selinux-git.orig/libselinux/configure.ac	2008-10-03 17:10:29.000000000 -0400
+++ selinux-git/libselinux/configure.ac	2008-10-03 17:38:42.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([libselinux], VERSION, selinux@tycho.nsa.gov)
+AC_INIT([libselinux], 2.0.73, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([utils/compute_create.c])
 AC_CONFIG_HEADER([config.h])
@@ -99,13 +99,6 @@
 	[]
 )
 
-if test -n "$with_python_site" ; then
-	AC_SUBST([pythondir],[$with_python_site])
-	AC_SUBST([pyexecdir],[$with_python_site])
-else
-	AC_MSG_WARN([Python site folder not specified, guessing...])
-fi
-
 AC_ARG_WITH([python],
 	[AC_HELP_STRING(
 		[--with-python=PATH],
@@ -186,6 +179,16 @@
 	_enable_swig=no
 	AC_MSG_NOTICE([Swig interface does not need to be regenerated 
 		because libpyselinux.so wrapper cannot be built])
+else
+	# Use what the user specified, otherwise fallback on autoconf
+        # internal default and display warning to user.
+        # autoconf default = libdir/pythonX.X/site-packages
+	if test -n "$with_python_site" ; then
+	        AC_SUBST([pythondir],[$with_python_site])
+	        AC_SUBST([pyexecdir],[$with_python_site])
+	else
+	        AC_MSG_WARN([Python site folder not specified, guessing...])
+	fi
 fi
 
 # slip in fake swig if needed
@@ -199,12 +202,6 @@
 		man/Makefile
 		include/Makefile])
 
-# Pickup the version info from the source directory if available
-VERSION=`cat $srcdir/VERSION`
-if test "$VERSION" = "" ; then
-	VERSION=git
-fi
-
 AC_OUTPUT
 
 PRINT='echo -n -e '
Index: selinux-git/libselinux/src/Makefile.am
===================================================================
--- selinux-git.orig/libselinux/src/Makefile.am	2008-09-30 11:43:45.000000000 -0400
+++ selinux-git/libselinux/src/Makefile.am	2008-10-03 17:43:09.000000000 -0400
@@ -9,7 +9,13 @@
 	policyvers.c freeconary.c label.c procattr.c check_context.c \
 	freecon.c label_file.c query_user_context.c compute_av.c fsetfilecon.c \
 	label_media.c compute_create.c get_context_list.c label_x.c \
-	selinux_check_securetty_context.c
+	selinux_check_securetty_context.c \
+	avc_internal.h avc_sidtab.h av_inherit.h av_perm_to_string.h \
+	callbacks.h class_to_string.h common_perm_to_string.h \
+	context_internal.h dso.h file_path_suffixes.h \
+	get_context_list_internal.h get_default_type_internal.h \
+	label_internal.h mapping.h policy.h selinux_internal.h \
+	selinux_netlink.h setrans_internal.h
 
 AVCSRC	= \
 	avc.c avc_internal.c avc_sidtab.c \
@@ -33,6 +39,7 @@
 selinux_python_PYTHON		= $(extra_py) 
 
 sysconf_DATA			= config
+CLEANFILES			= config
 config:Makefile
 	echo -e "SELINUXTYPE=$(policyname)\nSELINUX=enforcing" > $@ 
 		
Index: selinux-git/libselinux/VERSION
===================================================================
--- selinux-git.orig/libselinux/VERSION	2008-10-03 17:10:50.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1 +0,0 @@
-2.0.73

--------------000708000607080905020909
Content-Type: text/x-patch;
 name="libsemanage-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsemanage-fixes.patch"

Index: selinux-git/libsemanage/VERSION
===================================================================
--- selinux-git.orig/libsemanage/VERSION	2008-09-30 10:18:55.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1 +0,0 @@
-2.0.28
Index: selinux-git/libsemanage/configure.ac
===================================================================
--- selinux-git.orig/libsemanage/configure.ac	2008-10-03 16:31:36.000000000 -0400
+++ selinux-git/libsemanage/configure.ac	2008-10-03 19:34:11.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT(libsemanage, VERSION, selinux@tycho.nsa.gov)
+AC_INIT(libsemanage, 2.0.28, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([src/modules.c])
 AC_CONFIG_HEADER([config.h])
@@ -20,8 +20,6 @@
 fi
 AC_PROG_INSTALL
 AC_PROG_LN_S
-# Stop libtool from building the .a because the NSA use special 
-# flags for the .a and need to be set manually from the Makefile.am
 # Static lib is used to build checkpolicy/module
 AC_DISABLE_STATIC
 AC_PROG_LIBTOOL
@@ -31,21 +29,18 @@
 AM_PROG_CC_C_O
 
 # Checks for libraries.
-AC_SEARCH_LIBS([selinux_init_load_policy],[selinux],
+AC_CHECK_LIB([selinux],[selinux_init_load_policy],
 	[],
 	[AC_MSG_ERROR([[SELinux library was not found.]])]
-	,[]
 )
-AC_SEARCH_LIBS([sepol_policydb_read],[sepol],
+AC_CHECK_LIB([sepol],[sepol_policydb_read],
 	[],
 	[AC_MSG_ERROR([[SELinux Policy library was not found.]])]
-	,[]
 )
 
-AC_SEARCH_LIBS([ustr_free],[ustr],
+AC_CHECK_LIB([ustr],[ustr_free],
 	[],
 	[AC_MSG_ERROR([[ustr Micro String library was not found.]])]
-	,[]
 )
 	
 # Checks for header files.
@@ -58,10 +53,8 @@
 	sys/time.h unistd.h])
 
 AC_CHECK_HEADER([selinux/selinux.h],
-	[AC_DEFINE(HAVE_SELINUX_SELINUX_H, 1, 
-		[Define to 1 if you have <selinux/selinux.h>.])]
-	,
-        [AC_MSG_ERROR([[SELinux headers are missing.]])]
+	[],
+	[AC_MSG_ERROR([[SELinux headers are missing.]])]
 )
 
 AC_CHECK_HEADER([ustr.h],
@@ -82,6 +75,35 @@
         [],
         [with_python=no]
 )
+
+AC_ARG_WITH([python-site],
+        [AC_HELP_STRING([--with-python-site=PATH],
+                        [Optional path to python site-packages folder,
+                        eg /usr/lib/python2.4/site-packages])],
+        []
+)
+
+AC_ARG_ENABLE([swig],
+	[AC_HELP_STRING([--disable-swig],
+		[Disable regeneration of python c interface (default=no)])],
+	[_enable_swig=$enableval],
+	[_enable_swig=yes]
+)
+
+AC_ARG_ENABLE([tests],
+        [AC_HELP_STRING([--disable-tests],[Disable building tests])],
+        [enable_tests=$enableval],
+        [enable_tests=no]
+)
+
+AM_CONDITIONAL([BUILD_tests],[test "$enable_tests" = "yes"])
+
+if test "$enable_tests" = "yes" ; then
+	AC_CHECK_LIB([cunit],[CU_initialize_registry],
+		[],
+		[AC_MSG_ERROR([CUnit is needed to build tests. Install cunit or --disable-tests])]
+	)
+fi
 if test "$with_python" != "no" ; then
         AC_SUBST([PYTHON_INCLUDE_DIR],[$with_python])
 
@@ -98,22 +120,31 @@
 
 AM_CONDITIONAL([enable_python], [test "$have_python" = yes])
 
-AC_SUBST([pythondir],[$libdir/python$with_pythonver/site-packages])
-AC_SUBST([pyexecdir],[$libdir/python$with_pythonver/site-packages])
-
-AC_ARG_ENABLE([swig],
-	[AC_HELP_STRING([--disable-swig],
-		[Disable regeneration of python c interface (default=no)])],
-	[_enable_swig=$enableval],
-	[_enable_swig=yes]
-)
-
 # Hault the config if we are asked for swig, but not swig is found
 if test "$_enable_swig" = "yes" -a -z "$SWIG" ; then
         AC_MSG_ERROR([Cannot find swig interface gemerator in PATH,
                 Disable python c-inteferace regeneration with --disable-swig])
 fi
 
+# If libpy*.so wrapper cannot be built, then do not rebuild swig interface
+# even if swig is available, and do not install site-packages
+if test "$have_python" != "yes" ; then
+        _enable_swig=no
+        AC_MSG_NOTICE([Swig interface does not need to be regenerated
+                because libpyselinux.so wrapper cannot be built])
+else
+        # Use what the user specified, otherwise fallback on autoconf
+        # internal default and display warning to user.
+        # autoconf default = libdir/pythonX.X/site-packages
+        if test -n "$with_python_site" ; then
+                AC_SUBST([pythondir],[$with_python_site])
+                AC_SUBST([pyexecdir],[$with_python_site])
+        else
+                AC_MSG_WARN([Python site folder not specified, guessing...])
+        fi
+fi
+
+
 # slip in fake swig if needed
 if test "$_enable_swig" != "yes" ; then
         AC_SUBST([SWIG],[/bin/true])
@@ -149,19 +180,16 @@
 AC_CONFIG_FILES([Makefile
                  src/Makefile
                  include/Makefile
+		 tests/Makefile
                  man/Makefile])
 
-# Pickup the version info from the source directory if available
-VERSION=`cat $srcdir/VERSION`
-if test "$VERSION" = "" ; then
-	VERSION=git
-fi
 AC_OUTPUT
 
 PRINT='echo -n -e '
 $PRINT  "\nLibsemanage Configuration Summary:\n"
 if test "$have_python" = "yes" ; then
 	$PRINT "\tlibpysemanage.so\t= $have_python (Using $with_python) \n"
+	$PRINT "\tPython Packages folder\t= $pythondir\n"
 else
 	$PRINT "\tlibpysemanage.so\t= no "
 	$PRINT "(try --with-python=/usr/include/python$PYTHON_VERSION) \n"
@@ -169,5 +197,5 @@
 $PRINT "\tRegenerate py wrapper\t= $_enable_swig\n"
 $PRINT "\tBuilding static lib\t= $enable_static\n"
 $PRINT "\tBuilding shared object\t= $enable_shared\n"
-$PRINT "\tPython Packages folder\t= $pythondir\n"
+$PRINT "\tBuilding tests\t\t= $enable_tests\n"
 $PRINT "------------------------------------------------------------\n"
Index: selinux-git/libsemanage/src/Makefile.am
===================================================================
--- selinux-git.orig/libsemanage/src/Makefile.am	2008-09-30 10:47:06.000000000 -0400
+++ selinux-git/libsemanage/src/Makefile.am	2008-10-03 18:27:31.000000000 -0400
@@ -17,7 +17,16 @@
 	parse_utils.c		seusers_policy.c 	database_file.c		\
 	iface_record.c		policy_components.c	user_base_record.c 	\
 	database_join.c		interfaces_file.c	port_record.c   	\
-	user_extra_record.c
+	user_extra_record.c \
+	boolean_internal.h	context_internal.h	database_activedb.h	\
+	database_file.h		database.h		database_join.h		\
+	database_llist.h	database_policydb.h	debug.h			\
+	direct_api.h		dso.h			fcontext_internal.h	\
+	genhomedircon.h		handle.h		handle_internal.h	\
+	iface_internal.h	module_internal.h	modules.h		\
+	node_internal.h		parse_utils.h		policy.h		\
+	port_internal.h		semanage_conf.h		semanage_store.h	\
+	seuser_internal.h	user_internal.h		utilities.h
 
 
 CLEANFILES			= $(BUILT_SOURCES)
@@ -59,4 +68,4 @@
 # allowing the configure conftest to pass but this make rule to fail.
 # This is why -o lex.yy.c is given here.
 AM_LFLAGS			= -o lex.yy.c -s
-sysconf_DATA			= semanage.conf
+dist_sysconf_DATA		= semanage.conf
Index: selinux-git/libsemanage/Makefile.am
===================================================================
--- selinux-git.orig/libsemanage/Makefile.am	2008-09-30 10:47:06.000000000 -0400
+++ selinux-git/libsemanage/Makefile.am	2008-10-03 18:31:48.000000000 -0400
@@ -1 +1 @@
-SUBDIRS = man src include
+SUBDIRS = man src include tests
Index: selinux-git/libsemanage/tests/Makefile.am
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ selinux-git/libsemanage/tests/Makefile.am	2008-10-03 18:41:10.000000000 -0400
@@ -0,0 +1,11 @@
+noinst_PROGRAMS = $(c_extra)
+if BUILD_tests
+c_extra	= libsemanage-tests
+else
+c_extra	=
+endif
+libsemanage_tests_SOURCES	= libsemanage-tests.c test_semanage_store.c \
+				test_utilities.c utilities.c
+
+libsemanage_tests_CFLAGS	=  -I$(top_srcdir) -I$(top_srcdir)/include/semanage
+libsemanage_tests_LDFLAGS	=  -Wl,--as-needed

--------------000708000607080905020909
Content-Type: text/x-patch;
 name="libsepol-fixes.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="libsepol-fixes.patch"

Index: selinux-git/libsepol/configure.ac
===================================================================
--- selinux-git.orig/libsepol/configure.ac	2008-10-03 16:38:06.000000000 -0400
+++ selinux-git/libsepol/configure.ac	2008-10-03 17:11:24.000000000 -0400
@@ -2,7 +2,7 @@
 # Process this file with autoconf to produce a configure script.
 
 AC_PREREQ(2.61)
-AC_INIT([libsepol], 2.0.32, selinux@tycho.nsa.gov)
+AC_INIT([libsepol], 2.0.33, selinux@tycho.nsa.gov)
 AM_INIT_AUTOMAKE
 AC_CONFIG_SRCDIR([utils/chkcon.c])
 AC_CONFIG_HEADER([config.h])
@@ -55,23 +55,26 @@
 AC_CHECK_FUNCS([memset strcasecmp strchr strdup strerror strncasecmp strrchr])
 
 AC_ARG_ENABLE([tests],
-        [AC_HELP_STRING([--enable-tests],[Enables building of tests])],
+        [AC_HELP_STRING([--disable-tests],[Disable building tests])],
         [enable_tests=$enableval],
-        [enable_tests=no]
+        [enable_tests=yes]
 )
 
-AM_CONDITIONAL([BUILD_tests],[test "$enable_tests]" = "yes"])
+AM_CONDITIONAL([BUILD_tests],[test "$enable_tests" = "yes"])
 
 AC_CONFIG_FILES([Makefile
                  include/Makefile
                  man/Makefile
                  src/Makefile
-                 utils/Makefile])
+                 utils/Makefile
+		 tests/Makefile])
+
 AC_OUTPUT
 
 PRINT='echo -n -e '
 $PRINT "\n*** Libsepol Configuration Summary ***\n"
 $PRINT "\tBuilding static lib\t= $enable_static\n"
 $PRINT "\tBuilding shared object\t= $enable_shared\n"
+$PRINT "\tBuilding tests\t\t= $enable_tests\n"
 $PRINT "------------------------------------------------------------\n" 
 
Index: selinux-git/libsepol/tests/Makefile.am
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ selinux-git/libsepol/tests/Makefile.am	2008-10-03 17:19:04.000000000 -0400
@@ -0,0 +1,5 @@
+noinst_PROGRAMS        = $(c_extra)
+
+if BUILD_tests
+c_extra        =
+endif
Index: selinux-git/libsepol/VERSION
===================================================================
--- selinux-git.orig/libsepol/VERSION	2008-09-30 10:18:55.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1 +0,0 @@
-2.0.33
Index: selinux-git/libsepol/Makefile.am
===================================================================
--- selinux-git.orig/libsepol/Makefile.am	2008-09-30 10:47:06.000000000 -0400
+++ selinux-git/libsepol/Makefile.am	2008-10-03 17:20:26.000000000 -0400
@@ -1 +1 @@
-SUBDIRS		=  include man src utils 
+SUBDIRS		=  include man src utils tests

--------------000708000607080905020909
Content-Type: text/plain;
 name="series"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="series"

ac-init-VERSION.patch
libsepol-fixes.patch
libselinux-fixes.patch
libsemanage-fixes.patch

--------------000708000607080905020909--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
