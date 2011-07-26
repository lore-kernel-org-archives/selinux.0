Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id p6QIiVe7018928
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2011 14:44:31 -0400
Received: from exchange10.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id p6QIiTPQ022033
	for <selinux@tycho.nsa.gov>; Tue, 26 Jul 2011 18:44:30 GMT
Message-ID: <4E2F0B0D.9050206@tresys.com>
Date: Tue, 26 Jul 2011 14:44:29 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: "refpolicy@oss.tresys.com" <refpolicy@oss1.tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: ANN: Reference Policy Release
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on
the Tresys OSS site, http://oss.tresys.com.  This release primarily
focused on general maintenance.

The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and role separation needs testing, in addition to general
testing.

* Tue Jul 26 2011 Chris PeBenito <selinux@tresys.com> - 2.20110726
- Fix role declarations to handle role attribute compilers.
- Rename audioentropy module to entropyd due to haveged support.
- Add haveged support from Sven Vermeulen.
- Authentication file patch from Matthew Ife.
- Add agent support to zabbix from Sven Vermeulen.
- Cyrus file context update for Gentoo from Corentin Labbe.
- Portage updates from Sven Vermeulen.
- Fix init_system_domain() description, pointed out by Elia Pinto.
- Postgresql selabel_lookup update from KaiGai Kohei.
- Dovecot managesieve support from Mika Pfluger.
- Semicolon after interface/template calls cleanup from Elia Pinto.
- Gentoo courier updates from Sven Vermeulen.
- Amavis patch for connecting to nslcd from Miroslav Grepl.
- Shorewall patch from Miroslav Grepl.
- Cpufreqselector dbus patch from Guido Trentalancia.
- Cron pam_namespace and pam_loginuid support from Harry Ciao.
- Xserver update for startx from Sven Vermeulen.
- Fix MLS constraint for contains permission from Harry Ciao.
- Apache user webpages fix from Dominick Grift.
- Change default build.conf to modular policy from Stephen Smalley.
- Xen refinement patch from Stephen Smalley.
- Sudo timestamp file location update from Sven Vermeulen.
- XServer keyboard event patch from Sven Vermeulen.
- RAID uevent patch from Sven Vermeulen.
- Gentoo ALSA init script usage patch from Sven Vermeulen.
- LVM semaphore usage patch from Sven Vermeulen.
- Module load request patch for insmod from Sven Vermeulen.
- Cron default contexts fix from Harry Ciao.
- Man page fixes from Justin Mattock.
- Add syslog capability.
- Support for logging in to /dev/console, from Harry Ciao.
- Database object class updates and associated SEPostgreSQL changes from
   KaiGai Kohei.
- IPSEC SPD and Hadoop IPSEC updates from Paul Nuzzi.
- Mount updates from Harry Ciao.
- Semanage update for MLS systems from Harry Ciao.
- Vlock terminal use update from Harry Ciao.
- Hadoop CDH3 updates from Paul Nuzzi.
- Add sepgsql_contexts appconfig files from KaiGai Kohei.
- Added modules:
         aiccu
         bugzilla (Dan Walsh)
         colord (Dan Walsh)
         cmirrord (Miroslav Grepl)
         mediawiki (Miroslav Grepl)
         mpd (Miroslav Grepl)
         ncftool
         passenger (Miroslav Grepl)
         qpid (Dan Walsh)
         samhain (Harry Ciao)
         telepathy (Dominick Grift)
         tcsd (Stephen Smalley)
         vnstatd (Dan Walsh)
         zarafa (Miroslav Grepl)


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
