From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Daniel J Walsh <dwalsh@redhat.com>, SELinux <SELinux@tycho.nsa.gov>
Subject: telnetd policy
Date: Mon, 9 May 2005 19:09:47 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fjyfCKjj38pJ3lP"
Message-Id: <200505091909.51560.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_fjyfCKjj38pJ3lP
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed to allow compiling a policy that doesn't include 
telnetd.te.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_fjyfCKjj38pJ3lP
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- net_contexts.orig	2005-05-09 19:08:20.000000000 +1000
+++ net_contexts	2005-05-09 19:08:34.000000000 +1000
@@ -41,7 +41,7 @@
 portcon tcp 20 system_u:object_r:ftp_data_port_t
 portcon tcp 21 system_u:object_r:ftp_port_t
 ifdef(`ssh.te', `portcon tcp 22 system_u:object_r:ssh_port_t')
-ifdef(`inetd.te', `portcon tcp 23 system_u:object_r:telnetd_port_t')
+ifdef(`telnetd.te', `portcon tcp 23 system_u:object_r:telnetd_port_t')
 
 portcon tcp 25 system_u:object_r:smtp_port_t
 portcon tcp 465 system_u:object_r:smtp_port_t

--Boundary-00=_fjyfCKjj38pJ3lP--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
