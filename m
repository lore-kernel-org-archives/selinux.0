Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h5P8nn3E028050
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 04:49:49 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h5P8n1ss007500
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 08:49:01 GMT
Received: from monk.verbum.org (mx-outgoing.verbum.org [216.226.142.159])
	by jazzswing.ncsc.mil  with ESMTP id h5P8n0hY007497
	for <selinux@tycho.nsa.gov>; Wed, 25 Jun 2003 08:49:01 GMT
Subject: Re: local policy changes, /var/lib access, syslogd
From: Colin Walters <walters@verbum.org>
To: Russell Coker <russell@coker.com.au>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <200306251613.08168.russell@coker.com.au>
References: <1056505792.29159.43.camel@columbia>
	 <200306251422.26574.russell@coker.com.au>
	 <1056518166.744.20.camel@columbia>
	 <200306251613.08168.russell@coker.com.au>
Content-Type: multipart/mixed; boundary="=-XByM+sMJDcWRJNVe7r+6"
Message-Id: <1056530966.744.67.camel@columbia>
Mime-Version: 1.0
Date: 25 Jun 2003 04:49:27 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-XByM+sMJDcWRJNVe7r+6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, 2003-06-25 at 02:13, Russell Coker wrote:
> On Wed, 25 Jun 2003 15:16, Colin Walters wrote:
> > It just looks like this (for example):
> >
> > avc:  denied  { search } for  pid=5269 exe=/usr/lib/postfix/tlsmgr
> > path=/lib dev=16:01 ino=32769 scontext=system_u:system_r:postfix_master_t
> > tcontext=system_u:object_r:var_lib_t tclass=dir
> 
> tlsmgr apparently caches some information on connections (public keys for TLS 
> I guess) under /var/lib.  Policy needs to be adjusted for this.

Ah, I have it.  This is all actually my fault.  I have 

tls_random_exchange_name = /var/lib/postfix/prng_exch

This was leftover from a previous postfix configuration.  I want to have
/etc RO in general, and plus the prng_exch kept showing up in my
integrit reports.  It really belongs in /var.  I'm going to be asking
the maintainer to change it upstream.

> tlsmgr 
> probably needs it's own domain.

Yeah.

> Something like the following should do it.  Try it out and send me whatever 
> variant on it works.  

Ok, I ended up not using the tlscache stuff.  My changes to postfix.te
and postfix.fc are attached.

> I haven't raised this issue for discussion on debian-devel because I've got 
> more than enough other things to bother with at the moment.

Ok.  Yeah, I wasn't using the db stuff at all.  I agree it probably
shouldn't be the default.  In the meantime though what do you think
about adding some dontaudit rules?


--=-XByM+sMJDcWRJNVe7r+6
Content-Disposition: attachment; filename=postfix.te.patch
Content-Type: text/plain; name=postfix.te.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/domains/program/postfix.te	Sat May 24=
 22:07:24 2003
+++ postfix.te	Wed Jun 25 16:47:45 2003
@@ -10,6 +10,7 @@
 type postfix_exec_t, file_type, sysadmfile, exec_type;
 type postfix_public_t, file_type, sysadmfile;
 type postfix_private_t, file_type, sysadmfile;
+type postfix_lib_t, file_type, sysadmfile;
 type postfix_spool_t, file_type, sysadmfile;
 type postfix_spool_maildrop_t, file_type, sysadmfile;
 type postfix_spool_flush_t, file_type, sysadmfile;
@@ -39,6 +40,8 @@
 allow postfix_$1_t bin_t:lnk_file r_file_perms;
 allow postfix_$1_t shell_exec_t:file rx_file_perms;
 allow postfix_$1_t var_spool_t:dir r_dir_perms;
+allow postfix_$1_t var_lib_t:dir {search getattr};
+allow postfix_$1_t postfix_lib_t:dir r_dir_perms;
 allow postfix_$1_t postfix_exec_t:file rx_file_perms;
 allow postfix_$1_t devtty_t:chr_file rw_file_perms;
 allow postfix_$1_t etc_runtime_t:file r_file_perms;
