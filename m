Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6O5cL2I022616
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 01:38:22 -0400
Received: from tyo202.gate.nec.co.jp (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6O5cJ1N004125
	for <selinux@tycho.nsa.gov>; Thu, 24 Jul 2008 05:38:20 GMT
Message-ID: <48881546.6070903@ak.jp.nec.com>
Date: Thu, 24 Jul 2008 14:38:14 +0900
From: KaiGai Kohei <kaigai@ak.jp.nec.com>
MIME-Version: 1.0
To: Joshua Brindle <jbrindle@tresys.com>
CC: selinux@tycho.nsa.gov
Subject: hierarchy_check_constraints() needs reworks?
Content-Type: text/plain; charset=ISO-2022-JP
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I found out that hierarchy_check_constraints() in libsepol
does not work correctly, as follows:

---- example: foo.te ----
module foo 1.0;

require {
        class file { read write getattr setattr ioctl };
};

type src;
type src.child;
type tgt;

allow src       tgt : file { read write };
allow src.child tgt : file { read write getattr setattr };
----------
[root@fedora9 kaigai]# checkmodule -m -M foo.te -o foo.mod
checkmodule:  loading policy configuration from foo.te
checkmodule:  policy configuration loaded
checkmodule:  writing binary representation (version 8) to foo.mod
[root@fedora9 kaigai]# /usr/sbin/semodule -i foo.pp
[root@fedora9 kaigai]#

The "foo.te" can make a hierarchy constraint violation, but we got
no assertion in this case.

I inject several printf()s to show internal state, and it shows me
the given p->te_avtab is empty, so no checks are applied. :-(
Now, I'm tracing it more.


In addition, I found two more potential matter in this code.

The first one is lack of checks for permissions via attribute.
When a child domain has an attribute which does not applied to
the parent one, the child can have wider permissions that its
parent.
I think any attribute attached to child domain also have to be
attached to the parent domain.
(I guess it derived from legacy attribute implementation.)

The later one is dependencies to the state of boolean.
Hierarchy constraint allows a child domain to have permissions
which are enabled for the parent, only if specific boolean is
turned on. It potentially makes a situation that child domain
has wider permissions.
I think it is difficult to check in the policy toolchain, so
checks on an avc entry creation is better way.

Any comment?

Thanks,
-- 
OSS Platform Development Division, NEC
KaiGai Kohei <kaigai@ak.jp.nec.com>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
