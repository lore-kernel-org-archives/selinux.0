Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8HNYnNs007520
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 19:34:49 -0400 (EDT)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8HNV7Mi011574
	for <selinux@tycho.nsa.gov>; Sat, 17 Sep 2005 23:31:08 GMT
Received: from amon by crisium.vnl.com with local (Exim 4.50 #1 (Debian))
	id 1EGm9I-0004jt-3q
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 00:31:12 +0100
Date: Sun, 18 Sep 2005 00:31:11 +0100
From: Dale Amon <amon@vnl.com>
To: selinux@tycho.nsa.gov
Subject: State of Debian SELinux
Message-ID: <20050917233111.GA17916@vnl.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I've set aside the next week to come back to SELinux
and evaluate if it's reached the point where I could
recommmend it for customer sites.

So far Debian SELinux is looking pretty grim, and I'd
like feedback on whether there really is a straight
forward path to install it. By that I mean one with
out a lot of kludges and pain as in the long=20
(and already obsolete) description of the Debian=20
install in McCarty's O'Reilly book.

I'm starting from a freshly burned Debian stable=20
install iso. I do a bog standard install up to
the point where the reboot brings you into aptitude.
I've tried both forks at that point; updating first
in sarge or cancelling.=20

I change the sources.list to sid and add Russell's
newselinux package line; then I update and
after selecting all the appropriate packages (and
the 2.6.12 kernel) I upgrade.

Problems: One, I have to deselect cups in the=20
policy default because it has an error that causes
the install to fail.

But even without it no go. I assumed I had to
reboot to get the selinuxfs, so I did that. But
the boot complains about it and a manual mount /selinuxfs
claims the kernel doesn't know what it is.

I checked the config; looks like everything associated
with selinux (and with xattr's on various file systems)
is selected.=20

The package will still not finish installing. The
error is:

 /usr/bin/checkpolicy: loading policy configuration from policy.conf
 libsepol.expand_abtab_insert: Type conflict!
 Out of memory - unable to check assertions.
 Check assertions failed.

I could fiddle a lot more, but that would be counter
productive: this time around I'm looking for a
reliable and straightforward install, not just
a bit of play time hacking.

Is there an up to date description of the Debian=20
install? McCarty's book is *way* out of date; I
could not find a current install procedure on
Russell's site, although such might be buried in
one of his many find tutorials.

Is there a current canonical 1-2-3 procedure for
going from the current debian iso to a fully
installed SELinux system? I don't mind if I have
to fiddle with policy afterwards, but I do want
the comfort of knowing I've got a reliable means
of installing and updating (or talking a customer
through it) if I am to consider using it for real.

Of course the fact that sid seems to be required
is a *huge* negative to start with...

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLKc/ZHES7UL0zXERAiEbAJ9UPyfuIFLj6O+AgLaOCH7arz367QCfX4iq
7W1/HibPDk/6FXuP0CWLCTU=
=3u7S
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
