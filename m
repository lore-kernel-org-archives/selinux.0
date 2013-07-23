From: Paul Moore <pmoore@redhat.com>
To: selinux@tycho.nsa.gov, Eric Paris <eparis@redhat.com>
Cc: sds@tycho.nsa.gov, waiman.long@hp.com
Subject: Follow-up on the lblnet-next tree
Date: Tue, 23 Jul 2013 18:05:03 -0400
Message-ID: <3261672.EsmV8HmHXd@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a quick follow-up to let you know that I've rebased the lblnet-next tree 
to Linus' post -rc2 tree from earlier today.  I did a quick build/boot/test 
cycle and everything looked sane to me, but additional testing is always 
welcome.

 * git://git.infradead.org/users/pcmoore/lblnet-2.6_next
 * http://git.infradead.org/users/pcmoore/lblnet-2.6_next

The lblnet-next tree contents:

Eric Paris (1):
      SELinux: fix selinuxfs policy file on big endian systems

Paul Moore (9):
      selinux: fix problems in netnode when BUG() is compiled out
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

Stephen Smalley (1):
      SELinux: Enable setting security contexts on rootfs inodes.

Waiman Long (2):
      SELinux: Reduce overhead of mls_level_isvalid() function call
      SELinux: Increase ebitmap_node size for 64-bit configuration


 include/linux/security.h        |   26 ++
 security/capability.c           |   15 +
 security/security.c             |   13 -
 security/selinux/hooks.c        |   18 +-
 security/selinux/include/xfrm.h |   45 ++--
 security/selinux/netnode.c      |    2 
 security/selinux/ss/ebitmap.c   |   20 ++
 security/selinux/ss/ebitmap.h   |   10 +
 security/selinux/ss/mls.c       |   22 +-
 security/selinux/ss/mls_types.h |    2 
 security/selinux/ss/policydb.c  |    3 
 security/selinux/xfrm.c         |  453 ++++++++++++++++---------------------
 12 files changed, 306 insertions(+), 323 deletions(-)

-- 
paul moore
security and virtualization @ redhat


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
