Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA01901
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 05:07:33 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA03932
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 09:06:03 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id JAA03928 for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 09:06:01 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 3D60B92465
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 19:07:29 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 8913B7BD
	for <selinux@tycho.nsa.gov>; Sun, 14 Jul 2002 10:52:38 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: minor bugfix for vmware.te
Date: Sun, 14 Jul 2002 10:52:38 +0200
MIME-Version: 1.0
Message-Id: <20020714085238.8913B7BD@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

diff -ru default/domains/program/vmware.te current/domains/program/vmware.te
--- default/domains/program/vmware.te   Sun Jul 14 09:59:45 2002
+++ current/domains/program/vmware.te   Sun Jul 14 10:35:09 2002
@@ -156,7 +156,9 @@
 allow vmware_user_t removable_device_t:lnk_file { read };

 # Allow to attach to xserver
+ifdef(`gnome-pty-helper.te', `
 allow vmware_user_t user_gph_t:fd use;
+')
 allow vmware_user_t user_xserver_tmp_t:sock_file { unlink write };
 allow vmware_user_t user_xserver_tmp_t:dir { search };
 allow vmware_user_t user_xserver_t:unix_stream_socket { connectto };

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
