Date: Thu, 30 Dec 2004 18:04:23 +0000
From: Dale Amon <amon@vnl.com>
To: Jaspreet Singh <jsingh@ensim.com>
Cc: Dale Amon <amon@vnl.com>, Erich Schubert <erich@debian.org>,
   nsa <SELinux@tycho.nsa.gov>
Subject: Re: Overlay Filesystem and SELinux
Message-ID: <20041230180423.GB2981@vnl.com>
References: <1098274225.12118.20.camel@jsingh.india.ensim.com> <20041020151031.GB21185@lkcl.net> <20041020174938.GL21185@lkcl.net> <1098887565.1620.15.camel@jsingh.india.ensim.com> <1104022405.29054.7.camel@wintermute.xmldesign.de> <1104050461.14672.6.camel@jsingh> <20041226125404.GA2459@vnl.com> <1104086350.19031.13.camel@jsingh>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DBIVS5p969aUjpLe"
In-Reply-To: <1104086350.19031.13.camel@jsingh>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--DBIVS5p969aUjpLe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 27, 2004 at 12:09:10AM +0530, Jaspreet Singh wrote:
> Thanx :) , Yes the official maintainers can answer that question better.
> For all i know unionfs is been publicized at lkml and there are talks
> for the same.
>=20
> Till recently, it just seemed to be an academic project. But now it has
> gained momentum. I have used and extended 3 overlay file-systems .. and
> this one seemed to be most promising and stable.
>=20
> It has some very good features like - adding/removing branches (i.e
> directories ) from a union.

If anyone hasn't seen it already, there is an article
on unionfs in this month's Linux Journal.

--=20
------------------------------------------------------
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--DBIVS5p969aUjpLe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB1EMnZHES7UL0zXERAoNlAJ9qwAS0n3zecVvyX3E8YzlMRzhUmACcD7vc
XTgRrWbt8esQA5GZOsTawrY=
=/gCo
-----END PGP SIGNATURE-----

--DBIVS5p969aUjpLe--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
