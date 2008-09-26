Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8QJglxK021495
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 15:42:47 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m8QJgl33018991
	for <selinux@tycho.nsa.gov>; Fri, 26 Sep 2008 19:42:47 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: [autotools] libselinux build system comments
Date: Fri, 26 Sep 2008 15:40:13 -0400
Message-ID: <06A6610D4F464D4EBEAFBF2C5F86911E669854@exchange2.columbia.tresys.com>
From: "Jason Tang" <jtang@tresys.com>
To: <selinux@tycho.nsa.gov>
Cc: <noel.ambrose@gmail.com>, "Joshua Brindle" <jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Josh asked me to look through the autotools work.  Here are the issues I have found with the libselinux package:

1. In configure.ac, the AC_INIT macro is not filled out.

2. Within libselinux/src/Makefile.am, the internal header files are not assigned to COMMONSRC and AVCSRC, as appropriately.

3. Within utils/Makefile.am, the builddir for utils is not necessarily sibling to src.

4. libselinux is being installed to $(LIBDIR).  In this case, it should default to the system library.

5. The SWIG and Python detection routines in configure.ac do not seem to work for my system (Debian/stable).

6. The help messages for --disable-rpm and kin are confusing.

7. There is no definition for the variable abs_top_srcdir in src/Makefile.am.

8. By default, the libselinux configuration file is written to $(SYSCONFDIR), but selinux_config.c has the path /etc/selinux hardcoded.  (N.b. the missing "selinux" subdirectory for the former path.)


For issues one through four, see my related notes on libsepol.

For issue five, why not use the swig_python (and related) package at http://autoconf-archive.cryp.to/swig_python.html?  It seems to work well for SETools.

For issue six, consider changing the line "default=no" to "default=enabled".  Otherwise the help message is ambiguous.

For issue seven, it should be either @abs_top_srcdir@ or $(top_srcdir).  I suggest the latter.

For issue eight, the simplest solution is to explicitly set an install directory ("/etc/selinux") for the configuration file.  A more robust solution is to write config to $(SYSCONFDIR)/selinux, and then have selinux_config.c "#include <config.h>" that includes the destination directory.

-- 
Jason Tang / jtang@tresys.com






--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
