Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA05170
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 17:28:09 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id VAA10168
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 21:26:38 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id VAA10164
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 21:26:37 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id AC93C92465
	for <selinux@tycho.nsa.gov>; Sat, 28 Sep 2002 07:28:04 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id A6EBA9F6A
	for <selinux@tycho.nsa.gov>; Fri, 27 Sep 2002 23:27:56 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: apache
Date: Fri, 27 Sep 2002 23:27:56 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_KY84I8UYXI31ZJYAD5YU"
Message-Id: <200209272327.56232.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_KY84I8UYXI31ZJYAD5YU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a patch for the apache policy.

If someone here knows the Apache source then the best solution would be to get 
the Apache source patched to set the file handle in question to close on 
exec...

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_KY84I8UYXI31ZJYAD5YU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="a.diff"

diff -ru /tmp/policy/domains/program/apache.te ./domains/program/apache.te
--- /tmp/policy/domains/program/apache.te	2002-09-27 22:27:37.000000000 +0200
+++ ./domains/program/apache.te	2002-09-27 18:28:52.000000000 +0200
@@ -158,6 +158,10 @@
 allow httpd_suexec_process_t httpd_var_run_t:file rw_file_perms;
 allow httpd_suexec_process_t httpd_cache_t:file rw_file_perms;
 
+# apache should set close-on-exec
+dontaudit httpd_suexec_process_t httpd_t:unix_stream_socket { read write };
+dontaudit { system_mail_t mta_user_agent } httpd_t:unix_stream_socket { read write };
+
 #
 # If a user starts a script by hand it gets the proper context
 #

--------------Boundary-00=_KY84I8UYXI31ZJYAD5YU--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
