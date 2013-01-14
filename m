Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r0EHCdGp007890
	for <selinux@tycho.nsa.gov>; Mon, 14 Jan 2013 12:12:39 -0500
Subject: [PATCH 0/2] Fix some multiqueue TUN problems
To: netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
        selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Mon, 14 Jan 2013 12:12:06 -0500
Message-ID: <20130114170837.31874.78897.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

No significant changes to this patchset since the last posting, just a
slight merge with the recent changes in tun_set_queue() and some
Acked-by and Tested-by additions.  I believe all the concerns have been
addressed and this patch is ready for merging.

Dave, I think it makes the most sense for this to get pulled in via the
netdev tree but if you think otherwise let me know and I'll go bug
James and Eric.

-Paul

---

Paul Moore (2):
      selinux: add the "attach_queue" permission to the "tun_socket" class
      tun: fix LSM/SELinux labeling of tun/tap devices


 drivers/net/tun.c                   |   23 +++++++++++---
 include/linux/security.h            |   59 +++++++++++++++++++++++++++--------
 security/capability.c               |   24 ++++++++++++--
 security/security.c                 |   28 ++++++++++++++---
 security/selinux/hooks.c            |   50 +++++++++++++++++++++++-------
 security/selinux/include/classmap.h |    2 +
 security/selinux/include/objsec.h   |    4 ++
 7 files changed, 152 insertions(+), 38 deletions(-)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
