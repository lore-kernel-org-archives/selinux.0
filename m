Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8T2bcrT012712
	for <selinux@tycho.nsa.gov>; Tue, 28 Sep 2004 22:37:38 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8T2aOuK020913
	for <selinux@tycho.nsa.gov>; Wed, 29 Sep 2004 02:36:32 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: rpcd.te patch
Date: Wed, 29 Sep 2004 12:37:13 +1000
Cc: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Z/hWBlly07rMA+4"
Message-Id: <200409291237.13327.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_Z/hWBlly07rMA+4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The latest version of rpc.statd uses netlink to query the network state.  The 
attach patch permits this.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Z/hWBlly07rMA+4
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rpc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rpc.diff"

--- rpcd.te	2004-09-29 00:49:59.000000000 +1000
+++ rpcd.te.new	2004-09-29 12:36:01.000000000 +1000
@@ -38,6 +38,7 @@
 allow rpcd_t self:unix_dgram_socket create_socket_perms;
 allow rpcd_t self:unix_stream_socket create_socket_perms;
 allow rpcd_t self:fifo_file rw_file_perms;
+allow rpcd_t self:netlink_route_socket r_netlink_socket_perms;
 
 # rpcd_t needs to talk to the portmap_t domain
 can_udp_send(rpcd_t, portmap_t)

--Boundary-00=_Z/hWBlly07rMA+4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
