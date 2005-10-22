Message-ID: <435AB140.4020001@cornell.edu>
Date: Sat, 22 Oct 2005 17:38:08 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
CC: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: [ SEMANAGE ] Resync to sepol changes
References: <435A8AE9.3020709@cornell.edu>
In-Reply-To: <435A8AE9.3020709@cornell.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

>
> It _should_ commit the users file successfully... but it doesn't yet - 
> need to do some more investigation.
> I'm pretty sure it's read successfully, updated successfully, and 
> merged into policy... not sure why it doesn't commit.

I see what's wrong... my implementations of add() and modify() invoke 
other functions of the database, but the enter_ro/exit_ro/enter_rw 
functions are not reentrant. As a result, the read lock is dropped 
early, and more importantly, the cache is dropped too (so all 
modifications are lost every time).

Hmm...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
