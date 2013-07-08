From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov, waiman.long@hp.com
Subject: Follow-up on the lblnet-next tree
Date: Mon, 08 Jul 2013 15:28:11 -0400
Message-ID: <5389823.3HQRbeCOef@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a quick follow-up to my emails from earlier today; I've built/booted the 
lblnet-next tree on Fedora Rawhide and didn't see anything catastrophic, but 
further testing is always welcome.  I also talked with Eric and he promised 
that once 3.11-rc1 is released he will do a push the tree to James.  If he 
doesn't, I promise to hunt him down and tar/feather him ;)

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_next
 * http://git.infradead.org/users/pcmoore/lblnet-2.6_next

Paul Moore (9):
      selinux: fix problems in netnode when BUG() is compiled out
      lsm: split the xfrm_state_alloc_security() hook implementation
      selinux: cleanup and consolidate the XFRM alloc/clone/delete/free code
      selinux: cleanup selinux_xfrm_policy_lookup() and ...
      selinux: cleanup selinux_xfrm_sock_rcv_skb() and ...
      selinux: cleanup some comment and whitespace issues in the XFRM code
      selinux: cleanup selinux_xfrm_decode_session()
      selinux: cleanup the XFRM header
      selinux: remove the BUG_ON() from selinux_skb_xfrm_sid()

Stephen Smalley (1):
      SELinux: Enable setting security contexts on rootfs inodes.

Waiman Long (1):
      SELinux: Reduce overhead of mls_level_isvalid() function call


 include/linux/security.h        |   26 ++
 security/capability.c           |   15 +
 security/security.c             |   13 -
 security/selinux/hooks.c        |   18 +-
 security/selinux/include/xfrm.h |   45 ++--
 security/selinux/netnode.c      |    2
 security/selinux/ss/ebitmap.c   |   20 ++
 security/selinux/ss/ebitmap.h   |    2
 security/selinux/ss/mls.c       |   22 +-
 security/selinux/ss/mls_types.h |    2
 security/selinux/xfrm.c         |  453 ++++++++++++++++---------------------
 11 files changed, 298 insertions(+), 320 deletions(-)

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
