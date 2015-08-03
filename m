Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t73JLobM000729
 for <selinux@tycho.nsa.gov>; Mon, 3 Aug 2015 15:21:51 -0400
Received: by wibud3 with SMTP id ud3so127039290wib.0
 for <selinux@tycho.nsa.gov>; Mon, 03 Aug 2015 12:21:46 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id gc4sm14985165wib.23.2015.08.03.12.21.45
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 03 Aug 2015 12:21:45 -0700 (PDT)
Date: Mon, 3 Aug 2015 21:21:44 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: secilc bug
Message-ID: <20150803192143.GE31031@x250>
References: <CAHC9VhQu=U51b85U74xhP+x+4VCOrm9W8WVAw=vW6s0FdSNPxw@mail.gmail.com>
 <alpine.LRH.2.11.1504131142390.774@namei.org>
 <CAHC9VhSAVxo2wkOpMj1QcM-=HvBVhOvVGyTG-JGQHKJhn-rvYw@mail.gmail.com>
 <alpine.LRH.2.11.1504241023280.13918@namei.org>
 <CAHC9VhTGXTRi0=XbeB8b+LQVC+MDdk3PH38hYSafmV5CMrvi8Q@mail.gmail.com>
 <553A6D3D.8020904@schaufler-ca.com>
 <CAHC9VhQkYU990OKAySUnPn-XzoOUN=21AjOB76pbM7uVQX_0xQ@mail.gmail.com>
 <alpine.LRH.2.11.1504271528350.16342@namei.org>
 <1430265211.2218.13.camel@linux.vnet.ibm.com>
 <20150502150259.GA15244@x131e>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
In-Reply-To: <20150502150259.GA15244@x131e>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 02, 2015 at 05:02:59PM +0200, Dominick Grift wrote:
> Today i hit an bug in secilc, when compiled by policy with some modules e=
xcluded.
>=20
> My policy is rather complex, and so i find the issue hard to explain but =
i will try:
>=20
> In my github.com/doverride/laptop policy (the auth.cil module to be preci=
se) i have a auth_pam_config_object_type() macro that
> essentially associates the calling type with the auth_pam_config_object_t=
ype type attribute, which in turn is associated with
> the auth_object_type attribute that is used to grant auth_admin() access =
to all "auth object types"
>=20
> The auth_pam_config_object_type() macro is called in various modules for =
various third party pam config files.
>=20
> For example, xserver maintains /etc/pam.d/xserver, which is associated wi=
th xserver_pam_config_t, and xserver_pam_config_t is
> associated with auth_pam_config_object_type.
>=20
> This is just one example.
>=20
> By excluding the xserver.cil module, the whole auth_pam_config_object_typ=
e, and all rules associated with it vanishes.
> I noticed today that on a system where i excluded xserver.cil i no longer=
 had access to /etc/security/access.conf (which is
> associated with pam_config_t, and pam_config_t is associated with auth_pa=
m_config_object_type)
>=20
> By reincluding the xserver.cil module , the rules that allow auth_admin()=
 to maintain auth_object_type files reappeared.
>=20
> To reproduce:
>=20
> clone my "laptop" policy and build it
>=20
> use "sesearch -A -s auth_admin_subject_type | grep auth_object_type" to c=
onfirm that auth_admin_subject_type is allowed
> to maintain file objects associated with auth_object_type
>=20
> Now exclude the xserver.cil module
>=20
> use above sesearch command again and notice how the rules granting auth_a=
dmin_subject_type access to maintain file objects
> associated with auth_object_type have vanished.
>=20
> P.S:
> Another really strange thing i noticed is that i have a compiled policy w=
ith a bunch of modules excluded that is bigger than
> a policy with little or no modules excluded.
>=20


I want to retract this. This was most likely a parens issue to begin with. =
Today i hit a similar issue and i decided to dig a little deeper.
Granted the issue i hit today was much simpler to track down.

Anyhow it turned out to be a misplaced parens which resulted in secilc remo=
ving a lot of policy that it thought was in one optional block.

in reality they were many optional blocks but the first one wasnt closed pr=
operly!

Yes, the secilc warning about "open without close" or "close without open" =
are annoying. but take my word for it.
its much better to have secilc identify these issues then to have it not id=
entify them and then when you decide to exclude a module
a whole load of policy gets removed because secilc thought it was part of t=
he single block!

anyhow sorry for thinking this was a bug in secilc. it was my mistake. in m=
y defense though: my policy is pretty complex and sometimes its not easy to=
 identify the issue. Also parens arent that friendly to humans...

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVv79CAAoJENAR6kfG5xmcI2cMAKVBQYvLpCgxC5Tn/Hdrwjmh
H1KNARBLZouZe4IbdsZlpI/7urWbzsK/q9Q8OY0XsKWXBUukPQsJ54JUNAOB/HK9
G0NZomW4RvGV+h6WAfj4pulXnnC/59ZIAOHDRjjHXY75e1wYTSc13ty64vU9rRTK
0qpt4aU9R+J1LsG9/5rCwnop+t8aoX6wiAEPFzx6be0B1JcS/t86meThMCgxo6AS
Er0+V8bpTokv7RFI4JLLVvhhpTsiFepSrvvMBqwkPZ56/5SOPl6nGxZGxU525Wo9
3pN1XTfQPPto23l8f/huRde/V+Gh8Bt6/TCrhdG39FPwP2tH4FXrKscEKuC03TIn
+G4xD4Z0dL8TQvAtIiyiLPYlkI4xNVHsfZrDdxEyER0JXqz2yV2OEy5IdEPcTRZ7
rnY13KuSZ32/GtktnUmdAniVr/cEc6hmqiL/L3IcwzylzsvKtnuCnoCBa6GH0KSX
cKsc1tXeFTyD8maxYdP3YC5nZG9iViR3/sQyTCHS3g==
=SF5P
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
