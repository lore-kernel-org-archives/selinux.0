Message-ID: <72222DC86846D411ABD300A0C9EB08A1015242C8@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'Hacko'" <toltec@karai.net>, SELinux@tycho.nsa.gov
Subject: RE: shell history task
Date: Fri, 8 Feb 2002 12:13:15 -0600 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I may be totally off base here, but the best you could do 
is to create a append_only_file_t. This may be useful  for 
some log files too. The real problem is unset SOMEENVIRONMNET. 
The environment variables are residing in the bash program 
itself. The unset command is part of the bash program, 
I am not sure of any way the create SELinux 
rules that would effect the way a programs behave to itself without 
making system calls. The unset command I believe does 
not make any system calls( I could be wrong, I have not 
look at the source )  but only effects the bash program.

It looks like you are try to audit what programs are being
executed, (i.e. seeing what a hacker is doing). A better method
would be to use the snare audit modules from  Intersecalliance
http://www.intersectalliance.com/projects/Snare/Documentation/index.html#SNA
RE_Installation
I am currently using that product on top of SELlinux. The government
requires audit data and it is the best for right now.


Mark Westerman

-----Original Message-----
From: Hacko [mailto:toltec@karai.net]
Sent: Friday, February 08, 2002 11:32 AM
To: SELinux@tycho.nsa.gov
Subject: shell history task


Hi all,

let's take for example bash,

shell user have an .bash_history,
the first thing to do for unauthorized user is:

unset HISTFILE,
ln -s /dev/null .bash_history
or something like that

from the other side:
- .bash_history often reveals what for example root wrote or
connect, if you become root.
- even from typing of the hacker you can know what he knows.
- etc.


so my task is:

user_ can't read, link, write, etc his own .bash_history,
		but append works ;),
                from the shell level, not from the user_ level

user_ becomming root       --- same ---- (su-stuff)
unset HISTFILE, etc don't work

(all these are under auditdeny)

best regards,

Hacko



--
You have received this message because you are subscribed to the selinux
list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
with
the words "unsubscribe selinux" without quotes as the message.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
