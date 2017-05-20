Subject: Re: [PATCH v7 0/9] SELinux support for Infiniband RDMA
To: Paul Moore <paul@paul-moore.com>, Daniel Jurgens <danielj@mellanox.com>
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <VI1PR05MB1678F822760B7C5F8E263573C4E50@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <CAHC9VhQtw4fFrCdKcznHrLDkAJVDhi=y9dYMxtOP23XVKq+rCw@mail.gmail.com>
Cc: "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
From: Doug Ledford <dledford@redhat.com>
Message-ID: <cb8d44ee-54bd-9567-f141-4da2fdef36f9@redhat.com>
Date: Sat, 20 May 2017 07:56:58 -0400
MIME-Version: 1.0
In-Reply-To: <CAHC9VhQtw4fFrCdKcznHrLDkAJVDhi=y9dYMxtOP23XVKq+rCw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SqmrAXRQI8USgs9APPjfHIUi5g9fFDgfR"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SqmrAXRQI8USgs9APPjfHIUi5g9fFDgfR
Content-Type: multipart/mixed; boundary="Qx1G1oDUlfvgaXvIrfX0sjvXNWC2EDTro";
 protected-headers="v1"
From: Doug Ledford <dledford@redhat.com>
To: Paul Moore <paul@paul-moore.com>, Daniel Jurgens <danielj@mellanox.com>
Cc: "chrisw@sous-sol.org" <chrisw@sous-sol.org>,
 "sds@tycho.nsa.gov" <sds@tycho.nsa.gov>,
 "eparis@parisplace.org" <eparis@parisplace.org>,
 "sean.hefty@intel.com" <sean.hefty@intel.com>,
 "hal.rosenstock@gmail.com" <hal.rosenstock@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Message-ID: <cb8d44ee-54bd-9567-f141-4da2fdef36f9@redhat.com>
Subject: Re: [PATCH v7 0/9] SELinux support for Infiniband RDMA
References: <1495198139-69993-1-git-send-email-danielj@mellanox.com>
 <VI1PR05MB1678F822760B7C5F8E263573C4E50@VI1PR05MB1678.eurprd05.prod.outlook.com>
 <CAHC9VhQtw4fFrCdKcznHrLDkAJVDhi=y9dYMxtOP23XVKq+rCw@mail.gmail.com>
In-Reply-To: <CAHC9VhQtw4fFrCdKcznHrLDkAJVDhi=y9dYMxtOP23XVKq+rCw@mail.gmail.com>

--Qx1G1oDUlfvgaXvIrfX0sjvXNWC2EDTro
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/19/2017 3:35 PM, Paul Moore wrote:
> On Fri, May 19, 2017 at 12:47 PM, Daniel Jurgens <danielj@mellanox.com>=
 wrote:
>> On 5/19/2017 7:49 AM, Dan Jurgens wrote:
>>> From: Daniel Jurgens <danielj@mellanox.com>
>>>
>>> Note on v7, it applies cleanly on Paul Moores' tree.  'git am' fails =
to
>>> apply patch 0002* to Dougs' tree, but 'patch' applies it without reje=
cts.
>>> There's a new file that needs to be added before resolving the git am=
,
>>> drivers/infiniband/core/security.c
>>
>> There's actually a trivial merge conflict in drivers/infiniband/core/u=
verbs.c that doesn't cause patch to create a reject file, in the function=
 create_qp a my patch adds a "goto err_destroy;".  In Dougs' tree it need=
s to be changed to "goto err_cb".
>=20
> Thanks for the rebase Daniel.  Aside from the small problems with LSM
> hook init code that I already mentioned it looks good to me.
>=20
> Considering that we got an ACK from the IB folks on v6 of your
> patchset I went ahead and merged it into the selinux/next tree.  I do
> reserve the right to yank it out before the next merge window if we
> discover any problems with the userspace, policy, or tests, but I
> think those are moving along nicely at the moment.
>=20
> Doug, and other IB folks, can I get an explicit ACK on this rebased
> patchset from Daniel?  I don't like sending cross-subsystem changes
> this large upstream without the associated ACKs.
>=20

Acked-by: Doug Ledford <dledford@redhat.com>

--=20
Doug Ledford <dledford@redhat.com>
    GPG Key ID: B826A3330E572FDD
    Key fingerprint =3D AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FD=
D


--Qx1G1oDUlfvgaXvIrfX0sjvXNWC2EDTro--

--SqmrAXRQI8USgs9APPjfHIUi5g9fFDgfR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJZIC8QAAoJELgmozMOVy/d5OQP/3PWII4nNptCV/BZyKBJVWGJ
zyIJBxNdDHxa3R4puAxunqM7AZNXcO03fuAlIcQO9r2Eeqoyc808//u7qiMMtDc6
yfFSgRoDLKWi2KoznHDBaurktNP8lbnLVJQNR8jp7akFybeMaLRSbpdxa/oVXVIh
qWPCIuqpz+Qe/1dMTCJxVA8Q8Htu/m9xmcyksCHpH0HNk8Xu9nO3ZO1EL6xhRA6W
ftNhoygVkOOAgUp20ZKh/AHolnDo481eol/DTX1k7Tnb/ZmNRemMG5Z11ZBOECKy
KxAWLnUBSil3P0Qc2T348GNJzUVemvaYJXhBRN7QMIAdjiohMfRmlRE+YcrCbv4E
4ov2ABGnh5QTjV9nczJ+pTZG38RusMAN2E6tV47RvkluKLlallMOojj293Y+1Pxc
warkFifEwS1dE9jRG98Z9anc9asyhE+9E5EYP7M2iO+cvFwtAGqKSGZ92DCFQIOa
0k++R4N2S0XB/KV6mwfzAt7W5fSrnlVviVNRhy/0DuOh8BOVhtUzLuM5sVV4hiTf
ngmT5Hxt1Zpw/H9US6bI4h79iEXLp6h8Bl6ZbTKpEA37NYCB7Rq42HdpIWRqW4Gn
gWCAQn/nS9ZYrSBMqP/kwoi46OKNAZIconK4YMJlvQPIagG7jaDDHxlgWvGfjmW3
4UJw74lRclucjAq1CTXb
=0J/E
-----END PGP SIGNATURE-----

--SqmrAXRQI8USgs9APPjfHIUi5g9fFDgfR--
