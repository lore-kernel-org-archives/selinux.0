From: =?us-ascii?Q?Vanuxem_gregory?= <gvanuxem@club-internet.fr>
To: "SELinux Mailing" <SELinux@tycho.nsa.gov>
Subject: TR: MLS changes (isn't understandable)
Date: Mon, 17 Jun 2002 11:46:09 +0200
Message-ID: <ADEEIKPBIEHIINPOFGAOIEHOCDAA.gvanuxem@club-internet.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 On Tue, 4 Jun 2002, Vanuxem gregory wrote:
> >
> > > I tried it and I had to change a lot of
> > > permissions !!!
> >
> > By the way, could you elaborate on what you mean by this statement?  Do
> > you mean that you had to change the mappings from SELinux permissions to
> > MLS base permissions in policy/mls?

	Yes

> > What exactly did you have to change
> > and why?  Are you trying to use MLS ranges for some of the initial SID
> > contexts?
>

I ask about change in the source code since with the previous release
I had to change a lot of permissions.
For example:

login => read and write  tty but now with the last version all is right
 	=> use fd from init 	"  	"              ""               ""


But I make a mistake,
First all domain run in public level
(unclassified -> public -> confidential ->secret ->top-secret ).

And I changed the default level for all the initials contexts (but I forgot
to set de default level in setfile code and  the mount/remount/relabel*
operation were always denied on boot).


Now:
	SElinux is relatively usable in mls environment


the actual change in policy/mls is
process sigchld := (login<->init on shutdown) (actually  Init (+
 mlstrustedreader) or sigchld = none)


Another problem is the /tmp dir.

I changed the code of login.c, if the user use another level that the
default level I log it directly in another directory, and login export
another HOME var = /home/*/otherlevel/`level`).

So the user has its own profile, shell.rc and its own TMPDIR
(home/*/otherlevel/`level`/tmp) .
 But some programs, for example 'man', don't test the TMPDIR variable and
write directly in /tmp

Free solutions I think, change
- the source code of man
- /tmp -> mlstrustedobject (awful but I use that)
- may be polyinstantiated directory ????

What do you think about that and where I can find some documentation (doc
not previously mentioned in this mailing list) and code source (better)
about polyinstantiated object ?


A last thing, what do you think about add mlstrustedreader for printer
daemon (cups or lpd) domain ?

			Greg




--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
