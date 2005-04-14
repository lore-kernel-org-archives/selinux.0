From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux@tycho.nsa.gov
Subject: ntpdate policy
Date: Thu, 14 Apr 2005 20:39:12 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ShkXCEkO6oMtIva"
Message-Id: <200504142039.14484.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_ShkXCEkO6oMtIva
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

allow sysadm_t ntp_port_t:udp_socket name_bind;

When running ntpdate with the strict policy the above is required.

Patch attached.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_ShkXCEkO6oMtIva
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ntpd.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ntpd.diff"

--- ntpd.te.old	2005-04-14 20:38:34.000000000 +1000
+++ ntpd.te	2005-04-14 19:13:25.000000000 +1000
@@ -14,6 +14,7 @@
 
 type ntpdate_exec_t, file_type, sysadmfile, exec_type;
 domain_auto_trans(initrc_t, ntpdate_exec_t, ntpd_t)
+allow sysadm_t ntp_port_t:udp_socket name_bind;
 
 logdir_domain(ntpd)
 

--Boundary-00=_ShkXCEkO6oMtIva--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
