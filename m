Message-ID: <4BD92AA3.8020709@gmail.com>
Date: Wed, 28 Apr 2010 23:43:47 -0700
From: "Justin P. Mattock" <justinmattock@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: sds@tycho.nsa.gov
Subject: SELinux Policy in OpenSUSE 11.2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

o.k. Stephen,

bug entry:
https://bugzilla.novell.com/show_bug.cgi?id=582399

you were right with some init
file not having #! /bin/bash
on the top of the head.
after looking around and gutting
/etc/init.d I found
that the files:
/etc/rc.status and rc.splash
has no such entry, so after adding
this entry and rebooting
I can get a clean bootup and policy load
without the need for init_upstart=1

cheers..


Justin P. Mattock

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
