Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1P1BNAr019539
	for <selinux@tycho.nsa.gov>; Fri, 24 Feb 2006 20:11:26 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1P19tag008709
	for <selinux@tycho.nsa.gov>; Sat, 25 Feb 2006 01:09:56 GMT
Subject: Tor module for refpolicy
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>
Cc: cpebenito@tresys.com
Content-Type: multipart/mixed; boundary="=-nnbwsETB+a4P/e8owtiw"
Date: Sat, 25 Feb 2006 02:11:18 +0100
Message-Id: <1140829878.8976.22.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-nnbwsETB+a4P/e8owtiw
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello fellow SELinux users,
attached is a refpolicy module for tor, "the onion router".
http://tor.eff.org/

While looking at the other modules in refpolicy for examples I came
across the following line:
dev_associate_usbfs(zebra_var_run_t)
this line can't be right, can it? I mean, zebra_var_run_t is a file
domain...
shouldn't this throw some assertion error?

Also see my tor.te file for some stuff where I didn't find appropriate
macros for and note that IMHO it would make a lot of sense to have
macros for much of the common stuff, I'd especially appreciate macros
like
make_pidfile(tor_t, tor_var_run_t)
make_logfiles(tor_t, tor_var_log_t)
make_libfiles(tor_t, tor_var_lib_t)
because there are just *tons* of services that need pretty much the same
policy.
So why should I repeat the same lines over and over again?

You might have read the recent article on AppArmor vs. SELinux.
Currently, SELinux is really bad with respect to policy writing. And as
much as I appreciate well-defined interfaces as advocated by the
reference policy...
Writing the tor policy for the old strict policy was easier... here's
the
first few lines:
---
daemon_domain(tor)
var_lib_domain(tor)
log_domain(tor)
etc_domain(tor)
can_network(tor_t)
---
I was especially missing this "can_network" macro...

Point me to the corresponding macros if I just missed them because they
were not used in the policies I looked at...

And some other stuff I'd like to discuss:
- why can't we just allow access to locales, /lib and such by default
for daemon domains? I mean, we're talking read-only access to standard
system files...
Is this femto-gain in security worth all the extra work in writing
policy?

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
  A polar bear is a rectangular bear after a coordinate transform.   //\
    Der Anfang aller Erkenntnis ist das Staunen. --- Aristoteles     V_/_

--=-nnbwsETB+a4P/e8owtiw
Content-Disposition: attachment; filename=tor.fc
Content-Type: text/plain; name=tor.fc; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

/usr/sbin/tor		--	gen_context(system_u:object_r:tor_exec_t,s0)
/etc/tor(/.*)?			gen_context(system_u:object_r:tor_etc_t,s0)
/var/lib/tor(/.*)?		gen_context(system_u:object_r:tor_var_lib_t,s0)
/var/log/tor(/.*)?		gen_context(system_u:object_r:tor_var_log_t,s0)
/var/run/tor(/.*)?		gen_context(system_u:object_r:tor_var_run_t,s0)

--=-nnbwsETB+a4P/e8owtiw
Content-Disposition: attachment; filename=tor.if
Content-Type: text/plain; name=tor.if; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

## <summary>Policy for TOR, the onion router</summary>

########################################
## <summary>
##	Execute a domain transition to run tor.
## </summary>
## <param name="domain">
##	Domain allowed to transition.
## </param>
#
interface(`tor_domtrans',`
	gen_requires(`
		type tor_t, tor_exec_t;
	')

	domain_auto_trans($1,tor_exec_t,tor_t)

	allow $1 tor_t:fd use;
	allow tor_t $1:fd use;
	allow tor_t:$1:fifo_file rw_file_perms;
	allow tor_t $1:process sigchld;
')

--=-nnbwsETB+a4P/e8owtiw
Content-Disposition: attachment; filename=tor.te
Content-Type: text/plain; name=tor.te; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

policy_module(tor,0.1.0)

########################################
#
# Declarations
#

type tor_t;
type tor_exec_t;
domain_type(tor_t)
init_daemon_domain(tor_t, tor_exec_t)

# etc/tor
type tor_etc_t;
files_config_file(tor_etc_t)

# var/lib/tor
type tor_var_lib_t;
files_type(tor_var_lib_t)

# log files
type tor_var_log_t;
logging_log_file(tor_var_log_t)

# pid files
type tor_var_run_t;
files_pid_file(tor_var_run_t)

########################################
#
# tor local policy
#

# configuration files
allow tor_t tor_etc_t:dir r_dir_perms;
allow tor_t tor_etc_t:file r_file_perms;
allow tor_t tor_etc_t:lnk_file { getattr read };

# var/lib/tor files
allow tor_t tor_var_lib_t:file create_file_perms;
allow tor_t tor_var_lib_t:sock_file create_file_perms;
allow tor_t tor_var_lib_t:dir create_dir_perms;
files_usr_filetrans(tor_t,tor_var_lib_t)
files_var_filetrans(tor_t,tor_var_lib_t,{ file dir sock_file })
files_var_lib_filetrans(tor_t,tor_var_lib_t)

# log files
allow tor_t tor_var_log_t:file create_file_perms;
allow tor_t tor_var_log_t:sock_file create_file_perms;
allow tor_t tor_var_log_t:dir { rw_dir_perms setattr };
logging_log_filetrans(tor_t,tor_var_log_t,{ sock_file file dir })

# pid file
allow tor_t tor_var_run_t:file manage_file_perms;
allow tor_t tor_var_run_t:sock_file manage_file_perms;
allow tor_t tor_var_run_t:dir rw_dir_perms;
files_pid_filetrans(tor_t,tor_var_run_t, { file sock_file })

# base
files_read_etc_files(tor_t)
miscfiles_read_localization(tor_t)
libs_use_ld_so(tor_t)
libs_use_shared_libs(tor_t)
allow tor_t self:fifo_file { read write };

# tor uses crypto and needs random
dev_read_urand(tor_t)

# comm with init
init_use_fd(tor_t)
init_use_script_ptys(tor_t)
domain_use_interactive_fds(tor_t)

# networking basics
sysnet_dns_name_resolve(tor_t)
corenet_tcp_sendrecv_all_if(tor_t)
#corenet_raw_sendrecv_all_if(tor_t)
corenet_tcp_sendrecv_all_nodes(tor_t)
#corenet_raw_sendrecv_all_nodes(tor_t)
corenet_tcp_sendrecv_all_ports(tor_t)
corenet_tcp_sendrecv_all_reserved_ports(tor_t)
corenet_non_ipsec_sendrecv(tor_t)
# TOR will need to connect to various ports
corenet_tcp_connect_all_ports(tor_t)
# ... especially including port 80 and other privileged ports
corenet_tcp_connect_all_reserved_ports(tor_t)
# TOR may bind to a non-privileged port
corenet_tcp_bind_all_ports(tor_t)
corenet_tcp_bind_all_nodes(tor_t)
# Couldn't find appropriate macros for this...
allow tor_t self:unix_stream_socket create_stream_socket_perms;
allow tor_t self:netlink_route_socket r_netlink_socket_perms;
allow tor_t self:tcp_socket { listen accept };

optional_policy(`selinuxutil',`
	seutil_sigchld_newrole(tor_t)
')

--=-nnbwsETB+a4P/e8owtiw--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
