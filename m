Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id KAA16934
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 10:52:23 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id OAA04288
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 14:51:52 GMT
Received: from vorpal.mcs.drexel.edu (vorpal.mcs.drexel.edu [129.25.6.250])
	by jazzband.ncsc.mil  with ESMTP id OAA04282
	for <selinux@tycho.nsa.gov>; Tue, 9 Oct 2001 14:51:47 GMT
Subject: ssh, ad nauseum
From: "Justin R. Smith" <jsmith@mcs.drexel.edu>
To: selinux@tycho.nsa.gov
Content-Type: text/plain
Date: 09 Oct 2001 10:51:22 -0400
Message-Id: <1002639082.14315.3.camel@vorpal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm sure people are tired of hearing this, but...

I rebooted my normal (i.e., non-selinux) kernel and ssh'ed to my office
machine from home and was asked for a password (so it didn't use my
'authorized_users' file). Then I remembered that I didn't restore the
vanilla version of the sshd --- I was still using the selinux version. 

I then replaced the selinux sshd with the original one and rebooted.
After this ssh worked normally. So, perhaps something in the selinux
sshd is responsible for my little problem (always having to type a
password to use ssh).
-- 




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
