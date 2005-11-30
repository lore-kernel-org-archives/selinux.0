Subject: NTP log rotation on debian [policy addition]
From: Erich Schubert <erich@debian.org>
To: SELinux@tycho.nsa.gov
Content-Type: text/plain
Date: Wed, 30 Nov 2005 14:22:58 +0100
Message-Id: <1133356978.8467.25.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
Debian needs the following addition to the NTP policy:

ifdef(`distro_debian', `
# cronjob to rotate ntp statistic files
create_dir_file(system_crond_t, ntpd_log_t)
')

Since the ntp package contains a cronjob to rotate the ntp stats file,
which are created by default. ntpd doesn't have security critical logs,
so I think it's okay to have the cronjob do that directly. I've filed a
bug report with debian
(http://bugs.debian.org/340781 ) to request they use logrotate... (but
I'm not sure if logrotate currently can handle the timestamped file
naming they use)

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
   In unseren Freunden suchen wir, was uns fehlt. --- Thornton Wilder  V_/_


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
