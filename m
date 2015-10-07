Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t97N8ml1015981
 for <selinux@tycho.nsa.gov>; Wed, 7 Oct 2015 19:08:50 -0400
Subject: [RFC PATCH v3 0/5] kdbus LSM/SELinux hooks
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org, linux-audit@redhat.com,
 selinux@tycho.nsa.gov
Cc: Paul Osmialowski <p.osmialowsk@samsung.com>
Date: Wed, 07 Oct 2015 19:08:16 -0400
Message-ID: <20151007230615.7823.74519.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

No real functional improvements since the v2 patchset earlier this
week, the main update is rebasing on GregKH's current kdbus tree
which is now 4.3-rc4 based and as a result brings the LSM stacking
changes and SELinux ioctl/xperm additions.

---

Paul Moore (5):
      kdbus: add creator credentials to the endpoints
      lsm: introduce hooks for kdbus
      lsm: add support for auditing kdbus service names
      selinux: introduce kdbus names into the policy
      selinux: introduce kdbus access controls

 include/linux/lsm_audit.h           |    2 
 include/linux/lsm_hooks.h           |   63 ++++++++++++++
 include/linux/security.h            |   71 ++++++++++++++++
 ipc/kdbus/bus.c                     |   13 +--
 ipc/kdbus/connection.c              |   73 +++++++++++------
 ipc/kdbus/endpoint.c                |   14 +--
 ipc/kdbus/endpoint.h                |    3 -
 ipc/kdbus/fs.c                      |   10 ++
 ipc/kdbus/message.c                 |   19 +++-
 ipc/kdbus/metadata.c                |    6 -
 ipc/kdbus/node.c                    |   11 +--
 ipc/kdbus/node.h                    |    5 +
 security/lsm_audit.c                |    4 +
 security/security.c                 |   62 ++++++++++++++
 security/selinux/hooks.c            |  153 +++++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |    4 +
 security/selinux/include/security.h |    5 +
 security/selinux/ss/policydb.c      |   88 ++++++++++++++++----
 security/selinux/ss/policydb.h      |    3 -
 security/selinux/ss/services.c      |   38 +++++++++
 20 files changed, 561 insertions(+), 86 deletions(-)
