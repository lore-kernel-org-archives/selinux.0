Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA05222
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 14:41:39 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id SAA25395
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 18:41:21 GMT
Received: from mail24.bigmailbox.com (mail24.bigmailbox.com [209.132.220.207])
	by jazzswing.ncsc.mil  with ESMTP id SAA25391
	for <selinux@tycho.nsa.gov>; Wed, 4 Apr 2001 18:41:20 GMT
Date: Wed, 4 Apr 2001 11:41:37 -0700
Message-Id: <200104041841.LAA21943@mail24.bigmailbox.com>
Content-Type: text/plain
Mime-Version: 1.0
From: "Jonathan Day" <jd9812@my-deja.com>
To: selinux@tycho.nsa.gov
Subject: Assorted ramblings
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

   First off, any news on when the next SELinux snapshot is likely? And will it play nice with devfs? (The existing version can get nasty, as the filing system holding the devices is virtual and gets recreated on each boot.)

   Second, I'm trying to shoe-horn the SELinux kernel patch into an -ac kernel. (2.4.3-ac2, with the International patches applied, to be exact.) 2.4.3 patched OK (well, apart from one #ifdef'ed comment, which doesn't seem too catastrophic :), but the -ac stuff is sufficiently different to really muck things up. Anyone tried this? And, if so, are there any kernel burps that crop up that I need to watch for?

Thanks




------------------------------------------------------------
--== Sent via Deja.com ==--
http://www.deja.com/



--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
