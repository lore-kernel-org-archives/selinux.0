Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i9F8RGrT004164
	for <selinux@tycho.nsa.gov>; Fri, 15 Oct 2004 04:27:16 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i9F8RCxT022220
	for <selinux@tycho.nsa.gov>; Fri, 15 Oct 2004 08:27:14 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: Asterisk on SELinux
Date: Fri, 15 Oct 2004 18:27:05 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1097499317.16758.40.camel@wintermute.xmldesign.de>
In-Reply-To: <1097499317.16758.40.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Zn4bBUR0zAnCJYB"
Message-Id: <200410151827.05984.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--Boundary-00=_Zn4bBUR0zAnCJYB
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 11 Oct 2004 22:55, Erich Schubert <erich@debian.org> wrote:
> # the debian standard installation hasn't got all dirs needed
> allow asterisk_t asterisk_spool_t:dir create_dir_perms;

This is what create_dir_file() is for.

> # some helper apps are probably there
> allow asterisk_t { bin_t sbin_t }:dir search;

There seems little point in allowing directory search without allowing it to 
do anything under that directory.  This needs more investigation.

> Unfortunately, while asterisk does now start (as root only, not as
> non-root-user... not sure why, but i think the user/group setup isn't
> right yet... how do i change a unix users primary group in selinux?)
> my test SIP call didn't get properly accepted.

UID/GID stuff works the same way in SE Linux as in regular Linux, except that 
sometimes what you want is not permitted.  ;)

vipw/vigr do the usual stuff.

I've attached a patch for asterisk which includes the parts of your policy 
changes that I think are ready for inclusion.  I don't think that the sbin_t 
part is complete and therefore it shouldn't go in yet.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_Zn4bBUR0zAnCJYB
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="asterisk.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="asterisk.diff"

--- /usr/src/se/policy/net_contexts	2004-10-14 10:09:55.000000000 +1000
+++ net_contexts	2004-10-15 18:18:24.000000000 +1000
@@ -145,6 +145,7 @@
 portcon tcp 1720 system_u:object_r:asterisk_port_t
 portcon tcp 2000 system_u:object_r:asterisk_port_t
 portcon udp 2427 system_u:object_r:asterisk_port_t
+portcon udp 2727 system_u:object_r:asterisk_port_t
 portcon udp 4569 system_u:object_r:asterisk_port_t
 portcon udp 5060 system_u:object_r:asterisk_port_t
 ')
--- /usr/src/se/policy/domains/program/unused/asterisk.te	2004-08-28 12:05:01.000000000 +1000
+++ domains/program/unused/asterisk.te	2004-10-15 18:23:34.000000000 +1000
@@ -10,24 +10,37 @@
 allow asterisk_t asterisk_var_run_t:{ sock_file fifo_file } create_file_perms;
 allow initrc_t asterisk_var_run_t:fifo_file unlink;
 
+allow asterisk_t self:process setsched;
+allow asterisk_t self:fifo_file rw_file_perms;
+
+allow asterisk_t proc_t:file { getattr read };
+
 etcdir_domain(asterisk)
 logdir_domain(asterisk)
 var_lib_domain(asterisk)
 
-allow asterisk_t asterisk_port_t:{ udp_socket tcp_socket } name_bind;
+allow asterisk_t asterisk_port_t:{ udp_socket tcp_socket } name_bind;
+
+# for VOIP voice channels.
+aollow asterisk_t port_t:{ udp_socket tcp_socket } name_bind;
 
 allow asterisk_t device_t:lnk_file read;
 allow asterisk_t sound_device_t:chr_file rw_file_perms;
 
 type asterisk_spool_t, file_type, sysadmfile;
-rw_dir_create_file(asterisk_t, asterisk_spool_t)
+create_dir_file(asterisk_t, asterisk_spool_t)
 allow asterisk_t var_spool_t:dir search;
 
+# demo files installed in /usr/share/asterisk/sounds/demo-instruct.gsm
+# are labeled usr_t
+allow asterisk_t usr_t:file r_file_perms;
+
 can_network(asterisk_t)
 can_ypbind(asterisk_t)
 allow asterisk_t etc_t:file { getattr read };
 
 allow asterisk_t self:unix_stream_socket { connectto create_stream_socket_perms };
+allow sysadm_t asterisk_t:unix_stream_socket { connectto rw_stream_socket_perms };
 allow asterisk_t self:sem create_sem_perms;
 allow asterisk_t self:shm create_shm_perms;
 
@@ -35,3 +48,4 @@
 allow asterisk_t self:capability dac_override;
 
 tmpfs_domain(asterisk)
+tmp_domain(asterisk)

--Boundary-00=_Zn4bBUR0zAnCJYB--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
