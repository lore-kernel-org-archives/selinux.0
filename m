Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4P2n7Rb015063
	for <selinux@tycho.nsa.gov>; Mon, 24 May 2004 22:49:07 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4P2n3AR001219
	for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 02:49:03 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
        by jazzband.ncsc.mil  with ESMTP id i4P2n1Hn001160 for <selinux@tycho.nsa.gov>; Tue, 25 May 2004 02:49:02 GMT
From: Russell Coker <rcoker@redhat.com>
Reply-To: rcoker@redhat.com
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
Subject: Re: [patch] policy for nrpe
Date: Tue, 25 May 2004 12:41:22 +1000
Cc: SELinux ML <selinux@tycho.nsa.gov>
References: <20040523214406.GB6147@jmh.mhn.de> <200405241056.58596.rcoker@redhat.com> <20040524090907.GA15439@thebe.cip.ifi.lmu.de>
In-Reply-To: <20040524090907.GA15439@thebe.cip.ifi.lmu.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_SJrsAJW6r09l4qo"
Message-Id: <200405251241.22708.rcoker@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_SJrsAJW6r09l4qo
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 24 May 2004 19:09, Thomas Bleher <bleher@informatik.uni-muenchen.de> 
wrote:
> > We currently have a netsaint.te in the policy, should we change that to
> > nagios.te?
>
> Yes, I think it would be best to change the name.

OK, I've attached nagios.te and nagios.fc to replace netsaint.te and 
netsaint.fc.  I have not made any changes other than the renaming.  I have 
not put in typealias rules because I don't believe that my netsaint policy 
got enough use to make compatibility an issue.

-- 
http://apac.redhat.com/disclaimer
See above URL for disclaimer.

--Boundary-00=_SJrsAJW6r09l4qo
Content-Type: text/plain;
  charset="iso-8859-15";
  name="nagios.fc"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nagios.fc"

# netsaint - network monitoring server
/usr/sbin/netsaint		--	system_u:object_r:nagios_exec_t
#/var/run/netsaint(/.*)?		system_u:object_r:nagios_var_run_t
/etc/netsaint(/.*)?			system_u:object_r:nagios_etc_t
/var/log/netsaint(/.*)?			system_u:object_r:nagios_log_t
/usr/lib(64)?/netsaint/plugins(/.*)?		system_u:object_r:bin_t
/usr/lib(64)?/cgi-bin/netsaint/.+	--	system_u:object_r:nagios_cgi_exec_t

--Boundary-00=_SJrsAJW6r09l4qo
Content-Type: text/plain;
  charset="iso-8859-15";
  name="nagios.te"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nagios.te"

#DESC Net Saint / NAGIOS - network monitoring server
#
# Author:  Russell Coker <russell@coker.com.au>
# X-Debian-Packages: netsaint, nagios
# Depends: mta.te
#

#################################
#
# Rules for the nagios_t domain.
#
# nagios_exec_t is the type of the netsaint/nagios executable.
#
daemon_domain(nagios, `, privmail')

etcdir_domain(nagios)
typealias nagios_etc_t alias etc_nagios_t;

logdir_domain(nagios)
allow nagios_t nagios_log_t:fifo_file create_file_perms;
allow initrc_t nagios_log_t:dir rw_dir_perms;

tmp_domain(nagios)
allow system_mail_t nagios_tmp_t:file { getattr read };
# for open file handles
dontaudit system_mail_t nagios_etc_t:file read;
dontaudit system_mail_t nagios_log_t:fifo_file read;

# Use the network.
allow nagios_t self:fifo_file rw_file_perms;
allow nagios_t self:unix_stream_socket create_socket_perms;
allow nagios_t self:unix_dgram_socket create_socket_perms;

# Use capabilities
allow nagios_t self:capability { dac_override setgid setuid };
allow nagios_t self:process setpgid;

allow nagios_t { bin_t sbin_t }:dir search;
allow nagios_t bin_t:lnk_file read;
can_exec(nagios_t, { shell_exec_t bin_t })

allow nagios_t proc_t:file { getattr read };

can_network(nagios_t)

# read config files
allow nagios_t { etc_t etc_runtime_t }:file { getattr read };
allow nagios_t etc_t:lnk_file read;

allow nagios_t etc_t:dir r_dir_perms;

# for ps
r_dir_file(nagios_t, domain)
allow nagios_t boot_t:dir search;
allow nagios_t system_map_t:file { getattr read };

# for who
allow nagios_t initrc_var_run_t:file { getattr read lock };

system_domain(nagios_cgi)
allow nagios_cgi_t device_t:dir search;
r_dir_file(nagios_cgi_t, nagios_etc_t)
allow nagios_cgi_t var_log_t:dir search;
r_dir_file(nagios_cgi_t, nagios_log_t)
allow nagios_cgi_t self:process { fork signal_perms };
allow nagios_cgi_t self:fifo_file rw_file_perms;
allow nagios_cgi_t bin_t:dir search;
can_exec(nagios_cgi_t, bin_t)
read_locale(nagios_cgi_t)

# for ps
allow nagios_cgi_t { etc_runtime_t etc_t }:file { getattr read };
r_dir_file(nagios_cgi_t, { proc_t self nagios_t })
allow nagios_cgi_t boot_t:dir search;
allow nagios_cgi_t system_map_t:file { getattr read };
dontaudit nagios_cgi_t domain:dir getattr;
allow nagios_cgi_t self:unix_stream_socket create_socket_perms;

ifdef(`apache.te', `
r_dir_file(httpd_t, nagios_etc_t)
domain_auto_trans({ httpd_t httpd_suexec_t }, nagios_cgi_exec_t, nagios_cgi_t)
allow nagios_cgi_t httpd_log_t:file append;
')

ifdef(`ping.te', `
domain_auto_trans(nagios_t, ping_exec_t, ping_t)
allow nagios_t ping_t:process { sigkill signal };
dontaudit ping_t nagios_etc_t:file read;
dontaudit ping_t nagios_log_t:fifo_file read;
')

--Boundary-00=_SJrsAJW6r09l4qo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
