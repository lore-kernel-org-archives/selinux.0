Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id OAA17239
	for <selinux@tycho.nsa.gov>; Mon, 1 Apr 2002 14:23:38 -0500 (EST)
From: belef24@ift.ulaval.ca
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id TAA22614
	for <selinux@tycho.nsa.gov>; Mon, 1 Apr 2002 19:22:31 GMT
Received: from courriel.ift.ulaval.ca (courriel.ift.ulaval.ca [132.203.26.4])
        by jazzband.ncsc.mil  with ESMTP id TAA22610 for <selinux@tycho.nsa.gov>; Mon, 1 Apr 2002 19:22:30 GMT
Received: (from nobody@localhost)
	by courriel.ift.ulaval.ca (8.10.1/8.10.1) id g31JN4s16425
	for selinux@tycho.nsa.gov; Mon, 1 Apr 2002 14:23:04 -0500
To: <selinux@tycho.nsa.gov>
Subject: Problem with newrole && || login.c
Message-ID: <1017688984.3ca8b39827d25@courriel.ift.ulaval.ca>
Date: Mon, 01 Apr 2002 14:23:04 -0500
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--- newrole problem ---
hi, when i try to change my role, i got this ( in debug mode ) :
bash-2.05# newrole -r user_r
Your type will be user_t.
Your old SID was 157
Your old context was system_u:system_r:sysadm_t
system_u
cannot find your entry in the passwd file.
the system_u line is what context_user_get(context) return.
So, i dont have any system_u in my passwd ( my passwd is normal like any other
unix system ) maybe im wrong here??
--- login problem ----
ok my login problem is that i dont use PAM so i change it in MCONFIG to no and
no login.c are compiled...i dont understand why and i suppose i must have a
new login to work with my shadow. ( i use slack its why i dont use pam :) )
Someone can help me please or got any idea? thx.


-------------------------------------------------
Ce message a été envoyé par le serveur IMP du département d'informatique à l'université Laval: courriel.ift.ulaval.ca

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
