Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kBCFQbpd025137
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 10:26:37 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kBCFR7oA004400
	for <selinux@tycho.nsa.gov>; Tue, 12 Dec 2006 15:27:08 GMT
Date: Tue, 12 Dec 2006 09:26:59 -0600
From: Klaus Weidner <klaus@atsec.com>
To: selinux@tycho.nsa.gov
Subject: [PATCH RFC 3/2] stricter MLS policy constraints
Message-ID: <20061212152659.GB3362@w-m-p.com>
References: <20061212072825.GA3362@w-m-p.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061212072825.GA3362@w-m-p.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Dec 12, 2006 at 01:28:26AM -0600, Klaus Weidner wrote:
> The following patches attempt to get the system closer to the
> Bell-LaPadula model expressed in the LSPP by permitting only "write
> equal" for unprivileged subjects.

A related but separate issue is that the policy treated accept() as a
read operation, and connect() as a write operation. That's not really
appropriate since both normally return bidirectional file descriptors,
equivalent to open(..., O_RDWR). The MLS check should require equal
levels for unprivileged subjects, or read *and* write overrides.

(Yes, there's a separate constraint for recvfrom, but it simplifies
analysis if open file descriptors are already sanitized to avoid the need
for security enforcing checks on read/write.)

Signed-off-by: Klaus Weidner <klaus@atsec.com>

 policy/mls |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff -ur serefpolicy-2.4.6.kw2/policy/mls serefpolicy-2.4.6.kw3/policy/mls
--- serefpolicy-2.4.6.kw2/policy/mls	2006-12-06 07:20:21.000000000 -0600
+++ serefpolicy-2.4.6.kw3/policy/mls	2006-12-06 07:29:35.000000000 -0600
@@ -167,8 +167,20 @@
 mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } relabelto
 	( h1 dom h2 );
 
+# the socket "read+write" ops
+# (Socket FDs are generally bidirectional, equivalent to open(..., O_RDWR),
+# require equal levels for unprivileged subjects, or read *and* write overrides)
+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { accept connect }
+	(( l1 eq l2 ) or
+	 (((( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
+	   ( t1 == mlsnetread )) and
+	  ((( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
+	   (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
+	   ( t1 == mlsnetwrite ))));
+
+
 # the socket "read" ops (note the check is dominance of the low level)
-mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen accept getopt recv_msg }
+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen getopt recv_msg }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsnetread ));
@@ -179,7 +191,7 @@
 	 ( t1 == mlsnetread ));
 
 # the socket "write" ops
-mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom connect setopt shutdown }
+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom setopt shutdown }
 	(( l1 eq l2 ) or 
 	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
