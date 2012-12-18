Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id qBIMsaaD020230
	for <selinux@tycho.nsa.gov>; Tue, 18 Dec 2012 17:54:37 -0500
Subject: [RFC PATCH v3 0/2] Fix some multiqueue TUN problems
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com
Date: Tue, 18 Dec 2012 17:53:37 -0500
Message-ID: <20121218225001.16104.34454.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A refresh/respin of the LSM/SELinux fixes to work on top of Jason's
latest API tweak (now living in DaveM's net tree).  In general, I
believe the hooks and thinking behind the v2 patchset still make sense
so no changes there, although I did change the SELinux permission from
"create_queue" to "attach_queue" to match the API changes.

Comments are welcome and encouraged; we need to get this fixed before
3.8 is released.

---

Paul Moore (2):
      selinux: add the "attach_queue" permission to the "tun_socket" class
      tun: fix LSM/SELinux labeling of tun/tap devices


 drivers/net/tun.c                   |   27 ++++++++++++----
 include/linux/security.h            |   59 +++++++++++++++++++++++++++--------
 security/capability.c               |   24 ++++++++++++--
 security/security.c                 |   28 ++++++++++++++---
 security/selinux/hooks.c            |   50 +++++++++++++++++++++++-------
 security/selinux/include/classmap.h |    2 +
 security/selinux/include/objsec.h   |    4 ++
 7 files changed, 155 insertions(+), 39 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
