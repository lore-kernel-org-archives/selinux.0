Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8I9pnNs009776
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 05:51:49 -0400 (EDT)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8I9m31I027548
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 09:48:03 GMT
Date: Sun, 18 Sep 2005 10:47:59 +0100
From: Dale Amon <amon@vnl.com>
To: Jiann-Ming Su <sujiannming@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050918094759.GB25649@vnl.com>
References: <20050917233111.GA17916@vnl.com> <561dc326050917171050554c9a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O5XBE6gyVG5Rl6Rj"
In-Reply-To: <561dc326050917171050554c9a@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--O5XBE6gyVG5Rl6Rj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 17, 2005 at 08:10:58PM -0400, Jiann-Ming Su wrote:
> On 9/17/05, Dale Amon <amon@vnl.com> wrote:
> > So far Debian SELinux is looking pretty grim, and I'd
> > like feedback on whether there really is a straight
> > forward path to install it. By that I mean one with
> > out a lot of kludges and pain as in the long
> > (and already obsolete) description of the Debian
> > install in McCarty's O'Reilly book.
> >=20
>=20
> In case you haven't seen these:
>=20
> https://sourceforge.net/docman/display_doc.php?docid=3D20372&group_id=3D2=
1266
> https://sourceforge.net/docman/display_doc.php?docid=3D21959&group_id=3D2=
1266

I'd forgotten about Faye's excellent writing. But
it unfortuneately describes (somewhat) the process
I went through, which was=20

	* install base debian
	* add Russ's repository to sources.list
	* update

I shouldn't think any of the debian package mods
would come into play at this point as it is prior
to fs labeling that things are bombing out.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--O5XBE6gyVG5Rl6Rj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLTfPZHES7UL0zXERArkKAJ9szdeu9ylWri1aV/JusPZ7Cm7uwACdF/Yw
j7Doil1dlWP77vAiIN/OWRs=
=T7+s
-----END PGP SIGNATURE-----

--O5XBE6gyVG5Rl6Rj--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
