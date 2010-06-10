Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o5A4oKfE028671
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 00:50:20 -0400
Received: from mail-pv0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o5A4nVbU014611
	for <selinux@tycho.nsa.gov>; Thu, 10 Jun 2010 04:49:31 GMT
Received: by pvg6 with SMTP id 6so964898pvg.12
        for <selinux@tycho.nsa.gov>; Wed, 09 Jun 2010 21:50:18 -0700 (PDT)
Message-ID: <4C106F0F.8020000@gmail.com>
Date: Wed, 09 Jun 2010 21:50:23 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: warning: the frame size of 1072 bytes is larger than 1024 bytes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I've racked my brain with this one today
with no results, but only what/where(maybe)
is the cause for this:

policydb_destroy(&oldpolicydb);

if I change the &oldpolicydb to
either &newpolicydb or &policydb
I can get a clean compile without any
warning message like below.

security/selinux/ss/services.c: In function 'security_load_policy':
security/selinux/ss/services.c:1882: warning: the frame size of 1072 
bytes is larger than 1024 bytes

is this a bug in policydb?
any ideas on this one?

Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
