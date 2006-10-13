Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k9DKU4ka014750
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 16:30:04 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k9DKTNeg028938
	for <selinux@tycho.nsa.gov>; Fri, 13 Oct 2006 20:29:23 GMT
Subject: [ANN] SETools - 3.0
From: "Jeremy A. Mowery" <jmowery@tresys.com>
To: selinux@tycho.nsa.gov
Cc: selinux-dev@tresys.com
Content-Type: text/plain
Date: Fri, 13 Oct 2006 16:31:44 -0400
Message-Id: <1160771504.2723.80.camel@Bishop.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new version of SETools is available on the Tresys Open Source Server.
http://oss.tresys.com/projects/setools

Please note that SETools requires libsepol-1.12.27 or greater.

SETools 3.0

SETools:

  * Moved entire project to autoconf build system.  This will detect
    dependencies correctly and make it easier to integrate with Linux
    distributions and their packaging systems.

SETools libraries:

  * Rewrite of back-end of SETools to use libsepol data structures.
    Most things should run notably faster.

  * All exported library functions have a standarized naming
    convention and are fully documented.  This will prove helpful for
    third-party developers integrating SETools into their own
    projects.

  * For policies version 15 or greater, domain transition analysis now
    takes into consideration setexec permission and/or type_transition
    rules.

apol:

  * Rework Tk interface to fit on 1024x768 displays.

  * Indirect matching of attributes now works with rule searches.

sediff:

  * New diffing algorithm yields significant speed improvements.

  * Can now diff neverallow and role_transition statements.

  * Streamlined results display - should be easier to read.
        
sechecker:

  * Updated module format and template for ease of extension.

Jeremy A. Mowery
Tresys Technology
410-290-1411 x148




--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
