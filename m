Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0JAhfn4016074
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 05:43:41 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 3zNHVf19gpz2FZxg
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:43:38 +0000 (UTC)
Received: from UPDC3CPA04.eemsg.mil (unknown [192.168.18.11])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 3zNHVd21fBz2FZxd
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 10:43:37 +0000 (UTC)
Received: by mail-wm0-f53.google.com with SMTP id t74so2505030wme.3
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 02:43:36 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id p93sm5453320edp.14.2018.01.19.02.43.34
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jan 2018 02:43:34 -0800 (PST)
Date: Fri, 19 Jan 2018 11:43:33 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180119104333.GC4126@julius.enp8s0.d30>
References: <20180119101951.GA4126@julius.enp8s0.d30>
 <20180119103437.GB4126@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
In-Reply-To: <20180119103437.GB4126@julius.enp8s0.d30>
Subject: Re: default_type limitations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 11:34:37AM +0100, Dominick Grift wrote:
> On Fri, Jan 19, 2018 at 11:19:51AM +0100, Dominick Grift wrote:
> > The default_type functionality is too limited because it assumes that a=
ll login programs associate the same type with a given role
> >=20
> > This is not the case
> >=20
> > For example:
> >=20
> > default_type for local_login: joe.role:joe.type
> > default_type for sshd: joe.role:joe_ssh_server.type
> > default_type for cockpit joe.role:joe_cockpit_bridge.type
>=20
> The thing is that login programs these day's often dont just run a shell =
on behalf of users directly.
> There is often an intermediate process that should not be associated with=
 the shell type ideally
>=20
> For example sshd uses pam_selinux to associate a context with the privile=
ged user sshd process. This process needs
> all kinds of extra permissions for tunneling, forwarding, chroots etc.
>=20
> this privileged process then runs a shell on half of the user:
>=20
> sshd -> user "priv" sshd process -> user shell
>=20
> This works because it uses pam_selinux for the user "priv" sshd manual pr=
ocess transition, and then i can use a transparent automatic type transitio=
n to associate a context with the shell (user_sshd.type -> shell -> user.ty=
pe)
>=20
> Same with cockpit:
> cockpits_session -> user cockpit bridge -> user shell
>=20
> unlike local_login:
> login -> user shell

I other words: There is no such thing as a "default_type". The default type=
 associated with a given role can vary per login program.

>=20
> >=20
> > etc
> >=20
> > So pam_selinux "select_context" can only support a single login program=
 due to this
> >=20
> > I do not understand why default_type is needed in the first place. The =
contexts/users/ file is more specific:
> >=20
> > /etc/selinux/TYPE/contexts/users/joe.user:
> > sys.role:login.type:s0 joe.role:joe.type:s0 joe1.role:joe1.type:s0
> > sys.role:sshd.type:s0 joe.role:joe_ssh_server.type:s0 joe1.role:joe1_ss=
h_server.type:s0
> > sys.role:cockpit_session.subj:s0 joe.role:joe_cockpit_bridge.type:s0 jo=
e1:joe1_cockpit_bridge.type:s0
> >=20
> > ie. its already specified that for example joe1.type is default type fo=
r joe1.role for local_login and that joe1_ssh_server.type is default type f=
or joe1.role for sshd
> >=20
> > So unless i am overlooking something, the default_type file is redundan=
t and it actually adds an extra file to configure
> >=20
> > --=20
> > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6=
B02
> > Dominick Grift
>=20
>=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlphy9EACgkQJXSOVTf5
R2mrBQwAoDfYbVqOkcXPcEjIxVVVKQI3svStslYewJmrkjcIqnzTRszFuc3g5pyv
+kNiCbQ9/zT2WFb0W0LO1354MA4GYYH5TYMvlxzPx2RDQeDZEDiYIGAiCe8fwiRi
CZ9xulIEUZQ8IMIHDPlHCEyk+V+OhiZRCch5oCiZupz4xIIfXyHw+zoVy/fnA3Fg
dBSPgoMNuqPLBaAunEfdH1TxapcBIUcbCMdTj+wu9aWQWBLHBwkZFnjtnq/MlQb+
TeRkqRNjx4rtUr5Ynlu8OzPnm5TiVRfE6+xxv8FYENmqrRRn+SVFHL1OmoY0RZd6
/WHDBPwsv6gFnCOCVQFETKb3nbp1KZ4f/uiwd4Uv7s7gAHBbmKjO0FQWFYyDeU5e
rNjqzPPVP8cwdPVnypvnk4Vf4CEwDIImEa1F3eJdOptZu5kJR4wSSW/QLryg/4UQ
i0bgcHXma6+rAoOvLkd0czLOE3krYHGAv+x9ypvhUVxFBKEedU8N1PmFLnkjxDvc
wxLmWOLl
=W7Hg
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
