Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NLYKrT021594
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:34:20 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NLXZAS002098
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:33:35 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id C3D4EBF88
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:34:19 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 28579-05 for <selinux@tycho.nsa.gov>;
	Mon, 23 Aug 2004 22:34:15 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 34CD0BF95
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:34:15 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzMdD-0003ZX-8E
	for selinux@tycho.nsa.gov; Mon, 23 Aug 2004 22:45:35 +0100
Date: Mon, 23 Aug 2004 22:45:35 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patch for freshclam (live update)
Message-ID: <20040823214535.GB13677@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZfOjI3PrQbgiZnxM"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

here is a patch which gets the freshclam "live update" package working
a bit more.

it's what i've seen so far, mostly this is boot-up time stuff rather
than cron job stuff (i think).

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=freshclam

diff -Naur 
--- default.1.14/domains/program/clamav.te	2004-08-02 08:28:37.000000000 +0100
+++ current/domains/program/clamav.te	2004-08-22 20:18:54.000000000 +0100
@@ -84,3 +84,16 @@
 
 allow clamd_t { random_device_t urandom_device_t }:chr_file { getattr read };
 dontaudit clamd_t { random_device_t urandom_device_t }:chr_file ioctl;
+
+# allow freshclam to do logging...
+allow freshclam_t var_t:dir { search };
+allow freshclam_t freshclam_log_t:dir { search write add_name };
+allow freshclam_t var_run_t:dir { search };
+
+allow freshclam_t clamd_var_run_t:dir { write };
+	#EXE=/usr/bin/freshclam  NAME=clamav   :  write
+
+allow freshclam_t clamd_var_run_t:file { getattr write create };
+allow freshclam_t clamd_var_run_t:dir { add_name };
+	#EXE=/usr/bin/freshclam  NAME=freshclam.pid   :  add_name
+

--ZfOjI3PrQbgiZnxM--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
