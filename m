Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i2D5a9Rb005532
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 00:36:10 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i2D5a80F028284
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 05:36:08 GMT
Received: from ns.sws.net.au ([61.95.69.3])
        by jazzband.ncsc.mil  with ESMTP id i2D5a6gZ028253 for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 05:36:07 GMT
Received: from localhost (localhost [127.0.0.1])
	by ns.sws.net.au (Postfix) with ESMTP id 64C2A61C66
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 16:34:46 +1100 (EST)
Received: from ns.sws.net.au ([127.0.0.1])
	by localhost (ns [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 07505-05 for <selinux@tycho.nsa.gov>;
	Sat, 13 Mar 2004 16:34:45 +1100 (EST)
Received: from tsv.sws.net.au (tsv.sws.net.au [61.95.69.2])
	by ns.sws.net.au (Postfix) with ESMTP id AC42A61C52
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 16:34:45 +1100 (EST)
Received: from kaos.lurking-grue.org (localhost [127.0.0.1])
	by tsv.sws.net.au (Postfix) with ESMTP id 7E1E7924F4
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 16:34:45 +1100 (EST)
Received: from kaos (kaos [127.0.0.1])
	by kaos.lurking-grue.org (Postfix) with ESMTP id A51CC7FF7
	for <selinux@tycho.nsa.gov>; Sat, 13 Mar 2004 16:34:43 +1100 (EST)
From: Faye Coker <faye@lurking-grue.org>
Reply-To: faye@lurking-grue.org
To: selinux@tycho.nsa.gov
Subject: policy for INN
Date: Sat, 13 Mar 2004 16:34:42 +1100
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_y1pUACs3MkGx2Tl"
Message-Id: <200403131634.42870.faye@lurking-grue.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_y1pUACs3MkGx2Tl
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Attached are the policy and file_contexts files needed for basic INN 
functionality.  You will need to add the following to your net_contexts file:

ifdef(`innd.te', `portcon tcp 119 system_u:object_r:innd_port_t')


faye
-- 
Faye Coker
faye@lurking-grue.org


--Boundary-00=_y1pUACs3MkGx2Tl
Content-Type: text/plain;
  charset="us-ascii";
  name="innd.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="innd.te"

#DESC INN - InterNetNews server
#
# Author:  Faye Coker <faye@lurking-grue.org>
# X-Debian-Packages: inn
#
################################

# Types for the server port and news spool.
#
type innd_port_t, port_type;
type news_spool_t, file_type, sysadmfile;


# need privmail attribute so innd can access system_mail_t
daemon_domain(innd, `, privmail')

# allow innd to create files and directories of type news_spool_t
create_dir_file(innd_t, news_spool_t)

# allow user domains to read files and directories these types
r_dir_file(userdomain, { news_spool_t innd_var_lib_t innd_etc_t })

can_exec(initrc_t, innd_etc_t)
can_exec(innd_t, { innd_exec_t bin_t })
ifdef(`hostname.te', `
can_exec(innd_t, hostname_exec_t)
')

allow innd_t var_spool_t:dir { getattr search };

can_network(innd_t)

can_unix_send( { innd_t sysadm_t }, { innd_t sysadm_t } )
allow innd_t self:unix_dgram_socket create_socket_perms;
allow innd_t self:unix_stream_socket create_stream_socket_perms;
can_unix_connect(innd_t, self)

allow innd_t self:fifo_file rw_file_perms;
allow innd_t innd_port_t:tcp_socket name_bind;

allow innd_t self:capability { dac_override kill setgid setuid net_bind_service };
allow innd_t self:process setsched;

allow innd_t { bin_t sbin_t }:dir search;
allow innd_t usr_t:lnk_file read;
allow innd_t usr_t:file { getattr read ioctl };
allow innd_t lib_t:file ioctl;
allow innd_t { etc_t resolv_conf_t }:file { getattr read };
allow innd_t { proc_t etc_runtime_t }:file { getattr read };
allow innd_t urandom_device_t:chr_file read;

allow innd_t innd_var_run_t:sock_file create_file_perms;

# allow innd to read directories of type innd_etc_t (/etc/news/(/.*)? and symbolic links with that type
etcdir_domain(innd)

# allow innd to create files under /var/log of type innd_log_t and have a directory for its own files that
# it can write to
logdir_domain(innd)

# allow innd read-write directory permissions to /var/lib/news.
var_lib_domain(innd)

ifdef(`crond.te', `
system_crond_entry(innd_exec_t, innd_t)
')

--Boundary-00=_y1pUACs3MkGx2Tl
Content-Type: text/plain;
  charset="us-ascii";
  name="innd.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="innd.fc"

/usr/sbin/innd.*	--	system_u:object_r:innd_exec_t
/var/run/innd(/.*)?		system_u:object_r:innd_var_run_t
/etc/news(/.*)?			system_u:object_r:innd_etc_t
/etc/news/boot		--	system_u:object_r:innd_exec_t
/var/spool/news(/.*)?		system_u:object_r:news_spool_t
/var/log/news(/.*)?		system_u:object_r:innd_log_t
/var/lib/news(/.*)?		system_u:object_r:innd_var_lib_t
/usr/sbin/in.nnrpd	--	system_u:object_r:innd_exec_t
/usr/lib/news/bin/.*	--	system_u:object_r:innd_exec_t
/usr/bin/inews		--	system_u:object_r:innd_exec_t
/usr/bin/rnews		--	system_u:object_r:innd_exec_t

--Boundary-00=_y1pUACs3MkGx2Tl--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
