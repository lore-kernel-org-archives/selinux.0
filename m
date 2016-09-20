Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8KKlnYA014418
 for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2016 16:47:49 -0400
Received: by mail-qk0-f171.google.com with SMTP id t7so27604161qkh.2
 for <selinux@tycho.nsa.gov>; Tue, 20 Sep 2016 13:47:09 -0700 (PDT)
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.9 (#2)
Date: Tue, 20 Sep 2016 16:47:07 -0400
Message-ID: <1717654.Tf9ZCY68e3@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

One more SELinux patch for 4.9: a quick fix for auditing on overlayfs 
filesystems.  I just reran the testsuite and everything still looks good.  
Please apply.

Thanks,
-Paul

---
The following changes since commit 9b6a9ecc2d88ccdc57efc22d69436b9dd7e2eceb:

  selinux: fix error return code in policydb_read()
           (2016-09-13 17:14:43 -0400)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.9

for you to fetch changes up to 43af5de74288a7cdc3684902c5259346ae67adf8:

  lsm,audit,selinux: Introduce a new audit data type LSM_AUDIT_DATA_FILE
                     (2016-09-19 13:42:38 -0400)

----------------------------------------------------------------
Vivek Goyal (1):
      lsm,audit,selinux: Introduce a new audit data type LSM_AUDIT_DATA_FILE

 include/linux/lsm_audit.h |  2 ++
 security/lsm_audit.c      | 13 +++++++++++++
 security/selinux/hooks.c  | 16 ++++++++--------
 3 files changed, 23 insertions(+), 8 deletions(-)

-- 
paul moore
security @ redhat
