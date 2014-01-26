Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s0QG4n2s012437
 for <selinux@tycho.nsa.gov>; Sun, 26 Jan 2014 11:04:49 -0500
Date: Sun, 26 Jan 2014 17:04:45 +0100
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: As we move to use Linux Containers User Namespace
Message-ID: <20140126160445.GB6663@mail.hallyn.com>
References: <52D6F7DF.2000603@redhat.com>
 <CACLa4puFZOyrX7TxQBft1614P9jpaqpSMWXSaK_vpnt3CNYRgg@mail.gmail.com>
 <3540912.0YWAzehTYh@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3540912.0YWAzehTYh@sifl>
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Quoting Paul Moore (paul@paul-moore.com):
> On Wednesday, January 15, 2014 06:25:05 PM Eric Paris wrote:

Note first off that you'll rarely want to check for capabilities against
yourself, because any unprivileged task can unshare a new user namespace
with his own (host) uid mapped to root in the new namespace, and pass
that test.  However, checking for capabilities against an open file (meaning
a inode_capable() check) makes sense.

> > Just to blow everyone's minds: The first thought that came to me was
> > that the only way to make this useful is to actually put a label on
> > the user namespace.
> > 
> > If I create a container, and then a container inside that container,
> > I'd think selinux should be able to control the capabilities at the
> > second level down.  Dan's only asking about one level down...

(Not sure whether you mean up or down? :)

> Turtles all the way down.
> 
> If we are going to do it for one level, we should do it for all levels.

Speaking in non-selinux terms, it would make sense to simply ask whether
task T1 has Capability C1 against object O1, where O1 is a task, a nic,
a file, a mountpoint, etc.  Referring to a specific user namespace by its
own label would be awkward, I believe.

I'm not sure how to put that in selinux terms, since labels will certainly
cross namespaces.

-serge
