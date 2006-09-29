Message-ID: <451C85C9.4020804@trustedcs.com>
Date: Thu, 28 Sep 2006 21:32:41 -0500
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: selinux@tycho.nsa.gov, jmorris@namei.org, sds@tycho.nsa.gov,
        paul.moore@hp.com
Subject: [PATCH 0/7] secid reconciliation-v03: Repost patchset with updates
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patchset is relative to davem's net-2.6.git

The following are the changes included in this patchset since the previous post:

- Retain secmark (from the originating socket/flow) on loopback traffic;
  this traffic is now flow controlled on the outbound only.

- When multiple iptables labeling rules are present (e.g.: both on PREROUTING and INPUT)
	INBOUND: The label in the last rule will prevail.
	OUTBOUND: secmark (from the originating socket) is flow-controlled against
		the label on the first rule, and, if it passes, the label on the
		first rule overrides the secmark (from the originating socket).
		This secmark is flow controlled against labels on the subsequent
		rules, each time, overridden by those labels.

- Forwarded packets: The FORWARD chain is treated as an outbound chain for flow
  control purposes. e.g: label with PREROUTING and flow-control with FORWARD or
  POSTROUTING.

- Simplification of the flow_out hook for SELinux: deleted the redundant flow_out
  check against the xfrm secid and the transition between the xfrm secid and the
  netfilter secid.

- SELinux postroute_last hook: unfortunately, the secmark Vs. UNLABELED SID check
  will now be done for ALL traffic (I couldn't except traffic already processed
  by (CONN)SECMARK outbound rules; a better understanding of iptabels resulted
  in realizing that the SECSID_WILD thing attempted in the previous patchset won't
  work well).

Please consider for inclusion in 2.6.19.


PATCHES TO BE POSTED BY COB FRIDAY (tomorrow):

NOTE: These patches were originally planned/desired to be included in this set
but I didn't want to hold this critical patchset up for one more day since
it needs a good extensive review.

- Create IPSec SAs to be acquired with the creating sock's context as opposed
  to that of the matching SPD rule, resulting in a simpler SPD as well as policy.
- Set peer_sid on tcp sockets to the reconciled secmark so trusted applications
  can retrieve and service the data at the appropriate context.

 include/linux/security.h                     |   35 ++++
 include/linux/skbuff.h                       |   29 +++
 include/net/ip.h                             |   32 ++++
 include/net/request_sock.h                   |   17 ++
 include/net/xfrm.h                           |   45 ++---
 net/dccp/ipv4.c                              |    5 
 net/ipv4/icmp.c                              |    4 
 net/ipv4/ip_output.c                         |    6 
 net/ipv4/tcp_ipv4.c                          |    1 
 net/ipv6/ip6_output.c                        |    5 
 net/ipv6/netfilter/ip6t_REJECT.c             |    2 
 net/netfilter/xt_CONNSECMARK.c               |   70 +++++++--
 net/netfilter/xt_SECMARK.c                   |   33 ++++
 security/dummy.c                             |   13 +
 security/selinux/hooks.c                     |  129 +++++++++++++----
 security/selinux/include/av_perm_to_string.h |    2 
 security/selinux/include/av_permissions.h    |    2 
 security/selinux/include/xfrm.h              |    5 
 security/selinux/ss/mls.c                    |    2 
 security/selinux/ss/services.c               |    2 
 security/selinux/xfrm.c                      |   28 +++
 21 files changed, 399 insertions(+), 68 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
