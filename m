From: =?us-ascii?Q?Vanuxem_gregory?= <gvanuxem@club-internet.fr>
To: "SELinux Mailing" <SELinux@tycho.nsa.gov>,
        "Stephen Smalley" <sds@tislabs.com>
Subject: RE: MLS changes
Date: Mon, 17 Jun 2002 01:18:37 +0200
Message-ID: <ADEEIKPBIEHIINPOFGAOEEHNCDAA.gvanuxem@club-internet.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <Pine.GSO.4.33.0206041536520.3949-100000@raven>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Tue, 4 Jun 2002, Vanuxem gregory wrote:
>
> > I tried it and I had to change a lot of
> > permissions !!!
>
> By the way, could you elaborate on what you mean by this statement?  Do
> you mean that you had to change the mappings from SELinux permissions to
> MLS base permissions in policy/mls?  What exactly did you have to change
> and why?  Are you trying to use MLS ranges for some of the initial SID
> contexts?

	For example

login => read and write  tty but now with the last version all is good
	=> fd use 			" "              ""               ""

process sigchld := (login => init) (actually  Init (+ mlstrustedreader) or
sigchld = none)



Some other things, first all domains run in public level (unclassified ->
public -> confidential ->secret ->top-secret ).

For this I change de default level in setfile code but i keep the
unclassified level in kernel source.

Since there is some change in kernel  source  a lot of thing work well now.





--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
