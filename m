Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8G3QOdE017441
	for <selinux@tycho.nsa.gov>; Sat, 15 Sep 2007 23:26:24 -0400
Received: from py-out-1112.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8G3QOJe021331
	for <selinux@tycho.nsa.gov>; Sun, 16 Sep 2007 03:26:24 GMT
Received: by py-out-1112.google.com with SMTP id u77so2708793pyb
        for <selinux@tycho.nsa.gov>; Sat, 15 Sep 2007 20:26:23 -0700 (PDT)
Message-ID: <f71a82820709152026u5ecc4326gd93925b6f996921@mail.gmail.com>
Date: Sun, 16 Sep 2007 12:26:23 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH]some interfaces in userdomain.if lacking user_home_dir_t .
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I've checked

http://oss.tresys.com/repos/refpolicy/trunk/policy/modules/system/userdomain.if

and found that
some interfaces in userdomain.if lacking user_home_dir_t .


--- userdomain.if       2007-09-16 11:22:26.000000000 +0900
+++ userdomain_new.if   2007-09-16 11:31:14.000000000 +0900
@@ -5076,7 +5076,7 @@
 #
 interface(`userdom_manage_generic_user_home_content_dirs',`
       gen_require(`
-               type user_home_t;
+               type user_home_dir_t, user_home_t;
       ')

       files_search_home($1)
@@ -5194,7 +5194,7 @@
 #
 interface(`userdom_manage_generic_user_home_content_symlinks',`
       gen_require(`
-               type user_home_t;
+               type user_home_dir_t, user_home_t;
       ')

       files_search_home($1)
@@ -5214,7 +5214,7 @@
 #
 interface(`userdom_manage_generic_user_home_content_pipes',`
       gen_require(`
-               type user_home_t;
+               type user_home_dir_t, user_home_t;
       ')

       files_search_home($1)
@@ -5234,7 +5234,7 @@
 #
 interface(`userdom_manage_generic_user_home_content_sockets',`
       gen_require(`
-               type user_home_t;
+               type user_home_dir_t, user_home_t;
       ')

       files_search_home($1)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
