Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6QGfcCq000306
	for <selinux@tycho.nsa.gov>; Thu, 26 Jul 2012 12:41:38 -0400
Message-ID: <50117340.9010104@tresys.com>
Date: Thu, 26 Jul 2012 12:41:36 -0400
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
MIME-Version: 1.0
To: "refpolicy@oss.tresys.com" <refpolicy@oss1.tresys.com>,
        "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: ANN: Reference Policy Release
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the Tresys OSS site, http://oss.tresys.com.

* Wed Jul 25 2012 Chris PeBenito <selinux@tresys.com> - 2.20120725
- Rename epollwakeup capability2 permission to block_suspend to match the
  corresponding kernel capability rename.
- Udev and init changes to support /run, from Sven Vermeulen.
- auth_use_nsswitch updates from Miroslav Grepl.
- Mount runtime files fix from Guido Trentalancia.
- Update Python scripts to support Python 3, from Sven Vermeulen.
- Update capability2 object class for new wake_alarm and epollwakeup
  capabilities.
- SEPostgresql updates from Kohei KaiGai.
- Simplify file contexts based on file context path substitutions, from Sven
  Vermeulen.
- Add optional name for kernel and system filetrans interfaces.
- Non-auth file attribute to eliminate set expressions, from James Carter.
- Virt updates from Sven Vermeulen.
- Various dontaudits from Sven Vermeulen.
- Fix base module and monolithic role declaration ordering issue now that
  role declarations must be explicit, from Harry Ciao.
- Added contrib modules:
        bacula (Stan Sander/Sven Vermeulen)
        bcfg2 (Miroslav Grepl)
        blueman (Miroslav Grepl)


-- 
Chris PeBenito
Tresys Technology, LLC
www.tresys.com | oss.tresys.com


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
