Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l73CQqNs013513
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 08:26:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l73CQpHw016268
	for <selinux@tycho.nsa.gov>; Fri, 3 Aug 2007 12:26:51 GMT
Subject: [ANN] SETools 3.3 Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: fedora-selinux-list@redhat.com
Content-Type: text/plain
Date: Fri, 03 Aug 2007 12:26:27 +0000
Message-Id: <1186143987.4015.111.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of SETools is now available on the Tresys OSS site, from
http://oss.tresys.com. The primary changes this release are performance
enhancements, especially for source policies, the ability to select
which AV rules are compared (allow and dontaudit only, for example) in
sediff and sediffx, and a rewrite of libsefs with C++.  The complete
change log for this release follows.

SETools 3.3:

SETools:

  * SETools now has an external dependency upon libsqlite3 >= 3.2.  The
    supplied configure script will enforce this dependency.

  * pkg-config scripts are installed with the SETools libraries.

libsefs:

  * Rewrite of library to have proper namespaces and much more usable
    object-oriented design.

  * SWIG wrappers generated for this library if the appropriate
    configure flags are set.

findcon, searchcon:

  * Merge searchcon's functionality into findcon.  The searchcon tool
    has been removed from SETools.

indexcon, replcon:

  * Updated to use new libsefs design.

apol:

  * Updated to use new libsefs design.

  * Modified to use the SWIG Tcl interface rather than a custom C
    library.  apol is now a combination of a Tcl script (simply called
    'apol') and associated packages that are required at runtime.

  * Neverallow rules are only loaded and expanded when the user
    performs a search for them.  This will dramatically speed up
    initial policy load time.

awish:

  * awish is no longer needed and thus has been removed from SETools.

sediff, sediffx:

  * Instead of differentiating "AV rules" or "TE rules", user now
    specifies which particular rule to compare (allow, dontaudit,
    type_transition, etc.).

  * Neverallow rules are only loaded and expanded when the user
    performs a diff upon them.  This will dramatically speed up
    initial policy load time.


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
