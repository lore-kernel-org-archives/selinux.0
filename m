Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w0JCD8k4024295
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 07:13:08 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC15.oob.disa.mil (Postfix) with SMTP id 3zNKTs526mz3GDS1
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 12:13:05 +0000 (UTC)
Received: from UPDC3CPA01.eemsg.mil (unknown [192.168.18.8])
 by UPDCF3IC15.oob.disa.mil (Postfix) with ESMTP id 3zNKTq74F7z3GD9h
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 12:13:03 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id b21so3119136wme.4
 for <selinux@tycho.nsa.gov>; Fri, 19 Jan 2018 04:13:03 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id g55sm6037203eda.70.2018.01.19.04.13.01
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 19 Jan 2018 04:13:01 -0800 (PST)
Date: Fri, 19 Jan 2018 13:12:59 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20180119121259.GD4126@julius.enp8s0.d30>
References: <20180119101951.GA4126@julius.enp8s0.d30>
 <20180119103437.GB4126@julius.enp8s0.d30>
 <20180119104333.GC4126@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zbGR4y+acU1DwHSi"
In-Reply-To: <20180119104333.GC4126@julius.enp8s0.d30>
Subject: Re: default_type limitations
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--zbGR4y+acU1DwHSi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2018 at 11:43:33AM +0100, Dominick Grift wrote:
> On Fri, Jan 19, 2018 at 11:34:37AM +0100, Dominick Grift wrote:
> > On Fri, Jan 19, 2018 at 11:19:51AM +0100, Dominick Grift wrote:
> > > The default_type functionality is too limited because it assumes that=
 all login programs associate the same type with a given role
> > >=20
> > > This is not the case
> > >=20
> > > For example:
> > >=20
> > > default_type for local_login: joe.role:joe.type
> > > default_type for sshd: joe.role:joe_ssh_server.type
> > > default_type for cockpit joe.role:joe_cockpit_bridge.type
> >=20
> > The thing is that login programs these day's often dont just run a shel=
l on behalf of users directly.
> > There is often an intermediate process that should not be associated wi=
th the shell type ideally
> >=20
> > For example sshd uses pam_selinux to associate a context with the privi=
leged user sshd process. This process needs
> > all kinds of extra permissions for tunneling, forwarding, chroots etc.
> >=20
> > this privileged process then runs a shell on half of the user:
> >=20
> > sshd -> user "priv" sshd process -> user shell
> >=20
> > This works because it uses pam_selinux for the user "priv" sshd manual =
process transition, and then i can use a transparent automatic type transit=
ion to associate a context with the shell (user_sshd.type -> shell -> user.=
type)
> >=20
> > Same with cockpit:
> > cockpits_session -> user cockpit bridge -> user shell
> >=20
> > unlike local_login:
> > login -> user shell
>=20
> I other words: There is no such thing as a "default_type". The default ty=
pe associated with a given role can vary per login program.

hmm, never mind. I will have to investigate further... looks like i got con=
fused

>=20
> >=20
> > >=20
> > > etc
> > >=20
> > > So pam_selinux "select_context" can only support a single login progr=
am due to this
> > >=20
> > > I do not understand why default_type is needed in the first place. Th=
e contexts/users/ file is more specific:
> > >=20
> > > /etc/selinux/TYPE/contexts/users/joe.user:
> > > sys.role:login.type:s0 joe.role:joe.type:s0 joe1.role:joe1.type:s0
> > > sys.role:sshd.type:s0 joe.role:joe_ssh_server.type:s0 joe1.role:joe1_=
ssh_server.type:s0
> > > sys.role:cockpit_session.subj:s0 joe.role:joe_cockpit_bridge.type:s0 =
joe1:joe1_cockpit_bridge.type:s0
> > >=20
> > > ie. its already specified that for example joe1.type is default type =
for joe1.role for local_login and that joe1_ssh_server.type is default type=
 for joe1.role for sshd
> > >=20
> > > So unless i am overlooking something, the default_type file is redund=
ant and it actually adds an extra file to configure
> > >=20
> > > --=20
> > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7=
B6B02
> > > Dominick Grift
> >=20
> >=20
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

--zbGR4y+acU1DwHSi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlph4McACgkQJXSOVTf5
R2k4gAv8DlCmzvqXu+WPgDJ/k1nsYRf90l1bNUvVyxWpMaWNOceKg5FpCatW9a5J
m30pF0wrhvJ7zF78AGF85DfYt4d+LUaJSQXtAtSwDhOmkkTNapbbhD8uvQHcUiti
CCEXfU8TgKXKqhA8UEp5rBHpi17Z6ZbLdWbhebmrLhhajqkHCiK8xU1wTsf1laWB
tBvfgyyMvoGIc42r2gsQXCb7SsSU/NgbtiWePF7yceuT8JzbJeY0hXVW1WO1zydN
b3zQ8Nd4SFQbjDJKGVuRuttbgG9RLLBdjq7CHipe7CokGe0cswpF5GXTNCG8Wo7u
SVhnFICJE11zxfzdYCZvB7f8U7NqinEKt6fO6SuUJKh9oo9kJMIkvbSb13hxxj/7
rtDQT9eJ5PJtERuXyq2VCsqYI9CopvcPAseFo1pmONHEVqlt/RD9ZwE0SIBAEKig
WUU/uJK5R515ALYIyrnBwsgspXgNEp6prZHCKmTDSJ1w9GSDbCvzYV29fvHNjw0V
7kdk5oJD
=PW6y
-----END PGP SIGNATURE-----

--zbGR4y+acU1DwHSi--
