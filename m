Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s1HKAmOK019018
 for <selinux@tycho.nsa.gov>; Mon, 17 Feb 2014 15:10:48 -0500
Received: from localhost ([31.16.177.238]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0McmFl-1WXIUX1mQz-00HyPo for <selinux@tycho.nsa.gov>;
 Mon, 17 Feb 2014 21:10:44 +0100
Date: Mon, 17 Feb 2014 21:10:21 +0100
From: Ole Kliemann <ole@plastictree.net>
To: Paul Moore <paul@paul-moore.com>
Subject: Re: RFC - Display context information using iproute2 ss utility
Message-ID: <20140217201021.GA2741@telmora.telvanni>
References: <1391790157.3514.YahooMailNeo@web87902.mail.ir2.yahoo.com>
 <20140207170325.GA10040@telmora.telvanni> <4844959.FlXfI971DN@sifl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
In-Reply-To: <4844959.FlXfI971DN@sifl>
Sender: telvanni@gmx.net
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2014 at 04:50:22PM -0500, Paul Moore wrote:
> On Friday, February 07, 2014 06:03:25 PM Ole Kliemann wrote:
> > On Fri, Feb 07, 2014 at 04:22:37PM +0000, Richard Haines wrote:
> > > I've been patching the iproute2 "ss" utility to display the SELinux
> > > security contexts for process and sockets, however I'm not sure
> > > whether the socket contexts are correct (I expected most to show
> > > system_u:object_r:....).
> > >=20
> > > I'm taking the socket contexts from /proc/PID/fd as was mentioned in
> > > a previous email regarding socket contexts - is this correct ??
> >=20
> > I was doing it that way and it seemed to work ...
>=20
> What you will see is the label of the socket's associated inode, not the=
=20
> actual socket label.
>=20
> > ... I could even change the context using 'chcon /proc/PID/fd'.
>=20
> Yes, you really shouldn't do that.  I've actually got a patch kicking aro=
und=20
> that I haven't had the time to test which will actually prevent you from=
=20
> changing a socket's inode label.=20
>=20
> > But I have no idea whether it is supposed to be a reliable way or
> > any other methods exist. The whole sockfs thing kept me rather
> > wondering...
>=20
> It works as far as I know, it just turns out that it isn't quite what you=
=20
> think it is :)

Thanks for clarification.=20

On a related question: Is it the same with pipes? I just=20
realized, in one of my programs I am actually using setfilecon on=20
/proc/self/fd/some_pipe to change the context of a pipe.

Do I have to expect this to break in a later kernel patch?

If yes, what would be the correct way? Do I have to use explicit=20
FIFO files to be able to do this?

Ole

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlMCbK0ACgkQS1FjE303ERxVNACeL6oA6IHtjcRkYmpjJx0O6mnK
7qkAn3HyOpGAyUQ9KjmeEdlK5vS7Adwq
=E7I/
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
