Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA27763
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 09:32:50 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA23275
	for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 14:30:54 GMT
Received: from nox.lemuria.org ([213.191.86.30])
        by jazzband.ncsc.mil  with ESMTP id OAA23271 for <selinux@tycho.nsa.gov>; Wed, 30 Oct 2002 14:30:53 GMT
Date: Wed, 30 Oct 2002 15:32:37 +0100
From: Tom <tom@lemuria.org>
To: selinux@tycho.nsa.gov
Subject: Re: mysql policy
Message-ID: <20021030153236.C13292@lemuria.org>
References: <20021028161207.B8537@lemuria.org> <Pine.GSO.4.33.0210291407460.29605-100000@raven>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
In-Reply-To: <Pine.GSO.4.33.0210291407460.29605-100000@raven>; from sds@tislabs.com on Tue, Oct 29, 2002 at 02:16:52PM -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 29, 2002 at 02:16:52PM -0500, Stephen Smalley wrote:
> >+allow initrc_t mysqld_db_t:dir { write };
> 
> I'm not clear as to the purpose of this rule in isolation.  

I understand it now, and I've attached a new mysql policy. There are
some other weirdnesses in it, due to the specific way that mysqld
works, especially all the wrapper scripts or the fact that mysqld
(running in mysqld_t) is shut down by a call to mysqladmin (bin_t).

I've put more comments into this policy to make it more transparent why
some rules are there.
This is not a patch since I've changed almost everything. I've decided
to post full files instead for the discussion. I will test this policy
for a few days before submitting it, then in patch form.


mysqld is a weird beast, especially with the wrapper script, and some
tools that can't quite decide whether they want to be part of the
server or not.
I've gone back and forth between defining new domains for the
safe_mysqld wrapper or not (deciding on not for now), and I'm not yet
sure whether it may be a good idea to put make the mysqladmin a
mysqld_exec_t, too.

That's why I post this now - to get some feedback. This policy works
for me, but I'm sure it can be improved.



-- 
PGP/GPG key: http://web.lemuria.org/pubkey.html
pub  1024D/2D7A04F5 2002-05-16 Tom Vogt <tom@lemuria.org>
     Key fingerprint = C731 64D1 4BCF 4C20 48A4  29B2 BF01 9FA1 2D7A 04F5

--gBBFr7Ir9EOA20Yy
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

--gBBFr7Ir9EOA20Yy
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

--gBBFr7Ir9EOA20Yy--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
