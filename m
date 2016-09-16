Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8GKkTRS008926
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 16:46:29 -0400
Received: by mail-yb0-f173.google.com with SMTP id x93so57139865ybh.1
 for <selinux@tycho.nsa.gov>; Fri, 16 Sep 2016 13:46:28 -0700 (PDT)
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.9
Date: Fri, 16 Sep 2016 16:46:26 -0400
Message-ID: <1824970.e99tEti4sB@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Hi James,

Another big set of SELinux patches for the 4.9 release.  The most significant 
patches are the seven from Vivek which add overlayfs support, but the other 
seven patches do a lot of nice things including additional policy sanity 
checking, bug fixing, and the removal of 
SECURITY_SELINUX_POLICYDB_VERSION_MAX.

All of these patches pass the selinux-testsuite and merge cleanly with the 
current linux-security#next branch, please apply.

Thanks,
-Paul

---
The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:    
                                                                                
  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)                                     
                                                                                
are available in the git repository at:                                         
                                                                                
  git://git.infradead.org/users/pcmoore/selinux stable-4.9                      
                                                                                
for you to fetch changes up to 9b6a9ecc2d88ccdc57efc22d69436b9dd7e2eceb:        
                                                                                
  selinux: fix error return code in policydb_read()
           (2016-09-13 17:14:43 -0400) 
                                                                                
----------------------------------------------------------------                
Javier Martinez Canillas (1):                                                   
      security: Use IS_ENABLED() instead of checking for built-in or module     
                                                                                
Vivek Goyal (7):                                                                
      security, overlayfs: provide copy up security hook for unioned files      
      selinux: Implementation for inode_copy_up() hook                          
      security,overlayfs: Provide security hook for copy up of xattrs
              for overlay file                                                                          
      selinux: Implementation for inode_copy_up_xattr() hook                    
      selinux: Pass security pointer to determine_inode_label()                 
      security, overlayfs: Provide hook to correctly label newly created
              files  
      selinux: Implement dentry_create_files_as() hook                          
                                                                                
Wei Yongjun (1):                                                                
      selinux: fix error return code in policydb_read()                         
                                                                                
William Roberts (5):                                                            
      selinux: print leading 0x on ioctlcmd audits                              
      selinux: drop SECURITY_SELINUX_POLICYDB_VERSION_MAX                       
      selinux: detect invalid ebitmap                                           
      selinux: initialize structures                                            
      selinux: fix overflow and 0 length allocations                            
                                                                                
 fs/overlayfs/copy_up.c              | 22 +++++++++                             
 fs/overlayfs/dir.c                  | 10 +++++                                 
 include/linux/lsm_hooks.h           | 36 +++++++++++++++                       
 include/linux/security.h            | 24 ++++++++++                            
 security/lsm_audit.c                |  4 +-                                    
 security/security.c                 | 27 +++++++++++                           
 security/selinux/Kconfig            | 38 ----------------                      
 security/selinux/hooks.c            | 90 +++++++++++++++++++++++++++------ 
 security/selinux/include/security.h |  4 --                                    
 security/selinux/ss/conditional.c   |  2 +                                     
 security/selinux/ss/ebitmap.c       |  3 ++                                    
 security/selinux/ss/policydb.c      | 12 +++--                                 
 security/smack/smack_netfilter.c    |  4 +-                                    
 13 files changed, 211 insertions(+), 65 deletions(-)

-- 
paul moore
security @ redhat
