Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8NLi8Yb032688
 for <selinux@tycho.nsa.gov>; Wed, 23 Sep 2015 17:44:11 -0400
Subject: [RFC PATCH v1 0/3] Another take on the kdbus LSM hooks
From: Paul Moore <pmoore@redhat.com>
To: Paul Osmialowski <p.osmialowsk@samsung.com>,
 linux-security-module@vger.kernel.org,
 Lukasz Pawelczyk <l.pawelczyk@samsung.com>, selinux@tycho.nsa.gov
Date: Wed, 23 Sep 2015 17:44:06 -0400
Message-ID: <20150923213043.25616.43422.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

A different take on the previous kdbus LSM hooks, intended to be much
simpler and more in line with what we currently do for binder and
other IPC mechanisms.  This patchset has three patches, the first
patch contains the LSM hooks and the last two patches are SELinux
specific implementations of those hooks.  Paul/Lukasz, please take a
look and see if this simplified set of hooks works for you; I'm hoping
it will.

This patchset is based of Greg's char-misc#kdbus tree which is a
little out of date with respect to LSM development, but that shouldn't
be a problem at this early stage of review.

I've intentionally only sent this to the SELinux and LSM list for the
time being; once we resolve our own concerns with the different
approaches we can start including the kdbus developers and other
relevant lists.  I'm also hoping that once we have a patchset which
contains the necessary SELinux/Smack/etc. support we can push this to
Greg for inclusion in the kdbus branch so we have at least some
kdbus/LSM support if/when kdbus is ever merged into Linus' tree.

You can find these patches in the working-kdbus-v1 branch of the
SELinux tree:

 * git://git.infradead.org/users/pcmoore/selinux

---

Paul Moore (3):
      lsm: introduce hooks for kdbus
      selinux: introduce kdbus names into the policy
      selinux: introduce kdbus access controls


 include/linux/security.h            |  113 +++++++++++++++++++++++++++++++++
 ipc/kdbus/connection.c              |   73 ++++++++++++++-------
 ipc/kdbus/message.c                 |   19 ++++-
 ipc/kdbus/metadata.c                |    6 +-
 security/security.c                 |   45 +++++++++++++
 security/selinux/hooks.c            |  121 ++++++++++++++++++++++++++++++++++-
 security/selinux/include/classmap.h |    4 +
 security/selinux/include/security.h |    6 +-
 security/selinux/ss/policydb.c      |   59 +++++++++++++++++
 security/selinux/ss/policydb.h      |    3 +
 security/selinux/ss/services.c      |   38 +++++++++++
 11 files changed, 449 insertions(+), 38 deletions(-)
