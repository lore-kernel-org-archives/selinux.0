Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7PLCTOa017948
	for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2009 17:12:29 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n7PLDdDB025888
	for <selinux@tycho.nsa.gov>; Tue, 25 Aug 2009 21:13:39 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [RFC PATCH v1 0/2] Policy support for the new TUN hooks
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Date: Tue, 25 Aug 2009 17:12:26 -0400
Message-ID: <20090825210647.6250.56266.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

These patches are my first attempt at drafting policy for the new TUN hooks,
any comments or feedback you have would be great.  It is worth noting that
permission to create/attach to TUN/TAP devices was not granted to every
domain that has r/w access to the /dev/net/tun device as the operations are
very different; r/w access to /dev/net/tun does not mean the domain needs
the ability to create/attach TUN/TAP devices.

I've done some basic testing but I'm not having a lot of luck running the
current refpolicy on Fedora/Rawhide (unfortunately refpolicy and the current
Rawhide policy diverge quite a bit in a few important areas touched by these
patches), if anyone has any tips I'd love to hear them.

---

Paul Moore (2):
      refpol: Policy for the new TUN driver access controls
      refpol: Add the "tun_socket" object class flask definitions


 policy/flask/access_vectors         |    2 ++
 policy/flask/security_classes       |    2 ++
 policy/modules/admin/vpn.te         |    1 +
 policy/modules/apps/qemu.if         |    3 +++
 policy/modules/apps/uml.te          |    3 +++
 policy/modules/services/openvpn.te  |    1 +
 policy/modules/services/virt.if     |   19 +++++++++++++++++++
 policy/modules/services/virt.te     |    1 +
 policy/modules/system/userdomain.if |   23 +++++++++++++++++++++++
 policy/modules/system/userdomain.te |    2 ++
 policy/modules/system/xen.te        |    1 +
 11 files changed, 58 insertions(+), 0 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
