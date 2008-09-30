Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8U7OClE032678
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 03:24:12 -0400
Received: from ug-out-1314.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8U7OC8J024349
	for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 07:24:12 GMT
Received: by ug-out-1314.google.com with SMTP id z36so700974uge.17
        for <selinux@tycho.nsa.gov>; Tue, 30 Sep 2008 00:24:11 -0700 (PDT)
Subject: Re: sepostgresql.pp conflicts on F9 (Re: How to find SELinux
	policy type?)
From: Dominick Grift <domg472@gmail.com>
To: KaiGai Kohei <kaigai@ak.jp.nec.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>, Daniel J Walsh <dwalsh@redhat.com>,
        selinux@tycho.nsa.gov
In-Reply-To: <48E1A8BF.6060107@ak.jp.nec.com>
References: <alpine.LRH.1.10.0809240910240.32319@tundra.namei.org>
	 <48D98748.6090408@ak.jp.nec.com> <9546.1222400049@turing-police.cc.vt.edu>
	 <48DC5C16.9040607@ak.jp.nec.com>
	 <1222421896.24783.7.camel@sulphur.notebook.internal>
	 <48DCB88E.3080503@kaigai.gr.jp>
	 <1222425714.24783.13.camel@sulphur.notebook.internal>
	 <48DCE45B.3040900@kaigai.gr.jp> <48DE5718.2050404@kaigai.gr.jp>
	 <48E1A8BF.6060107@ak.jp.nec.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-90FzjmDUJIPFp6RvuwXN"
Date: Tue, 30 Sep 2008 09:24:07 +0200
Message-Id: <1222759447.29878.3.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-90FzjmDUJIPFp6RvuwXN
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-09-30 at 13:19 +0900, KaiGai Kohei wrote:
> Dominick,
>=20
> Show the package:
>   http://koji.fedoraproject.org/koji/buildinfo?buildID=3D64748
>=20
> It will be able to help your matter.

hello

sh-3.2# rpm -Uvh sepostgresql-8.3.4-2.1067.fc9.x86_64.rpm
error: Failed dependencies:
postgresql-server =3D 8.3.4 is needed by
sepostgresql-8.3.4-2.1067.fc9.x86_64

sh-3.2# rpm -qa | grep postgresql-server
postgresql-server-8.3.3-2.fc9.x86_64

sepostgresql-8.3.3-2.869.fc9.x86_64 from installed has depsolving
problems
  --> Missing Dependency: postgresql-server =3D 8.3.3 is needed by package
sepostgresql-8.3.3-2.869.fc9.x86_64 (installed)
Error: Missing Dependency: postgresql-server =3D 8.3.3 is needed by
package sepostgresql-8.3.3-2.869.fc9.x86_64 (installed)

sh-3.2# cd selinux-policy-3.5.6-2.fc10.src
sh-3.2# grep -i require selinux-policy.spec
BuildRequires: python gawk checkpolicy >=3D %{CHECKPOLICYVER} m4
policycoreutils >=3D %{POLICYCOREUTILSVER}
Requires(pre): policycoreutils >=3D %{POLICYCOREUTILSVER} libsemanage >=3D
2.0.14-3
Requires: checkpolicy >=3D %{CHECKPOLICYVER} m4=20
Requires(pre): policycoreutils >=3D %{POLICYCOREUTILSVER}
Requires(pre): coreutils
Requires(pre): selinux-policy =3D %{version}-%{release}
Requires(pre): policycoreutils >=3D %{POLICYCOREUTILSVER}
Requires(pre): coreutils
Requires(pre): selinux-policy =3D %{version}-%{release}
Requires: policycoreutils-newrole >=3D %{POLICYCOREUTILSVER} setransd
Requires(pre): policycoreutils >=3D %{POLICYCOREUTILSVER}
Requires(pre): coreutils
Requires(pre): selinux-policy =3D %{version}-%{release}

I hope this helps.
Thanks

--=20
Dominick Grift <domg472@gmail.com>

--=-90FzjmDUJIPFp6RvuwXN
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjh1BAACgkQL00QnzrVtlw+WACfTi86T7RHP/kvn2vjUicfxdcW
yNoAoMiHF+IY4B7s2OMZfMlziY08Dbsc
=H2xk
-----END PGP SIGNATURE-----

--=-90FzjmDUJIPFp6RvuwXN--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
