Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q849WsBk020818
	for <selinux@tycho.nsa.gov>; Tue, 4 Sep 2012 05:32:54 -0400
Date: Tue, 4 Sep 2012 11:32:19 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Marcel Butucea <marcelbutucea@gmail.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: RBAC to SELinux policy migration
Message-ID: <20120904093219.GB2999@telmora.telvanni>
References: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vGgW1X5XWziG23Ko"
In-Reply-To: <CADxHy9eYOVaVK22ZCi_UregXFwsOwtb1B=Tyygh=87tECsYwhg@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--vGgW1X5XWziG23Ko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2012 at 11:41:14PM +0100, Marcel Butucea wrote:
>  Hello SELinux Team,
>=20
> As I am a beginner in deciphering the depths of SELinux I come to you with
> the following predicament in hope of guidance and help:
>=20
> We are migrating an application from Solaris to Linux and the main user is
> allowed, through the use of RBAC roles, to run a few system commands like
> svccfg/svcadm (chkconfig on redhat).
>=20
> Is it possible, using only SElinux (no sudo), to allow a normal user to r=
un
> chkconfig off/on <service> (basically giving it the ability to add/remove
> services) ?(my ultimate goal would be to allow this user to run other
> "root-only" utilities as well). One of my concerns is that chkconfig might
> have some internal check for the uid of the calling user, ergo blocking
> this account from running the utility irrespective of my selinux policy, =
is
> my worry legitimate or am I imagining things ?

To clarify the question: You want a user (uid!=3D0) to perform=20
operations on the system the require uid=3D=3D0?=20

In that case: SELinux is an independent addition to the=20
traditional linux permissions (DAC). If DAC requires you to have=20
uid=3D=3D0, SELinux can't override that for you. In short: With=20
SELinux you can only deny stuff that was allowed, not allow what=20
was denied.

> All my
> attempts so far have failed, so my second question would be=20
> where could I
> find good documentation that applies to this specific problem ?

The only real documentation I know of is the 'SELinux Notebook'=20
by Richard Haines. It's a good reference. You might want to start=20
there.

--vGgW1X5XWziG23Ko
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBFyqMACgkQS1FjE303ERwY7wCfQf7GMY0BHy788m50XyLmvUpW
Xe8AniWG7XYotO1rN/V6vm1XTeOpswf7
=gTjn
-----END PGP SIGNATURE-----

--vGgW1X5XWziG23Ko--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
