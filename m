Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA06786
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2001 04:59:36 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id IAA17656
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2001 08:59:20 GMT
Received: from mailgate3.cinetic.de (mailgate3.cinetic.de [212.227.116.80])
	by jazzband.ncsc.mil  with ESMTP id IAA17652
	for <selinux@tycho.nsa.gov>; Tue, 31 Jul 2001 08:59:19 GMT
Received: from web.de (fmomail02.dlan.cinetic.de [172.20.1.46])
	by mailgate3.cinetic.de (8.11.2/8.11.2/SuSE Linux 8.11.0-0.4) with SMTP id f6V8xX620375
	for selinux@tycho.nsa.gov; Tue, 31 Jul 2001 10:59:33 +0200
Date: Tue, 31 Jul 2001 10:59:33 +0200
Message-Id: <200107310859.f6V8xX620375@mailgate3.cinetic.de>
MIME-Version: 1.0
From: "king killer" <thenamelessone@web.de>
To: selinux@tycho.nsa.gov
Subject: Re: seperate kernel modules
Content-Type: text/plain; charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

first
i know the hurd
second
l4 is a great design
third
if you really read the exokernel manual you will see that it
is much more than a microkernel, since it handles network messages, hd blocks etc.
fourth
to seperate kernel modules another instance (a first-level kernel)would be needed that would handle ressource registration, for kernel modules which would then run in ring 1. the problem is that if you want to securely seperate them you have to put them into multiple segments.then a call from one module to another would include a call to the first-level-kernel.for all this stub routines could be made which would be mapped into every module segment and the module calls would point to the stup routine which would do the right call the 1st-lv-kernel.there would be no need to change the modules greatly, but the linux kernel would have to be completely modularized.

_______________________________________________________________________
1.000.000 DM gewinnen - kostenlos tippen - http://millionenklick.web.de
IhrName@web.de, 8MB Speicher, Verschluesselung - http://freemail.web.de



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
