Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id RAA02183
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 17:30:02 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id WAA18727
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 22:27:12 GMT
Received: from unicorn.lemuria.org (b069097.adsl.hansenet.de [62.109.69.97])
	by jazzswing.ncsc.mil  with ESMTP id WAA18722
	for <selinux@tycho.nsa.gov>; Tue, 21 Jan 2003 22:27:10 GMT
Date: Tue, 21 Jan 2003 23:24:52 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: Apache/mysql policy status ?
Message-ID: <20030121232452.E24908@lemuria.org>
References: <200301211848.NAA02352@moss-shockers.ncsc.mil> <200301212042.11953.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
In-Reply-To: <200301212042.11953.russell@coker.com.au>; from russell@coker.com.au on Tue, Jan 21, 2003 at 08:42:11PM +0100
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 21, 2003 at 08:42:11PM +0100, Russell Coker wrote:
> mysqld was permitted to write to var_log_t files and initrc_t was permitted to 
> write to mysqld_log_t files.

As I recall, the later is necessary because the wrapper script insists
on putting some startup information into the mysql logfiles. I don't
remember the reason for the prior one, but I'm fairly sure I didn't
just put random stuff in there. :)

I have the policy attached. Check it and tell me which parts make you
unhappy.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mysqld.te"

#DESC mysql database server
#
# Authors:  Russell Coker <russell@coker.com.au>
#           Tom Vogt <tom@lemuria.org>
#

#################################
#
# Rules for the mysqld_t domain.
#
# mysqld_t is the type of the mysql daemon
#
daemon_domain(mysqld)
domain_auto_trans(initrc_t, mysqld_exec_t, mysqld_t)

type etc_mysqld_t, file_type, sysadmfile;
type mysqld_db_dir_t, file_type, sysadmfile;
type mysqld_db_t, file_type, sysadmfile;
type mysqld_log_t, file_type, sysadmfile, logfile;

#
# Permissions required by the initrc script and safe_mysqld wrapper
# (both running in initrc_t)
#
allow initrc_t etc_mysqld_t:file { read };

# create error startup log in /var/lib/mysql
allow initrc_t mysqld_db_dir_t:dir { write };
file_type_auto_trans(initrc_t, mysqld_db_dir_t, mysqld_db_t)

# touch /var/log/mysql and chown it to the mysql user
allow initrc_t mysqld_log_t:dir rw_dir_perms;
allow initrc_t mysqld_log_t:file create_file_perms;

# mysqladmin wants to talk to mysqld
allow initrc_t var_run_mysqld_t:sock_file { write };
allow initrc_t mysqld_t:unix_stream_socket { connectto };

#
# Permissions for the daemon itself (mysqld)
#
general_proc_read_access(mysqld_t)
general_file_read_access(mysqld_t)
allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
allow mysqld_t self:fifo_file rw_file_perms;
allow mysqld_t self:process { getsched };

# read config files
allow mysqld_t etc_mysqld_t:dir r_dir_perms;
allow mysqld_t etc_t:lnk_file r_file_perms;
allow mysqld_t etc_t:file r_file_perms;
allow mysqld_t etc_mysqld_t:file r_file_perms;

# temp and log files
allow mysqld_t var_log_t:dir { search };
allow mysqld_t var_log_t:file { append };
allow mysqld_t mysqld_log_t:file { create append };
file_type_auto_trans(mysqld_t, var_log_t, mysqld_log_t)
allow mysqld_t tmp_t:dir r_dir_perms;

# drop uid/gid
allow mysqld_t self:capability { setgid setuid };

# read /etc/mtab
allow mysqld_t etc_runtime_t:file r_file_perms;

# access the console
allow mysqld_t admin_tty_type:chr_file { read write };


#
# The databases
#
file_type_auto_trans(mysqld_t, mysqld_db_dir_t, mysqld_db_t)
allow mysqld_t mysqld_db_dir_t:dir create_dir_perms;
allow mysqld_t mysqld_db_t:dir create_dir_perms;
allow mysqld_t mysqld_db_t:file create_file_perms;

# Let dpkg install the default DB correctly and start/stop the server
ifdef(`dpkg.te', `
allow dpkg_t mysqld_exec_t:file { execute };
domain_auto_trans(dpkg_t, mysqld_exec_t, mysqld_t)
file_type_auto_trans(dpkg_t, mysqld_db_dir_t, mysqld_db_t)
')


#
# Client tools, for the sysadm role, this is easy:
#
allow sysadm_t mysqld_t:unix_stream_socket { connectto };

# for normal users, we need to give them some other
# access rights, too:
allow user_t mysqld_t:unix_stream_socket { connectto };
allow user_t var_run_mysqld_t:sock_file { write };
allow user_t etc_mysqld_t:dir { search };
allow user_t etc_mysqld_t:file { read };
allow user_t mysqld_db_dir_t:dir { search };
allow user_t var_run_mysqld_t:dir { search };


ifdef(`logrotate.te', `
r_dir_file(logrotate_t, etc_mysqld_t)
allow logrotate_t mysqld_db_dir_t:dir search;
allow logrotate_t var_run_mysqld_t:dir search;
allow logrotate_t var_run_mysqld_t:sock_file write;
can_unix_connect(logrotate_t, mysqld_t)
')

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mysqld.fc"

# mysql database server
/usr/sbin/mysqld		system_u:object_r:mysqld_exec_t
/var/run/mysqld(/.*)?		system_u:object_r:var_run_mysqld_t
/var/log/mysql.*		system_u:object_r:mysqld_log_t
/var/lib/mysql	        	system_u:object_r:mysqld_db_dir_t
/var/lib/mysql/.*		system_u:object_r:mysqld_db_t
/etc/my.cnf			system_u:object_r:etc_mysqld_t
/etc/mysql(/.*)?		system_u:object_r:etc_mysqld_t

--KsGdsel6WgEHnImy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
