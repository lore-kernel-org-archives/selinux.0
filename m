Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NNAPrT022208
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 19:10:25 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NNAJwb015842
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 23:10:19 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 5DB8EBF6F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:10:17 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 00868-02 for <selinux@tycho.nsa.gov>;
	Tue, 24 Aug 2004 00:10:15 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 46026BF2F
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 00:10:15 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzO87-000467-JZ
	for selinux@tycho.nsa.gov; Tue, 24 Aug 2004 00:21:35 +0100
Date: Tue, 24 Aug 2004 00:21:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: prelink on debian
Message-ID: <20040823232135.GA12720@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="cNdxnHkX5QqsyA0e"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

prelink is a script on debian: i had to add this because prelink checks
that there's > 50mb of disk space and then exec's prelink.bin.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=z

diff -Naur 
--- default.1.14/file_contexts/program/prelink.fc   2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/program/prelink.fc    2004-08-15 10:00:40.000000000 +0100
@@ -1,5 +1,6 @@
 # prelink - prelink ELF shared libraries and binaries to speed up startup time
 /usr/sbin/prelink      --  system_u:object_r:prelink_exec_t
+/usr/sbin/prelink.bin      --  system_u:object_r:prelink_exec_t
 /etc/prelink.conf      --  system_u:object_r:etc_prelink_t
 /var/log/prelink.log       --  system_u:object_r:prelink_log_t
 /etc/prelink.cache     --  system_u:object_r:prelink_cache_t

--cNdxnHkX5QqsyA0e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
