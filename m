Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8HAF7La024083
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 06:15:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8HAF5mw000409
	for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:15:05 GMT
Received: from sat.sws.net.au (sat.sws.net.au [202.5.161.49])
        by jazzband.ncsc.mil  with ESMTP id h8HAF39d000403 for <selinux@tycho.nsa.gov>; Wed, 17 Sep 2003 10:15:04 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: Boot time avc messages
Date: Wed, 17 Sep 2003 20:14:59 +1000
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
References: <20030915214153.GE8988@vnl.com> <20030916145353.GM8988@vnl.com>
In-Reply-To: <20030916145353.GM8988@vnl.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jQDa/V0BwCSRczn"
Message-Id: <200309172014.59503.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_jQDa/V0BwCSRczn
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 17 Sep 2003 00:53, Dale Amon wrote:

Here's a new syslogd.te that should solve most of the problems you had.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_jQDa/V0BwCSRczn
Content-Type: text/plain;
  charset="iso-8859-1";
  name="syslogd.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="syslogd.te"

#DESC Syslogd - System log daemon
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
# X-Debian-Packages: sysklogd syslog-ng
#

#################################
#
# Rules for the syslogd_t domain.
#
# syslogd_t is the domain of syslogd.
# syslogd_exec_t is the type of the syslogd executable.
# devlog_t is the type of the Unix domain socket created 
# by syslogd.
#
ifdef(`klogd.te', `
daemon_domain(syslogd)
', `
daemon_domain(syslogd, `, privmem')
')

# can_network is for the UDP socket
can_network(syslogd_t)

type devlog_t, file_type, sysadmfile;

# if something can log to syslog they should be able to log to the console
allow privlog console_device_t:chr_file { ioctl read write getattr };

tmp_domain(syslogd)

# read files in /etc
allow syslogd_t etc_t:file r_file_perms;
allow syslogd_t resolv_conf_t:{ file lnk_file } r_file_perms;

# Use capabilities.
allow syslogd_t syslogd_t:capability { net_bind_service dac_override };

# Inherit and use descriptors from init.
allow syslogd_t init_t:fd use;
allow syslogd_t { initrc_devpts_t console_device_t }:chr_file { read write };

# Modify/create log files.
create_append_log_file(syslogd_t, var_log_t)

# Create and bind to /dev/log or /var/run/log.
file_type_auto_trans(syslogd_t, { device_t var_run_t }, devlog_t, sock_file)
allow syslogd_t self:unix_dgram_socket create_socket_perms;
allow syslogd_t self:unix_dgram_socket { sendto };
allow syslogd_t self:unix_stream_socket create_stream_socket_perms;
allow syslogd_t self:fifo_file rw_file_perms;
allow syslogd_t devlog_t:unix_stream_socket name_bind;
allow syslogd_t devlog_t:unix_dgram_socket name_bind;

# Domains with the privlog attribute may log to syslogd.
allow privlog devlog_t:sock_file rw_file_perms;
can_unix_send(privlog,syslogd_t)
can_unix_connect(privlog,syslogd_t)
# allow /dev/log to be a link elsewhere for chroot setup
allow privlog devlog_t:lnk_file read;

ifdef(`crond.te', `
# Write to the cron log.
allow syslogd_t crond_log_t:file rw_file_perms;
')

ifdef(`logrotate.te', `
allow logrotate_t syslogd_exec_t:file r_file_perms;
')

# uncomment this to allow syslogd to log to virtual consoles
#allow syslogd_t tty_device_t:chr_file rw_file_perms;

ifdef(`klogd.te', `', `
# Allow access to /proc/kmsg for syslog-ng
allow syslogd_t proc_t:dir search;
allow syslogd_t proc_kmsg_t:file { getattr read };
allow syslogd_t kernel_t:system { syslog_mod syslog_console };
')

--Boundary-00=_jQDa/V0BwCSRczn--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
