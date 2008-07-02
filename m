Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m62Fcq42028170
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2008 11:38:52 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m62FcqUp028995
	for <selinux@tycho.nsa.gov>; Wed, 2 Jul 2008 15:38:52 GMT
Subject: ANN: Reference Policy Release
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: SELinux Mail List <selinux@tycho.nsa.gov>
Content-Type: text/plain
Date: Wed, 02 Jul 2008 11:37:22 -0400
Message-Id: <1215013042.14256.7.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

A new release of the SELinux Reference Policy is now available on the
Tresys OSS site, http://oss.tresys.com.  In this release, the user roles
were moved into individual modules.  This enables the policy writer to
easily configure which roles to include in their policy.  It also makes
audit and security administrator roles available in non MLS policies.
The complete change log for this release follows at the end of the
email.

For people interested in helping Reference Policy development, the X
desktop area needs attention.

* Wed Jul 02 2008 Chris PeBenito <selinux@tresys.com> - 20080702
- Fix httpd_enable_homedirs to actually provide the access it is supposed to
  provide.
- Add unused interface/template parameter metadata in XML.
- Patch to handle postfix data_directory from Vaclav Ovsik.
- SE-Postgresql policy from KaiGai Kohei.
- Patch for X.org dbus support from Martin Orr.
- Patch for labeled networking controls in 2.6.25 from Paul Moore.
- Module loading now requires setsched on kernel threads.
- Patch to allow gpg agent --write-env-file option from Vaclav Ovsik.
- X application data class from Eamon Walsh and Ted Toth.
- Move user roles into individual modules.
- Make hald_log_t a log file.
- Cryptsetup runs shell scripts.  Patch from Martin Orr.
- Add file for enabling policy capabilities.
- Patch to fix leaky interface/template call depth calculator from Vaclav
  Ovsik.
- Added modules:
        kerneloops (Dan Walsh)
        kismet (Dan Walsh)
        podsleuth (Dan Walsh)
        prelude (Dan Walsh)
        qemu (Dan Walsh)
        virt (Dan Walsh)

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
