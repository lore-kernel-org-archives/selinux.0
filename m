Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m84F9NJH029950
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 11:09:23 -0400
Received: from yx-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m84F9Nk3003785
	for <selinux@tycho.nsa.gov>; Thu, 4 Sep 2008 15:09:23 GMT
Received: by yx-out-1718.google.com with SMTP id 3so1778320yxi.84
        for <selinux@tycho.nsa.gov>; Thu, 04 Sep 2008 08:09:23 -0700 (PDT)
Message-ID: <cadfc0e40809040809v43b12641n4a3556f1a53c384e@mail.gmail.com>
Date: Thu, 4 Sep 2008 10:09:22 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SELinux Mailing List" <selinux@tycho.nsa.gov>
Subject: [PATCH][gnome.if]: bad gen_require type
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

When I attempted to use this interface I got the follow error:
/usr/bin/checkmodule:  loading policy configuration from tmp/ml-launch.tmp
ml-launch.te":72:ERROR 'unknown type user_gconf_tmp_t' at token ';' on
line 5970:
	allow ml_launch_t user_gconf_tmp_t:dir { getattr search };

--- serefpolicy-3.5.4/policy/modules/apps/gnome.if	2008-08-28
17:36:53.000000000 -0500
+++ serefpolicy-3.5.4.new/policy/modules/apps/gnome.if	2008-08-28
17:35:59.000000000 -0500
@@ -125,7 +125,7 @@
 #
 template(`gnome_stream_connect_gconf_template',`
 	gen_require(`
-		type $1_gconfd_t, gconf_tmp_t;
+		type $1_gconfd_t, $1_gconf_tmp_t;
 	')

 	read_files_pattern($2, $1_gconf_tmp_t, $1_gconf_tmp_t)

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
