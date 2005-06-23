Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5N6HWgA024075
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 02:17:34 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5N673RO019994
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 06:07:14 GMT
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 7598061B02
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:07:25 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 02601-08 for <selinux@tycho.nsa.gov>;
	Thu, 23 Jun 2005 16:07:25 +1000 (EST)
Received: from aeon.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 6886561B01
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:07:24 +1000 (EST)
Received: from aeon (aeon [127.0.0.1])
	by aeon.coker.com.au (Postfix) with ESMTP id BEA8B37
	for <selinux@tycho.nsa.gov>; Thu, 23 Jun 2005 16:07:21 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "SE-Linux" <selinux@tycho.nsa.gov>
Subject: ssh-keysign
Date: Thu, 23 Jun 2005 16:07:17 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ZGluCv+NuJSBaFU"
Message-Id: <200506231607.21501.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_ZGluCv+NuJSBaFU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=46rom the man page it appears that ssh-keysign can only be invoked from ss=
h(1). =20
Therefore shouldn't this policy:
domain_auto_trans($1_t, ssh_keysign_exec_t, $1_ssh_keysign_t)
Be replaced by this:
domain_auto_trans($1_ssh_t, ssh_keysign_exec_t, $1_ssh_keysign_t)

The $1_ssh_keysign_t domain can read the sshd private keys so we want to=20
restrict transitions to it as much as possible.

I've attached a patch to demonstrate the concept.  The boolean=20
allow_ssh_keysign needs to be defined in ssh.te.

=2D-=20
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_ZGluCv+NuJSBaFU
Content-Type: text/x-diff;
  charset="us-ascii";
  name="ssh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ssh.diff"

--- macros/program/ssh_macros.te.orig	2005-06-23 16:04:18.000000000 +1000
+++ macros/program/ssh_macros.te	2005-06-23 16:06:13.000000000 +1000
@@ -143,7 +143,9 @@
 
 type $1_ssh_keysign_t, domain, nscd_client_domain;
 role $1_r types $1_ssh_keysign_t;
-domain_auto_trans($1_t, ssh_keysign_exec_t, $1_ssh_keysign_t)
+
+if (allow_ssh_keysign) {
+domain_auto_trans($1_ssh_t, ssh_keysign_exec_t, $1_ssh_keysign_t)
 allow $1_ssh_keysign_t sshd_key_t:file { getattr read };
 allow $1_ssh_keysign_t self:capability { setgid setuid };
 allow $1_ssh_keysign_t urandom_device_t:chr_file r_file_perms;
@@ -156,6 +158,7 @@
 allow $1_ssh_keysign_t self:dir search;
 allow $1_ssh_keysign_t self:file { getattr read };
 allow $1_ssh_keysign_t self:unix_stream_socket create_socket_perms;
+}
 
 ')dnl end macro definition
 ', `

--Boundary-00=_ZGluCv+NuJSBaFU--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
