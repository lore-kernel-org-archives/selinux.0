Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4IM7ARb005903
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 18:07:10 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4IM77AR001290
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 22:07:08 GMT
Received: from smtp801.mail.ukl.yahoo.com (smtp801.mail.ukl.yahoo.com [217.12.12.138])
        by jazzband.ncsc.mil  with SMTP id i4IM77Hn001287 for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 22:07:07 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp801.mail.ukl.yahoo.com with SMTP; 18 May 2004 21:08:43 -0000
Received: from highfield ([192.168.0.223]:32798 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.24 #1)
	id 1BQBs9-00083e-86
	for <selinux@tycho.nsa.gov>; Tue, 18 May 2004 21:11:37 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BQBmq-0002Kt-5f
	for selinux@tycho.nsa.gov; Tue, 18 May 2004 21:06:08 +0000
Date: Tue, 18 May 2004 21:06:08 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: patch for wdm /var/lib access
Message-ID: <20040518210608.GH7348@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- current/file_contexts/program/xdm.fc        2004-05-18 16:52:23.000000000 +0
000
+++ default/file_contexts/program/xdm.fc        2004-05-18 09:00:10.000000000 +0
000
@@ -17,7 +17,7 @@
 /etc/kde/kdm/Xsession  --      system_u:object_r:xsession_exec_t
 /var/run/xdmctl(/.*)?          system_u:object_r:xdm_var_run_t
 /var/run/console.*             system_u:object_r:xdm_var_run_t
-/var/lib(64)?/kdm(/.*)? system_u:object_r:xdm_var_lib_t
+/var/lib(64)?/[kw]dm(/.*)? system_u:object_r:xdm_var_lib_t
 /usr/lib(64)?/qt-3.3/etc/settings/qtrc(/.*)? system_u:object_r:xdm_var_lib_t

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
