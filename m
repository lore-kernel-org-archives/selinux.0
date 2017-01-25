Message-ID: <1485313720.43764.97.camel@redhat.com>
Subject: Re: [PATCH v6 0/9] SELinux support for Infiniband RDMA
From: Doug Ledford <dledford@redhat.com>
To: Daniel Jurgens <danielj@mellanox.com>, Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "chrisw@sous-sol.org"
 <chrisw@sous-sol.org>, "eparis@parisplace.org" <eparis@parisplace.org>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>, "hal.rosenstock@gmail.com"
 <hal.rosenstock@gmail.com>, "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "selinux@tycho.nsa.gov"
 <selinux@tycho.nsa.gov>
Date: Tue, 24 Jan 2017 22:08:40 -0500
In-Reply-To: <VI1PR0501MB242933AC0EC458EAD2792560C4750@VI1PR0501MB2429.eurprd05.prod.outlook.com>
References: <1479910651-43246-1-git-send-email-danielj@mellanox.com>
 <a56c4be8-f908-4774-dd1c-c6bbab5c1b03@tycho.nsa.gov>
 <DB6PR0501MB2422DCC01A577CDA280C2C82C49B0@DB6PR0501MB2422.eurprd05.prod.outlook.com>
 <CAHC9VhTdntem1hK0arEo4p1MWPH5sjzDN0yG_=1S7ui=C4i8Yg@mail.gmail.com>
 <1485294015.43764.91.camel@redhat.com>
 <1485294335.43764.94.camel@redhat.com>
 <VI1PR0501MB242933AC0EC458EAD2792560C4750@VI1PR0501MB2429.eurprd05.prod.outlook.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
 protocol="application/pgp-signature"; boundary="=-csrreG53PorA05P69Y6c"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--=-csrreG53PorA05P69Y6c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2017-01-24 at 22:40 +0000, Daniel Jurgens wrote:
> On 1/24/2017 3:45 PM, Doug Ledford wrote:
> >=C2=A0
> > Although it would also be helpful if you could rebase on a current
> > tree
> > (preferably my k.o/for-4.11 branch).
> >=20
> Doug, I'm working on the user space patches, hope to be ready to
> submit in the next 1-2 weeks.=C2=A0=C2=A0Do you want me to rebase now or =
wait
> until those are submitted?

I would suggest moving the rebase up just so I can provide you with an
upstream branch to test against with your user space stuff.

--=20
Doug Ledford <dledford@redhat.com>
=C2=A0 =C2=A0 GPG KeyID: B826A3330E572FDD
=C2=A0 =C2=A0
Key fingerprint =3D AE6B 1BDA 122B 23B4 265B =C2=A01274 B826 A333 0E57 2FDD

--=-csrreG53PorA05P69Y6c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJYiBa4AAoJELgmozMOVy/dFTEQALnjUU7+BgbjGpRoxLNFqQZh
N3mGsBM9izy5+XXZa+5buPtQ0UqvdTKnvmh2TdseGj/J8JO7UMoT8mDPKTdkvchh
vn9J6CYr61MhHIXW6JwprvPjhv1Qp+q9RPZqvl0984lEat28NpG3EO9iYIy0uRvC
S1LSfpOK8Rb/yECdPSlMaIMjYTsSs7q6DsCe40Nk9zh5Nemfk9x55X2xydrLIatr
F/iTeQ1RU2gnD4QlaODfmp0nreKOvU4oHmE7uf8GW+f3QI3Gkmx4CXUFxHfsZwWV
8b2kOO6H7RsgBnS4n47+iuboKUgu3oJQvTtA+VmMFMw2lH/4xFQUqbibo+psu+Ju
f/1iLFIWg+YHfYRANqDKRYqBHelF/OGvWu0BGwMdWWZwFT1l1t0j7/z3IBz+ggE9
AwIA2bsMJdWsff9X0jPbidG2IOj6foTIl8K61uPA6FKPJ7gJchMLxEGEq+EyUqcs
WALUpmmglJmsUmwp0LCb+rFilbgwcLJnnIAwzg/DiBV9cJGtbuUZUu4wElCA98zO
XlBN2YbbLCEu+gvvRSbKftIt8Pq1g7NDyZHSN7naKNXS2xbZ2+cCfJvO6OYtpVSz
D3FlxpYYjlvSS+cBLVWqNCNDcCjliwWanaeO2biy92ErS6mBdBmWZOz37lR70m5b
8oA86QnwHctXWFKOe5Uo
=/oRB
-----END PGP SIGNATURE-----

--=-csrreG53PorA05P69Y6c--
