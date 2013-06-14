Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5EJ3Yfo020672
	for <selinux@tycho.nsa.gov>; Fri, 14 Jun 2013 15:03:34 -0400
Subject: [PATCH 0/8] Labeled IPsec cleanups
To: linux-security-module@vger.kernel.org, selinux@tycho.nsa.gov
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 14 Jun 2013 15:03:31 -0400
Message-ID: <20130614185950.30803.17359.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

The SELinux labeled IPsec has languished for a few years without any
housekeeping, this patchset attempts to tidy up the code and sweep
away the dust bunnies hiding in the corners.

Most of the patchset is fairly trivial with the exception of the first
patch (1/8) which has some substance to it but doesn't actually affect
the behavior of the labeled IPsec code, it just makes it more sensible.

---

Paul Moore (8):
      lsm: split the xfrm_state_alloc_security() hook implementation
      selinux: cleanup and consolidate the XFRM alloc/clone/delete/free code
      selinux: cleanup selinux_xfrm_policy_lookup() and selinux_xfrm_state_pol_flow_match()
      selinux: cleanup selinux_xfrm_sock_rcv_skb() and selinux_xfrm_postroute_last()
      selinux: cleanup some comment and whitespace issues in the XFRM code
      selinux: cleanup selinux_xfrm_decode_session()
      selinux: cleanup the XFRM header
      selinux: remove the BUG_ON() from selinux_skb_xfrm_sid()


 include/linux/security.h        |   26 ++
 security/capability.c           |   15 +
 security/security.c             |   13 -
 security/selinux/hooks.c        |   11 +
 security/selinux/include/xfrm.h |   45 ++--
 security/selinux/xfrm.c         |  453 +++++++++++++++++----------------------
 6 files changed, 262 insertions(+), 301 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
