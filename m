Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m73MjSSN020349
	for <selinux@tycho.nsa.gov>; Sun, 3 Aug 2008 18:45:28 -0400
Received: from palpatine.hardeman.nu (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m73MjMa4001774
	for <selinux@tycho.nsa.gov>; Sun, 3 Aug 2008 22:45:23 GMT
Date: Mon, 4 Aug 2008 00:44:48 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
To: dwalsh@redhat.com
Cc: selinux@tycho.nsa.gov
Subject: Some questions regarding RedHat refpolicy patches
Message-ID: <20080803224448.GA22709@hardeman.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Going through the RedHat patches trying to find more stuff to send 
upstream for merge, I've come across a few things that I don't quite 
understand and I'd appreciate if someone could explain them to me :)

a)

There are quite a lot of changes like this:

--- ./upstream/refpolicy/policy/modules/apps/uml.fc     2008-08-03 12:31:17.000000000 +0200
+++ ./fedora/refpolicy/policy/modules/apps/uml.fc       2008-08-03 12:29:42.000000000 +0200
@@ -1,7 +1,7 @@
  #
  # HOME_DIR/
  #
-HOME_DIR/\.uml(/.*)?           gen_context(system_u:object_r:ROLE_uml_rw_t,s0)
+HOME_DIR/\.uml(/.*)?           gen_context(system_u:object_r:user_uml_rw_t,s0)

What is the purpose of these changes and is it something that makes 
sense upstream? The upstream SVN version seems to contain quite a lot of 
"ROLE" contexts already...then again, other parts of the patch do the 
reverse:

--- ./upstream/refpolicy/policy/modules/apps/mplayer.fc 2008-08-03 12:31:17.000000000 +0200
+++ ./fedora/refpolicy/policy/modules/apps/mplayer.fc   2008-08-03 12:29:42.000000000 +0200
@@ -10,4 +10,4 @@
  /usr/bin/mencoder      --      gen_context(system_u:object_r:mencoder_exec_t,s0)
  /usr/bin/xine          --      gen_context(system_u:object_r:mplayer_exec_t,s0)
  
-HOME_DIR/\.mplayer(/.*)?        gen_context(system_u:object_r:ROLE_mplayer_home_t,s0)
+HOME_DIR/\.mplayer(/.*)?        gen_context(system_u:object_r:user_mplayer_home_t,s0)


b)

There are also quite a lot of changes like this:

--- ./upstream/refpolicy/policy/modules/apps/awstats.if 2008-08-03 12:31:17.000000000 +0200
+++ ./fedora/refpolicy/policy/modules/apps/awstats.if   2008-05-15 15:10:34.000000000 +0200
@@ -33,7 +33,8 @@
  #
  interface(`awstats_cgi_exec',`
         gen_require(`
-               type httpd_awstats_script_exec_t, httpd_awstats_content_t;
+               type httpd_awstats_script_exec_t;
+               type httpd_awstats_content_t;

Are these only noise (and in that case, would you (Dan) like a patch to 
remove that noise) or something which is actually wanted upstream?


c)

A lot of changes only alter whitespace, would it be possible to avoid 
these by generating the fedora diff with the appropriate options to 
diff?


d)

Why does postgrey_t need to be able to restart apache? (and the same 
goes for many many other service module changes in the patch, such as 
canna, ldap, etc, etc)

-- 
David Härdeman

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
