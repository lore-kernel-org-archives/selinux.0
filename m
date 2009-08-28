Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7SLD28M027449
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 17:13:02 -0400
Received: from g4t0014.houston.hp.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7SLCR5q008041
	for <selinux@tycho.nsa.gov>; Fri, 28 Aug 2009 21:12:27 GMT
From: Paul Moore <paul.moore@hp.com>
Subject: [PATCH 0/2] Policy support for the new TUN hooks
To: selinux@tycho.nsa.gov, refpolicy@oss1.tresys.com
Date: Fri, 28 Aug 2009 17:13:00 -0400
Message-ID: <20090828211039.2821.58710.stgit@flek.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Second, and hopefully final, version of the SELinux policy for the new TUN
hooks.  This version includes all the feedback from Chris discussed on the
list as well as my sign-off.

---

Paul Moore (2):
      refpol: Policy for the new TUN driver access controls
      refpol: Add the "tun_socket" object class flask definitions


 policy/flask/access_vectors         |    2 ++
 policy/flask/security_classes       |    2 ++
 policy/modules/admin/vpn.te         |    1 +
 policy/modules/apps/qemu.if         |    3 +++
 policy/modules/apps/uml.te          |    6 ++++++
 policy/modules/services/openvpn.te  |    1 +
 policy/modules/services/virt.if     |   19 +++++++++++++++++++
 policy/modules/services/virt.te     |    1 +
 policy/modules/system/userdomain.if |   23 +++++++++++++++++++++++
 policy/modules/system/userdomain.te |    2 ++
 10 files changed, 60 insertions(+), 0 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
