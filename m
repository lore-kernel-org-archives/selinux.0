Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1LLoCcA031131
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 16:50:12 -0500
Received: from mail.atsec.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1LLpTMh018470
	for <selinux@tycho.nsa.gov>; Wed, 21 Feb 2007 21:51:30 GMT
Date: Wed, 21 Feb 2007 15:51:14 -0600
From: Klaus Weidner <klaus@atsec.com>
To: Darrel Goeddel <dgoeddel@TrustedCS.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        Karl MacMillan <kmacmillan@mentalrootkit.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest diffs - Resent with additional changes.
Message-ID: <20070221215114.GC9827@w-m-p.com>
References: <45B8ACBF.8090201@redhat.com> <1171663101.20576.147.camel@sgc.columbia.tresys.com> <20070219031951.GA9827@w-m-p.com> <45DB4F07.9040607@trustedcs.com> <45DB79DB.3080209@trustedcs.com> <20070221002727.GB9827@w-m-p.com> <45DC8833.50503@trustedcs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <45DC8833.50503@trustedcs.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Feb 21, 2007 at 11:58:11AM -0600, Darrel Goeddel wrote:
> The subject based override should be mlsfilewriteinrange and the object
> based override should be mlsrangedobject, as they are.  I was just
> wondering if there was a need for both.  I'm fine with having the extra
> flexibility of both the subject based override and the object based
> override.

Ok - I'm fine with supporting both overrides for extra flexibility.

> So... Do we agree that the block of constraints in question (the "big" file
> write block and the extra directory operation block) should read should be:
> 
> (( l1 eq l2 ) or
> (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
> (( t1 == mlsfilewriteinrange ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
> ( t1 == mlsfilewrite ) or
> (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
> ( t2 == mlstrustedobject ));

Yes, see below.

> I'll let you know what we come up with on the possibility of the extra
> override on the netif/node constraint.
> 
> I stuck what I think the mls file should look like here:
> 
> http://home.insightbb.com/~dgoeddel/policy/mls
> 
> I can give patches against svn or the rhel policy if you need.  Just let
> me know.  It would probably be easiest if you could roll this into the big
> patch for upstream (assuming everyone approves).  Otherwise I could make a
> follow-on patch after the currently proposed changed are handled by Chris.

I agree that the policy on your web page looks reasonable, and I think we
should go with that one. (We'll still need to run tests on it, and will
speak up if something unexpected happens.)

For completeness, here's a patch against selinux-policy-2.4.6-38.el5.src.rpm
(downloaded from http://people.redhat.com/dwalsh/SELinux/RHEL5/) to make
it match that policy.

Signed-off-by: Klaus Weidner <klaus@atsec.com>

--- /home/kw/bulk/src/rpm/BUILD/serefpolicy-2.4.6/policy/mls	2007-02-21 15:44:31.000000000 -0600
+++ dgoeddel/mls	2007-02-21 11:58:12.000000000 -0600
@@ -85,20 +85,21 @@
 	 ( t1 == mlsfileread ) or
 	 ( t2 == mlstrustedobject ));
 
-# the "single level" file "write" ops
+# the file "write" ops
 mlsconstrain { file lnk_file fifo_file dir chr_file blk_file sock_file } { write create setattr relabelfrom append unlink link rename mounton }
 	(( l1 eq l2 ) or
+	 (( t1 == mlsfilewriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsfilewrite ) or
-	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( h1 domby h2 )) or
+	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 ( t2 == mlstrustedobject ));
 
-# Directory "write" ops
 mlsconstrain dir { add_name remove_name reparent rmdir }
 	(( l1 eq l2 ) or
 	 (( t1 == mlsfilewriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsfilewritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
 	 ( t1 == mlsfilewrite ) or
+	 (( t2 == mlsrangedobject ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 ( t2 == mlstrustedobject ));
 
 # these access vectors have no MLS restrictions
@@ -167,20 +168,9 @@
 mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } relabelto
 	( h1 dom h2 );
 
-# the socket "read+write" ops
-# (Socket FDs are generally bidirectional, equivalent to open(..., O_RDWR),
-# require equal levels for unprivileged subjects, or read *and* write overrides)
-mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { accept connect }
-	(( l1 eq l2 ) or
-	 (((( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
-	   ( t1 == mlsnetread )) and
-	  ((( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
-	   (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
-	   ( t1 == mlsnetwrite ))));
-
-
 # the socket "read" ops (note the check is dominance of the low level)
-mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen getopt recv_msg }
+# note that accept and connect are also subject to the write constraint below
+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { read getattr listen accept connect getopt recv_msg }
 	(( l1 dom l2 ) or
 	 (( t1 == mlsnetreadtoclr ) and ( h1 dom l2 )) or
 	 ( t1 == mlsnetread ));
@@ -191,7 +181,8 @@
 	 ( t1 == mlsnetread ));
 
 # the socket "write" ops
-mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom setopt shutdown }
+# note that accept and connect are also subject to the read constraint above
+mlsconstrain { socket tcp_socket udp_socket rawip_socket netlink_socket packet_socket key_socket unix_stream_socket unix_dgram_socket netlink_route_socket netlink_firewall_socket netlink_tcpdiag_socket netlink_nflog_socket netlink_xfrm_socket netlink_selinux_socket netlink_audit_socket netlink_ip6fw_socket netlink_dnrt_socket } { write setattr relabelfrom accept connect setopt shutdown }
 	(( l1 eq l2 ) or 
 	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )) or
 	 (( t1 == mlsnetwritetoclr ) and ( h1 dom l2 ) and ( l1 domby l2 )) or
@@ -290,7 +281,7 @@
 # the netif/node "write" ops (implicit single level socket doing the write)
 mlsconstrain { netif node } { tcp_send udp_send rawip_send }
 	(( l1 eq l2 ) or
-	(( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));
+	 (( t1 == mlsnetwriteranged ) and ( l1 dom l2 ) and ( l1 domby h2 )));
 
 # these access vectors have no MLS restrictions
 # node enforce_dest

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
