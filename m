Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2QJdRVK024366
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 15:39:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by anor.bigon.be (Postfix) with ESMTP id 879821A15A
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:39:26 +0200 (CEST)
Received: from anor.bigon.be ([127.0.0.1])
	by localhost (anor.bigon.be [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r-H1byDiOrnj for <selinux@tycho.nsa.gov>;
	Mon, 26 Mar 2012 21:39:24 +0200 (CEST)
Received: from fornost.bigon.be (fornost.bigon.be [IPv6:2001:6f8:303:1:226:18ff:fe08:6073])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: bigon)
	by anor.bigon.be (Postfix) with ESMTPSA id 745FF1A044
	for <selinux@tycho.nsa.gov>; Mon, 26 Mar 2012 21:39:24 +0200 (CEST)
Date: Mon, 26 Mar 2012 21:39:21 +0200
From: Laurent Bigonville <bigon@debian.org>
To: selinux@tycho.nsa.gov
Subject: [PATCH 1/8] setools -- Fix FTBFS with swig >= 2.0
Message-ID: <20120326213921.53660933@fornost.bigon.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

Here a series of patches applied to the setools package in debian


Cheers,
Laurent Bigonville


Description: Fix FTBFS with swig >= 2.0
Author: Sebastian Ramacher <s.ramacher@gmx.at>
Date: Tue, 28 Jun 2011 22:19:49 +0200
Bug-Debian: http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=631800

--- setools-3.3.6.ds.orig/m4/ac_pkg_swig.m4	2007-02-09 18:32:41.000000000 +0100
+++ setools-3.3.6.ds/m4/ac_pkg_swig.m4	2011-06-27 14:12:03.000000000 +0200
@@ -106,15 +106,18 @@
                         if test -z "$available_patch" ; then
                                 [available_patch=0]
                         fi
-                        if test $available_major -ne $required_major \
-                                -o $available_minor -ne $required_minor \
-                                -o $available_patch -lt $required_patch ; then
-                                AC_MSG_WARN([SWIG version >= $1 is required.  You have $swig_version.  You should look at http://www.swig.org])
-                                SWIG='echo "Error: SWIG version >= $1 is required.  You have '"$swig_version"'.  You should look at http://www.swig.org" ; false'
-                        else
+                        if test $available_major -gt $required_major || \
+                                ( test $available_major -eq $required_major && \
+                                      test $available_minor -gt $required_minor ) || \
+                                ( test $available_major -eq $required_major && \
+                                        test $available_minor -eq $required_minor && \
+                                        test $available_patch -ge $required_patch ) ; then
                                 AC_MSG_NOTICE([SWIG executable is '$SWIG'])
                                 SWIG_LIB=`$SWIG -swiglib`
                                 AC_MSG_NOTICE([SWIG library directory is '$SWIG_LIB'])
+                        else
+                                AC_MSG_WARN([SWIG version >= $1 is required.  You have $swig_version.  You should look at http://www.swig.org])
+                                SWIG='echo "Error: SWIG version >= $1 is required.  You have '"$swig_version"'.  You should look at http://www.swig.org" ; false'
                         fi
                 else
                         AC_MSG_WARN([cannot determine SWIG version])

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
