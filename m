Message-ID: <4366F160.2070005@cornell.edu>
Date: Mon, 31 Oct 2005 23:38:56 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>, Joshua Brindle <jbrindle@tresys.com>
Subject: Re: [ SEMANAGE ] Fix MLS parsing of users
References: <4366EE1B.1060303@cornell.edu>
In-Reply-To: <4366EE1B.1060303@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

By the way, expanding the module (sepol_expand_module) takes an 
unusually long time to run... commit is very slow (and this is on an 
Athlon3k computer)....

1. Time to modify seuser things: 0.5 sec
2. Time to call sepol_expand_module: 9 sec
3. Time to merge and commit other policy components, and load the 
policy: 1 sec

You can see why I want (2), and most of (3) skipped in the case of 
seusers...need to add tracking of when the policy is modified.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
