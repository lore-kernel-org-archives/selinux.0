Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j9HHUuNs000901
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 13:30:56 -0400 (EDT)
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j9HHSTup001229
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 17:28:30 GMT
Received: from ha (chadsbox.columbia.tresys.com [10.1.13.99])
	by gotham.columbia.tresys.com (8.12.8/8.12.8) with ESMTP id j9HHSUYq010442
	for <selinux@tycho.nsa.gov>; Mon, 17 Oct 2005 13:28:30 -0400
From: Chad Sellers <csellers@tresys.com>
To: selinux@tycho.nsa.gov
Subject: [RFC] Dynamic discover of object classes
Date: Mon, 17 Oct 2005 13:28:30 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510171328.30452.csellers@tresys.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

One of the efforts of the selinux policy server project is to make a
functional userspace security server to give access control decisions to
userspace object managers (eg., passwd, dbus, SE-X). This would free up
kernel resources associated with the userspace object classes.
Additionally, as userspace object managers grow in numbers, so will
userspace object classes.  Consequently, we would like to support easy
addition and use of userspace object classes.

Currently it is possible to add object classes and permissions to policy.
Unfortunately, there is no infrastructure in place to discover the numeric
class value and permission bitmap assigned when the policy is compiled.
This model is not flexible enough for easy addition and use of userspace
object classes and permissions.

We would rather not change the current security server interface for
permission queries, as this works quite well.  Instead, we would like to
modify libselinux so that userspace object managers can translate object
classes into their numeric values.

In order to do this, a userspace object manager must be able to discover the
value for the object classes it manages, and must be able to translate its
permissions into bit values to compare against the resulting decision from
the security server.  This would get rid of the need for hardcoded values in
all object classes and libselinux awareness of all possible object classes.

To accomplish this goal there are a number of possibilities. We believe that
there are 2 good choices. The first is to add interfaces to selinuxfs and
the userspace security server to query the object class and permissions
values from the in-memory policy. This would require interfaces on the
security server to access the policydb and return the results. The
interfaces would take strings and return integer values. The userspace
security server would implement a similar interface.  These simple
interfaces would allow the userspace object manager (through libselinux) to
query the running policy to discover object classes and their associated
permission bitmaps.  This is a conceptually simple method of discovery, but 
requires kernel changes to add this interface.  Additionally, using this 
libselinux call on a kernel without object class discovery support could fall 
back to the previous system of utilizing the predefined values in the 
headers.

The second choice is to discover this information from disk.  The
information is already available in the on-disk policy (assuming policy on
disk and in the security servers is in sync), so the userspace object
manager could query the policy for discovery.  This would mean all userspace
object managers would need to have read access to the policy and would
introduce some overhead to parse the policy.  To solve these problems, an
ancillary file could be built at policy link time which contains the
information required.  This addresses the problems of querying policy
directly, but adds another file to disk and duplicates information already
in the policy.

We would like to begin implementing option 1, as this seems to be the 
cleanest.  Any feedback would be appreciated.

-- 
----------------------
Chad Sellers
Tresys Technology, LLC
csellers@tresys.com
(410)290-1411 x117
http://www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
