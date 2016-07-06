Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u66KVS5n027222
 for <selinux@tycho.nsa.gov>; Wed, 6 Jul 2016 16:31:28 -0400
Received: by mail-qk0-f178.google.com with SMTP id t127so325438021qkf.1
 for <selinux@tycho.nsa.gov>; Wed, 06 Jul 2016 13:31:27 -0700 (PDT)
From: Paul Moore <pmoore@redhat.com>
To: James Morris <jmorris@namei.org>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Subject: [GIT PULL] SELinux patches for 4.8
Date: Wed, 06 Jul 2016 16:31:25 -0400
Message-ID: <3578981.542aY96mi8@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Unsubscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/options/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=unsubscribe>
List-Archive: <http://prometheus.infosec.tycho.ncsc.mil/pipermail/selinux/>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>
List-Subscribe: <http://prometheus.infosec.tycho.ncsc.mil/mailman/listinfo/selinux>,
 <mailto:selinux-request@tycho.nsa.gov?subject=subscribe>

Hi James,

A big set of SELinux related patches for 4.8, 25 in total, although 19 are due 
to the new RFC5570/CALIPSO implementation.  Beyond the CALIPSO patches (all 
the patches from Huw Davies) we have improvements to the SELinux bounded 
domain transitions, fixes for AF_UICV sockets and NetLabel, and a small type 
mismatch correction.

All these patches pass the selinux-testsuite and have been included in the 
pcmoore/kernel-secnext COPR kernel builds for some time.  The CALIPSO patches 
have also been tested against Solaris TX for interoperability and I've cleared 
them with DaveM for merging via the SELinux tree.  Please apply.

Thanks,
-Paul

---
The following changes since commit b937190c40de0f6f07f592042e3097b16c6b0130:

  LSM: LoadPin: provide enablement CONFIG (2016-05-17 20:10:30 +1000)

are available in the git repository at:

  git://git.infradead.org/users/pcmoore/selinux stable-4.8

for you to fetch changes up to 3f09354ac84c6904787189d85fb306bf60f714b8:

  netlabel: Implement CALIPSO config functions for SMACK.
    (2016-06-27 15:06:18 -0400)

----------------------------------------------------------------
Heinrich Schuchardt (1):
      selinux: fix type mismatch

Huw Davies (19):
      netlabel: Mark rcu pointers with __rcu.
      netlabel: Add an address family to domain hash entries.
      netlabel: Initial support for the CALIPSO netlink protocol.
      netlabel: Add support for querying a CALIPSO DOI.
      netlabel: Add support for enumerating the CALIPSO DOI list.
      netlabel: Add support for creating a CALIPSO protocol domain mapping.
      netlabel: Add support for removing a CALIPSO DOI.
      ipv6: Add ipv6_renew_options_kern() that accepts a kernel mem pointer.
      netlabel: Move bitmap manipulation functions to the NetLabel core.
      calipso: Set the calipso socket label to match the secattr.
      netlabel: Prevent setsockopt() from changing the hop-by-hop option.
      ipv6: Allow request socks to contain IPv6 options.
      calipso: Allow request sockets to be relabelled by the lsm.
      ipv6: constify the skb pointer of ipv6_find_tlv().
      calipso: Allow the lsm to label the skbuff directly.
      netlabel: Pass a family parameter to netlbl_skbuff_err().
      calipso: Add validation of CALIPSO option.
      calipso: Add a label cache.
      netlabel: Implement CALIPSO config functions for SMACK.

Paul Moore (4):
      netlabel: add address family checks to netlbl_{sock,req}_delattr()
      iucv: properly clone LSM attributes to newly created child sockets
      selinux: import NetLabel category bitmaps correctly
      netlabel: handle sparse category maps in netlbl_catmap_getlong()

Stephen Smalley (1):
      selinux: Only apply bounds checking to source types

 include/net/calipso.h               |   91 +++
 include/net/inet_sock.h             |    7 +-
 include/net/ipv6.h                  |   10 +-
 include/net/netlabel.h              |  101 ++-
 include/uapi/linux/audit.h          |    2 +
 include/uapi/linux/in6.h            |    1 +
 net/dccp/ipv6.c                     |   12 +-
 net/ipv4/cipso_ipv4.c               |   88 +--
 net/ipv4/tcp_input.c                |    3 +
 net/ipv6/Makefile                   |    1 +
 net/ipv6/af_inet6.c                 |    9 +-
 net/ipv6/calipso.c                  | 1473 +++++++++++++++++++++++++++++++++
 net/ipv6/exthdrs.c                  |   76 ++
 net/ipv6/exthdrs_core.c             |    2 +-
 net/ipv6/ipv6_sockglue.c            |    1 -
 net/ipv6/sysctl_net_ipv6.c          |   19 +
 net/ipv6/tcp_ipv6.c                 |   12 +-
 net/iucv/af_iucv.c                  |    5 +-
 net/netlabel/Kconfig                |    1 +
 net/netlabel/Makefile               |    2 +-
 net/netlabel/netlabel_calipso.c     |  740 ++++++++++++++++++
 net/netlabel/netlabel_calipso.h     |  151 ++++
 net/netlabel/netlabel_domainhash.c  |  293 +++++--
 net/netlabel/netlabel_domainhash.h  |   17 +-
 net/netlabel/netlabel_kapi.c        |  394 +++++++++-
 net/netlabel/netlabel_mgmt.c        |   85 +-
 net/netlabel/netlabel_mgmt.h        |   27 +-
 net/netlabel/netlabel_unlabeled.c   |    5 +-
 net/netlabel/netlabel_user.c        |    5 +
 security/selinux/hooks.c            |   21 +-
 security/selinux/include/netlabel.h |    4 +-
 security/selinux/netlabel.c         |   36 +-
 security/selinux/selinuxfs.c        |    2 +-
 security/selinux/ss/ebitmap.c       |    2 +-
 security/selinux/ss/services.c      |   70 +-
 security/smack/smack_lsm.c          |    2 +-
 36 files changed, 3511 insertions(+), 259 deletions(-)
 create mode 100644 include/net/calipso.h
 create mode 100644 net/ipv6/calipso.c
 create mode 100644 net/netlabel/netlabel_calipso.c
 create mode 100644 net/n

-- 
paul moore
security @ redhat
