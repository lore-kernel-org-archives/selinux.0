Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id PAA05366
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2002 15:59:00 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id UAA10936
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2002 20:58:33 GMT
Received: from portal.east.saic.com (portal.east.saic.com [198.151.13.15])
	by jazzswing.ncsc.mil  with SMTP id UAA10932
	for <selinux@tycho.nsa.gov>; Fri, 4 Jan 2002 20:58:33 GMT
Received: from mcl-its-ieg01.mail.saic.com by mclmx.mail.saic.com for selinux@tycho.nsa.gov; Fri, 4 Jan 2002 15:58:45 -0500
Received: from mcl-its-exbh01.mail.saic.com ([149.8.64.11])
 by mcl-its-ieg01.mail.saic.com (NAVGW 2.5.1.15) with SMTP id M2002010415584408399
 for <selinux@tycho.nsa.gov>; Fri, 04 Jan 2002 15:58:44 -0500
Message-Id: <39C5845092F9D1119AA90008C724FC7C03C18CD6@US-Columbia.mail.saic.com>
From: "Christie, Richard" <ChristieR@atsgroup.saic.com>
To: "'selinux_post'" <selinux@tycho.nsa.gov>
Subject: Syntax for users for MLS
Date: Fri, 4 Jan 2002 15:58:43 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Can someone please tell me the correct syntax for the
policy/users file to support MLS? I know that entries
for this file are to take the form of 
user username roles role_set [ranges MLS range_set]

I am unsure of what form the MLS range set syntax is supposed to be.

an example

user mrbean roles {user_r} ranges {u c s ts};

Also,

Is there better documentation on how to implement MLS somewhere?

Richard Christie
christier@saic.com




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
