Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w4GBuqqm024804
 for <selinux@tycho.nsa.gov>; Wed, 16 May 2018 07:56:52 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Linux-Audit Mailing List <linux-audit@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux NetDev Upstream Mailing List <netdev@vger.kernel.org>,
 Netfilter Devel List <netfilter-devel@vger.kernel.org>,
 Linux Security Module list <linux-security-module@vger.kernel.org>,
 Integrity Measurement Architecture <linux-integrity@vger.kernel.org>,
 SElinux list <selinux@tycho.nsa.gov>
Cc: Eric Paris <eparis@redhat.com>, Paul Moore <paul@paul-moore.com>,
 Steve Grubb <sgrubb@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 David Howells <dhowells@redhat.com>, Richard Guy Briggs <rgb@redhat.com>
Date: Wed, 16 May 2018 07:55:44 -0400
Message-Id: <cover.1526430313.git.rgb@redhat.com>
Subject: [PATCH ghak81 V3 0/3] audit: group task params
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Group the audit parameters for each task into one structure.
In particular, remove the loginuid and sessionid values and the audit
context pointer from the task structure, replacing them with an audit
task information structure to contain them.  Use access functions to
access audit values.

Use dynamic allocation of the audit task information structure employing
kmem_cache.  Static allocation has the limitation that future audit task
information structure changes would cause a visible change to the rest
of the kernel, whereas dynamic allocation would mostly hide any future
changes.

Passes audit-testsuite.

Changelog:
v3
- drop patches 2, 3, 4 already merged.
- fix for previous v2 patch 3 (seccomp get audit_context)
- dynamic audit_task_info allocation from kmem_cache
- fix assignment in if statement v2 patch 1 (normalize loginuid read)
- fix a number of merge conflicts/checkpatch
v2
- p2/5: add audit header to init/init_task.c to quiet kbuildbot
- audit_signal_info(): fetch loginuid once
- remove task_struct from audit_context() param list
- remove extra task_struct local vars
- do nothing on request to set audit context when audit is disabled

Richard Guy Briggs (3):
  audit: use new audit_context access funciton for
    seccomp_actions_logged
  audit: normalize loginuid read access
  audit: collect audit task parameters

 include/linux/audit.h | 34 ++++++++++++++++-------
 include/linux/sched.h |  5 +---
 init/init_task.c      |  3 +-
 init/main.c           |  2 ++
 kernel/auditsc.c      | 77 ++++++++++++++++++++++++++++++++++++++-------------
 kernel/fork.c         |  2 +-
 6 files changed, 87 insertions(+), 36 deletions(-)

-- 
1.8.3.1
