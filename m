Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id FAA01129
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 05:58:25 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id JAA08816
	for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 09:56:37 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
        by jazzband.ncsc.mil  with ESMTP id JAA08812 for <selinux@tycho.nsa.gov>; Tue, 1 Oct 2002 09:56:33 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 9DA1692465
	for <selinux@tycho.nsa.gov>; Tue,  1 Oct 2002 19:58:17 +1000 (EST)
Received: from lyta (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id E609C7B1
	for <selinux@tycho.nsa.gov>; Tue,  1 Oct 2002 11:58:04 +0200 (CEST)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: selinux@tycho.nsa.gov
Subject: rlogin policy patch
Date: Tue, 1 Oct 2002 11:58:04 +0200
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_SORAC6OIOVPVNQ0LMT7G"
Message-Id: <200210011158.04480.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--------------Boundary-00=_SORAC6OIOVPVNQ0LMT7G
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I've attached a patch for the Debian telnetd setup.  In Debian telnetd runs a 
SUID root wrapper for calling /bin/login so that telnetd can be run as 
non-root.

For running with SE Linux it's easiest to just run telnetd as root (to deny 
inetd setuid capability) but it still calls the wrapper by default anyway.

This patch allows that use, and doesn't give any significant extra access, so 
I think it is worthy of inclusion in the CVS.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--------------Boundary-00=_SORAC6OIOVPVNQ0LMT7G
Content-Type: text/x-diff;
  charset="us-ascii";
  name="rlogin.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="rlogin.diff"

diff -ru default/domains/program/rlogind.te current/domains/program/rlogind.te
--- default/domains/program/rlogind.te	Tue Oct  1 17:18:52 2002
+++ current/domains/program/rlogind.te	Tue Oct  1 18:58:29 2002
@@ -15,6 +15,9 @@
 domain_auto_trans(inetd_t, rlogind_exec_t, rlogind_t)
 domain_auto_trans(tcpd_t, rlogind_exec_t, rlogind_t)
 
+# for /usr/lib/telnetlogin
+can_exec(rlogind_t, rlogind_exec_t)
+
 type rlogind_tmp_t, file_type, sysadmfile, tmpfile;
 file_type_auto_trans(rlogind_t, tmp_t, rlogind_tmp_t)
 
diff -ru default/file_contexts/program/rlogind.fc current/file_contexts/program/rlogind.fc
--- default/file_contexts/program/rlogind.fc	Tue Oct  1 17:18:52 2002
+++ current/file_contexts/program/rlogind.fc	Tue Oct  1 18:57:26 2002
@@ -1,3 +1,4 @@
 # rlogind and telnetd
 /usr/sbin/in.rlogind		system_u:object_r:rlogind_exec_t
 /usr/sbin/in.telnetd		system_u:object_r:rlogind_exec_t
+/usr/lib/telnetlogin		system_u:object_r:rlogind_exec_t

--------------Boundary-00=_SORAC6OIOVPVNQ0LMT7G--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
