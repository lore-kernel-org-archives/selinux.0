Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5QGll2X029238
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:47 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5QGlkgW000676
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 16:47:46 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5QGlkQZ016468
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5QGlkmW012399
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:46 -0400
Received: from vpn50-132.rdu.redhat.com (vpn50-132.rdu.redhat.com [172.16.50.132])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k5QGljLp031522
	for <selinux@tycho.nsa.gov>; Mon, 26 Jun 2006 12:47:45 -0400
Subject: [PATCH] libselinux: 0/2 Refactor Handling of /proc/pid/attr/*
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Mon, 26 Jun 2006 12:48:52 -0400
Message-Id: <1151340532.21012.148.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The follow patch set will rework libselinux to now include generic get
and set functions for reading and writing contexts to the interfaces
found in /proc/pid/attr/  The individual libselinux calls will tell the
generic function the path to the attr along with the context
information.

Patch 1/2: Introduce {get,set}procattrcon - These are the 2 functions
that will actually do the work of reading and writing.  reads and writes
are now wrapped in do{}while (ret < 1 && errno == EINTR) to stop early
unneeded failure (suggested by steve g)  errno is now saved across
close(fd) in both get and set to make sure that read/write errors are
propagated back up the stack rather than close errno which we don't
check anyway (suggested by james antill). get still uses strdup since
the malloc is a whole page and leaving that much space unused is just
wasteful (mentioned by steve g).

Patch 2/2: Convert old users to new generic function
-{get,set}fscreatecon()
-{get,set}execcon()
-{get,set}con() the old setcon() had a special check for attempting to
write null and would fail with -1;  From my testing this is the same
thing that happens if you actually try to write null to
the /proc/self/attr/current file so special casing this was not needed.
-getpidcon()
-getprevcon()

Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
