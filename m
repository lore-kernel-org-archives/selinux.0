Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l890LONk001714
	for <selinux@tycho.nsa.gov>; Sat, 8 Sep 2007 20:21:24 -0400
Received: from atlantic.devin.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l890LLix010150
	for <selinux@tycho.nsa.gov>; Sun, 9 Sep 2007 00:21:22 GMT
Received: from aqua by atlantic.devin.com with local (Exim 4.63)
	(envelope-from <aqua@atlantic.devin.com>)
	id 1IUAYC-0002gu-PS
	for selinux@tycho.nsa.gov; Sat, 08 Sep 2007 17:21:20 -0700
Date: Sat, 8 Sep 2007 17:21:20 -0700
From: Devin Carraway <selinux-list@devin.com>
To: selinux@tycho.nsa.gov
Subject: [refpolicy] exim policy
Message-ID: <20070909002120.GD31848@atlantic.devin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nmemrqcdn5VTmUEE"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--nmemrqcdn5VTmUEE
Content-Type: multipart/mixed; boundary="PmA2V3Z32TCmWXqI"
Content-Disposition: inline


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's a refpolicy module for the Exim MTA.  It appears to work under both
targeted and strict policies, although my ability to test strict is somewhat
limited.

This is based in part on the patterns in the mta interface, most notably
mta_mailserver().  Structurally, Exim resembles Sendmail -- a large,
setuid-root binary which does everything.  In operation it sheds privileges
and execve()s itself at various points to reacquire them depending on what
operation it's attempting.  Current versions of exim don't have a distinct
binary for each of these phases on which a domain transition could be made.
There was some discussion here and on the Debian selinux list about inserti=
ng
wrappers or hardlinks which could be labelled for more specific controls.  =
As
of Exim 4.67 this hasn't yet been done, and I wanted to get a policy togeth=
er
which could be used with current releases.  This monolithic policy should
make it difficult to expand an exim compromise into most of the rest of the
OS, but does grant arbitrary control over user_home_dir_t, something not to=
 be
taken lightly.

Access to mailman, spamassassin, clamav, SASL authentication services and
local mysql & postgresql databases are available.  I'd like to provide tuna=
ble
policy around these, particularly the DB connectivity and auth services, but
these are accessed via UNIX domain sockets, and AFAICT one still can't comb=
ine
optional and tunable policies.  Connection to remote mysql/postgresql DBs is
provided as a tunable.

Critique welcome.  MTAs are big, complex contraptions and I may well have
gotten some things wrong.

Also available at http://devin.com/debian/exim-selinux/ if anyone prefers.

Devin

--=20
Devin  \ aqua(at)devin.com, IRC:Requiem; http://www.devin.com
Carraway \ 1024D/E9ABFCD2: 13E7 199E DD1E 65F0 8905 2E43 5395 CA0D E9AB FCD2

--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="exim.if"

## <summary>Exim service</summary>

