From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov
Subject: courier policy
Date: Tue, 31 May 2005 14:28:33 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0f+mCdcrDng5jBm"
Message-Id: <200505311428.36959.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_0f+mCdcrDng5jBm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow courier to read random data for SSL.  
Recent versions want to stat the random device, and it seems that different 
versions require either urandom or random.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_0f+mCdcrDng5jBm
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- domains/program/unused/courier.te.orig	2005-05-31 14:25:06.000000000 +1000
+++ domains/program/unused/courier.te	2005-05-31 14:26:35.000000000 +1000
@@ -92,7 +92,7 @@
 allow courier_tcpd_t sbin_t:dir search;
 allow courier_tcpd_t var_lib_t:dir search;
 # for TLS
-allow courier_tcpd_t urandom_device_t:chr_file read;
+allow courier_tcpd_t { random_device_t urandom_device_t }:chr_file { getattr read };
 read_locale(courier_tcpd_t)
 can_exec(courier_tcpd_t, courier_exec_t)
 allow courier_authdaemon_t courier_tcpd_t:{ unix_stream_socket tcp_socket } rw_stream_socket_perms;

--Boundary-00=_0f+mCdcrDng5jBm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
