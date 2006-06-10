Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k5CFoFd0007898
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:16 -0400
Received: from moss-lions.epoch.ncsc.mil (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k5CFoDlb024180
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 15:50:14 GMT
Received: from moss-lions.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6) with ESMTP id k5CFoMCB010574
	for <selinux@tycho.nsa.gov>; Mon, 12 Jun 2006 11:50:22 -0400
Received: (from jwcart2@localhost)
	by moss-lions.epoch.ncsc.mil (8.13.6/8.13.6/Submit) id k5CFoMUF010573
	for selinux@tycho.nsa.gov; Mon, 12 Jun 2006 11:50:22 -0400
Message-ID: <36282A1733C57546BE392885C0618592012D626D@chaos.tcs.tcs-sec.com>
From: Venkat Yekkirala <vyekkirala@TrustedCS.com>
To: redhat-lspp@redhat.com, selinux@tycho.nsa.gov, sds@tycho.nsa.gov,
        jmorris@redhat.com, tjaeger@cse.psu.edu, latten@austin.ibm.com
Cc: Chad Hanson <chanson@TrustedCS.com>,
        Darrel Goeddel
	 <DGoeddel@TrustedCS.com>
Subject: [RFC] [SELXFRM 0/4] SELinux/MLS enhancements to IPSec
Date: Sat, 10 Jun 2006 17:37:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This patch set adds/enhances support for SELinux/MLS in handling IPSec
xfrm's. It builds on the work by Trent Jaeger, et al, on the labeling of
IPSec SAs. A policy patch is also included for reference. Patch is relative
to the lspp.34 kernel (http://people.redhat.com/sgrubb/files/lspp).
ipsec-tools 0.6.5 src in FC rawhide already has the setkey changes needed to
work with this. A patch to ipsec-tools/racoon will follow later on the
ipsec-tools-devel list.

The basic idea is to have the IPSec policy specify an MLS range and have
unique SAs generated/used for each of the levels that fall in the range. SAs
for different levels can either be manually loaded (using setkey and such)
or negotiated using IKE (racoon, etc.).

Example:

Let's say we have the following in the SPD (Security Policy Database):

spdadd 9.2.9.15 9.2.9.17 any -ctx 1 1
"system_u:object_r:zzyzx_t:s0-s9:c0-c127"
-P in ipsec esp/transport//require ;
spdadd 9.2.9.17 9.2.9.15 any -ctx 1 1
"system_u:object_r:zzyzx_t:s0-s9:c0-c127"
-P out ipsec esp/transport//require ;

with nothing in the SAD (Security Association Database) initially. When the
kernel runs into the first packet with the label s2:c4 destined for
9.2.9.17, it will see that there's no SA available to encrypt it with. So,
it will call upon racoon/IKE to generate an SA. Racoon will obtain the label
(s2:c4) from the kernel, do the negotiation with its peer, including the
label (s2:c4) also in the payload/proposals. The negotiation will result in
a dynamically generated SPI that is unique to the label (s2:c4) plus the
other normal parameters involved. It will then insert the SA (along with the
SPI) such as the following into the SAD in the kernel:

add 9.2.9.15 9.2.9.17 esp 0x123456
-ctx 1 1 "system_u:object_r:zzyzx_t:s2:c4"
-E des-cbc 0x0000000000000000;

If the kernel subsequently runs into a packet at a different label (say
s2:c5) for which there's no SA available, it will again call upon racoon
(which will get s2:c5 from the kernel this time) and a different SA (with a
different SPI) will be negotiated.

Description of changes:

While the following uses MLS examples and hence may seem MLS-oriented, the
controls would apply equally to SELinux/TE.

A "sid" member has been added to the flow cache key resulting in the sid
being available at all needed locations and the flow cache lookups
automatically using the sid. The flow sid is derived from the socket on the
outbound and the SAs (unlabeled where an SA was not used) on the inbound.

Outbound case:
1. Find policy for the socket.
2. OLD: Find an SA that matches the policy.
   NEW: Find an SA that matches BOTH the policy and the flow/socket.
        This is necessary since not every SA that matches the policy
        can be used for the flow/socket. Consider policy range Secret-TS,
        and SAs each for Secret and TS. We don't want a TS socket to
        use the Secret SA. Hence the additional check for the SA Vs.
flow/socket.
3. NEW: When looking thru bundles for a policy, make sure the flow/socket
can use the bundle. If a bundle is not found, create one, calling for IKE if
necessary. If using IKE, include the security context in the acquire message
to the IKE daemon.

Inbound case:
1. OLD: Find policy for the socket.
   NEW: Find policy for the incoming packet based on the sid of the SA(s) it
used or the unlabeled sid if no SAs were used. (Consider a case where a
socket is "authorized" for two policies (unclassified-confidential,
secret-top_secret). If the packet has come in using a secret SA, we really
ought to be using the latter policy (secret-top_secret).)
2. OLD: BUG: No check to see if the SAs used by the packet agree with the
policy sec_ctx-wise. (It was indicated in selinux_xfrm_sock_rcv_skb() that
this was being accomplished by (x->id.spi == tmpl->id.spi || !tmpl->id.spi)
in xfrm_state_ok, but it turns out tmpl->id.spi would normally be zero
(unless xfrm policy rules specify one at the template level, which they
usually don't).
   NEW: The socket is checked for access to the SAs used (based on the sid
of the SAs) in selinux_xfrm_sock_rcv_skb().

Outstanding issues:
- Timewait acknowledgements and such are generated using a NULL socket
resulting in the any_socket sid (SYSTEM_HIGH) to be used.


 include/linux/security.h                     |   97 ++++++++++++--
 include/net/flow.h                           |    5
 net/core/flow.c                              |    7 -
 net/core/sock.c                              |    4
 net/key/af_key.c                             |   24 +++
 net/xfrm/xfrm_policy.c                       |   28 ++--
 net/xfrm/xfrm_state.c                        |   12 +
 net/xfrm/xfrm_user.c                         |    2
 security/dummy.c                             |   23 +++
 security/selinux/hooks.c                     |   27 +++
 security/selinux/include/av_perm_to_string.h |    1
 security/selinux/include/av_permissions.h    |    1
 security/selinux/include/objsec.h            |    1
 security/selinux/include/security.h          |    2
 security/selinux/include/xfrm.h              |    9 +
 security/selinux/ss/mls.c                    |   20 --
 security/selinux/ss/mls.h                    |   20 ++
 security/selinux/ss/services.c               |   48 +++++++
 security/selinux/xfrm.c                      |  185
++++++++++++++++++++++-----
 19 files changed, 423 insertions(+), 93 deletions(-)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
