Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id SAA28211
	for <selinux@tycho.nsa.gov>; Sat, 15 Feb 2003 18:45:39 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA13705
	for <selinux@tycho.nsa.gov>; Sat, 15 Feb 2003 23:42:33 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA13701
	for <selinux@tycho.nsa.gov>; Sat, 15 Feb 2003 23:42:30 GMT
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id ED9AE9253C
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 10:45:18 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 77D404121
	for <selinux@tycho.nsa.gov>; Sun, 16 Feb 2003 00:45:11 +0100 (CET)
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: NetSaint
Date: Sun, 16 Feb 2003 00:45:10 +0100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_GEtT+E52gu704nd"
Message-Id: <200302160045.10585.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_GEtT+E52gu704nd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've attached policy for the NetSaint system monitoring tool.

It has a netsaint_t domain for the daemon and netsaint_cgi_t for the cgi-bin 
scripts.  I haven't done support for the web based configuration tool because 
I haven't got that far, and because I'm not certain that it's a good idea 
(because of security and managability issues).

This policy is not complete, because I haven't completely figured out the 
NetSaint configuration files yet.  Hopefully someone here will be a NetSaint 
expert and be able to help me.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_GEtT+E52gu704nd
Content-Type: text/plain;
  charset="us-ascii";
  name="netsaint.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="netsaint.fc"

# netsaint - network monitoring server
/usr/sbin/netsaint		system_u:object_r:netsaint_exec_t
/var/lib/ldap(/.*)?		system_u:object_r:netsaint_db_t
#/var/run/netsaint(/.*)?		system_u:object_r:var_run_netsaint_t
/etc/netsaint(/.*)?		system_u:object_r:etc_netsaint_t
/var/log/netsaint(/.*)?		system_u:object_r:netsaint_log_t
/usr/lib/netsaint/plugins(/.*)?	system_u:object_r:bin_t
/usr/lib/cgi-bin/netsaint/.+	system_u:object_r:netsaint_cgi_exec_t

--Boundary-00=_GEtT+E52gu704nd
Content-Type: text/plain;
  charset="us-ascii";
  name="netsaint.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="netsaint.te"

#DESC Net Saint - network monitoring server
#
# Author:  Russell Coker <russell@coker.com.au>
#

#################################
#
# Rules for the netsaint_t domain.
#
# netsaint_exec_t is the type of the netsaint executable.
#
daemon_domain(netsaint)

type etc_netsaint_t, file_type, sysadmfile;
type netsaint_db_t, file_type, sysadmfile;

log_domain(netsaint)

# Use the network.
allow netsaint_t self:fifo_file rw_file_perms;
allow netsaint_t self:unix_stream_socket create_socket_perms;
allow netsaint_t self:unix_dgram_socket create_socket_perms;

# Use capabilities
allow netsaint_t self:capability { setgid setuid };
allow netsaint_t self:process setpgid;

allow netsaint_t { bin_t sbin_t }:dir search;
allow netsaint_t bin_t:lnk_file read;
can_exec(netsaint_t, { shell_exec_t bin_t })

allow netsaint_t proc_t:file { getattr read };

# read config files
allow netsaint_t { etc_t resolv_conf_t etc_runtime_t }:file { getattr read };
allow netsaint_t etc_t:lnk_file read;

allow netsaint_t etc_t:dir r_dir_perms;
r_dir_file(netsaint_t, etc_netsaint_t)

# for ps
r_dir_file(netsaint_t, domain)
allow netsaint_t boot_t:dir search;
allow netsaint_t system_map_t:file { getattr read };

# for who
allow netsaint_t initrc_var_run_t:file { getattr read lock };

system_domain(netsaint_cgi)
allow netsaint_cgi_t device_t:dir search;
r_dir_file(netsaint_cgi_t, etc_netsaint_t)
allow netsaint_cgi_t var_log_t:dir search;
r_dir_file(netsaint_cgi_t, netsaint_log_t)
allow netsaint_cgi_t self:process { fork signal_perms };
allow netsaint_cgi_t self:fifo_file rw_file_perms;
allow netsaint_cgi_t bin_t:dir search;
can_exec(netsaint_cgi_t, bin_t)
# for ps
allow netsaint_cgi_t { etc_runtime_t etc_t }:file { getattr read };
r_dir_file(netsaint_cgi_t, { proc_t self netsaint_t })
allow netsaint_cgi_t boot_t:dir search;
allow netsaint_cgi_t system_map_t:file { getattr read };
dontaudit netsaint_cgi_t domain:dir getattr;
allow netsaint_cgi_t self:unix_stream_socket create_socket_perms;

ifdef(`apache.te', `
r_dir_file(httpd_t, etc_netsaint_t)
domain_auto_trans(httpd_t, netsaint_cgi_exec_t, netsaint_cgi_t)
allow netsaint_cgi_t httpd_log_files_t:file append;
')

ifdef(`mta.te', `
domain_auto_trans(initrc_t, sendmail_exec_t, system_mail_t)
')

ifdef(`ping.te', `
domain_auto_trans_read(netsaint_t, ping_exec_t, ping_t)
dontaudit ping_t etc_netsaint_t:file read;
dontaudit ping_t netsaint_log_t:fifo_file read;
')

--Boundary-00=_GEtT+E52gu704nd--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
