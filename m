Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t2QA39o6013242
 for <selinux@tycho.nsa.gov>; Thu, 26 Mar 2015 06:03:09 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Subject: [GIT PULL] SELinux fixes for 3.20 #2
Date: Thu, 26 Mar 2015 06:02:59 -0400
Message-ID: <1476299.dB92YccQxo@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Just a single small, but important, patch that fixes a long standing bug in 
SELinux.  Please pull for v3.20.

Thanks,
-Paul

---
The following changes since commit 04f81f0154e4bf002be6f4d85668ce1257efa4d9:    
                                                                                
  cipso: don't use IPCB() to locate the CIPSO IP option
         (2015-02-11 14:46:37 -0500)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux upstream

for you to fetch changes up to 6436a123a147db51a0b06024a8350f4c230e73ff:

  selinux: fix sel_write_enforce broken return value
           (2015-03-25 16:55:06 -0400)

----------------------------------------------------------------
Joe Perches (1):
      selinux: fix sel_write_enforce broken return value

 security/selinux/selinuxfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
paul moore
security @ redhat
