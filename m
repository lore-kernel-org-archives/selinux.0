Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id JAA04786
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 09:44:54 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id NAA01102
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 13:43:08 GMT
Received: from nox.lemuria.org ([213.191.86.30])
	by jazzswing.ncsc.mil  with ESMTP id NAA01098
	for <selinux@tycho.nsa.gov>; Wed, 24 Apr 2002 13:43:07 GMT
Date: Wed, 24 Apr 2002 15:45:23 +0200
From: Tom <tom@lemuria.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: split admins
Message-ID: <20020424154523.B14453@lemuria.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Policy Question:

I've tried setting up a seperate "security admin" role, as a 1st step
towards a split admin concept. Idea being that sysadm_r can not change the
SELinux policy (obviously I'll have to think about "circumvention" ways
like access to lilo, raw devices, etc. later), but a new role,
secadm_r, has control over these areas.

one problem I encountered was that newrole -r secadm_r didn't work,
kicking me out with:
arkham:~# newrole -r secadm_r
Couldn't get default type.

So where do I set this default type? I didn't find anything obvious,
and actually, I believed that my modification of domains/admin.te,
which included role secadm_r type secadm_t would've taken care of that.


If anyone's done something like this (splitting root into several
segments) before, any hints would be appreciated.


-- 
http://web.lemuria.org/pubkey.html
pub  1024D/D88D35A6 2001-11-14 Tom Vogt <tom@lemuria.org>
     Key fingerprint = 276B B7BB E4D8 FCCE DB8F  F965 310B 811A D88D 35A6

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
