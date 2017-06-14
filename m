Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v5EE97cv002950
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 10:09:07 -0400
Received: by mail-lf0-f51.google.com with SMTP id v20so1815259lfa.1
 for <selinux@tycho.nsa.gov>; Wed, 14 Jun 2017 07:08:40 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id g28sm55361eda.58.2017.06.14.07.08.37
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 14 Jun 2017 07:08:38 -0700 (PDT)
Date: Wed, 14 Jun 2017 16:08:36 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Collecting ideas for audit2allow improvement
Message-ID: <20170614140836.GA5298@julius.enp8s0.d30>
References: <1133520246.22847804.1497445285851.JavaMail.zimbra@redhat.com>
 <c8dedce5-ab89-ced9-d59b-92c5caee3ec5@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
In-Reply-To: <c8dedce5-ab89-ced9-d59b-92c5caee3ec5@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 14, 2017 at 09:58:43AM -0400, jwcart2 wrote:
> On 06/14/2017 09:01 AM, Jan Zarsky wrote:
> > Hi,
> >=20
> > I would like to improve SELinux audit2allow tool as my bachelor thesis.
> > I collected ideas from my colleagues from RedHat SELinux team and I wou=
ld also
> > like to hear your ideas - what would you improve to make audit2allow sm=
arter or
> > easier to use.
> >=20
> > Ideas collected so far:
> >=20
> >    * offer dac_read_search when sufficient instead of dac_override
> >      (see <https://github.com/SELinuxProject/selinux/issues/31>)
> >    * offer multiple solutions to a problem (example: 1) add allow rule =
for
> >      execute + execute_no_trans or 2) add allow rule for execute
> >      + type_transition rule)
> >    * interactive mode: ask questions and choose best solution
> >    * warn when solution touches trusted computing base (rules you shoul=
d not be
> >      adding)
> >    * suggest alternate labels for content, example: httpd_t not allowed=
 to write
> >      to user_home_t, might suggest that changing the label to
> >      httpd_user_content_t
> >    * output to CIL (add option for this)
>=20
> This would definitely be helpful and should be relatively straightforward.
>=20
> Jim

I will second that. I actually think this is the only compelling improvemen=
t in the whole list.

Except this (which isnt in the list):

https://twitter.com/evilSnobu/status/871787143781285889

Granted, its about sealert but it applies to audit2allow as well. Do not ov=
erwhelm users: they will get intimidated.
The idea is that things should improve security not to just dump a long lis=
t of (mostly terrible) options on unsuspecting users

Focus on making audit2allow more enjoyable to use. Waste no time on impossi=
ble missions, remove all the functionality that tries to do the impossible =
and does it terribly.

Stick with the basics, its a helper tool, its not some magic tool that can =
make security decisions on your behalf, and it never will be

>=20
> >    * if the AVC talks about execute permission then offer also type_tra=
nsition
> >      rule
> >    * idea for a tool for automatic policy generation: On a test system =
you
> >      install application, turn the SELinux to permissive and run a full=
 test
> >      suit. You collect all the AVCs in say Elasticsearch (can use commo=
n logging
> >      ViaQ project for that) and then there is a tool that searches the =
AVC,
> >      groups them and creates a policy out of them.
> >    * add option to open bugzilla
> >    * output to Ansible playbook/role task (add option for this)
> >=20
> > I would also like to know which feature would you appreciate the most.
> >=20
> > Thanks
> >=20
> > Jan Zarsky
> >=20
>=20
>=20
> --=20
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAllBQ2AACgkQJXSOVTf5
R2mEewwAuSUbNji6b1486ExYpCYZKL4yeIOaYHGdgwJnDltlNcb1iWOqMWC/wPr7
PICQbbawwCqvBR3Rr8LgSfCsTijZvbP+MvpE98wuuhETnwPuZCOVdjY+p2tAbjy/
gkPDOZIs//mvXJPlDm4Rc+EGYM3GjVI2QcuxPY/jBIwPiNEWJUi0I2b+j/9vx3bB
0AHD1+l7CSfqMYXaidRAhm2Cn2Ae1uIRT8sB77yC0hdOmKolG+AaXoxPrG8fS5dw
BaTT5PtumPpBievdfwI+yEe34PkSyPrrA/uP5oOoClOKTidm7UsGc1oyZ26cIjOB
M2ggWjFgII2xiO2lq0VI6W1NPVwSvh8zTUz4qfawiy7DRMMLS7tSXR5M/cqtBQs+
ghlwp8ZWx2c5wEgFU/JAtsrtNcZJaVs+Xy750ejwo824vwJVPjrZM2CQgt8A4Ksz
syToztHl1qoSOQm5M6VZzaorQKdjFjlHZFZYIlRepDOZLNA6/f7tgf2/6ugLAotf
DJDnyXo5
=ddGy
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
