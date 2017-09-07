Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v87EnEjK013220
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 10:49:15 -0400
Received: by mail-wm0-f45.google.com with SMTP id r10so75026wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 07:30:48 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id d11sm2503519eda.68.2017.09.07.07.30.38
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Sep 2017 07:30:38 -0700 (PDT)
Date: Thu, 7 Sep 2017 16:30:36 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170907143036.GA8005@julius.enp8s0.d30>
References: <20170907090534.GA1813@julius.enp8s0.d30>
 <1504788923.22845.10.camel@tycho.nsa.gov>
 <20170907132242.GC1813@julius.enp8s0.d30>
 <20170907133047.GD1813@julius.enp8s0.d30>
 <20170907135002.GF1813@julius.enp8s0.d30>
 <20170907135636.GG1813@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
In-Reply-To: <20170907135636.GG1813@julius.enp8s0.d30>
Subject: Re: pam_selinux and systemd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 03:56:36PM +0200, Dominick Grift wrote:
> On Thu, Sep 07, 2017 at 03:50:02PM +0200, Dominick Grift wrote:
> > On Thu, Sep 07, 2017 at 03:30:47PM +0200, Dominick Grift wrote:
> > > On Thu, Sep 07, 2017 at 03:22:42PM +0200, Dominick Grift wrote:
> > > > On Thu, Sep 07, 2017 at 08:55:23AM -0400, Stephen Smalley wrote:
> > > > > On Thu, 2017-09-07 at 11:05 +0200, Dominick Grift wrote:
> > > > > > pam_selinux requirements are generally pretty simple: its used =
to
> > > > > > associate a context with a login shell.
> > > > > >=20
> > > > > > With systemd things have becomes a bit more complicated.
> > > > > >=20
> > > > > > systemd uses pam_selinux to associate a context with both a log=
in
> > > > > > shell (via container-shell@.service) as well as with a systemd =
--user=20
> > > > > > instance.
> > > > > >=20
> > > > > > Ideally one would not associate a login shell context with a sy=
stemd
> > > > > > --user instance because a systemd --user instance needs permiss=
ions
> > > > > > that do not make sense for a login shell to have.
> > > > > >=20
> > > > > > I am not aware of any way to make pam_selinux associate a conte=
xt
> > > > > > based on variable like for example: if its a login shell then
> > > > > > associate this context , and if its a systemd --user instance t=
hen
> > > > > > associate that context
> > > > > >=20
> > > > > > This is an issue for me currently because if users are allowed =
to
> > > > > > "host-shell" (machinectl shell .host) then they are able to ope=
n a
> > > > > > shell with the context of the systemd --user instance and escape
> > > > > > their shell restrictions
> > > > > >=20
> > > > > > For now I can just block host-shell access with polkit but I am
> > > > > > trying to figure out what it would take to address this challen=
ge
> > > > > > with pam_selinux
> > > > >=20
> > > > > The logic for determining a security context from pam_selinux (us=
ing
> > > > > libselinux get_ordered_context_with_level) can take the source/fr=
om
> > > > > context (i.e. the context in which the caller of pam_selinux is r=
unning
> > > > > ) into account as a factor in selecting which context to use, sin=
ce it
> > > > > checks reachability (transition permission) as part of
> > > > > security_compute_user().  So that's a possible approach if you can
> > > > > distinguish what contexts are reachable for systemd --user vs log=
in
> > > > > daemons.
> > > >=20
> > > > The challenge here is that the source/from context is the same whet=
her systemd --system spawns a login shell on behalf of a login user or whet=
her systemd --system spawns a systemd --user instance on behalf of a login =
user
> > > >=20
> > > > >=20
> > > > > What SELinux permissions are required to host-shell?  Can you blo=
ck
> > > > > that via SELinux policy rather than just polkit?
> > > >=20
> > > > Might be possible but probably tricky. Not sure what it would take.
> > > >=20
> > > > machinectl shell can also be used to spawn a shell in a container a=
nd this doesnt use pam_selinux, only machinectl shell .host makes systemd -=
-system use pam_selinux to determine the pam characteristics to associate w=
ith the login shell on the host for the user
> > > >=20
> > > > So "machinectl shell $container" makes machinectl itself a shell in=
 $container (no pam), and "machinectl shell .host" makes machinectl tell sy=
stemd --system to spawn a login shell on the host (where systemd --system i=
s using pam_selinux)
> > > >=20
> > > > >=20
> > > > > Running machinectl shell .host locally doesn't seem to work:
> > > > > $ machinectl shell .host
> > > > > Failed to get shell PTY: Access denied
> > > >=20
> > > > Probably SELinux blocking then?
> > > >=20
> > > > $ id -Z
> > > > wheel.id:wheel.role:wheel.subj:s0
> > > > $ machinectl shell .host
> > > > =3D=3D=3D=3D AUTHENTICATING FOR org.freedesktop.machine1.host-shell=
 =3D=3D=3D
