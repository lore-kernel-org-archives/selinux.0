Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2M1MuDo011221
	for <selinux@tycho.nsa.gov>; Mon, 21 Mar 2005 20:22:56 -0500 (EST)
Received: from static-70-19-113-34.ny325.east.verizon.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2M1Kdo2011543
	for <selinux@tycho.nsa.gov>; Tue, 22 Mar 2005 01:20:39 GMT
Subject: New policy for pyzor
From: David Hampton <hampton-rh@rainbolthampton.net>
To: selinux@tycho.nsa.gov
Cc: fedora-selinux-list@redhat.com
Content-Type: multipart/mixed; boundary="=-GEPh34QG21ZL4E2D+7kk"
Date: Mon, 21 Mar 2005 20:23:14 -0500
Message-Id: <1111454594.18940.54.camel@hampton-pc.rainbolthampton.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-GEPh34QG21ZL4E2D+7kk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This is a new strict policy for the pyzor spam filter.  It is based on
the selinux-policy-strict-sources-1.23.2-1 fedora RPM.  This policy
requires the definition of a pyzor reserved port that was in the
net_contexts diff I sent last Wednesday.  Please let me know if there
are any problems with or changes needed to this policy.

David


--=-GEPh34QG21ZL4E2D+7kk
Content-Disposition: attachment; filename=pyzor.fc
Content-Type: text/plain; name=pyzor.fc; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

/etc/pyzor(/.*)?			system_u:object_r:pyzor_etc_t
/usr/bin/pyzor			--	system_u:object_r:pyzor_exec_t
/usr/bin/pyzord			--	system_u:object_r:pyzord_exec_t
/var/lib/pyzord(/.*)?			system_u:object_r:pyzor_var_lib_t
/var/log/pyzord.log		--	system_u:object_r:pyzord_log_t
HOME_DIR/\.pyzor(/.*)?			system_u:object_r:ROLE_pyzor_home_t

--=-GEPh34QG21ZL4E2D+7kk
Content-Disposition: attachment; filename=pyzor_macros.te
Content-Type: text/plain; name=pyzor_macros.te; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# Pyzor - Pyzor is a collaborative, networked system to detect and
#         block spam using identifying digests of messages.
#
# Author:  David Hampton <hampton@employees.org>
#

##########
# common definitions for pyzord and all flavors of pyzor
##########
define(`pyzor_base_domain',`

# Networking
can_network_client_tcp($1_t, http_port_t);
can_network_udp($1_t, pyzor_port_t);
can_resolve($1_t);

general_proc_read_access($1_t)

tmp_domain($1)

allow $1_t bin_t:dir { getattr search };
allow $1_t bin_t:file getattr;
allow $1_t lib_t:file { getattr read };
allow $1_t { var_t var_lib_t var_run_t }:dir search;
uses_shlib($1_t)

# Python does a getattr on this file
allow $1_t pyzor_exec_t:file getattr;

# mktemp and other randoms
allow $1_t { random_device_t urandom_device_t }:chr_file r_file_perms;

# Allow access to various files in the /etc/directory including mtab
# and nsswitch
allow $1_t { etc_t etc_runtime_t }:file { getattr read };
read_locale($1_t)
')


#
# Define a user domain for a pyzor
#
# Note: expects to be called with an argument of user, sysadm

define(`pyzor_domain',`
type $1_pyzor_t, domain, privlog, nscd_client_domain;
role $1_r types $1_pyzor_t;
domain_auto_trans($1_t, pyzor_exec_t, $1_pyzor_t)

pyzor_base_domain($1_pyzor)

# Per-user config/data files
home_domain($1, pyzor)

# System config files
r_dir_file($1_pyzor_t, pyzor_etc_t)

# System data files
r_dir_file($1_pyzor_t, pyzor_var_lib_t);

allow $1_pyzor_t self:unix_stream_socket create_stream_socket_perms;

# Allow pyzor to be run by hand.  Needed by any action other than
# invocation from a spam filter.
allow $1_pyzor_t $1_devpts_t:chr_file rw_file_perms;
allow $1_pyzor_t sshd_t:fd use;
')

--=-GEPh34QG21ZL4E2D+7kk
Content-Disposition: attachment; filename=pyzor.te
Content-Type: text/plain; name=pyzor.te; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

#
# Pyzor - Pyzor is a collaborative, networked system to detect and
#         block spam using identifying digests of messages.
#
# Author:  David Hampton <hampton@employees.org>
#

# NOTE: This policy is based upon the FC3 pyzor rpm from ATrpms.
# Pyzor normally dumps everything into $HOME/.pyzor.  By putting the
# following line to the spamassassin config file:
#
#	pyzor_options --homedir /etc/pyzor
#
# the various files will be put into appropriate directories.
# (I.E. The log file into /var/log, etc.)  This policy will work
# either way.

type pyzor_port_t, port_type, reserved_port_type;

##########
# pyzor daemon
##########
daemon_domain(pyzord, `, privlog, nscd_client_domain')
pyzor_base_domain(pyzord)
allow pyzord_t pyzor_port_t:udp_socket name_bind;
home_domain_access(pyzord_t, sysadm, pyzor)
log_domain(pyzord)

# Read shared daemon/client config file
r_dir_file(pyzord_t, pyzor_etc_t)

# Write shared daemon/client data dir
allow pyzord_t var_lib_t:dir search;
create_dir_file(pyzord_t, pyzor_var_lib_t)

##########
# Pyzor query application - from system_r applictions
##########
type pyzor_t, domain, privlog, daemon;
type pyzor_exec_t, file_type, sysadmfile, exec_type;
role system_r types pyzor_t;

pyzor_base_domain(pyzor)

# System config/data files
etcdir_domain(pyzor)
var_lib_domain(pyzor)

##########
##########

#
# Some spam filters executes the pyzor code directly.  Allow them access here.
#
ifdef(`spamd.te',`
domain_auto_trans(spamd_t, pyzor_exec_t, pyzor_t);
# pyzor needs access to the email spamassassin is checking
allow pyzor_t spamd_tmp_t:file r_file_perms;
')

--=-GEPh34QG21ZL4E2D+7kk--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
