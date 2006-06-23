Subject: [PATCH 0/10] Optionals in base take 2
From: Joshua Brindle <jbrindle@tresys.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Fri, 23 Jun 2006 10:51:54 -0400
Message-Id: <1151074315.4011.66.camel@twoface.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset addresses the issues encountered when optionals in base
were enabled. There are also unit tests which are large so I'll send
them separately. Several major things had to be done to correctly
support optionals in base including a slight format change in the linked
policy (which is never used) so that aliases have their own value and
the primary field has the value of the primary type. The linking
algorithm has also changed to address mutually dependent optionals not
being turned on. There are also unrelated bug fixes and memory leak
fixes included.

An sediff between the source and a binary created with this toolchain
has no diffs. This toolchain will not build the released refpolicy or
the fc5 policy because of a duplicate type_trans rule, this is fixed in
the refpolicy svn trunk.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
