Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m1PEYbDe016686
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 09:34:37 -0500
Received: from ppsw-7.csi.cam.ac.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m1PEYaa4007808
	for <selinux@tycho.nsa.gov>; Mon, 25 Feb 2008 14:34:36 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:59437)
	by ppsw-7.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.137]:25)
	with esmtp id 1JTePS-00018n-Nf (Exim 4.67) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Mon, 25 Feb 2008 14:34:26 +0000
Message-ID: <47C2D1EE.7060309@martinorr.name>
Date: Mon, 25 Feb 2008 14:34:22 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_caligula-7955-1203950066-0001-2"
To: SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] loadkeys and init fds
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-7955-1203950066-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Prevent audit messages on boot:

Feb 25 13:52:47 caligula kernel: audit(1203947566.566:9): avc:  denied  {
use } for  pid=2900 comm="loadkeys" path="/dev/console" dev=tmpfs ino=311
context=system_u:system_r:loadkeys_t:s0 tcontext=system_u:system_r:init_t:s0
tclass=fd

Best wishes,

-- 
Martin Orr

--=_caligula-7955-1203950066-0001-2
Content-Type: text/x-patch; name="loadkeys_init_fd.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="loadkeys_init_fd.patch"

Index: policy/modules/apps/loadkeys.te
===================================================================
--- policy/modules/apps/loadkeys.te	(revision 2624)
+++ policy/modules/apps/loadkeys.te	(working copy)
@@ -32,6 +32,7 @@
 term_dontaudit_use_console(loadkeys_t)
 term_use_unallocated_ttys(loadkeys_t)
 
+init_dontaudit_use_fds(loadkeys_t)
 init_dontaudit_use_script_ptys(loadkeys_t)
 
 libs_use_ld_so(loadkeys_t)

--=_caligula-7955-1203950066-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
