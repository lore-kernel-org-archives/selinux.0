Date: Thu, 6 Oct 2005 14:17:23 -0400 (EDT)
From: Gaurav Poothia <gpoothia@cs.sunysb.edu>
To: SELinux@tycho.nsa.gov
Subject: Newbie questions
Message-ID: <Pine.GSO.4.53.0510061416520.10856@compserv1>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hello!
I have been looking at macros/program/mozilla_macros.te in file (ver 1.26)

Mozilla seems to run in its own derived domain(based on the user
running it). It then seems to create these domain transitions for many
execs such as:
-> To a derived domain on calling a java program
-> To specialized domains on exec of mplayer, lpr etc

Q1. Is the idea here for SELinux to create specialized domains for all
possible desktop apps (on the server side it seems the plan is to
eventually confine all daemons)?  If not then any SELinux unaware app on
exec will run within  Mozilla domain if called form within the browser
(viewers/players/editors)?
What about invocation from shell...will it then run within user_t domain?

Q2 When I ran an strace on mozilla opening a document using xpdf it seemed
to call a clone() which then exec to xpdf rather than call fork().
Are both fork and clone treated identically by the SELinux?
If yes would xpdf then run inside the prefix_mozilla_t domain (since
SELinux seems be xpdf unaware)

I am sorry I pbbly could answer some of these questions empirically but I
haven't installed the policy. Btw is there a play machine out there with
1.26
installed?

Thanks
-Gaurav


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
