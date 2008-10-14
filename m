Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m9EIZQZA007646
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 14:35:27 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m9EIYA89015972
	for <selinux@tycho.nsa.gov>; Tue, 14 Oct 2008 18:34:10 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: refpolicy@oss.tresys.com, selinux@tycho.nsa.gov
Content-Type: text/plain
Date: Tue, 14 Oct 2008 14:34:20 -0400
Message-Id: <1224009260.21012.30.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  In this release, support for
init scripts with different labels was added.  For example, this enables
an Apache admin to restart only the Apache service, not all services.
The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop and user-based role separation areas need attention.

* Tue Oct 14 2008 Chris PeBenito <selinux@tresys.com> - 20081014
- Debian update for NetworkManager/wpa_supplicant from Martin Orr.
- Logrotate and Bind updates from Vaclav Ovsik.
- Init script file and domain support.
- Glibc 2.7 fix from Vaclav Ovsik.
- Samba/winbind update from Mike Edenfield.
- Policy size optimization with a non-security file attribute from James
  Carter.
- Database labeled networking update from KaiGai Kohei.
- Several misc changes from the Fedora policy, cherry picked by David
  Hardeman.
- Large whitespace fix from Dominick Grift.
- Pam_mount fix for local login from Stefan Schulze Frielinghaus.
- Issuing commands to upstart is over a datagram socket, not the initctl
  named pipe.  Updated init_telinit() to match.
- Added modules:
        cyphesis (Dan Walsh)
        memcached (Dan Walsh)
        oident (Dominick Grift)
        w3c (Dan Walsh)


-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
