Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9FAhpDU012252
 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2014 06:43:51 -0400
Received: by mail-wi0-f175.google.com with SMTP id d1so12513077wiv.8
 for <selinux@tycho.nsa.gov>; Wed, 15 Oct 2014 03:43:48 -0700 (PDT)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id cx1sm18944399wib.1.2014.10.15.03.43.46
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 15 Oct 2014 03:43:47 -0700 (PDT)
Date: Wed, 15 Oct 2014 12:43:45 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: fs_use_trans
Message-ID: <20141015104342.GA961@e145.network2>
References: <CAFftDdrTMJrq5P=+vkJeQ612Ndr5G-_qc5Ve10k1F2KJfQpZGA@mail.gmail.com>
 <543D36DC.8060202@tycho.nsa.gov>
 <CAFftDdpSxAHnNKHG+TGVBdWz6uxt_RKeo_BMbQ5UtpB_Q=Bg1w@mail.gmail.com>
 <543D5FDB.7@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <543D5FDB.7@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2014 at 01:39:39PM -0400, Stephen Smalley wrote:
> On 10/14/2014 11:00 AM, William Roberts wrote:
> > Yeah looking at this statement doesn't really just allow for the use of
> > type_transition statements on that filesystem? It doesn't actually gene=
rate
> > labels, you still need the typetrans rule. It appears that the definiti=
on
> > is overreaching for its actual function and probably inferring something
> > from refpolicy.
>=20
> Each of the fs_use_* statements specifies how to determine the label for
> existing inodes in the filesystem.  fs_use_xattr tells SELinux to fetch
> the inode label via ->getxattr().  fs_use_task tells SELinux to assign
> the inode the label of its creator.  fs_use_trans tells SELinux to
> compute the inode label based on the result of security_transition_sid()
> on the creating process SID and the filesystem SID.  What
> security_transition_sid() returns depends on whether or not you have a
> transition rule in policy.  So fs_use_trans doesn't guarantee that you
> have a transition rule in place; it just allows you to use transition
> rules if you wish to label the inodes based on some combination of the
> creating process domain and the filesystem type.
>=20

In light of the above, in what category do you think the following file sys=
tems would fall (if any):

aio, drm, anon_inodefs, bdev, efivarfs

I currently use genfscon for all of the above but i suspect that this is wr=
ong for the above

They are initialized but do not show up in the mount table

--=20
Dominick Grift

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUPk++AAoJENAR6kfG5xmczFYMALoYEXZsEfqHCt+w8BkWHCpg
Yud79YU+FeInHx0bR54fbj1m7wO3LKIT7BTLkPxaP6bN9i7dTDn87VjJgucmDZAb
KHHdNtIvhhAEU5ymOXzp+p+dqpj7YKc8ZCrnPXQkNokvNw2IMvxR83wlxzUkaWyZ
/CGZ1aekeDwMSo3EZyJ3w97yqJpo6JlCtmIKXrqS0CTPMfr18G0dRO6HLnA7np+U
vol2lFSgaaxSWavo7nNl0yMp/zQJIP57ATrk+7kfPxkMXTs38E2G2XMz4HIHHfWi
Q4kxkwSQ7/xd1YAJsFy4ZxiyYzcC3Muulc6LNMLCsxPz2Epyc0hwnANYMLWAz45k
LsjTJEVTuDSva7TJe4fH4eDHBHXXb5r/Z2NtXyWlv3SyzIm6OhKlfgCBTIiWjBsI
Z2eGK36rTMB7Izqd69T4dW6ZPE/MmjNGqyDF7X1G6eS27wZbxcxdhw7c2+E/W758
kbe/oK9t9NXz4Z5sAClEVKiRUvDV1DeJ3v2fyePIkg==
=Gk3a
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
