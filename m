Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i53E5vrT011838
	for <selinux@tycho.nsa.gov>; Thu, 3 Jun 2004 10:05:57 -0400 (EDT)
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i54E5bpx005522
	for <selinux@tycho.nsa.gov>; Fri, 4 Jun 2004 10:05:38 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id 47FA961BD6
	for <selinux@tycho.nsa.gov>; Fri,  4 Jun 2004 00:05:52 +1000 (EST)
Received: from smtp.sws.net.au ([127.0.0.1])
	by localhost (smtp [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 26463-09 for <selinux@tycho.nsa.gov>;
	Fri, 4 Jun 2004 00:05:51 +1000 (EST)
Received: from lyta.coker.com.au (localhost [127.0.0.1])
	by smtp.sws.net.au (Postfix) with ESMTP id AB7C461BB0
	for <selinux@tycho.nsa.gov>; Fri,  4 Jun 2004 00:05:51 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by lyta.coker.com.au (Postfix) with ESMTP id 57A9AB586F
	for <selinux@tycho.nsa.gov>; Fri,  4 Jun 2004 00:05:50 +1000 (EST)
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: SE Linux <selinux@tycho.nsa.gov>
Subject: mysqld
Date: Fri, 4 Jun 2004 00:05:49 +1000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_9AzvA5e3FxlFQbK"
Message-Id: <200406040005.49762.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_9AzvA5e3FxlFQbK
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

ifdef(`mysqld.te', `portcon tcp 3306 system_u:object_r:mysqld_port_t')

With the attached policy files and the above line added to net_contexts.te I 
almost have mysqld working in Fedora.

I get the below messages in /var/log/mysqld.log, I suspect that because the 
first time I tried to start it the policy didn't let it do what it wanted it 
messed things up and now isn't going to start properly.  Further testing by 
someone who knows more about mysql than I do would be helpful.

040603 23:44:13  mysqld started
Cannot initialize InnoDB as 'innodb_data_file_path' is not set.
If you do not want to use transactional InnoDB tables, add a line
skip-innodb
to the [mysqld] section of init parameters in your my.cnf
or my.ini. If you want to use InnoDB tables, add to the [mysqld]
section, for example,
innodb_data_file_path = ibdata1:10M:autoextend
But to get good performance you should adjust for your hardware
the InnoDB startup options listed in section 2 at
http://www.innodb.com/ibman.html
040603 23:44:13  /usr/libexec/mysqld: Table 'mysql.host' doesn't exist
040603 23:44:13  mysqld ended

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_9AzvA5e3FxlFQbK
Content-Type: text/plain;
  charset="us-ascii";
  name="mysqld.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mysqld.te"

#DESC Mysqld - Database server
#
# Author:  Russell Coker <russell@coker.com.au>
# X-Debian-Packages: mysql-server
#

#################################
#
# Rules for the mysqld_t domain.
#
# mysqld_exec_t is the type of the mysqld executable.
#
daemon_domain(mysqld)

type mysqld_port_t, port_type;
allow mysqld_t mysqld_port_t:tcp_socket name_bind;

allow mysqld_t mysqld_var_run_t:sock_file create_file_perms;

etcdir_domain(mysqld)
typealias mysqld_etc_t alias etc_mysqld_t;
type mysqld_db_t, file_type, sysadmfile;

log_domain(mysqld)

allow mysqld_t tmp_t:dir { getattr read };

allow mysqld_t usr_t:file { getattr read };

allow mysqld_t self:fifo_file { read write };
allow mysqld_t self:unix_stream_socket create_stream_socket_perms;
allow initrc_t mysqld_t:unix_stream_socket { connectto };
allow initrc_t mysqld_var_run_t:sock_file write;

allow initrc_t mysqld_log_t:file { write append setattr ioctl };

allow mysqld_t self:capability { setgid setuid };
allow mysqld_t self:process getsched;

allow mysqld_t proc_t:file { getattr read };

# Allow access to the mysqld databases
create_dir_file(mysqld_t, mysqld_db_t)
allow mysqld_t var_lib_t:dir search;

can_network(mysqld_t)

# read config files
r_dir_file(initrc_t, mysqld_etc_t)
allow mysqld_t { etc_t etc_runtime_t }:{ file lnk_file } { read getattr };

allow mysqld_t etc_t:dir search;

allow mysqld_t sysctl_kernel_t:dir search;
allow mysqld_t sysctl_kernel_t:file read;

can_unix_connect(sysadm_t, mysqld_t)

# for /root/.my.cnf - should not be needed
allow mysqld_t sysadm_home_dir_t:dir search;
allow mysqld_t sysadm_home_t:file { read getattr };

ifdef(`logrotate.te', `
r_dir_file(logrotate_t, mysqld_etc_t)
allow logrotate_t mysqld_db_t:dir search;
allow logrotate_t mysqld_var_run_t:dir search;
allow logrotate_t mysqld_var_run_t:sock_file write;
can_unix_connect(logrotate_t, mysqld_t)
')

ifdef(`user_db_connect', `
allow userdomain mysqld_var_run_t:dir search;
allow userdomain mysqld_var_run_t:sock_file write;
')

ifdef(`rpm.te', `
allow initrc_t mysqld_db_t:dir create_dir_perms;

# because Fedora has the sock_file in the database directory
file_type_auto_trans(mysqld_t, mysqld_db_t, mysqld_var_run_t, sock_file)
')

--Boundary-00=_9AzvA5e3FxlFQbK
Content-Type: text/plain;
  charset="us-ascii";
  name="mysqld.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mysqld.fc"

# mysql database server
/usr/sbin/mysqld	--	system_u:object_r:mysqld_exec_t
/usr/libexec/mysqld	--	system_u:object_r:mysqld_exec_t
/var/run/mysqld(/.*)?		system_u:object_r:mysqld_var_run_t
/var/log/mysql.*	--	system_u:object_r:mysqld_log_t
/var/lib/mysql(/.*)?		system_u:object_r:mysqld_db_t
/etc/my\.cnf		--	system_u:object_r:mysqld_etc_t
/etc/mysql(/.*)?		system_u:object_r:mysqld_etc_t

--Boundary-00=_9AzvA5e3FxlFQbK--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
