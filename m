Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j2TBYPDo004121
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 06:34:25 -0500 (EST)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j2TBUma7026010
	for <selinux@tycho.nsa.gov>; Tue, 29 Mar 2005 11:30:48 GMT
Date: Tue, 29 Mar 2005 12:33:21 +0100
From: Dale Amon <amon@vnl.com>
To: Rogelio Serrano <rogelio.serrano@gmail.com>
Cc: Ivan Gyurdiev <ivg2@cornell.edu>,
   "Fedora SELinux support list for users &amp, developers." <fedora-selinux-list@redhat.com>,
   selinux@tycho.nsa.gov
Subject: Re: Desktop apps interoperability
Message-ID: <20050329113321.GC24833@vnl.com>
References: <1111985855.1514.70.camel@cobra.ivg2.net> <1111986213.1514.77.camel@cobra.ivg2.net> <1111987652.1514.97.camel@cobra.ivg2.net> <20050328100140.GB3430@lkcl.net> <a9951d2a0503280217234c3f65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
In-Reply-To: <a9951d2a0503280217234c3f65@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 28, 2005 at 06:17:14PM +0800, Rogelio Serrano wrote:
> On Mon, 28 Mar 2005 11:01:40 +0100, Luke Kenneth Casson Leighton
> <lkcl@lkcl.net> wrote:
> > On Mon, Mar 28, 2005 at 12:27:31AM -0500, Ivan Gyurdiev wrote:
> >=20
> > > Now Windows' approach of having "My Documents" and the like is starti=
ng
> > > to make a lot of sense (even though I absolutely hate those names).
> >=20
> >  and the concept of a registry, too.
> >=20
> >  unix has a lot of legacy headaches to answer for that make its
> >  useability as a desktop system a pain in the neck.
> >=20
> >  perhaps this is one that's worthwhile raising with the linux
> >  standards base people?
> >=20
> >  if it doesn't present a solution "now" it might at least get one into
> >  the pipeline and start to make a difference in five to ten years time.
> >=20
> >  l.
> >=20
>=20
> NextStep and Mac OS X solved this problem very elegantly. IMHO. =20

I will run screaming if someone imports the registry
concept into Unix. You'll need full AI to get it right.
I managed a moderate size university network of NeXT's.
The admin interface seems nice at first... but it sucks
you in and then you find the problems with upgrades of
software; the problem that if you pulled the plug on=20
UFS open files got corrupted... and guess what? The
netinfo files were almost always open!=20

Keep it ASCII; keep it in seperate files. By all means
try to get application and daemon writers to standardize
on their parsing. Not that you ever will.

And has to My Documents? Yech. Every user has their
own private idea of what setups should exist. Users
are users and have their own little worlds; Root
is Root and never the twain shall meet. Except perhaps
with proper selinux controls...

Now I do wish there were a dotfile directory in each
home directory and everyone put the dotfiles in it
when they are created... but if wishes were fishes
I'd have a life time supply of fish'n'chips.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCST0BZHES7UL0zXERAsFjAJ9qeG33ssmUmuR4JOQK9hmzQeyVlwCeMS6E
+oWIocrwpPYhE3NsiDRoxkQ=
=ySOE
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
