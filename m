Message-ID: <3C47BFA9.1070301@pcez.com>
Date: Thu, 17 Jan 2002 22:24:41 -0800
From: Shaun Savage <savages@pcez.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_homegate.savages.net-5492-1011335171-0001-2"
To: SELinux@tycho.nsa.gov
Subject: snort files and policy
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_homegate.savages.net-5492-1011335171-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi all
Attached is the file needed to get iptables snort to work with selinux. 
 Now selinux can have the snort NIDS using iptables.   I have not tested 
it with libpcap interface.  

Shaun

--=_homegate.savages.net-5492-1011335171-0001-2
Content-Type: text/plain; name="snort.te"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snort.te"

#
#
# add snort_t to system_r (from rbac)
role system_r types snort_t;

# add snort_t o sysadm_r (from rbac)
role sysadm_r types snort_t;

# allow the admin to enter snort_t domain (from sysadm.te)
domain_auto_trans(sysadm_t, snort_exec_t, snort_t)
# allow output (from sysadm.te)
allow snort_t sysadm_tty_device_t:chr_file rw_file_perms;
allow snort_t sysadm_devpts_t:chr_file rw_file_perms;
allow snort_t sysadm_gph_t:fd inherit_fd_perms;

#################################
#
# Rules for the snort_t domain.
#
# snort_t is the domain for the snort program.
# snort_exec_t is the type of the corresponding program.
# snort_log_t is the type of the log files.
#
type snort_t, domain, privowner, privlog;
type snort_exec_t, file_type, sysadmfile, exec_type;
type snort_log_t, file_type, sysadmfile;
type snort_etc_t, file_type, sysadmfile;
type snort_db_t, file_type, sysadmfile;
type snort_run_t, file_type, sysadmfile;

# Create temporary files.
type snort_tmp_t, file_type, sysadmfile, tmpfile;
file_type_auto_trans(snort_t, tmp_t, snort_tmp_t)

# use iptable netlink
allow snort_t self:netlink_socket create_socket_perms;
allow snort_t self:packet_socket create_socket_perms;
allow snort_t self:capability { net_admin net_raw };

# create run file 
file_type_auto_trans(snort_t, var_run_t, snort_run_t)

# Modify /var/log.
allow snort_t snort_log_t:dir ra_dir_perms;
allow snort_t snort_log_t:file create_file_perms;
allow snort_t snort_etc_t:dir r_dir_perms;
allow snort_t snort_etc_t:file r_file_perms;
allow snort_t snort_db_t:file rw_file_perms;

--=_homegate.savages.net-5492-1011335171-0001-2
Content-Type: text/plain; name="snort.files"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="snort.files"

/usr/sbin/snort		system_u:object_r:snort_exec_t
/etc/snort(|/.*)	system_u:object_r:snort_etc_t
/var/log/snort(|/.*)	system_u:object_r:snort_log_t

--=_homegate.savages.net-5492-1011335171-0001-2--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
