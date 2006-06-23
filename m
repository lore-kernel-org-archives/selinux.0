Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5NKVked012366
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:46 -0400
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5NKVj0d018423
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 20:31:45 GMT
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5NKVjA6017013
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:45 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [172.16.52.156])
	by int-mx1.corp.redhat.com (8.12.11.20060308/8.12.11) with ESMTP id k5NKVj7t015129
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:45 -0400
Received: from vpn50-149.rdu.redhat.com (vpn50-149.rdu.redhat.com [172.16.50.149])
	by pobox.corp.redhat.com (8.12.8/8.12.8) with ESMTP id k5NKVis3003477
	for <selinux@tycho.nsa.gov>; Fri, 23 Jun 2006 16:31:44 -0400
Subject: [PATCH] libselinux: 0/2 Refactor Handling of /proc/pid/attr/*
From: Eric Paris <eparis@parisplace.org>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 16:32:44 -0400
Message-Id: <1151094764.21012.92.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The follow patch set will rework libselinux to now include generic get
and set functions for reading and writing contexts to the interfaces
found in /proc/pid/addr/  The individual libselinux calls will tell the
generic function the path to the attr along with the current context
information.

Patch 1/2: Introduce {get,set}procattrcon - These are the 2 functions
that will actually do the work of reading a writing
Patch 2/2: Convert old users to new generic function
-{get,set}fscreatecon()
-{get,set}execcon()
-{get,set}con() - the old setcon() had a special check for attempting to
write null and would fail with -1;  From my testing this is the same
thing that happens if you actually try to write null to the pid file so
special casing this was not needed.  getcon_raw() was also used
elsewhere in libselinux, so it is left.  The other caller could be made
to pass a path directly to the generic call, or be made to not use the
_raw interfaces in the future.....
-getpidcon()
-getprevcon() - again there were other users of getprevcon_raw inside
selinux, so it was left


Eric


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
