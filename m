Message-ID: <3C1CE2BD.20707@pcez.com>
Date: Sun, 16 Dec 2001 10:06:53 -0800
From: Shaun Savage <savages@pcez.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_homegate.savages.net-9793-1008526377-0001-2"
To: SELinux@tycho.nsa.gov
Subject: iptables.te  errors
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_homegate.savages.net-9793-1008526377-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

HI
I am having a hard time with getting courier to work that I decided to 
try somwthing easier. iptables. Attached is the te file that I am using.
During make load I get the error

security: context system_u:system_r:iptables_t is invalid

the during the command iptables -t nat -L
I get the errors
avc: denied { create } for pid=9757 exe=/sbin/iptables 
scontext=root:sysadmin_r:sysadmin_t tcontext=root_u:sysadm_r:sysadm_t 
tclass=rawip_socket
avc: denied { getopt } for pid=9757 exe=/sbin/iptables 
scontext=root:sysadmin_r:sysadmin_t tcontext=root_u:sysadm_r:sysadm_t 
tclass=rawip_socket


much more later


Shaun savage

--=_homegate.savages.net-9793-1008526377-0001-2
Content-Type: text/plain; name="iptables.te"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="iptables.te"

#
# Authors:  Justin Smith <jsmith@mcs.drexel.edu>
#

#
# Rules for the iptables_t domain.
#
type iptables_t, domain, privlog;
type iptables_exec_t, file_type, sysadmfile, exec_type;
type iptables_var_run_t, file_type, sysadmfile, pidfile;

domain_auto_trans(iptables_t, insmod_exec_t, insmod_t)
domain_auto_trans(iptables_t, ifconfig_exec_t, ifconfig_t)

file_type_auto_trans(iptables_t, var_run_t, iptables_var_run_t)

# Inherit and use descriptors from init.
allow iptables_t init_t:fd inherit_fd_perms;

allow iptables_t bin_t:file { execute execute_no_trans };
allow iptables_t iptables_exec_t:file { execute_no_trans };
allow iptables_t iptables_t:capability { net_admin net_raw };
allow iptables_t iptables_t:rawip_socket { create setopt getopt };


--=_homegate.savages.net-9793-1008526377-0001-2--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
