Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qB5KQPHC011854
	for <selinux@tycho.nsa.gov>; Wed, 5 Dec 2012 15:26:29 -0500
Subject: [RFC PATCH v2 0/3] Fix some multiqueue TUN problems
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com
Date: Wed, 05 Dec 2012 15:25:56 -0500
Message-ID: <20121205202144.18626.61966.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Second draft of the LSM/SELinux fixes to the upcoming multiqueue TUN
functionality.  This draft incorporates all the comments/decisions
from the first draft, notably the new LSM and SELinux hook for the
TUNSETQUEUE operation.  Other LSMs do not provide TUN controls so they
are not affected.

Once we decide this is the right approach I'll push the associated
SELinux policy FLASK definitions upstream; for those who are interested
the SELinux policy diff in included in the description of patch 1/2.

I don't expect this to be the final patch, just a starting point for
further discussion so I didn't really do any testing, simply making
sure that it compiled cleanly.

---

Paul Moore (3):
      tun: correctly report an error in tun_flow_init()
      selinux: add the "create_queue" permission to the "tun_socket" class
      tun: fix LSM/SELinux labeling of tun/tap devices


 drivers/net/tun.c                   |   29 +++++++++++++----
 include/linux/security.h            |   59 +++++++++++++++++++++++++++--------
 security/capability.c               |   24 ++++++++++++--
 security/security.c                 |   28 ++++++++++++++---
 security/selinux/hooks.c            |   50 +++++++++++++++++++++++-------
 security/selinux/include/classmap.h |    2 +
 security/selinux/include/objsec.h   |    4 ++
 7 files changed, 156 insertions(+), 40 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
