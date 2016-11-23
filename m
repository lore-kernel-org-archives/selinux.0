Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uANMng5e003676
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 17:49:42 -0500
Received: by mail-qk0-f173.google.com with SMTP id n21so31682503qka.3
 for <selinux@tycho.nsa.gov>; Wed, 23 Nov 2016 14:49:41 -0800 (PST)
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.10
Date: Wed, 23 Nov 2016 17:49:39 -0500
Message-ID: <17624288.OmnOjAWxmJ@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Seven SELinux patches for v4.10, all being fixes and cleanups.  The four 
patches from Andreas are geared towards fixing problems with the GFS2/
SELinux integration, while the two from Stephen and the one from Tetsuo are 
relatively obvious and straightforward.

All of these patches pass the selinux-testsuite and merge cleanly with the 
current linux-security#next branch, please apply.

Thanks,
-Paul

---
The following changes since commit 07d9a380680d1c0eb51ef87ff2eab5c994949e69:    
                                                                                
  Linux 4.9-rc2 (2016-10-23 17:10:14 -0700)                                     
                                                                                
are available in the git repository at:                                         
                                                                                
  git://git.infradead.org/users/pcmoore/selinux stable-4.10                     
                                                                                
for you to fetch changes up to 9287aed2ad1ff1bde5eb190bcd6dccd5f1cf47d3:        
                                                                                
  selinux: Convert isec->lock into a spinlock (2016-11-22 17:44:02 -0500)       
                                                                                
----------------------------------------------------------------                
Andreas Gruenbacher (4):                                                        
      selinux: Minor cleanups                                                   
      proc: Pass file mode to proc_pid_make_inode                               
      selinux: Clean up initialization of isec->sclass                          
      selinux: Convert isec->lock into a spinlock                               
                                                                                
Stephen Smalley (2):                                                            
      selinux: normalize input to /sys/fs/selinux/enforce                       
      selinux: keep SELinux in sync with new capability definitions             
                                                                                
Tetsuo Handa (1):                                                               
      SELinux: Use GFP_KERNEL for selinux_parse_opts_str().                     
                                                                                
 fs/proc/base.c                      |  23 +++----                              
 fs/proc/fd.c                        |   6 +-                                   
 fs/proc/internal.h                  |   2 +-                                   
 fs/proc/namespaces.c                |   3 +-                                   
 security/selinux/hooks.c            | 120 +++++++++++++++++++-----------
 security/selinux/include/classmap.h |   4 ++
 security/selinux/include/objsec.h   |   5 +-
 security/selinux/selinuxfs.c        |   6 +-
 8 files changed, 97 insertions(+), 72 deletions(-)

-- 
paul moore
security @ redhat
