Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t95KfAfd000795
 for <selinux@tycho.nsa.gov>; Mon, 5 Oct 2015 16:41:10 -0400
Subject: [RFC PATCH v2 0/5] kdbus LSM/SELinux hooks
From: Paul Moore <pmoore@redhat.com>
To: linux-security-module@vger.kernel.org
Cc: linux-audit@redhat.com, selinux@tycho.nsa.gov
Date: Mon, 05 Oct 2015 16:41:06 -0400
Message-ID: <20151005203358.32023.88592.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I got a little distracted with some other tasks so it has taken me a
bit longer than I had hoped to get v2 of this patchset out, but
better late than never they say ...

This revision incorporates all of Stephen's comments and adds support
for auditing kdbus service names; see each patch's changelog for more
details.  Please take a look and comment, I'm especially interested
to hear what people have to say about the kdbusfs labeling, right now
it is very barebones, and I'm not sure if we want to support more
options (transitions, etc.).

Also, Smack folks, it would be great if I heard something from you
guys about the viability of these hooks for Smack.

---

Paul Moore (5):
      kdbus: add creator credentials to the endpoints
      lsm: introduce hooks for kdbus
      lsm: add support for auditing kdbus service names
      selinux: introduce kdbus names into the policy
      selinux: introduce kdbus access controls


 include/linux/lsm_audit.h           |    2 
 include/linux/security.h            |  126 +++++++++++++++++++++++++++++
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
 security/security.c                 |   50 ++++++++++++
 security/selinux/hooks.c            |  152 +++++++++++++++++++++++++++++++++++
 security/selinux/include/classmap.h |    4 +
 security/selinux/include/security.h |    5 +
 security/selinux/ss/policydb.c      |   88 +++++++++++++++++---
 security/selinux/ss/policydb.h      |    3 -
 security/selinux/ss/services.c      |   38 +++++++++
 19 files changed, 540 insertions(+), 86 deletions(-)
