Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h3O2uJI4006183
	for <selinux@tycho.nsa.gov>; Wed, 23 Apr 2003 22:56:20 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h3O2uEVf009919
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 02:56:14 GMT
Received: from sat.sws.net.au ([202.5.161.49])
	by jazzswing.ncsc.mil  with ESMTP id h3O2uB4D009916
	for <selinux@tycho.nsa.gov>; Thu, 24 Apr 2003 02:56:12 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Peter Gervai <grin@tolna.net>, SELinux List <selinux@tycho.nsa.gov>
Subject: Re: please offer your good advices / new policies: exim, dovecot, maradns, (aptitude)
Date: Thu, 24 Apr 2003 12:56:09 +1000
References: <20030423111231.GV3993@narya.grin.hu>
In-Reply-To: <20030423111231.GV3993@narya.grin.hu>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_JJ1p+pIIHoW4FI6"
Message-Id: <200304241256.09174.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_JJ1p+pIIHoW4FI6
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 24 Apr 2003 02:06, Peter Gervai wrote:
> My policies are on http://narya.grin.hu/selinux/policy/
> There is a diff to help to show my actions, and the policies are there as
> well if someone needs them.

In future please provide .tar.gz archives of policy as that makes it easier to 
download and reduces the risk of errors in transmission.  Some web browsers 
do silly things like converting from Unix to DOS text files, a .tar.gz file 
will generally escape unscathed.

# links to exim
#  leave them alone - putting them into exim_exec_t causes
#  programs to fail read on lnk_files.
You can put a "--" after the file name to specify that only file types (not 
links) are matched.

It would be good if we could have the main exim program labeled as 
sendmail_exec_t so it fits in better with mta.te (it's a pity that exim 
doesn't provide separate programs for the tasks of mail queuing and of the 
full mail server functionality).  mta.te is necessary for all mail servers.  
It's the base policy for running "sendmail -t" for sending mail from a 
program.  All mail servers that accept mail from local processes should use 
mta.te.

One thing I recommend for all daemons is to use the daemon_base_domain() or 
daemon_domain() macro as appropriate.  This gets all the base access a daemon 
needs and reduces the effort for someone who reads the policy, they can just 
see the daemon_domain() macro (which corresponds to over a dozen lines of 
policy that you wrote), know what it does, and keep reading.

The drawback for using daemon_domain in this situation is that it wants the 
executable type to be based on the name of the daemon domain.  So sendmail_t 
is required to match sendmail_exec_t (not what you desire).

To solve this we could change mta.te and mta_macros.te to use some ifdef's to 
use exim_exec_t in the case of exim and sendmail_exec_t for other mail 
servers.

I have attached a modified exim.te which contains some of the changes I 
suggest.  Also note that I removed every_domain() because it's bad.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_JJ1p+pIIHoW4FI6
Content-Type: text/plain;
  charset="iso-8859-1";
  name="exim.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="exim.te"

#DESC Exim - Mail server
#
# Authors:  Peter Gervai <grin@grin.hu>
# Original by: Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the exim_t domain.
#
# exim_t is the domain for the exim 
# daemon started by the init rc scripts.
#
# depends on mta.te
#
daemon_domain(exim, `, mta_delivery_agent')

tmp_domain(exim)
log_domain(exim)

# --<g>
type exim_spool_t, file_type, sysadmfile;
type etc_exim_t, file_type, sysadmfile;
# not strictly required
#file_type_auto_trans(exim_t, etc_t, etc_exim_t)

# Use capabilities
allow exim_t exim_t:capability { setuid setgid net_bind_service sys_nice chown };

# Use the network.
can_network(exim_t)
allow exim_t resolv_conf_t:file r_file_perms;

# Bind to the SMTP port.
allow exim_t smtp_port_t:tcp_socket name_bind;

# Write to /etc/aliases and /etc/mail.
#allow exim_t etc_aliases_t:file { setattr rw_file_perms };
#allow exim_t etc_mail_t:dir rw_dir_perms;
#allow exim_t etc_mail_t:file create_file_perms;

# Write to /var/spool/mail and /var/spool/mqueue.
allow exim_t mail_spool_t:dir rw_dir_perms;
allow exim_t mail_spool_t:file create_file_perms;
allow exim_t exim_spool_t:dir rw_dir_perms;
allow exim_t exim_spool_t:file create_file_perms;

# /usr/sbin/exim asks for w access to utmp, but it will operate
# correctly without it.  Do not audit write denials to utmp.
#dontaudit exim_t initrc_var_run_t:file { read write };

# When exim runs as user_mail_domain, it needs some extra permissions
# to update /etc/mail/statistics.
#allow user_mail_domain etc_mail_t:file rw_file_perms;

# Silently deny attempts to access /root.
##FIXME:
##dontaudit exim_t sysadm_home_dir_t:dir { getattr search };
##dontaudit system_mail_t sysadm_home_dir_t:dir { getattr search };

# Run procmail in its own domain, if defined.
ifdef(`procmail.te',`
domain_auto_trans(exim_t, procmail_exec_t, procmail_t)
#domain_auto_trans(system_mail_t, procmail_exec_t, procmail_t)
')

# exim -q 
#@allow system_mail_t exim_spool_t:dir rw_dir_perms;
#@allow system_mail_t exim_spool_t:file create_file_perms;

# Inherit and use pipes created by rc scripts.
#@allow system_mail_t initrc_t:fd use;
#@allow system_mail_t initrc_t:fifo_file { getattr read write };

r_dir_file(exim_t, etc_exim_t)
# searches /proc/net/if_inet6 to check ipv6 existence
allow system_crond_t exim_exec_t:file r_file_perms;
# ?
#domain_auto_trans(sysadm_mail_t, exim_exec_t, exim_t)
# ?
domain_auto_trans(initrc_t, exim_exec_t, exim_t)
# hmm - startup
allow exim_t etc_t:lnk_file read;
# checks /var/spool/exim existence
allow exim_t var_spool_t:dir search;
# call ourselves
allow exim_t exim_exec_t:file execute_no_trans;
# hm
allow exim_t sbin_t:dir search;

allow exim_t etc_aliases_t:file r_file_perms;

# huh?
#allow exim_t var_t:dir getattr

# awww
allow exim_t self:capability  dac_override ;
#allow exim_t self:capability { dac_override dac_read_search };

--Boundary-00=_JJ1p+pIIHoW4FI6--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
