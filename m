From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SELinux <SELinux@tycho.nsa.gov>
Subject: mailman
Date: Mon, 11 Oct 2004 16:13:08 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_0RiaBBW9yf33Ski"
Message-Id: <200410111613.08592.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_0RiaBBW9yf33Ski
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for mailman.  It still doesn't make mailman work, 
but it gets it closer.  Please include it in the CVS to avoid duplication of 
effort.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_0RiaBBW9yf33Ski
Content-Type: text/x-diff;
  charset="us-ascii";
  name="mailman.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mailman.diff"

--- /usr/src/se/policy/domains/program/unused/mailman.te	2004-08-28 12:05:03.000000000 +1000
+++ domains/program/unused/mailman.te	2004-10-08 06:06:06.000000000 +1000
@@ -87,7 +87,10 @@
 
 allow mta_delivery_agent mailman_data_t:dir search;
 allow mta_delivery_agent mailman_data_t:lnk_file read;
-domain_auto_trans(mta_delivery_agent, mailman_mail_exec_t, mailman_mail_t)
+domain_auto_trans({ mta_delivery_agent initrc_t }, mailman_mail_exec_t, mailman_mail_t)
+ifdef(`direct_sysadm_daemon', `
+domain_auto_trans(sysadm_t, mailman_mail_exec_t, mailman_mail_t)
+')
 allow mailman_mail_t self:unix_dgram_socket create_socket_perms;
 
 system_crond_entry(mailman_queue_exec_t, mailman_queue_t)

--Boundary-00=_0RiaBBW9yf33Ski--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
