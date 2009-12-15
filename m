Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id nBFKEMjn032068
	for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2009 15:14:22 -0500
Received: from ey-out-1920.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id nBFKGh2d012988
	for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2009 20:16:43 GMT
Received: by ey-out-1920.google.com with SMTP id 13so78266eye.32
        for <selinux@tycho.nsa.gov>; Tue, 15 Dec 2009 12:14:19 -0800 (PST)
Date: Tue, 15 Dec 2009 21:14:16 +0100
From: Dominick Grift <domg472@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Policy writing philosophy...
Message-ID: <20091215201415.GA6630@localhost.localdomain>
References: <81092d890910190949t537c00e8t3d7633c9f56a4800@mail.gmail.com>
 <1255972389.3099.70.camel@moss-pluto.epoch.ncsc.mil>
 <81092d890910191843q4aa20f6ep877f8e739b52ce43@mail.gmail.com>
 <1256037508.4061.3.camel@moss-pluto.epoch.ncsc.mil>
 <D06FE0A2807BC145B0D38744789D4F5D077A087F@de01exm68.ds.mot.com>
 <1256633374.3090.13.camel@localhost>
 <D06FE0A2807BC145B0D38744789D4F5D07909698@de01exm68.ds.mot.com>
 <D06FE0A2807BC145B0D38744789D4F5D07B9501F@de01exm68.ds.mot.com>
 <1260460494.3025.22.camel@moss-pluto.epoch.ncsc.mil>
 <D06FE0A2807BC145B0D38744789D4F5D07CF6350@de01exm68.ds.mot.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
In-Reply-To: <D06FE0A2807BC145B0D38744789D4F5D07CF6350@de01exm68.ds.mot.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 15, 2009 at 12:43:37PM -0500, Hasan Rezaul-CHR010 wrote:
> Hi All,
>=20
> I have Linux 2.6.27 on a non-popular Linux distro, and I have the
> following SELinux package versions :
>  =20
> >  checkpolicy-2.0.19
> >  libselinux-2.0.85
> >  libsemanage-2.0.33
> >  libsepol-2.0.37
> >  policycoreutils-2.0.69
> >  sepolgen-1.0.17
>=20
> I know SELinux's is governing framework is that by default everything is
> DENIED, except all accesses that are explicitly allowed in the policy...
>=20
> Is there anyway whatsoever to reverse that philosophy ?  In other words,
> is it possible to configure things and write policy in a way such that:
>=20
> Only explicit things are disallowed... So whenever no explicit policy
> exists for an access request it is actually ALLOWED. This way, if I
> write a new task or process, I don't have to write new policy for it to
> allow all the things it needs. By default things will just be allowed,
> unless some of those accesses have been explicitly disallowed in policy
> ?
>=20
> My guess is that this CANT be done... But thought I would ask anyway ?

Fedoras' selinux-policy-minimal is supposed to be just that (well kind of).=
 By default everything runs in a unconfined domain which is allowed all acc=
ess. To restrict processes you should explicitly write policy.=20
>=20
> Also can SELinux mappings be created for a Unix Group, as opposed to
> mapping to individual Linux Users ?

No afaik.
>=20
> Thanks.
>=20
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAksn7hcACgkQMlxVo39jgT9XjwCeOq3OPKL1exa20kiQ1e5jSfJ3
BCQAn1SsqH+XtWUo/2en6MKU6yPi0sYa
=2dER
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
