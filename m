Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8IEoxdL002439
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 10:50:59 -0400
Received: from an-out-0708.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l8IEowgF013316
	for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 14:50:58 GMT
Received: by an-out-0708.google.com with SMTP id c38so326686ana
        for <selinux@tycho.nsa.gov>; Tue, 18 Sep 2007 07:50:51 -0700 (PDT)
Message-ID: <f71a82820709180750v3163b06eyee88eeecb28f7504@mail.gmail.com>
Date: Tue, 18 Sep 2007 23:50:51 +0900
From: "Shintaro Fujiwara" <shintaro.fujiwara@gmail.com>
To: selinux <selinux@tycho.nsa.gov>
Subject: [PATCH]dpkg.if lacking dpkg_var_lib_t
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi, I was checking another interface and found dpkg_var_lib_t is lacking
in dpkg.if.

Is it OK with this patch?


Index: policy/modules/admin/dpkg.if
===================================================================
--- policy/modules/admin/dpkg.if        (revision 2422)
+++ policy/modules/admin/dpkg.if        (working copy)
@@ -223,7 +223,7 @@
 #
 interface(`dpkg_lock_db',`
        gen_require(`
-               type dpkg_lock_t;
+               type dpkg_lock_t, dpkg_var_lib_t;
        ')

        files_search_var_lib($1)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
