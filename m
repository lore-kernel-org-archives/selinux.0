Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2P2Daao029925
	for <selinux@tycho.nsa.gov>; Fri, 24 Mar 2006 21:13:36 -0500
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2P2DXah024627
	for <selinux@tycho.nsa.gov>; Sat, 25 Mar 2006 02:13:33 GMT
Subject: mta=module not working, make 3.81-rc2 issues
From: Erich Schubert <erich@debian.org>
To: selinux@tycho.nsa.gov
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 25 Mar 2006 03:13:26 +0100
Message-Id: <1143252807.9540.3.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
first of all, mta=module does currently not work. A couple of modules
(e.g. cron) call mta_something interfaces without an optional_policy()
wrap around it.
Maybe we should put that optional_policy statement _into_ the interface
def?

Secondly, make 3.81-rc2 still doesn't build refpolicy correctly.
I'm seeing some odd behaviour again, namely when building
tmp/all_te_files.conf,
it's missing corenetwork.te from the $^ variable _despite_ being in
$(BASE_TE_FILES); again a downgrade to make 3.80 resolved these issues.

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
     We can debug relationships, but it's always good policy to     //\
     consider the people themselves to be features. People get      V_/_
         annoyed when you try to debug them. -- Larry Wall
               Für jedes Problem gibt es eine Lösung,
                 die einfach, klar und falsch ist.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
