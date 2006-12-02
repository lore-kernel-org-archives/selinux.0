Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kB250S3D030860
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 00:00:28 -0500
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id kB24xlj4028019
	for <selinux@tycho.nsa.gov>; Sat, 2 Dec 2006 04:59:47 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: User home directory creation with useradd (rhbz#217441)
Date: Sat, 2 Dec 2006 00:00:50 -0500
Message-ID: <6FE441CD9F0C0C479F2D88F959B015885C821F@exchange.columbia.tresys.com>
In-Reply-To: <200612021527.25229.russell@coker.com.au>
From: "Joshua Brindle" <jbrindle@tresys.com>
To: <russell@coker.com.au>
Cc: "Linda Knippers" <linda.knippers@hp.com>,
        "James Antill" <jantill@redhat.com>, <selinux@tycho.nsa.gov>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> From: Russell Coker [mailto:russell@coker.com.au] 
> 
> On Saturday 02 December 2006 14:20, Joshua Brindle 
> <jbrindle@tresys.com>
> wrote:
> > > I think that this is a bug.  You should be able to create 
> SE Linux 
> > > users without Linux logins, if only for the case of a NIS/LDAP 
> > > server being down at SE Linux user creation time.
> >
> > You can create them all you want, you just can't log in with a user 
> > that has a matching selinux user without a login mapping the linux 
> > user to the selinux user, this is by design, we don't want 
> the implicit mapping.
> 
> Note that I am talking about Linux accounts (entries in 
> /etc/passwd) when I say "Linux logins".
> 

Yes, I know. You said "You should be able to create SE Linux users
without Linux logins", I said you can.

> > >> but I think I ought to be able to create the selinux 
> users separate 
> > >> and them map one or more linux login to each one, or 
> have useradd 
> > >> create a unique linux user for me if I choose.  And if I don't 
> > >> choose, the linux user should end up with the correct home 
> > >> directory based on the default selinux user.
> > >
> > > I think that part of the solution is to have semanage 
> call useradd.
> >
> > no. semanage is managing selinux and selinux resources, not logins, 
> > not system resources.
> 
> The sys-admin is wanting to create an entry for a user who 
> can login.  They don't want to think about creating a home 
> directory, creating a group, a user, a home directory, a SE 
> Linux user, and a SE Linux login mapping entry.
> 

Doesn't matter, semanage doesn't need any more feature creep than it has
right now.

> > >>> 2. Have semanage do the equivalent of a restorecon when 
> doing an 
> > >>> add/modify (or just add) of SELinux user information.
> > >>
> > >> If the semanage is done after the useradd (could be 
> weeks after), 
> > >> the user could have files that live outside the home 
> directory (I 
> > >> think Dan pointed this out to me) so what files and directories 
> > >> would you run restorecon on?
> > >
> > > Also for a MLS environment you can't just relabel the 
> files unless 
> > > the new sensitivity label dominates the old.  For a strict policy 
> > > system it's generally acceptable for relabel the files, 
> but for MLS that won't work.
> >
> > you can if the thing relabeling is mls privileged, the 
> useradd program 
> > or whatever labels the home directory would have that privilege
> 
> Sure, you can break whatever security goals you might have if 
> your process is sufficiently privileged.  You can turn off SE 
> Linux too if that's what you desire.
> 

Useradd is clearly a privleged app already.

> But if your aim is that s15 data never gets relabeled to s0 
> then you are limited in what you can do if you want to 
> achieve your aim.
> 

With such a secure setup you should be administering it correctly and
your users will never have files with the wrong level.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
