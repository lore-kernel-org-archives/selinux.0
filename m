Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7OChgi0017175
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 08:43:42 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l7OChfVO000962
	for <selinux@tycho.nsa.gov>; Fri, 24 Aug 2007 12:43:41 GMT
Subject: [ANN] SETools 3.3.1 Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Cc: fedora-selinux-list@redhat.com
Content-Type: text/plain
Date: Fri, 24 Aug 2007 08:42:43 -0400
Message-Id: <1187959363.13874.148.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of SETools is now available on the Tresys OSS site, from
http://oss.tresys.com.  This is a minor release, to fix a few minor
issues seen in the 3.3 release.  The complete change log for this
release follows.

SETools 3.3.1:

  * Fix to configure when Tcl is not found on build system; fix when
    compiling with --disable-gui option.

  * Fix to uninstall targets of Java wrappers.

  * Fix to libapol where transitive flows could return results that
    were supposed to be excluded; fixed memory leaks in infoflow graph
    generation.

  * Fix to libsefs when running MLS query on non-MLS fclists.

  * Fix to apol when reading older .apol files; fix copy and select
    all on certain tabs; fix to filter by attribute on some advanced
    dialogs.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
