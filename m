Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6LBlRgA024731
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 07:47:27 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6LBfpBa002278
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 11:42:04 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 3B58B61B00
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 21:42:30 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 25170-07 for <selinux@tycho.nsa.gov>;
	Thu, 21 Jul 2005 21:42:29 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id C801061AFE
	for <selinux@tycho.nsa.gov>; Thu, 21 Jul 2005 21:42:29 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>, Daniel J Walsh <dwalsh@redhat.com>,
   fedora-selinux-list@redhat.com
Subject: ainit
Date: Thu, 21 Jul 2005 21:42:23 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ko43C00AtN4/pfv"
Message-Id: <200507212142.28830.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_ko43C00AtN4/pfv
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The attached patch is needed for correct functionality of ainit with the 
latest strict policy when running reasonably recent rawhide packages.

Is this really what we want?  Having a system process allocate shared memory 
that can be used by any user processes?  Also it seems likely that other 
sound programs will need to access the shared memory in question.

There are three possible assumptions that we could make:

1)  Anyone who is serious about security doesn't use ALSA so such access 
doesn't matter that much.

2)  Sound devices are a channel for communication anyway so it doesn't really 
grant any new access.  NB  I don't know enough about sound programming to 
know whether this assumption is correct.  Does ALSA require that a shared 
memory segment be available to all programs that are accessing the sound 
device?  If so the assumption holds for ALSA.  Can an application stuff some 
data into the sound hardware without using the user-space code from ALSA in 
such a way that another application can read it?

3)  We need to have pam_console launch programs such as ainit in a context 
determined by the user role.


Option 3 might be the best one long-term.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_ko43C00AtN4/pfv
Content-Type: text/x-diff;
  charset="us-ascii";
  name="alsa.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="alsa.diff"

--- domains/program/alsa.te.orig	2005-07-20 17:08:26.000000000 +1000
+++ domains/program/alsa.te	2005-07-20 17:36:28.000000000 +1000
@@ -5,13 +5,20 @@
 #
 type alsa_t, domain, privlog, daemon;
 type alsa_exec_t, file_type, sysadmfile, exec_type;
+role system_r types alsa_t;
 uses_shlib(alsa_t)
+read_locale(alsa_t)
+dontaudit alsa_t var_t:dir search;
 allow alsa_t self:sem  create_sem_perms;
 allow alsa_t self:shm  create_shm_perms;
 allow alsa_t self:unix_stream_socket create_stream_socket_perms;
+allow alsa_t self:unix_dgram_socket create_socket_perms;
 type alsa_etc_rw_t, file_type, sysadmfile, usercanread;
 rw_dir_create_file(alsa_t,alsa_etc_rw_t)
-allow alsa_t self:capability { setgid setuid ipc_owner };
+allow alsa_t self:capability { setgid setuid ipc_owner sys_admin };
 allow alsa_t devpts_t:chr_file { read write };
 allow alsa_t etc_t:file { getattr read };
 domain_auto_trans(pam_console_t, alsa_exec_t, alsa_t)
+
+allow userdomain alsa_t:sem rw_sem_perms;
+allow userdomain alsa_t:shm { rw_shm_perms destroy };

--Boundary-00=_ko43C00AtN4/pfv--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
