Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBAH0AIi021501
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 12:00:10 -0500 (EST)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBAGwSwg008155
	for <selinux@tycho.nsa.gov>; Fri, 10 Dec 2004 16:58:28 GMT
Message-Id: <200412101700.iBAH06eq019975@turing-police.cc.vt.edu>
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: SE Linux list <selinux@tycho.nsa.gov>
Subject: Re: Single home directory type for all roles. 
In-Reply-To: Your message of "Fri, 10 Dec 2004 08:19:39 PST."
             <20041210161940.57421.qmail@web50204.mail.yahoo.com>
From: Valdis.Kletnieks@vt.edu
References: <20041210161940.57421.qmail@web50204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-2050370756P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 10 Dec 2004 12:00:06 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_-2050370756P
Content-Type: text/plain; charset=us-ascii

On Fri, 10 Dec 2004 08:19:39 PST, Casey Schaufler said:

> > Or if
> > it *is* solved there, it's not actually made it into
> > AIX, Irix, Tru64, or Solaris.
> 
> You have to go to the costs-extra multilevel secure
> versions.

Right.  And that was my point - that although every vendor has managed to hack
something up, it hasn't ever escaped and gotten any significant mindshare. You
may as well say that somebody's already solved this for Linux, because there
exists some out-of-tree patch that handles it.  Because that's what all those
basically were - out-of-mainline-tree add-ons. It hasn't been solved for "the
Unix world", it's been solved for some tiny subset that were forced to install
"an MLS component" for whatever reason, and had to deal with all the borkedness
of the bolt-on because there wasn't enough market share to make it Really Work
Right (go ahead - admit it.  Trusted Irix almost certainly had plenty of warts
on it that never got fixed because Trusted Irix had only a miniscule market share,
when similar-sized warts in the regular Irix would get fixed...)

And "in the base level" is an important thing - I've seen *plenty* of sites
that don't want to have to install (or pay for) a full MLS implementation when
all they want is some variant of "We need to redirect each user's view of /tmp
to $USER/tmp just so they quit stepping on each other's toes accidentally".
Everybody who's ever worked the help desk at a uni and had to answer "How come
I can't save test1.c?" with "because some other user already saved test1.c in
/tmp" knows exactly what I mean...

(Admittedly, it was even worse in the days before 'chmod +t /tmp', when one
user doing a 'rm *' could totally adger the work of everybody on the system..)

> > So I have no idea what Casey's talking about.  There
> > might be some hooks in
> > some Unixoids to help assist, but I don't know of
> > anyplace where it's a fully
> > integrated solution...
> 
> Trusted Solaris, Trusted Irix, SystemV/MLS, UNICOS
> all include it.

After-the-fact bolt-ons, all of them. ;)

For better or worse, at least the AIX/370 "hidden directories" stuff was mostly
integrated into the base level code, and documented, and integrated into the
sysadmin and user userspace tools - /bin/sh had code to set the search path for
them, and so on.  And even there, IBM had basically grafted Locus's "Transparent
Computing Facility" code onto an otherwise mostly-stock SYSV kernel, and there
were quite a few rough edges to deal with (all the *little* stuff, like getting
the software installer tool to Do The Right Thing - it had all the same sort of
corner-case issues that Fedora is now fighting with 'rpm' to make sure that
files end up labelled correctly).

Why am I making a point about this?  Because we're presumably working on
something that will be in the *mainline* kernel, and have support in the
default .ISO images shipped by vendors - and I don't know of any Unix vendor
who's shipped this stuff in their *mainline* product.

And *that* is uncharted territory indeed.  VMS is probably the closest thing to
Unix/Linux that actually used stuff like SYS$WHATEVER inside a filename to get
a similar effect to moldy directories *and* carry it through all the way for
the base system...


--==_Exmh_-2050370756P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBudYVcC3lWbTT17ARAgfrAJ9nhiwyH1Yag//odMk4gyt9LEeVbQCePCns
BfrYb04PxCEsMzUz0RYxyqw=
=pe3S
-----END PGP SIGNATURE-----

--==_Exmh_-2050370756P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
