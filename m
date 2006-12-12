Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBC7RtG1010541
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 02:27:55 -0500
Received: from mail.atsec.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBC7SPS2010457
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 07:28:26 GMT
Date: Tue, 12 Dec 2006 01:28:26 -0600
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH RFC 0/2] stricter MLS policy constraints
Message-ID: <20061212072825.GA3362@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello,

this is a followup to a previous discussion about the MLS constraints
in the reference policy:

	http://marc.theaimsgroup.com/?l=selinux&m=116327030930738&w=2

Darrel Goeddel's explained that these MLS constraints are based on
"ranged objects" for container objects such as directories, and for
sockets, allowing writes if the subject low level is within the object's
low-high range:

	http://marc.theaimsgroup.com/?l=selinux&m=116414826605626&w=2

These ranged objects unfortunately violate the Bell-LaPadula rules, and
can lead to information leaks. For example, a low subject may be able to
see names created in a ranged directory by a higher subject. Such ranged
directories should not be needed thanks to polyinstantiation.

The following patches attempt to get the system closer to the
Bell-LaPadula model expressed in the LSPP by permitting only "write
equal" for unprivileged subjects. The old behavior is still available by
giving attributes to the subjects that need it. (LSPP accepts privileged
programs that can override the information flow rules, so these
attributes can be given fairly liberally, but the default user types must
not have them.)

Patch 1: Rename the "mlsfilewriteinrange" attribute with no functional
changes. The reason for the renaming is that this is an object attribute
(like "mlstrustedobject"), and it's confusing to use the naming scheme
usually used for subject attributes for it. It's currently only used for
the printer device object.

Patch 2: For untrusted subjects, permit write operations on ranged
objects only when the subject effective level equals the object low
level. Introduce new subject attributes "mlsfilewriteranged" and
"mlsnetwriteranged" that give these privileged subjects the right to use
the old ranged-write behavior.

I haven't prepared a patch yet to provide interfaces for setting the new
attributes - that's easy to do once we've identified subjects that need
these privileges.

The patches are very lightly tested (the policy builds, and permits
unlabeled ssh login in enforcing mode) -- can the people doing labeled
networking tests please test it?

-Klaus

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
