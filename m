Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l3UEDtOv028803
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 10:13:57 -0400
Received: from Bishop.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l3UEDqid023664
	for <selinux@tycho.nsa.gov>; Mon, 30 Apr 2007 14:13:52 GMT
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [ANN] SETools 3.2 Release
Date: Mon, 30 Apr 2007 10:14:30 -0400
Cc: fedora-selinux-list@redhat.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200704301014.30836.jmowery@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of SETools is now available on the Tresys OSS site, from
http://oss.tresys.com. The primary changes this release are the addition
of MLS to sediff and sediffx, the ability to export and import policy list
files to better manage long lists of policy modules, and the introduction
of SWIG wrappers for python and java. The complete change log for this 
release follows.

SETools 3.2:

libapol, libqpol, libesaudit, libpoldiff:

  * If --enable-swig-python is given during configure time, the build
    system will create Python SWIG wrappers for these libraries.

  * If --enable-swig-java is given during configure time, the build
    system will create Java SWIG wrappers for these libraries.

libpoldiff:

  * Provides ability to diff levels, categories, and range_transition
    statements.  Provides ability to diff modifications to a user's
    default level and permitted MLS range, assuming the policies are MLS.
    
apol, seaudit, sediffx:

  * Introduces 'policy list', a small text file that contains
    references to a base policy and any number of modules.  After
    selecting the base policy and modules in a tool's open policy
    dialog, click on 'Export' to write a policy list to disk.  That
    policy list then may be imported into the same tool or any other
    graphical SETools application.  This file also may be specified
    on the command line for all tools that load a policy.

sesearch, apol:

  * Provides full support for version 21 policy (i.e., object classes for
    range_transition statements).

sediff:

  * Shows MLS diffs.

sediffx:

  * Shows MLS diffs.

  * Provides option to show line numbers that contributed just to a
    specific AV rule's permission by clicking that AV rule's permissions.
    This is in addition to existing sediffx behavior that showed all lines
    associated with a particular rule difference.

  * Provides support for type joins and splits within the type remap dialog.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
