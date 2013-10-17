Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r9HDGCsA007985
	for <selinux@tycho.nsa.gov>; Thu, 17 Oct 2013 09:16:12 -0400
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux updates for 3.12
Date: Thu, 17 Oct 2013 09:15:49 -0400
Message-ID: <2307607.HXDCGv9Ccf@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi James,

Here are a collection of SELinux updates that should be included in 3.12.  
This request contains mostly various cleanup patches with a few bugfixes and 
performance improvements thrown in for good measure.  The bulk of these 
patches were inherited from Eric's old tree, hence the merge/pull in the log.

Lastly, all of these patches have been in linux-next for some time now, and 
they all pass the SELinux testsuite with flying colors.

Enjoy,
-Paul

---
The following changes since commit 6e4664525b1db28f8c4e1130957f70a94c19213e:

  Linux 3.11 (2013-09-02 13:46:10 -0700)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux

for you to fetch changes up to 42d64e1add3a1ce8a787116036163b8724362145:

  selinux: correct locking in selinux_netlbl_socket_connect) 
           (2013-09-26 17:00:46 -0400)

----------------------------------------------------------------
Anand Avati (1):
      selinux: consider filesystem subtype in policies

Chris PeBenito (1):
      Add SELinux policy capability for always checking packet and peer 
classes.

Duan Jiong (1):
      selinux: Use kmemdup instead of kmalloc + memcpy

Eric Paris (12):
      SELinux: fix selinuxfs policy file on big endian systems
      SELinux: remove crazy contortions around proc
      SELinux: make it harder to get the number of mnt opts wrong
      SELinux: use define for number of bits in the mnt flags mask
      SELinux: rename SE_SBLABELSUPP to SBLABEL_MNT
      SELinux: do all flags twiddling in one place
      SELinux: renumber the superblock options
      SELinux: change sbsec->behavior to short
      SELinux: do not handle seclabel as a special flag
      SELinux: pass a superblock to security_fs_use
      SELinux: use a helper function to determine seclabel
      Revert "SELinux: do not handle seclabel as a special flag"

Paul Moore (12):
      lsm: split the xfrm_state_alloc_security() hook implementation
      selinux: cleanup and consolidate the XFRM alloc/clone/delete/free code
      selinux: cleanup selinux_xfrm_policy_lookup() and         
               selinux_xfrm_state_pol_flow_match()
      selinux: cleanup selinux_xfrm_sock_rcv_skb() and
               selinux_xfrm_postroute_last()
      selinux: cleanup some comment and whitespace issues in the XFRM code
      selinux: cleanup selinux_xfrm_decode_session()
      selinux: cleanup the XFRM header
      selinux: remove the BUG_ON() from selinux_skb_xfrm_sid()
      selinux: fix problems in netnode when BUG() is compiled out
      Merge git://git.infradead.org/users/eparis/selinux
      selinux: add Paul Moore as a SELinux maintainer
      selinux: correct locking in selinux_netlbl_socket_connect)

Stephen Smalley (1):
      SELinux: Enable setting security contexts on rootfs inodes.

Waiman Long (2):
      SELinux: Reduce overhead of mls_level_isvalid() function call
      SELinux: Increase ebitmap_node size for 64-bit configuration

 MAINTAINERS                         |   3 +-
 include/linux/security.h            |  26 ++-
 security/capability.c               |  15 +-
 security/security.c                 |  13 +-
 security/selinux/hooks.c            | 146 +++++++-----
 security/selinux/include/objsec.h   |   4 +-
 security/selinux/include/security.h |  13 +-
 security/selinux/include/xfrm.h     |  45 ++--
 security/selinux/netlabel.c         |   6 +-
 security/selinux/netnode.c          |   2 +
 security/selinux/selinuxfs.c        |   4 +-
 security/selinux/ss/ebitmap.c       |  20 +-
 security/selinux/ss/ebitmap.h       |  10 +-
 security/selinux/ss/mls.c           |  22 +-
 security/selinux/ss/mls_types.h     |   2 +-
 security/selinux/ss/policydb.c      |   3 +-
 security/selinux/ss/services.c      |  66 ++++--
 security/selinux/xfrm.c             | 453 +++++++++++++++-------------------
 18 files changed, 452 insertions(+), 401 deletions(-)

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
