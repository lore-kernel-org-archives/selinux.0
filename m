Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id AAA04090
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 00:55:30 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id EAA18325
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 04:54:51 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id EAA18321
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 04:54:48 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 93C6092462
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 14:55:21 +1000 (EST)
Received: from there (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with SMTP id 19D666DD8
	for <selinux@tycho.nsa.gov>; Mon, 15 Jul 2002 06:55:03 +0200 (CEST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Fwd: locales
Date: Mon, 15 Jul 2002 06:55:01 +0200
MIME-Version: 1.0
Message-Id: <20020715045504.19D666DD8@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov



----------  Forwarded Message  ----------

Subject: locales
Date: Mon, 15 Jul 2002 10:47:35 +1000
From: Brian May <bam@snoopy.apana.org.au>
To: Russell Coker <russell@coker.com.au>

Russell,

I suggest making the following change seeing as so many programs
require read access to the locale files:

(still to resolve: execute permission for /usr/lib/gconv/*.so)

diff -Nru a/domains/misc/locales.te b/domains/misc/locales.te
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/domains/misc/locales.te	Mon Jul 15 10:39:58 2002
@@ -0,0 +1,2 @@
+allow domain writeable_t:dir r_dir_perms;
+allow domain writeable_t:notdevfile_class_set r_file_perms;
diff -Nru a/domains/program/amanda.te b/domains/program/amanda.te
--- a/domains/program/amanda.te	Mon Jul 15 10:39:58 2002
+++ b/domains/program/amanda.te	Mon Jul 15 10:39:58 2002
@@ -310,9 +310,6 @@
 allow amanda_recover_t amanda_recover_dir_t:dir { add_name remove_name
 search write }; allow amanda_recover_t amanda_recover_dir_t:file { append
 create getattr setattr unlink };

-# access to locale at /usr/lib/locale/de_DE/LC_CTYPE
-allow amanda_recover_t writeable_t:file { getattr read };
-
 # access to var_t and var_run_t
 allow amanda_recover_t var_t:dir { search };
 allow amanda_recover_t var_run_t:dir { search };
diff -Nru a/domains/program/ipsec.te b/domains/program/ipsec.te
--- a/domains/program/ipsec.te	Mon Jul 15 10:39:58 2002
+++ b/domains/program/ipsec.te	Mon Jul 15 10:39:58 2002
@@ -164,9 +164,6 @@
 uses_shlib(ipsec_mgmt_t)
 uses_shlib(ipsec_t)
 allow ipsec_mgmt_t lib_t:dir r_dir_perms;
-# access /usr/lib/locale information
-allow ipsec_mgmt_t writeable_t:dir r_dir_perms;
-allow ipsec_mgmt_t writeable_t:file r_file_perms;
 # access /usr/share/locale
 allow ipsec_mgmt_t usr_t:file r_file_perms;
 # Read and write /dev/tty
--
Brian May <bam@snoopy.apana.org.au>

-------------------------------------------------------

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
