Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7NLjJrT021684
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 17:45:20 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7NLjHwb013808
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 21:45:18 GMT
Received: from localhost (localhost [127.0.0.1])
	by open.hands.com (Postfix) with ESMTP id 1A526BF8A
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:45:19 +0100 (BST)
Received: from open.hands.com ([127.0.0.1])
	by localhost (open [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 29836-02 for <selinux@tycho.nsa.gov>;
	Mon, 23 Aug 2004 22:45:17 +0100 (BST)
Received: from lkcl.net (host81-152-10-162.range81-152.btcentralplus.com [81.152.10.162])
	by open.hands.com (Postfix) with ESMTP id 7DE43BF88
	for <selinux@tycho.nsa.gov>; Mon, 23 Aug 2004 22:45:16 +0100 (BST)
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BzMns-0003at-Im
	for selinux@tycho.nsa.gov; Mon, 23 Aug 2004 22:56:36 +0100
Date: Mon, 23 Aug 2004 22:56:36 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patch for firefox
Message-ID: <20040823215636.GD13677@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="xB0nW4MQa6jZONgY"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

the attached patch is required for firefox 0.9.3 to run under debian
(and other oses?)

the reason for the patch is because someone decided to write a
script around firefox called firefox-bin that does some LD_LIBRARY_PATH
messing to keep /usr/lib/mozilla/blah separate.

that this [script] messes up kde from being able to re-run firefox-bin
for session management because the real binary is fired up without the
correct LD_LIBRARY_PATH doesn't seem to have occurred to anyone, but
that's another story...

l.

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--xB0nW4MQa6jZONgY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=firefox

diff -Naur 
--- default.1.14/file_contexts/program/mozilla.fc	2004-08-02 08:28:37.000000000 +0100
+++ current/file_contexts/program/mozilla.fc	2004-08-14 21:34:18.000000000 +0100
@@ -10,6 +10,7 @@
 /usr/bin/mozilla-snapshot --	system_u:object_r:mozilla_exec_t
 /usr/bin/epiphany-bin   --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/firefox/firefox-bin	--	system_u:object_r:mozilla_exec_t
+/usr/lib(64)?/mozilla-firefox/firefox-bin	--	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-[0-9].* --	system_u:object_r:mozilla_exec_t
 /usr/bin/mozilla-bin-[0-9].* --	system_u:object_r:mozilla_exec_t
 /usr/lib(64)?/netscape/.+/communicator/communicator-smotif.real -- system_u:object_r:mozilla_exec_t

--xB0nW4MQa6jZONgY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
