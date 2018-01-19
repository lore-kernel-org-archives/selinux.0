Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0JAYmH0013430
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 05:34:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by USFBF3ID11.oob.disa.mil (Postfix) with SMTP id 3zNHJM3mvZzXqW4
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:34:43 +0000 (UTC)
Received: from USFB19PA08.eemsg.mil (unknown [192.168.16.5])
 by USFBF3ID11.oob.disa.mil (Postfix) with ESMTP id 3zNHJL2Bp3zXqVy
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:34:42 +0000 (UTC)
Received: by mail-wm0-f51.google.com with SMTP id v71so2542964wmv.2
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 02:34:40 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id b27sm6393797edc.28.2018.01.19.02.34.39
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jan 2018 02:34:39 -0800 (PST)
Date: Fri, 19 Jan 2018 11:34:37 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180119103437.GB4126@julius.enp8s0.d30>
References: <20180119101951.GA4126@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
In-Reply-To: <20180119101951.GA4126@julius.enp8s0.d30>
Subject: Re: default_type limitations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--b5gNqxB1S1yM7hjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 11:19:51AM +0100, Dominick Grift wrote:
> The default_type functionality is too limited because it assumes that all=
 login programs associate the same type with a given role
>=20
> This is not the case
>=20
> For example:
>=20
> default_type for local_login: joe.role:joe.type
> default_type for sshd: joe.role:joe_ssh_server.type
> default_type for cockpit joe.role:joe_cockpit_bridge.type

The thing is that login programs these day's often dont just run a shell on=
 behalf of users directly.
There is often an intermediate process that should not be associated with t=
he shell type ideally

For example sshd uses pam_selinux to associate a context with the privilege=
d user sshd process. This process needs
all kinds of extra permissions for tunneling, forwarding, chroots etc.

this privileged process then runs a shell on half of the user:

sshd -> user "priv" sshd process -> user shell

This works because it uses pam_selinux for the user "priv" sshd manual proc=
ess transition, and then i can use a transparent automatic type transition =
to associate a context with the shell (user_sshd.type -> shell -> user.type)

Same with cockpit:
cockpits_session -> user cockpit bridge -> user shell

unlike local_login:
login -> user shell

>=20
> etc
>=20
> So pam_selinux "select_context" can only support a single login program d=
ue to this
>=20
> I do not understand why default_type is needed in the first place. The co=
ntexts/users/ file is more specific:
>=20
> /etc/selinux/TYPE/contexts/users/joe.user:
> sys.role:login.type:s0 joe.role:joe.type:s0 joe1.role:joe1.type:s0
> sys.role:sshd.type:s0 joe.role:joe_ssh_server.type:s0 joe1.role:joe1_ssh_=
server.type:s0
> sys.role:cockpit_session.subj:s0 joe.role:joe_cockpit_bridge.type:s0 joe1=
:joe1_cockpit_bridge.type:s0
>=20
> ie. its already specified that for example joe1.type is default type for =
joe1.role for local_login and that joe1_ssh_server.type is default type for=
 joe1.role for sshd
>=20
> So unless i am overlooking something, the default_type file is redundant =
and it actually adds an extra file to configure
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlphybkACgkQJXSOVTf5
R2lkrAwAmUhlKxem3OQglqIu5yJhbkLk8FqGKC68S6dJFeV+IVvy8LBom31OAKxI
YaiGv3J2/sqVKWTIablIEUxa/OV9iTBtG6LL3sF0tkcEhbTaMEVT5/WcGt6g2Bna
twFgEHjyxWTGNSr8dPouBkfXCChY7ceeVBPwjOIBrP2vm2pq9qUL8PBAETxi9e0U
f3LngqyCAd/jyT+DK33+9f1mHQS/Dblm0DXvv3nq6s0qJGNqXsj6viSuErGk0vg9
MzbGB1SaqsIK86GkZayiai9UKrKVV3PzjXH43IHz2ZEuqBWQOcdoCbC0tnYtm6wB
4/Q3+nP6CiG86pzgO+Zg7D4l2+XoFSQISkxAY32Ac3OAFX4cF4yRGzeopkY+hR+O
r+rWfT8BZsizGAxbmnwM2sjLyDdMlqRNw0MyBFQXD5khtR2ZhnBrPVKHNAyKbMGk
dAIrwj462RfmqyktUYCTA8rfs0PXA7LdpXCnZa18+Erj66RNuxGqqI98DR6ZeAob
o8jdm4v1
=T/WZ
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
