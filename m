Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9ICeqrT020391
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 08:40:52 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9ICdPG3024746
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 12:39:37 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AE3E761AFB
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 22:40:37 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 27939-02 for <selinux@tycho.nsa.gov>;
	Mon, 18 Oct 2004 22:40:37 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 1798661AF7
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 22:40:37 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 34595B5ACE
	for <selinux@tycho.nsa.gov>; Mon, 18 Oct 2004 22:40:32 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: squid policy
Date: Mon, 18 Oct 2004 22:40:31 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_/m7cBZmWyhsvpMe"
Message-Id: <200410182240.31688.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_/m7cBZmWyhsvpMe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached policy patch is needed for new versions of squid.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_/m7cBZmWyhsvpMe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="diff"

--- /usr/src/se/policy/file_contexts/program/squid.fc	2004-06-17 15:10:44.000000000 +1000
+++ file_contexts/program/squid.fc	2004-10-18 22:39:51.000000000 +1000
@@ -3,6 +3,6 @@
 /var/cache/squid(/.*)?		system_u:object_r:squid_cache_t
 /var/spool/squid(/.*)?		system_u:object_r:squid_cache_t
 /var/log/squid(/.*)?		system_u:object_r:squid_log_t
-/etc/squid\.conf	--	system_u:object_r:squid_conf_t
+/etc/squid(/.*)?		system_u:object_r:squid_conf_t
 /var/run/squid\.pid	--	system_u:object_r:squid_var_run_t
 /usr/share/squid(/.*)?		system_u:object_r:squid_conf_t

--Boundary-00=_/m7cBZmWyhsvpMe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
