Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id UAA08437
	for <selinux@tycho.nsa.gov>; Sat, 5 Jan 2002 20:24:03 -0500 (EST)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id BAA28971
	for <selinux@tycho.nsa.gov>; Sun, 6 Jan 2002 01:23:36 GMT
Received: from sendmail (savages.net [208.170.193.18] (may be forged))
	by jazzswing.ncsc.mil  with ESMTP id BAA28950
	for <selinux@tycho.nsa.gov>; Sun, 6 Jan 2002 01:23:35 GMT
Message-ID: <3C37B8C3.8090307@pcez.com>
Date: Sat, 05 Jan 2002 18:38:59 -0800
From: Shaun Savage <savages@pcez.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: change login.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi

during login with selinux, the question "do you want to change context" 
is asked.  My feeling is that this creates  complexity problem.  I have 
changed get_user_sid() to get_default_user_sid().  This does not confuse 
"the user" also, if someone does get root this adds one more fence.

Shaun Savage


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