@@ -91,7 +94,8 @@
 allow postfix_master_t etc_aliases_t:file r_file_perms;
 create_dir_file(postfix_master_t, postfix_spool_flush_t)
 allow postfix_master_t random_device_t:chr_file { read getattr };
-allow postfix_master_t postfix_prng_t:file rw_file_perms;
+allow postfix_master_t postfix_lib_t:dir rw_dir_perms;
+allow postfix_master_t postfix_prng_t:file create_file_perms;
=20
 # allow access to deferred queue and allow removing bogus incoming entries
 allow postfix_master_t postfix_spool_t:dir create_dir_perms;
@@ -114,18 +118,21 @@
 allow postfix_smtp_t postfix_spool_t:file rw_file_perms;
 allow postfix_smtp_t { postfix_private_t postfix_public_t }:dir search;
 allow postfix_smtp_t { postfix_private_t postfix_public_t }:sock_file writ=
e;
-allow postfix_smtp_t random_device_t:chr_file r_file_perms;
 allow postfix_smtp_t postfix_master_t:unix_stream_socket connectto;
=20
 postfix_server_domain(smtpd)
-allow postfix_smtpd_t random_device_t:chr_file r_file_perms;
 allow postfix_smtpd_t postfix_master_t:tcp_socket rw_stream_socket_perms;
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:dir search;
 allow postfix_smtpd_t { postfix_private_t postfix_public_t }:sock_file rw_=
file_perms;
 allow postfix_smtpd_t postfix_master_t:unix_stream_socket connectto;
 allow postfix_smtpd_t etc_aliases_t:file r_file_perms;
=20
-allow { postfix_smtp_t postfix_smtpd_t } postfix_prng_t:file rw_file_perms=
;
+postfix_server_domain(tlsmgr)
+allow postfix_tlsmgr_t postfix_master_t:tcp_socket rw_stream_socket_perms;
+allow postfix_tlsmgr_t postfix_private_t:fifo_file rw_file_perms;
+
+allow { postfix_smtp_t postfix_smtpd_t postfix_tlsmgr_t } random_device_t:=
chr_file r_file_perms;
+allow { postfix_smtp_t postfix_smtpd_t postfix_tlsmgr_t } postfix_prng_t:f=
ile rw_file_perms;
=20
 postfix_server_domain(local, `, mta_delivery_agent')
 ifdef(`procmail.te', `

--=-XByM+sMJDcWRJNVe7r+6
Content-Disposition: attachment; filename=postfix.fc.patch
Content-Type: text/plain; name=postfix.fc.patch; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- /usr/share/selinux/policy/default/file_contexts/program/postfix.fc	Sat =
May 24 22:07:24 2003
+++ ../../file_contexts/program/postfix.fc	Wed Jun 25 16:32:47 2003
@@ -2,6 +2,8 @@
 /etc/postfix(/.*)?		system_u:object_r:etc_postfix_t
 /etc/postfix/postfix-script.*	system_u:object_r:postfix_exec_t
 /etc/postfix/prng_exch		system_u:object_r:postfix_prng_t
+/var/lib/postfix(/.*)?		system_u:object_r:postfix_lib_t
+/var/lib/postfix/prng_exch	system_u:object_r:postfix_prng_t
 /usr/lib/postfix/.*		system_u:object_r:postfix_exec_t
 /usr/lib/postfix/cleanup	system_u:object_r:postfix_cleanup_exec_t
 /usr/lib/postfix/local		system_u:object_r:postfix_local_exec_t
@@ -11,6 +13,7 @@
 /usr/lib/postfix/showq		system_u:object_r:postfix_showq_exec_t
 /usr/lib/postfix/smtp		system_u:object_r:postfix_smtp_exec_t
 /usr/lib/postfix/smtpd		system_u:object_r:postfix_smtpd_exec_t
+/usr/lib/postfix/tlsmgr         system_u:object_r:postfix_tlsmgr_exec_t
 /usr/lib/postfix/bounce		system_u:object_r:postfix_bounce_exec_t
 /usr/lib/postfix/pipe		system_u:object_r:postfix_pipe_exec_t
 /usr/sbin/postalias		system_u:object_r:postfix_master_exec_t

--=-XByM+sMJDcWRJNVe7r+6--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
