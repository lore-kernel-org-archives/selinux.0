Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1PH1V5v028810
	for <selinux@tycho.nsa.gov>; Sat, 25 Feb 2006 12:01:33 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1PH1T5J002081
	for <selinux@tycho.nsa.gov>; Sat, 25 Feb 2006 17:01:30 GMT
Subject: Wishlist: services/httpd.* module, module meta information,
	conflicts
From: Erich Schubert <erich@debian.org>
To: SE Linux <selinux@tycho.nsa.gov>, cpebenito@tresys.com
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 25 Feb 2006 18:01:29 +0100
Message-Id: <1140886889.20168.32.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
I'd strongly prefer to abstract the apache module from apache to a
generic httpd module and an apache specialization. I'll be running
lighttpd and similar on my selinux boxes I guess. Or maybe continue
using fnord.

A similar thing was already done for sendmail and postfix:
services/mta.*
The same thing is needed for apt-get on rpm and on dpkg.

Is there an easy way to extract dependency information from modules, to
build a dependency satisfaction graph? For automatic (initial) module
installation.

Also I'd like to be able to add meta information (read: old
X-Debian-Packages) to the modules. Is there something in place for them,
or should this be done by
e.g. module.meta files to go along with each module.pp file?
This would probably be the easiest, having such information in there,
eg.
---[ postfix.pp ]--
Description: Postfix policy module
Depends: mta
Conflicts: sendmail
X-Debian-Packages: postfix
---[]---

best regards,
Erich Schubert
-- 
     erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C     (o_
 A man doesn't know what he knows until he knows what he doesn't know. //\
     Während das Glück dir lacht, wirst Freunde du zählen in Menge;    V_/_
       wenn sich der Himmel bewölkt, findest du dich bald allein.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
