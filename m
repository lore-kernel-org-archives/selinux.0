Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2M1MqDo011216
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2005 20:22:52 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2M1N9In017002
	for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2005 01:23:10 GMT
Subject: New policy for razor
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-bAzBmk7tvI/K2Kk1IZEq"
Date: Mon, 21 Mar 2005 20:23:10 -0500
Message-Id: <1111454590.18940.52.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-bAzBmk7tvI/K2Kk1IZEq
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is a new strict policy for the razor spam filter.  It is based on
the selinux-policy-strict-sources-1.23.2-1 fedora RPM.  This policy
requires the definition of a razor reserved port that was in the
net_contexts diff I sent last Wednesday.  Please let me know if there
are any problems with or changes needed to this policy.

David


--=-bAzBmk7tvI/K2Kk1IZEq
Content-Disposition: attachment; filename=razor.fc
Content-Type: text/plain; name=razor.fc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

# razor
/etc/razor(/.*)?		system_u:object_r:razor_etc_t
/usr/bin/razor.*		system_u:object_r:razor_exec_t
/var/lib/razor(/.*)?		system_u:object_r:razor_var_lib_t
/var/log/razor-agent.log	system_u:object_r:razor_log_t
HOME_DIR/\.razor(/.*)?		system_u:object_r:ROLE_razor_home_t

--=-bAzBmk7tvI/K2Kk1IZEq
Content-Disposition: attachment; filename=razor_macros.te
Content-Type: text/plain; name=razor_macros.te; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# Razor - Razor is a collaborative, networked system to detect and
#         block spam using identifying digests of messages.
#
# Author:  David Hampton <hampton@employees.org>
#

##########
# common definitions for razord and all flavors of razor
##########
define(`razor_base_domain',`

# Razor is one executable and several symlinks
allow $1_t razor_exec_t:{ file lnk_file } { getattr read };

# Networking
can_network_client_tcp($1_t, razor_port_t)
can_resolve($1_t);

general_proc_read_access($1_t)

# Read system config file
r_dir_file($1_t, razor_etc_t)

# Update razor common files
file_type_auto_trans($1_t, var_log_t, razor_log_t, file)
create_dir_file($1_t, razor_log_t)
allow $1_t var_lib_t:dir search;
create_dir_file($1_t, razor_var_lib_t)

allow $1_t bin_t:dir { getattr search };
allow $1_t bin_t:file getattr;
allow $1_t lib_t:file { getattr read };
allow $1_t { var_t var_run_t }:dir search;
uses_shlib($1_t)

# Razor forks other programs to do part of its work.
general_domain_access($1_t)
can_exec($1_t, bin_t)

# mktemp and other randoms
allow $1_t { random_device_t urandom_device_t }:chr_file r_file_perms;

# Allow access to various files in the /etc/directory including mtab
# and nsswitch
allow $1_t { etc_t etc_runtime_t }:file { getattr read };
read_locale($1_t)
')


#
# Define a user domain for a razor
#
# Note: expects to be called with an argument of user, sysadm

define(`razor_domain',`
type $1_razor_t, domain, privlog, nscd_client_domain;
role $1_r types $1_razor_t;
domain_auto_trans($1_t, razor_exec_t, $1_razor_t)

razor_base_domain($1_razor)

# Per-user config/data files
home_domain($1, razor)

tmp_domain($1_razor)

allow $1_razor_t self:unix_stream_socket create_stream_socket_perms;

# Allow razor to be run by hand.  Needed by any action other than
# invocation from a spam filter.
allow $1_razor_t $1_devpts_t:chr_file rw_file_perms;
allow $1_razor_t sshd_t:fd use;
')

--=-bAzBmk7tvI/K2Kk1IZEq
Content-Disposition: attachment; filename=razor.te
Content-Type: text/plain; name=razor.te; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# Razor - Vipul's Razor is a distributed, collaborative, spam
#         detection and filtering network.
#
# Author:  David Hampton <hampton@employees.org>
#

# NOTE: This policy will work with either the ATrpms provided config
# file in /etc/razor, or with the default of dumping everything into
# $HOME/.razor.

type razor_port_t, port_type, reserved_port_type;

##########
# Razor query application - from system_r applictions
##########
type razor_t, domain, privlog, daemon;
type razor_exec_t, file_type, sysadmfile, exec_type;
role system_r types razor_t;

razor_base_domain(razor)

# Razor config file directory.  When invoked as razor-admin, it can
# update files in this directory.
etcdir_domain(razor)
create_dir_file(razor_t, razor_etc_t);

# Shared razor files updated freuently
var_lib_domain(razor)

# Log files
log_domain(razor)
allow razor_t var_log_t:dir search;
ifdef(`logrotate.te', `
allow logrotate_t razor_log_t:file r_file_perms;
')

##########
##########

#
# Some spam filters executes the razor code directly.  Allow them access here.
#
define(`razor_access',`
r_dir_file($1, razor_etc_t)
allow $1 var_log_t:dir search;
allow $1 razor_log_t:file ra_file_perms;
r_dir_file($1, razor_var_lib_t)
r_dir_file($1, sysadm_razor_home_t)
can_network_client_tcp($1, razor_port_t)
')

ifdef(`spamd.te', `razor_access(spamd_t)');
ifdef(`amavis.te', `razor_access(amavisd_t)');

--=-bAzBmk7tvI/K2Kk1IZEq--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
