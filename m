Date: Fri, 8 Feb 2002 19:32:18 +0200 (EET)
From: Hacko <toltec@karai.net>
To: SELinux@tycho.nsa.gov
Subject: shell history task
Message-ID: <Pine.LNX.4.44.0202081906001.2448-100000@karai.karai.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

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
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
