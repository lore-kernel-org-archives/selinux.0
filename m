From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: howl
Date: Wed, 13 Oct 2004 20:25:49 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tKQbBVrfmz2rFKY"
Message-Id: <200410132025.49472.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_tKQbBVrfmz2rFKY
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for howl.te

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_tKQbBVrfmz2rFKY
Content-Type: text/x-diff;
  charset="us-ascii";
  name="howl.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="howl.diff"

--- /usr/src/se/policy/domains/program/unused/howl.te	2004-08-28 12:05:02.000000000 +1000
+++ domains/program/unused/howl.te	2004-10-13 20:24:49.000000000 +1000
@@ -1,3 +1,8 @@
+#DESC howl - port of Apple Rendezvous multicast DNS
+#
+# Author:  Russell Coker <rcoker@redhat.com>
+#
+
 daemon_domain(howl)
 allow howl_t proc_t:file { getattr read };
 can_network(howl_t)
@@ -7,7 +12,7 @@
 allow howl_t self:fifo_file rw_file_perms;
 
 type howl_port_t, port_type;
-allow howl_t howl_port_t:tcp_socket name_bind;
+allow howl_t howl_port_t:{ udp_socket tcp_socket } name_bind;
 
 allow howl_t etc_t:file { getattr read };
 allow howl_t initrc_var_run_t:file rw_file_perms;

--Boundary-00=_tKQbBVrfmz2rFKY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
