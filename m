Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hBJ2jsRb010081
	for <selinux@tycho.nsa.gov>; Thu, 18 Dec 2003 21:45:54 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id hBJ2j4jx011202
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 02:45:04 GMT
Received: from continuum.cm.nu (continuum.cm.nu [216.113.193.225])
	by jazzswing.ncsc.mil  with ESMTP id hBJ2j3SR011197
	for <selinux@tycho.nsa.gov>; Fri, 19 Dec 2003 02:45:03 GMT
Received: from shane by continuum.cm.nu with local (Exim 4.30)
	id 1AXAeD-0006mx-GD
	for selinux@tycho.nsa.gov; Thu, 18 Dec 2003 18:45:49 -0800
Date: Thu, 18 Dec 2003 18:45:48 -0800
To: selinux@tycho.nsa.gov
Subject: Domain Transitions (or the Exim4 policy)
Message-ID: <20031219024548.GA24510@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Shane Wegner <shane-keyword-selinux.9d5a25@cm.nu>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi all,

I am new to this list and SELinux in general but have
managed to get it running on a Debian cid system using
Russell's packages and policies.  Those policies did come
with a sendmail policy which I have attempted to modify for
exim4.  I believe I have the file permissions pretty much
figured out but the domain transitions are a bit confusing.

The two things I am not sure of is when exim calls
procmail, there is a domain transition to procmail_t which
is rather restrictive.  My own personal .procmailrc file
for example runs tmda which is a python program which in
turn can send out response emails.  procmail_t by default
doesn't want any part of this and when procmail calls
sendmail which is a symbolic link back to exim4, there is
no transition back to exim4_t so exim doesn't have the
permissions it needs.  Further, when a user sends mail, say
echo Hello world |mail
exim4 gets spawned but this time in the user_t domain,
again without the necessary permissions to write to its
spool.

I'm thinking maybe procmail should run as user_r:user_t as
a users procmail process should be able to do anything the
logged in user can do.  Would that be a better way of doing
things?  Also, how would I set it up so that whenever a
user, cron, or any other process for that matter called
exim4 or sendmail, it took it into the exim4_t domain?

For anyone who is interested, I have included exim4.te
below.  Any comments would be appreciated.

#DESC Exim4 - Mail server
#
# Adapted from sendmail.te by Shane Wegner <shane@cm.nu>
# sendmail.te Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
# X-Debian-Packages: exim4-daemon-heavy
# Depends: mta.te
#

#################################
#
# Rules for the exim4_t domain.
#
# exim4_t is the domain for the exim4 
# daemon started by the init rc scripts.
#

daemon_domain(exim4, `, mta_delivery_agent, mail_server_domain')

tmp_domain(exim4)
log_domain(exim4)

allow initrc_t exim4_exec_t:lnk_file read;

# Use capabilities
allow exim4_t self:capability { chown dac_override fowner setuid setgid sys_resource net_bind_service };
allow exim4_t self:process setpgid;

# Use the network.
can_network(exim4_t)
allow exim4_t resolv_conf_t:file { getattr read };

allow exim4_t self:unix_stream_socket create_stream_socket_perms;
allow exim4_t self:unix_dgram_socket create_socket_perms;
# TODO: Does exim use fifos?
allow exim4_t self:fifo_file rw_file_perms;

# Bind to the SMTP port.
allow exim4_t smtp_port_t:tcp_socket name_bind;

allow exim4_t etc_t:file { getattr read };

allow exim4_t etc_aliases_t:file { getattr r_file_perms };
allow exim4_t exim4_conf_t:dir rw_dir_perms;
allow exim4_t exim4_conf_t:file create_file_perms;
# for the start script to generate exim4.config
# from /etc/exim4/conf.d fragments
allow initrc_t exim4_conf_t:dir rw_dir_perms;
allow initrc_t exim4_conf_t:file create_file_perms;

# Write to /var/spool/mail and /var/spool/exim4
allow exim4_t var_spool_t:dir search;
allow exim4_t exim4_spool_t:dir { read getattr lock search ioctl add_name remove_name write rmdir };
allow exim4_t exim4_spool_t:file { create ioctl read getattr lock write setattr append link unlink rename };
allow exim4_t mail_spool_t:dir rw_dir_perms;
allow exim4_t mail_spool_t:file create_file_perms;

#allow exim4_t lib_t:file { getattr read };

# Run procmail in its own domain, if defined.
ifdef(`procmail.te',`
domain_auto_trans(exim4_t, procmail_exec_t, procmail_t)
allow exim4_t bin_t:dir { getattr search };
')

allow exim4_t sysctl_kernel_t:dir search;
allow exim4_t sysctl_kernel_t:file { getattr read };
allow exim4_t random_device_t:chr_file read;

ifdef(`clamav.te', `
# Comment these directives if not using clam from an acl or if
# Exim is not otherwise directly connecting to clamd.
can_unix_connect(exim4_t, clamd_var_run_t)
allow exim4_t clamd_var_run_t:sock_file { write };
dontaudit clamd_t var_spool_t:dir { search };
allow clamd_t exim4_spool_t:dir { search };
allow clamd_t exim4_spool_t:file { getattr read };
')

ifdef(`mailman.te', `
# Recommended Debian Exim ACLs check for a mailing list
# by the existance of its config file in mailman_data_t
allow exim4_t mailman_data_t:file { getattr read };
')

#domain_auto_trans(initrc_t, exim4_exec_t, exim4_t)
#allow initrc_t exim4_exec_t:lnk_file read;
allow exim4_t exim4_exec_t:file execute_no_trans;
allow exim4_t sbin_t:dir search;

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
