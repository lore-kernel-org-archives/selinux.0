Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iB9LciIi016522
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 16:38:44 -0500 (EST)
Received: from mailrelay2.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iB9Lb6PS028001
	for <selinux@tycho.nsa.gov>; Thu, 9 Dec 2004 21:37:07 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Thu, 9 Dec 2004 22:38:46 +0100
Date: Thu, 9 Dec 2004 22:38:46 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Russell Coker <rcoker@redhat.com>, Colin Walters <walters@redhat.com>,
   Stephen Smalley <sds@epoch.ncsc.mil>, SE Linux list <selinux@tycho.nsa.gov>,
   Joshua Brindle <jbrindle@snu.edu>, Jim Carter <jwcart2@epoch.ncsc.mil>,
   Nalin Dahyabhai <nalin@redhat.com>
Subject: Re: Single home directory type for all roles.
Message-Id: <20041209213846.GH8179@jmh.mhn.de>
References: <20041207000805.GH3678@jmh.mhn.de> <1102534349.30962.25.camel@moss-lions.epoch.ncsc.mil> <41B8826D.30105@redhat.com> <1102613299.10785.21.camel@nexus.verbum.private> <1102615344.4509.39.camel@aeon> <41B8AB69.1060805@redhat.com> <1102623195.4509.86.camel@aeon> <41B8B409.4070807@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YQEH9CATo+4lan7A"
In-Reply-To: <41B8B409.4070807@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YQEH9CATo+4lan7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Daniel J Walsh <dwalsh@redhat.com> [2004-12-09 22:21]:
> Russell Coker wrote:
> >On Thu, 2004-12-09 at 14:45 -0500, Daniel J Walsh wrote:
> >The expected practice should be to create the role before creating the
> >user who will have it.  This means that there should not be a need to
> >relabel.  There is only a need to relabel if you change the roles that
> >are permitted after the machine has been running.  But that also means
> >you may have to have the user logout first to prevent processes becoming
> >unlabeled.
> >
> Yes that is all well in good, but it does not work that way in the real=
=20
> world.  Admins
> are going to want to be able to change peoples roles.

Then they'll have to relabel the users home dir, delete /tmp and logout
the user. That's life.
I think it's a price worth paying for the added security benefit.
And it's not like an admin has to add a new role every day.

> Roles can be used to govern which applications can be run.  So I could=20
> have a student role where only
> student applications could be run.=20

That's right, but unless you lock down the account _very_ much, you
can't prevent them from running arbitrary code. That's something to keep
in mind.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--YQEH9CATo+4lan7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBuMXmxWIrrrL0q+cRAhZRAJ9dxy+RZEVw39rqfrxhacNK7Lg5HACgqjA0
jucU2bZpnsqmXd4DjPGv234=
=vmHz
-----END PGP SIGNATURE-----

--YQEH9CATo+4lan7A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
