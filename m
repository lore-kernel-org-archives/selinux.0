Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4P976Rb016392
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 05:07:06 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4P94aar025588
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 09:04:36 GMT
Received: from smtp800.mail.ukl.yahoo.com (smtp800.mail.ukl.yahoo.com [217.12.12.142])
	by jazzswing.ncsc.mil  with SMTP id i4P94ZQu025585
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 09:04:35 GMT
Received: from unknown (HELO lkcl.net) (selinux@tycho.nsa.gov@81.130.181.235 with poptime)
  by smtp800.mail.ukl.yahoo.com with SMTP; 25 May 2004 09:06:52 -0000
Received: from highfield ([192.168.0.223]:32778 helo=lkcl.net)
	by lkcl.net with esmtp (Exim 4.34 #1)
	id 1BSXFD-00069f-Ls
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 08:25:07 +0000
Received: from lkcl by lkcl.net with local (Exim 4.24)
	id 1BSXqq-00012C-MC
	for selinux@tycho.nsa.gov; Tue, 25 May 2004 09:04:00 +0000
Date: Tue, 25 May 2004 09:04:00 +0000
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>
Subject: merging of SuSE stuff into sf.net cvs
Message-ID: <20040525090400.GD3264@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

hiya russell/steve et al,

when that nice suse man sent those patches i applied them from
his original message, now i do a cvs update i find they're already
incorporated...

except for these, and i noticed that you commented about not doing
/tmp stuff already but the ifdef unconfined one appears to have
been missed and i thought i should mention it.  l.

also the mkdir ROOTDIR i added because on a first install that directory
doesn't exist (!)

l.

Index: Makefile
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/Makefile,v
retrieving revision 1.25
diff -u -u -r1.25 Makefile
--- Makefile	11 May 2004 17:55:37 -0000	1.25
+++ Makefile	25 May 2004 08:23:35 -0000
@@ -68,6 +70,7 @@
 	install -m 644 $< $@
 
 $(ROOTDIR)/.default_contexts: appconfig/root_default_contexts
+	mkdir -p $(ROOTDIR)
 	install -m 644 $< $@
 
 
Index: domains/program/unused/inetd.te
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/domains/program/unused/inetd.te,v
retrieving revision 1.6
diff -u -u -r1.6 inetd.te
--- domains/program/unused/inetd.te	4 May 2004 19:35:53 -0000	1.6
+++ domains/program/unused/inetd.te	25 May 2004 08:23:36 -0000
@@ -118,7 +118,9 @@
 dontaudit inetd_child_t krb5_conf_t:file write;
 allow inetd_child_t urandom_device_t:chr_file { getattr read };
 
+ifdef(`unconfined.te', `
 domain_auto_trans(inetd_t, unconfined_exec_t, unconfined_t)
+')
 
 ifdef(`unlimitedServices', `
 unconfined_domain(inetd_t) 
Index: file_contexts/program/screen.fc
===================================================================
RCS file: /cvsroot/selinux/nsa/selinux-usr/policy/file_contexts/program/screen.fc,v
retrieving revision 1.4
diff -u -u -r1.4 screen.fc
--- file_contexts/program/screen.fc	21 May 2004 20:12:22 -0000	1.4
+++ file_contexts/program/screen.fc	25 May 2004 08:23:36 -0000
@@ -3,7 +3,14 @@
 HOME_DIR/\.screenrc	--	system_u:object_r:ROLE_home_screen_t
 /var/run/screen/S-[^/]+	-d	system_u:object_r:screen_dir_t
 /var/run/screen/S-[^/]+/.*	<<none>>
+<<<<<<< screen.fc
+# SuSE puts this under /tmp ...
+/tmp/uscreens		-d	system_u:object_r:var_run_t
+/tmp/uscreens/S-[^/]+	-d	system_u:object_r:screen_dir_t
+/tmp/uscreens/S-[^/]+/.*	<<none>>
+=======
 # SuSE puts this under /tmp ...
 #/tmp/uscreens		-d	system_u:object_r:var_run_t
 #/tmp/uscreens/S-[^/]+	-d	system_u:object_r:screen_dir_t
 #/tmp/uscreens/S-[^/]+/.*	<<none>>
+>>>>>>> 1.4
-- 
-- 
expecting email to be received and understood is a bit like
picking up the telephone and immediately dialing without
checking for a dial-tone; speaking immediately without listening
for either an answer or ring-tone; hanging up immediately and
believing that you have actually started a conversation.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
