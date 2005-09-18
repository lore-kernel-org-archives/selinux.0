Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8IA1lNs009826
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 06:01:47 -0400 (EDT)
Received: from crisium.vnl.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8I9w01I028038
	for <selinux@tycho.nsa.gov>; Sun, 18 Sep 2005 09:58:01 GMT
Date: Sun, 18 Sep 2005 10:58:07 +0100
From: Dale Amon <amon@vnl.com>
To: Dale Amon <amon@vnl.com>, selinux@tycho.nsa.gov
Subject: Re: State of Debian SELinux
Message-ID: <20050918095806.GC25649@vnl.com>
References: <20050917233111.GA17916@vnl.com> <20050918001512.GR9092@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
In-Reply-To: <20050918001512.GR9092@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--m51xatjYGsM+13rf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 18, 2005 at 01:15:12AM +0100, Luke Kenneth Casson Leighton wrot=
e:
> dale, hi,

And hello yourself. I've been a bit scarce on this list lately.
Business has been good for a change... so no playtime. :-)
=20
> i did manage to set up debian/selinux - back when 2.6.6 -> 2.6.9 was in
> "unstable".
> it was painful, took about four to five months, and it worked.

Ouch. Well, I'm only interested in getting it up on rack mount
server class machines with no fancy workstation apps on them.=20
Nothing but LAMP's.
=20
> you will NOT get sarge to work [as-is].

But can you start from the sarge iso and upgrade? Or should I look
at whatever they have as the latest and most bleeding edge "don't
look at me crosseyed or I'll fall over" sid iso?
=20
> you WILL need libselinux1 for a start and because of the freeze
> some 18 months ago libselinux1 did NOT make it into sarge.

I'm picking that up from Russel's repository during the upgrade
and it does install okay.
=20
> you _will_ need the patched version of dpkg - the one that
> sets selinux file contexts on files as it unpacks them - just
> like rpm does.

Yeah, but that shouldn't matter yet: the problems are in the
initial upgrade to SELinux packages so the file system isn't
labeled yet and the kernel is still the base debian one.=20
=20
> sorry that's a bit long-winded and probably difficult to
> understand but i'm trying to pack stuff in quickly as i remember it -
> from several months ago - without time for review of what i've written.

Oh, that's fine. Many of the items you note will
be time savers. Once I get the initial selinux package
install to work that is...

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDLTouZHES7UL0zXERAv3xAJsGdeM6gwGJuCbqQPKgdvASorMneQCfYEQE
MhBgGxC4xqOsHaGDR8EMsbI=
=CFoA
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
