Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m2RC2aft027172
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 08:02:36 -0400
Received: from queueout01-winn.ispmail.ntl.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id m2RC2ZlO000107
	for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 12:02:35 GMT
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080327104825.FFJH1244.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 10:48:25 +0000
Received: from [192.168.1.102] (really [82.18.189.14])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20080327105048.MMNT26699.aamtaout03-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Thu, 27 Mar 2008 10:50:48 +0000
Message-ID: <47EB7AA5.1030502@martinorr.name>
Date: Thu, 27 Mar 2008 10:44:53 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_caligula-10774-1206614696-0001-2"
To: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SELinux List <selinux@tycho.nsa.gov>
Subject: [refpolicy] lvm runs shell scripts
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-10774-1206614696-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

crytpsetup, for setting up encrypted volumes, runs shell scripts during this
process which gives me:

Mar 27 10:16:41 caligula kernel: audit(1206612989.635:4): avc:  denied  {
execute } for  pid=2929 comm="cryptsetup" name="dash" dev=dm-0 ino=470542
scontext=system_u:system_r:lvm_t:s0
tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

Attached patch fixes this.

Best wishes,

-- 
Martin Orr

--=_caligula-10774-1206614696-0001-2
Content-Type: text/plain; name="113_cryptsetup_shell"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="113_cryptsetup_shell"

Written by: Martin Orr

Allow cryptsetup to run shell scripts

Mar 27 10:16:41 caligula kernel: audit(1206612989.635:4): avc:  denied  { execute } for  pid=2929 comm="cryptsetup" name="dash" dev=dm-0 ino=470542 scontext=system_u:system_r:lvm_t:s0 tcontext=system_u:object_r:shell_exec_t:s0 tclass=file

Index: policy/modules/system/lvm.te
===================================================================
--- policy/modules/system/lvm.te.orig
+++ policy/modules/system/lvm.te
@@ -247,6 +247,7 @@
 term_list_ptys(lvm_t)
 
 corecmd_exec_bin(lvm_t)
+corecmd_exec_shell(lvm_t)
 
 domain_use_interactive_fds(lvm_t)
 

--=_caligula-10774-1206614696-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
