Date: Thu, 20 May 2004 12:46:46 -0500
From: Mike Perry <mikepery@fscked.org>
To: SELinux@tycho.nsa.gov
Subject: Fixfiles "undocumented feature"
Message-ID: <20040520174646.GA17614@fscked.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I'm running FC2's SELinux (w/ policycoreutils-1.11-2) and I've noticed
that 'fixfiles relabel' has the rather annoying property (I'd call it a
bug) of erasing *all* of /tmp. Is this necessary? It kills screen
sessions, X11 sockets, ssh agents, esd, gconf locks, gnome IPC, and
all sorts of other important things that make running systems not want
to run very well anymore. 

At the very least, some sort of warning in the manpage would be nice.


-- 
Mike Perry
Mad Computer Scientist
fscked.org evil labs

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
