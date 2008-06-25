Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m5PGViwX028553
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 12:31:44 -0400
Received: from mtaout01-winn.ispmail.ntl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m5PGVc0Z003546
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 16:31:43 GMT
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080625163605.DRBI28496.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>
          for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 17:36:05 +0100
Received: from [192.168.1.102] (really [82.18.189.14])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080625163452.NZLZ29365.aamtaout02-winn.ispmail.ntl.com@[192.168.1.102]>
          for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2008 17:34:52 +0100
Message-ID: <486272E3.109@martinorr.name>
Date: Wed, 25 Jun 2008 17:31:31 +0100
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_caligula-11776-1214411494-0001-2"
To: SELinux List <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: [refpolicy] Let dpkg scripts ptrace
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-11776-1214411494-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

Some dpkg maintainer scripts run pidof, which needs the sys_ptrace capability.

Mar 17 15:14:31 caligula kernel: audit(1205766871.788:13): avc:  denied  {
sys_ptrace } for  pid=4214 comm="pidof" capability=19
scontext=system_u:system_r:dpkg_script_t:s0
tcontext=system_u:system_r:dpkg_script_t:s0 tclass=capability

-- 
Martin Orr

--=_caligula-11776-1214411494-0001-2
Content-Type: text/plain; name="118_dpkg_script_pidof"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="118_dpkg_script_pidof"

Written by: Martin Orr

Allow dpkg scripts to run pidof

Mar 17 15:14:31 caligula kernel: audit(1205766871.788:13): avc:  denied  { sys_ptrace } for  pid=4214 comm="pidof" capability=19 scontext=system_u:system_r:dpkg_script_t:s0 tcontext=system_u:system_r:dpkg_script_t:s0 tclass=capability

Index: policy/modules/admin/dpkg.te
===================================================================
--- policy/modules/admin/dpkg.te.orig
+++ policy/modules/admin/dpkg.te
@@ -216,7 +216,7 @@
 #
 # TODO: actually use dpkg_script_t
 
-allow dpkg_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot sys_nice mknod kill };
+allow dpkg_script_t self:capability { chown dac_override dac_read_search fowner fsetid setgid setuid ipc_lock sys_chroot sys_nice mknod kill sys_ptrace };
 allow dpkg_script_t self:process ~{ ptrace setcurrent setexec setfscreate setrlimit execmem execstack execheap };
 allow dpkg_script_t self:fd use;
 allow dpkg_script_t self:fifo_file rw_fifo_file_perms;

--=_caligula-11776-1214411494-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
