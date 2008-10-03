Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m93K8mMj016819
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 16:08:48 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m93K8mrA007043
	for <selinux@tycho.nsa.gov>; Fri, 3 Oct 2008 20:08:48 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: [autotools][patch] AC_INIT VERSION info fix + checkpolicy test
Date: Fri, 3 Oct 2008 16:08:47 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E669859@exchange2.columbia.tresys.com>
References: <48E2716E.2050106@manicmethod.com>
From: "Jason Tang" <jtang@tresys.com>
To: <noel.ambrose@gmail.com>, <selinux@tycho.nsa.gov>
Cc: "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Subject: [autotools][patch] AC_INIT VERSION info fix + checkpolicy test
Date: Tue, 30 Sep 2008 13:17:55 -0400
From: Vikram Noel Ambrose <noel.ambrose@gmail.com>
To: owner-selinux@tycho.nsa.gov
CC: Joshua Brindle <method@manicmethod.com>

>Changelog.
>1. AC_INIT gets version string from $srcdir/VERSION file
>2. checkpolicy tests are now being built with --enable-tests

With this patch applied against the current autotools branch on git, the following issues seem to exist:

libsepol:
1. Version information is in both configure.ac as well as the VERSION file.  Consider having configure.ac generate the VERSION file via a @VERSION@ substitution in AC_CONFIG_FILE.
2. Default behavior of libsepol should be to enable_tests.
3. Syntax of subsequent AM_CONDITIONAL is incorrect; there is a stray right bracket.
4. Actual library and symlink will be installed to $(LIBDIR).  The current model is to place library at /lib and symlink at /usr/lib.
5. No Makefile.am for tests subdirectory.


libselinux:
1. No Ruby support in configure.ac.
2. By default, configure.ac will not enable Python.  This is because $with_python is set to the default ("no"), but then it does not actually guess the Python site folder despite what the help message claims.
3. Consider using the ac_pkg_swig package (http://autoconf-archive.cryp.to/ac_pkg_swig.html) to detect if SWIG and Python are installed.
4. In utils/Makefile.am, instead of $(builddir)/.., this should simply be $(top_builddir).  Likewise, consider $(top_srcdir) instead of $(srcdir)/...
5. In src/Makefile.am, private header files are not included.
6. Actual library and symlink will be installed to $(LIBDIR).  The current model is to place library at /lib and symlink at /usr/lib.


libsemanage:
1. Instead of using AC_SEARCH_LIBS in configure.ac, why not use AC_CHECK_LIB?  There are no alternatives to libselinux, libsepol, and libustr, respectively, AC_CHECK_LIB would be simpler.
2. Defining HAVE_SELINUX_SELINUX_H and its kin are unnecessary.  In no case would it be possible to compile libsemanage without having these defines be false.
3. By default, configure.ac will not enable Python.  This is because $with_python is set to the default ("no").
4. Consider using the ac_pkg_swig package (http://autoconf-archive.cryp.to/ac_pkg_swig.html) to detect if SWIG and Python are installed.
5. No Makefile.am for tests subdirectory.
6. In src/Makefile.am, private header files are not included.
7. Actual library and symlink will be installed to $(LIBDIR).  The current model is to place library at /lib and symlink at /usr/lib.


sepolgen:
1. No Makefile.am for tests subdirectory.
2. The perm_map file is being installed to pkglibdir, but it should be written to /var/lib as in the current build system.


checkpolicy:
1. Default behavior of libsepol should be to enable_tests.
2. In Makefile.am, policy_parse.c should be added to BUILT_SOURCES.  The rule for generating y.tab.h can then be removed; the default rule for YACC files should now suffice.
3. In test/Makefile.am, they should link to $(DESTDIR)/$(LIBDIR) instead of relying upon the default library search path.  Otherwise, the test will fail to build when bootstrapping a bare, non-SELinux system.


policycoreutils:
1. Instead of using AC_SEARCH_LIBS in configure.ac, why not use AC_CHECK_LIB?  There are no alternative libraries that may be used.
2. Consider changing the library search path in configure.ac to include $(DESTDIR)/$(LIBDIR) instead of relying upon the default library search path.  Otherwise, the utilities may fail to build when bootstrapping a bare, non-SELinux system.


Following resolution of these known issues, running 'make distcheck' on each of these packages ought not return any errors.

-- 
Jason Tang  /  jtang@tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
