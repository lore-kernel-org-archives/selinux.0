Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l1QDMLdU018242
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 08:22:22 -0500
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l1QDNgZc023840
	for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 13:23:42 GMT
Received: by ug-out-1314.google.com with SMTP id y2so931657uge
        for <selinux@tycho.nsa.gov>; Mon, 26 Feb 2007 05:23:40 -0800 (PST)
Message-ID: <e311c5d90702260523p2925038ctc924503b8655b61e@mail.gmail.com>
Date: Mon, 26 Feb 2007 14:23:40 +0100
From: "James Jansen" <james1940@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Many log entries in /var/log/messages?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Good afternoon,

I recently discovered that selinux is writing many log entries to my
/var/log/messages file, about 10 per second. These log entries all
have the following format:

Feb 26 13:04:31 plesk kernel: audit(1172495067.819:379181): avc:
denied  { connectto } for  pid=28130 comm="httpd"
path=000000008B1E34524756E536DB1D126A5358A52E90889B5F010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
scontext=root:system_r:httpd_t tcontext=user_u:system_r:initrc_t
tclass=unix_stream_socket

My server has RHEL4 with selinux enabled:
SELINUX=enforcing
SELINUXTYPE=targeted

getsebool -a returns:
allow_syslog_to_console --> inactive
allow_ypbind --> inactive
dhcpd_disable_trans --> inactive
httpd_builtin_scripting --> active
httpd_disable_trans --> inactive
httpd_enable_cgi --> active
httpd_enable_homedirs --> active
httpd_ssi_exec --> active
httpd_tty_comm --> inactive
httpd_unified --> active
mysqld_disable_trans --> inactive
named_disable_trans --> inactive
named_write_master_zones --> inactive
nscd_disable_trans --> inactive
ntpd_disable_trans --> inactive
pegasus_disable_trans --> inactive
plesk_enable_fp --> active
plesk_enable_spamassasin --> active
plesk_enable_webapps --> active
portmap_disable_trans --> inactive
postgresql_disable_trans --> inactive
sitebuilder_enable_upload --> active
snmpd_disable_trans --> inactive
squid_disable_trans --> inactive
syslogd_disable_trans --> inactive
use_nfs_home_dirs --> inactive
use_samba_home_dirs --> inactive
use_syslogng --> inactive
winbind_disable_trans --> inactive
ypbind_disable_trans --> inactive

What should i do to prevent these message from appearing? I suspect i
have to activate or deactivate a bool, but i'm not sure which one.

Can someone please offer me a helping hand? (or a better place where i
can ask this question)

Thank you,
James Timmer

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
