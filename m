Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAHTcIi021797
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 12:29:38 -0500 (EST)
Received: from web50202.mail.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id iBAHTfR8005692
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 17:29:41 GMT
Message-ID: <20041210172942.10731.qmail@web50202.mail.yahoo.com>
Date: Fri, 10 Dec 2004 09:29:42 -0800 (PST)
From: Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: Single home directory type for all roles. 
To: Valdis.Kletnieks@vt.edu, Casey Schaufler <casey@schaufler-ca.com>
Cc: SE Linux list <selinux@tycho.nsa.gov>
In-Reply-To: <200412101700.iBAH06eq019975@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--- Valdis.Kletnieks@vt.edu wrote:

> On Fri, 10 Dec 2004 08:19:39 PST, Casey Schaufler
> said:
> 
> > > Or if
> > > it *is* solved there, it's not actually made it
> into
> > > AIX, Irix, Tru64, or Solaris.
> > 
> > You have to go to the costs-extra multilevel
> secure
> > versions.
> 
> Right.  And that was my point - that although every
> vendor has managed to hack
> something up, it hasn't ever escaped and gotten any
> significant mindshare. You
> may as well say that somebody's already solved this
> for Linux, because there
> exists some out-of-tree patch that handles it. 
> Because that's what all those
> basically were - out-of-mainline-tree add-ons.

Although I expect you may invoke the "splitting
hairs" counter, the Trusted versions of Irix,
Solaris, and UNICOS build from the same source
tree (the mainline) as thier regular counterparts
do (or did in the UNICOS case). The vendors charge
extra for the modules, but they are built along
with everything else.

> It
> hasn't been solved for "the
> Unix world", it's been solved for some tiny subset
> that were forced to install
> "an MLS component" for whatever reason, and had to
> deal with all the borkedness
> of the bolt-on because there wasn't enough market
> share to make it Really Work

The integration of MLS systems with their SLU
breathern is much tighter than you seem to believe.

> Right (go ahead - admit it.  Trusted Irix almost
> certainly had plenty of warts
> on it that never got fixed because Trusted Irix had
> only a miniscule market share,
> when similar-sized warts in the regular Irix would
> get fixed...)

Sure. On the other hand, Trix had major influence
on CXFS because so many Big HPC sites wanted both.

> And "in the base level" is an important thing - I've
> seen *plenty* of sites
> that don't want to have to install (or pay for) a
> full MLS implementation when
> all they want is some variant of "We need to
> redirect each user's view of /tmp
> to $USER/tmp just so they quit stepping on each
> other's toes accidentally".

Err, not to hold up a mirror or anything, but
SELinux faces all of those issues.

> Everybody who's ever worked the help desk at a uni
> and had to answer "How come
> I can't save test1.c?" with "because some other user
> already saved test1.c in
> /tmp" knows exactly what I mean...
> 
> (Admittedly, it was even worse in the days before
> 'chmod +t /tmp', when one
> user doing a 'rm *' could totally adger the work of
> everybody on the system..)
> 

> > Trusted Solaris, Trusted Irix, SystemV/MLS, UNICOS
> > all include it.
> 
> After-the-fact bolt-ons, all of them. ;)

All of which have over a decade of deployment,
predate over half the current kernel code in their
respective systems, and all of which are in the
base source trees.

It's fun to discuss this, but hey. Enjoy the code
if you like, ignore it otherwise.


=====
Casey Schaufler
casey@schaufler-ca.com


		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