> > > > Authentication is required to acquire a shell on the local host.
> > > > Authenticating as: kcinimod
> > > > Password:
> > > > =3D=3D=3D=3D AUTHENTICATION COMPLETE =3D=3D=3D
> > > > Connected to the local host. Press ^] three times within 1s to exit=
 session
> > > > # journalctl -rb
> > > > sh: journalctl: command not found
> > > > # bash
> > > > # journalctl -rb | grep denied | head -n 1
> > > > Sep 07 15:14:29 julius audit[1983]: AVC avc:  denied  { getattr } f=
or  pid=3D1983 comm=3D"sh" path=3D"/usr/bin/journalctl" dev=3D"dm-1" ino=3D=
2756183 scontext=3Dsysadm.id:sysadm.role:sysadm_systemd.subj:s0 tcontext=3D=
sys.id:sys.role:journalctl.cmd_file:s0 tclass=3Dfile permissive=3D0
> > > > # ps auxZ | grep sysadm_systemd.subj
> > > > sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1983 0.2  0.0 144=
52 4500 pts/4 Ss 15:14   0:00 -bin/sh
> > > > sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1988 0.2  0.0 820=
36 7956 ?   Ss   15:14   0:00 /usr/lib/systemd/systemd --user
> > > >=20
> > > > So systemd --system runs -bin/sh using its pam_selinux which tells =
it to associate "sysadm_systemd.subj" with the login process, but that type=
 is for the systemd --user instance of this user
> > > > then there is an automatic transition from sysadm_systemd.subj to s=
ysadm.subj on cmd.shell.cmd_file that eventually makes the transition work =
when manually running bash
> > > >=20
> > > > I put in that auto type transition (sysadm_systemd.subj > (cmd.shel=
l.cmd_file) -> sysadm.subj) not realizing that the shell initially ends up =
with sysadm_systemd.subj via pam_selinux
> > > >=20
> > > > So i should remove that auto type transition as well since i should=
nt end up in sysadm_systemd.subj in the first place
> > >=20
> > > So to answer your question as to whether i would be able to block thi=
s access without polkit:
> > >=20
> > > Yes i would be able to do this by just not allowing the systemd --use=
r instances to execute a shell
> >=20
> > So that will be my short term solution. Eventually I would like to figu=
re out a way to make this work though.
> >=20
> > That would require, i suspect, that pam_selinux be modified somehow so =
that systemd --system spawns -bin/sh (ex. sysadm.id:sysadm.role:sysadm.subj=
:s0) with a different context than when it spawns /usr/lib/systemd --user (=
ex. sysadm.id:sysadm.role:sysadm_system.subj:s0)
>=20
> Actually that wont work because then a user service unit in ~/.config/sys=
temd/user with a ExecStart=3D/bin/sh -c /bin/id wouldnt work anymore ...
>=20
> mind bending...

I imagine that some start to wonder whether it is worth confining systemd -=
-user instances in the first place.

One reason that i find kind of compelling is socket activation

systemd --user also supports socket activation (actually dbus --user is soc=
ket activated but so can be many others)

That means that systemd --user needs to be able to create sockets on behalf=
 of socket activated entities with setsockcreate, but besides that systemd =
--user would also need to be able to bind sockets to ports on behalf of for=
 example tcp socket activated entities

>=20
> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > Ideally, I'd like to get rid of security_compute_user() entirely,=
 take
> > > > > the logic for determining user context entirely to userspace, and
> > > > > simplify it significantly, both in libselinux and in pam_selinux.=
=20
> > > > > That's been discussed previously on the list.
> > > > >=20
> > > >=20
> > > > --=20
> > > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6=
B02
> > > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2=
C7B6B02
> > > > Dominick Grift
> > >=20
> > >=20
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

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmxWAgACgkQJXSOVTf5
R2l9rwv+K5uhYBqQQimgcU8oiN1SLgSyktbXx1RMlGTAYOq72m7OJ4uL2Povv2v8
6BnLYtDoxgou2sJRYzLd83hmIfEs435YrpVdU9aWubvwf+IczU9nNze1IUM0uPdW
XGToQVbAS9wT2oBOcNCL6ZELDCnWSL10me60ps7948xzO9hD88tOJnpqNgjZOOeU
cEUyRWILIgTNWJmCzqLtvyoRbj1mBEXh8JoYVIj+0tzxh4XX0DalxtWYo3duR+HO
baBuULLV5sJJoJvtDy54B96JAgoWwxv+pEULd5XoRecIjOTbVzwVMiQY8IcZMDvQ
skfZazk14piH79bhjwptX+VXyM/gpVeJr/dC27iFqx59JRhyx24PfG9xj0Z6TF0W
tyBbk8cqFZHpVko2YJMOYEbl5fPdh1icBee+WxlB8BmwoEZgOyTYTQ9NptAR85c0
oLR858dKvk2OPtxAhZL+OOFCIzO5vhzLqE5hOg4HgyEX1R50UVerkLxIRf+ZL+yI
y3hKWiJp
=Y/XL
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
