Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id MAA09332
	for <selinux@tycho.nsa.gov>; Sat, 8 Jun 2002 12:37:30 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id QAA17168
	for <selinux@tycho.nsa.gov>; Sat, 8 Jun 2002 16:36:09 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id QAA17164 for <selinux@tycho.nsa.gov>; Sat, 8 Jun 2002 16:36:08 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 5DEBA92461
	for <selinux@tycho.nsa.gov>; Sun,  9 Jun 2002 02:37:26 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id CEF4075C6
	for <selinux@tycho.nsa.gov>; Sat,  8 Jun 2002 18:38:07 +0200 (CEST)
Content-Type: text/plain;
  charset="us-ascii"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: /boot
Date: Sat, 8 Jun 2002 18:38:07 +0200
MIME-Version: 1.0
Message-Id: <20020608163807.CEF4075C6@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On the SE Linux machine at LinuxTag I have been providing everyone with 
"root" access and inviting them to discover a way to obtain full access to 
the system (root is in user_r only).

They have discovered that as user_t they can read /boot files which may 
contain the lilo password in a form that can be extracted (I am not sure if 
that is the case for this version of LILO - it was definately the case for 
previous versions).  Here is a patch to remove this access.

diff -ru default/macros/global_macros.te current/macros/global_macros.te
--- default/macros/global_macros.te     Wed Jun  5 13:29:34 2002
+++ current/macros/global_macros.te     Sat Jun  8 18:34:08 2002
@@ -716,11 +716,6 @@
 allow $1 initrc_var_run_t:file r_file_perms;
 allow $1 wtmp_t:file r_file_perms;

-# Read /boot and /boot/kernel.h.
-allow $1 boot_t:dir r_dir_perms;
-allow $1 boot_t:{ file lnk_file } r_file_perms;
-allow $1 boot_runtime_t:{ file lnk_file } r_file_perms;
-
 # Read /etc.
 allow $1 etc_t:dir r_dir_perms;
 allow $1 etc_t:notdevfile_class_set r_file_perms;


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
