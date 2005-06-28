Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5SEj7gA003942
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 10:45:07 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5SEiPaC021497
	for <selinux@tycho.nsa.gov>; Tue, 28 Jun 2005 14:44:26 GMT
From: Joshua Brindle <jbrindle@tresys.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH] SELinux Loadable Modules
Date: Tue, 28 Jun 2005 10:46:04 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200506281046.04113.jbrindle@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This set of patches (not included in email since they are fairly large) 
include all the infrastructure from before as well as the module store, 
compiler and associated utilities. These patches implement the full module 
compiler and management system. The patches as well as the additional library 
and clients are available at: 
http://sepolicy-server.sourceforge.net/index.php?page=modules

Instructions for using the module store and some general information about 
policy modules is available at:
http://sepolicy-server.sourceforge.net/index.php?page=module-overview

I appreciate any feedback on these patches and the module system in general.

Joshua Brindle
Tresys Technology

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