########################################
## <summary>
##     Permit transitions to the exim domain
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_domtrans',`
	gen_require(`
		type exim_t;
		type exim_exec_t;
	')

	files_search_usr($1)
	corecmd_search_sbin($1)
	domtrans_pattern($1, exim_t, exim_exec_t)
')

########################################
## <summary>
##     Read generated exim configuration
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_read_var_config',`
	gen_require(`
		type exim_var_conf_t;
	')

        files_search_var_lib($1)
	read_files_pattern($1, exim_var_conf_t, exim_var_conf_t);
')

########################################
## <summary>
##     Manage generated exim configuration
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_manage_var_config',`
	gen_require(`
		type exim_var_conf_t;
	')

        files_search_var_lib($1)
	manage_files_pattern($1, exim_var_conf_t, exim_var_conf_t);
')

########################################
## <summary>
##     Grants readonly access to Exim logs
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_read_logs',`
	gen_require(`
		type exim_log_t;
	')

	files_search_var($1)
	read_files_pattern($1, exim_log_t, exim_log_t)
')

########################################
## <summary>
##     Manage exim logs
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_manage_logs',`
	gen_require(`
		type exim_log_t;
	')

	files_search_var($1)
	manage_files_pattern($1, exim_log_t, exim_log_t)
')

########################################
## <summary>
##     Read contents of exim spool
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_read_spool',`
	gen_require(`
		type exim_spool_t;
	')

	files_search_spool($1)
	list_dirs_pattern($1, exim_spool_t, exim_spool_t)
	read_files_pattern($1, exim_spool_t, exim_spool_t)
')

########################################
## <summary>
##     Modify/delete contents of exim mail spool
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_manage_spool',`
	gen_require(`
		type exim_spool_t;
	')

	files_search_spool($1)
	manage_dirs_pattern($1, exim_spool_t, exim_spool_t)
	manage_files_pattern($1, exim_spool_t, exim_spool_t)
')

########################################
## <summary>
##     Create an exim mail spool (implies creating dirs in var_spool_t).
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_create_spool',`
	gen_require(`
		type var_spool_t;
		type exim_spool_t;
	')

	create_dirs_pattern($1, var_spool_t, exim_spool_t)
	filetrans_pattern($1, var_spool_t, exim_spool_t, dir)
')

########################################
## <summary>
##     Manage the user mail spools (not the exim queue/spool dirs).  This
##     is somewhat more permissive than mta_rw_spool(), also permitting
##     the creation (via hardlink) of spool lock files in mail_spool_t.
## </summary>
## <param name="domain">
##     <summary>
##         Domain allowed access.
##     </summary>
## </param>
#
interface(`exim_manage_mail_spool',`
	gen_require(`
		type mail_spool_t;
	')

	mta_rw_spool($1)
	allow $1 mail_spool_t:dir rw_dir_perms;
	allow $1 mail_spool_t:file manage_file_perms;
')


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="exim.fc"
Content-Transfer-Encoding: quoted-printable

# $Id$
# Draft SELinux refpolicy module for the Exim MTA
#=20
# Devin Carraway <selinux/at/devin.com>

/etc/exim4?(/.*)?         gen_context(system_u:object_r:etc_mail_t,s0)
/var/spool/exim4?(/.*)?   gen_context(system_u:object_r:exim_spool_t,s0)
/var/run/exim4?(/.*)?     gen_context(system_u:object_r:exim_var_run_t,s0)
/var/lib/exim4?(/.*)?     gen_context(system_u:object_r:exim_var_conf_t,s0)
/var/log/exim4?(/.*)?     gen_context(system_u:object_r:exim_log_t,s0)
/usr/sbin/exim4?          gen_context(system_u:object_r:exim_exec_t,s0)
/usr/sbin/eximstats       gen_context(system_u:object_r:exim_stats_exec_t, =
s0)
ifdef(`distro_debian', `
/usr/sbin/update-exim4\.conf    gen_context(system_u:object_r:exim_conf_upd=
ate_exec_t,s0)
# work around a misparse if the word template appears without adjustment
/usr/sbin/update-exim4\.conf\.[t]emplate   gen_context(system_u:object_r:ex=
im_conf_update_exec_t,s0)
')


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="exim.te"
Content-Transfer-Encoding: quoted-printable

# $Id: exim.te 687 2007-09-09 00:19:41Z aqua $
# Draft SELinux refpolicy module for the Exim MTA
#=20
# Devin Carraway <selinux/at/devin.com>

policy_module(exim, 1.0.0)

########################################
#
# Declarations
#

type exim_t;
type exim_exec_t;
mta_mailserver(exim_t, exim_exec_t)
mta_mailserver_user_agent(exim_t)

type exim_spool_t;
files_type(exim_spool_t)

type exim_var_run_t;
files_pid_file(exim_var_run_t)

type exim_log_t;
logging_log_file(exim_log_t)

type exim_stats_t;
type exim_stats_exec_t;
domain_type(exim_stats_t)
domain_entry_file(exim_stats_t, exim_stats_exec_t)

## <desc>
## <p>
##     Allow exim to connect to networked databases (postgres, mysql)
## </p>
## </desc>
gen_tunable(exim_can_connect_db_network, false)

### exim4 daemon policy

libs_use_ld_so(exim_t)
libs_read_lib_files(exim_t)
libs_exec_lib_files(exim_t)
libs_use_shared_libs(exim_t)
libs_legacy_use_shared_libs(exim_t)
ifdef(`strict_policy',`
	gen_require(`
		type shlib_t;
		class file { read getattr };
	')
	allow exim_t shlib_t:file { read getattr };
')


# reads /proc/sys/kernel/ngroups_max
kernel_read_kernel_sysctls(exim_t)

# needs the local timezone
miscfiles_read_localization(exim_t)

files_search_usr(exim_t)
files_search_var(exim_t)

# tries to read /proc/stat, but doesn't use it
kernel_dontaudit_read_system_state(exim_t)

# exim calls execve() on itself to switch tasks and possibly reacquire privs
allow exim_t exim_exec_t:file { exec_file_perms };

# also to set its rlimits, change process group, shed privileges and so for=
th
gen_require(`
	class capability { sys_resource dac_override setuid setgid fowner chown };
	class process { setrlimit setpgid } ;
')
allow exim_t self:capability { sys_resource dac_override setuid setgid fown=
er chown };
allow exim_t self:process { setrlimit setpgid };

allow exim_t self:capability dac_override;

# PID files
allow exim_t exim_var_run_t:dir rw_dir_perms;
allow exim_t exim_var_run_t:file manage_file_perms;
files_pid_filetrans(exim_t, exim_var_run_t, file)

## configuration

# static, admin-edited config files

mta_read_aliases(exim_t)
mta_read_config(exim_t)

files_read_etc_files(exim_t)

# Debian uses a template based config generator which generates config
# files under /var
ifdef(`distro_debian',`
	type exim_var_conf_t;
	files_config_file(exim_var_conf_t)
	exim_read_var_config(exim_t)

	type exim_conf_update_t;
	type exim_conf_update_exec_t;
	init_domain(exim_conf_update_t, exim_conf_update_exec_t)
	domain_entry_file(exim_conf_update_t, exim_conf_update_exec_t)
	mta_read_config(exim_conf_update_t)
	exim_manage_var_config(exim_conf_update_t)
')

## spool

# this is exim's own spool, not the user mailboxes in /var{/spool,}/mail

# exim creates its own spool when first started
exim_create_spool(exim_t)
exim_manage_spool(exim_t)

# Give clamav read access to the spool so it can scan incoming messages.
# Preferably this would only involve giving it read access to the one being
# scanned at the time, but exim creates the scan directory in its spool at
# runtime, making it difficult to label separately.  As of v4.67, exim also
# creates a scan directory for each message (attachments are extracted and
# saved separately, e.g.), the contents of which clamav must find and read.
optional_policy(`
	gen_require(`
		type clamd_t;
	')
	exim_read_spool(clamd_t)
')

## client authentication

# local accounts via SASL (authd)
optional_policy(`
	sasl_connect(exim_t)
')

# local accounts via Cyrus SASL
optional_policy(`
	cyrus_stream_connect(exim_t)
')

# courier authdaemon; authdaemon doesn't have a type for its UNIX domain
# socket, nor a public interface for it yet.
ifdef(`TODO', `
optional_policy(`
	gen_require(`
		type courier_var_run_t;
	')
	files_search_pids(exim_t)
	stream_connect_pattern(exim_t, courier_var_run_t, courier_var_run_t)
')
')

## receipt & validation

optional_policy(`
	clamav_domtrans_clamscan(exim_t)
	clamav_stream_connect(exim_t)
')

# XXX: need to be able to combine tunable and optional_policy; this should
# be controllable.
optional_policy(`
	mysql_stream_connect(exim_t)
')
optional_policy(`
	postgresql_stream_connect(exim_t)
')

tunable_policy(`exim_can_connect_db_network',`
        corenet_tcp_connect_mysqld_port(exim_t)
        corenet_sendrecv_mysqld_client_packets(exim_t)

        corenet_tcp_connect_postgresql_port(exim_t)
        corenet_sendrecv_postgresql_client_packets(exim_t)
')

# exim can connect to spamd directly (the usual way), or be configured
# to call the spamassassin or spamc commands instead.  Access to the
# spamd TCP port is granted in the network allow roles lower down.
optional_policy(`
	spamassassin_exec(exim_t)
	spamassassin_exec_client(exim_t)
')

## delivery

# this implies pretty much arbitrary control over home_dir_t, unfortunately
mta_mailserver_delivery(exim_t)

optional_policy(`
	procmail_domtrans(exim_t)
')

# delivery to mailman; virtual mailing lists are often implemented by having
# exim read files from the mailman data directory.
optional_policy(`
	mailman_read_data_files(exim_t)
	mailman_domtrans(exim_t)
')


## logging

# the usual logs, generally /var/log/exim*/*
logging_log_filetrans(exim_t, exim_log_t, file)
exim_manage_logs(exim_t)

# Exim uses its own logfiles normally, but will resort to syslog if those
# are inaccessible; it may also be configured to use syslog normally
logging_send_syslog_msg(exim_t)

# access /sbin
corecmd_search_sbin(exim_t)

# Exim uses BerkeleyDB, which checks /var/tmp but doesn't actually use it
files_dontaudit_getattr_tmp_dirs(exim_t)

# STARTTLS support requires the SSL certs; the SSL private key is usually
# alongside exim's configuration (exim_conf_t), but might also be in the
# system SSL private directory; at present, keys have the same type as
# certificates and no other interface, so miscfiles_read_certs() will grant
# access to both.
miscfiles_read_certs(exim_t)

# TLS sessions need entropy
dev_read_urand(exim_t)
dev_read_rand(exim_t)

## network access

gen_require(`
	class fifo_file { rw_file_perms };
	class tcp_socket { create_stream_socket_perms connected_stream_socket_perm=
s };
	class udp_socket { create_socket_perms };
	class unix_stream_socket { create_stream_socket_perms };
')

allow exim_t self:fifo_file rw_file_perms;
allow exim_t self:tcp_socket { create_stream_socket_perms connected_stream_=
socket_perms };
allow exim_t self:udp_socket { create_socket_perms };
allow exim_t self:unix_stream_socket { create_stream_socket_perms };

# DNS lookups
sysnet_dns_name_resolve(exim_t)
optional_policy(`
        nscd_socket_use(exim_t)
')

corenet_udp_sendrecv_generic_if(exim_t)
corenet_udp_sendrecv_generic_node(exim_t)
corenet_udp_sendrecv_lo_node(exim_t)

corenet_tcp_sendrecv_generic_if(exim_t)
corenet_tcp_sendrecv_generic_node(exim_t)
corenet_tcp_sendrecv_lo_node(exim_t)
corenet_tcp_bind_lo_node(exim_t)
corenet_tcp_bind_generic_node(exim_t)

# older policy:
corenet_tcp_sendrecv_generic_if(exim_t)
corenet_tcp_sendrecv_generic_node(exim_t)
corenet_tcp_sendrecv_generic_port(exim_t)
corenet_tcp_sendrecv_lo_node(exim_t)
corenet_non_ipsec_sendrecv(exim_t)
# newer policy:
# corenet_all_recvfrom_unlabeled(exim_t)
# corenet_all_recvfrom_netlabel(exim_t)

# bind to the SMTP ports (TCP 25, 467, 587)
corenet_tcp_bind_smtp_port(exim_t)
corenet_tcp_connect_smtp_port(exim_t)
corenet_tcp_sendrecv_smtp_port(exim_t)
corenet_sendrecv_smtp_server_packets(exim_t)
corenet_sendrecv_all_client_packets(exim_t)

# make identd connections
corenet_tcp_connect_auth_port(exim_t)
corenet_tcp_sendrecv_auth_port(exim_t)

# connect to spamassassin
corenet_tcp_connect_spamd_port(exim_t)
corenet_tcp_sendrecv_spamd_port(exim_t)


### eximstats policy (much simpler)

exim_read_logs(exim_stats_t)


--PmA2V3Z32TCmWXqI--

--nmemrqcdn5VTmUEE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG4zyAU5XKDemr/NIRAnC+AKDXRPWFc4WCDR+6ocpH3z3S55MB7gCfe2z4
Gd+ZqLmN9HIEnG3Bgj/Kj6A=
=iqGe
-----END PGP SIGNATURE-----

--nmemrqcdn5VTmUEE--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
