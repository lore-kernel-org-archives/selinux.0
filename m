Message-ID: <3C45D723.7090308@pcez.com>
Date: Wed, 16 Jan 2002 11:40:19 -0800
From: Shaun Savage <savages@pcez.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_homegate.savages.net-2504-1011210258-0001-2"
To: SELinux@tycho.nsa.gov
Subject: more info
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_homegate.savages.net-2504-1011210258-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

During the load process I get

ss: loading .....
security: 5 users, 6roles, 391 types
security: 29 classes, 74171 rules
security: context root:sysadm_r:ipchains_t is invalid

Why/How is it invalid?

attached is the new ipchains.te

Shaun 

--=_homegate.savages.net-2504-1011210258-0001-2
Content-Type: text/plain; name="ipchains.te"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ipchains.te"

#
# Authors:  Justin Smith <jsmith@mcs.drexel.edu>
#

role sysadm_t types { ipchains_t };
domain_auto_trans(sysadm_t, ipchains_exec_t, ipchains_t)

allow tripwire_t sysadm_tty_device_t:chr_file rw_file_perms;
allow tripwire_t sysadm_devpts_t:chr_file rw_file_perms;
allow tripwire_t sysadm_gph_t:fd inherit_fd_perms;
 
auditallow sysadm_t ipchains_t:process transition;
auditallow sysadm_t ipchains_exec_t:process transition;
auditallow sysadm_t ipchains_exec_t:file execute;

#
# Rules for the ipchains_t domain.
#
type ipchains_t, domain, privlog;
type ipchains_exec_t, file_type, sysadmfile, exec_type;
type ipchains_var_run_t, file_type, sysadmfile, pidfile;

domain_auto_trans(ipchains_t, insmod_exec_t, insmod_t)

domain_auto_trans(ipchains_t, ifconfig_exec_t, ifconfig_t)
file_type_auto_trans(ipchains_t, var_run_t, ipchains_var_run_t)
uses_shlib(ipchains_t)

# Inherit and use descriptors from init.
allow ipchains_t init_t:fd inherit_fd_perms;

allow ipchains_t bin_t:file { execute execute_no_trans };
allow ipchains_t ipchains_exec_t:file { execute_no_trans };
allow ipchains_t ipchains_t:capability { net_admin net_raw };
allow ipchains_t ipchains_t:rawip_socket { create setopt };

--=_homegate.savages.net-2504-1011210258-0001-2--

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
