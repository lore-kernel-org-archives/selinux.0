Subject: Re: Many log entries in /var/log/messages?
From: Stephen Smalley <sds@tycho.nsa.gov>
To: James Jansen <james1940@gmail.com>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <e311c5d90702260523p2925038ctc924503b8655b61e@mail.gmail.com>
References: <e311c5d90702260523p2925038ctc924503b8655b61e@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 26 Feb 2007 08:33:06 -0500
Message-Id: <1172496786.19041.183.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2007-02-26 at 14:23 +0100, James Jansen wrote:
> Good afternoon,
> 
> I recently discovered that selinux is writing many log entries to my
> /var/log/messages file, about 10 per second. These log entries all
> have the following format:
> 
> Feb 26 13:04:31 plesk kernel: audit(1172495067.819:379181): avc:
> denied  { connectto } for  pid=28130 comm="httpd"
> path=000000008B1E34524756E536DB1D126A5358A52E90889B5F010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
> scontext=root:system_r:httpd_t tcontext=user_u:system_r:initrc_t
> tclass=unix_stream_socket
> 
> My server has RHEL4 with selinux enabled:
> SELINUX=enforcing
> SELINUXTYPE=targeted
> 
> getsebool -a returns:
> allow_syslog_to_console --> inactive
> allow_ypbind --> inactive
> dhcpd_disable_trans --> inactive
> httpd_builtin_scripting --> active
> httpd_disable_trans --> inactive
> httpd_enable_cgi --> active
> httpd_enable_homedirs --> active
> httpd_ssi_exec --> active
> httpd_tty_comm --> inactive
> httpd_unified --> active
> mysqld_disable_trans --> inactive
> named_disable_trans --> inactive
> named_write_master_zones --> inactive
> nscd_disable_trans --> inactive
> ntpd_disable_trans --> inactive
> pegasus_disable_trans --> inactive
> plesk_enable_fp --> active
> plesk_enable_spamassasin --> active
> plesk_enable_webapps --> active
> portmap_disable_trans --> inactive
> postgresql_disable_trans --> inactive
> sitebuilder_enable_upload --> active
> snmpd_disable_trans --> inactive
> squid_disable_trans --> inactive
> syslogd_disable_trans --> inactive
> use_nfs_home_dirs --> inactive
> use_samba_home_dirs --> inactive
> use_syslogng --> inactive
> winbind_disable_trans --> inactive
> ypbind_disable_trans --> inactive
> 
> What should i do to prevent these message from appearing? I suspect i
> have to activate or deactivate a bool, but i'm not sure which one.
> 
> Can someone please offer me a helping hand? (or a better place where i
> can ask this question)

Run 'ps -eZ | grep initrc_t'.  You have some process left running in the
initrc_t domain, which is only intended for use by init scripts, and
httpd is trying to connect to it.  So you need to identify that process,
put it into an appropriate domain, and then allow httpd to connect to it
(w/o being able to connect to arbitrary other processes on your system).
Or, if it isn't truly needed for operation, you can suppress the audit
message via a dontaudit rule instead.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
