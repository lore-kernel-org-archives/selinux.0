Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v87DYikM013388
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 09:34:44 -0400
Received: by mail-wm0-f45.google.com with SMTP id r10so3943210wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 06:30:52 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id m12sm2167053edi.65.2017.09.07.06.30.49
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Sep 2017 06:30:49 -0700 (PDT)
Date: Thu, 7 Sep 2017 15:30:47 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170907133047.GD1813@julius.enp8s0.d30>
References: <20170907090534.GA1813@julius.enp8s0.d30>
 <1504788923.22845.10.camel@tycho.nsa.gov>
 <20170907132242.GC1813@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
In-Reply-To: <20170907132242.GC1813@julius.enp8s0.d30>
Subject: Re: pam_selinux and systemd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 03:22:42PM +0200, Dominick Grift wrote:
> On Thu, Sep 07, 2017 at 08:55:23AM -0400, Stephen Smalley wrote:
> > On Thu, 2017-09-07 at 11:05 +0200, Dominick Grift wrote:
> > > pam_selinux requirements are generally pretty simple: its used to
> > > associate a context with a login shell.
> > >=20
> > > With systemd things have becomes a bit more complicated.
> > >=20
> > > systemd uses pam_selinux to associate a context with both a login
> > > shell (via container-shell@.service) as well as with a systemd --user=
=20
> > > instance.
> > >=20
> > > Ideally one would not associate a login shell context with a systemd
> > > --user instance because a systemd --user instance needs permissions
> > > that do not make sense for a login shell to have.
> > >=20
> > > I am not aware of any way to make pam_selinux associate a context
> > > based on variable like for example: if its a login shell then
> > > associate this context , and if its a systemd --user instance then
> > > associate that context
> > >=20
> > > This is an issue for me currently because if users are allowed to
> > > "host-shell" (machinectl shell .host) then they are able to open a
> > > shell with the context of the systemd --user instance and escape
> > > their shell restrictions
> > >=20
> > > For now I can just block host-shell access with polkit but I am
> > > trying to figure out what it would take to address this challenge
> > > with pam_selinux
> >=20
> > The logic for determining a security context from pam_selinux (using
> > libselinux get_ordered_context_with_level) can take the source/from
> > context (i.e. the context in which the caller of pam_selinux is running
> > ) into account as a factor in selecting which context to use, since it
> > checks reachability (transition permission) as part of
> > security_compute_user().  So that's a possible approach if you can
> > distinguish what contexts are reachable for systemd --user vs login
> > daemons.
>=20
> The challenge here is that the source/from context is the same whether sy=
stemd --system spawns a login shell on behalf of a login user or whether sy=
stemd --system spawns a systemd --user instance on behalf of a login user
>=20
> >=20
> > What SELinux permissions are required to host-shell?  Can you block
> > that via SELinux policy rather than just polkit?
>=20
> Might be possible but probably tricky. Not sure what it would take.
>=20
> machinectl shell can also be used to spawn a shell in a container and thi=
s doesnt use pam_selinux, only machinectl shell .host makes systemd --syste=
m use pam_selinux to determine the pam characteristics to associate with th=
e login shell on the host for the user
>=20
> So "machinectl shell $container" makes machinectl itself a shell in $cont=
ainer (no pam), and "machinectl shell .host" makes machinectl tell systemd =
--system to spawn a login shell on the host (where systemd --system is usin=
g pam_selinux)
>=20
> >=20
> > Running machinectl shell .host locally doesn't seem to work:
> > $ machinectl shell .host
> > Failed to get shell PTY: Access denied
>=20
> Probably SELinux blocking then?
>=20
> $ id -Z
> wheel.id:wheel.role:wheel.subj:s0
> $ machinectl shell .host
> =3D=3D=3D=3D AUTHENTICATING FOR org.freedesktop.machine1.host-shell =3D=
=3D=3D
> Authentication is required to acquire a shell on the local host.
> Authenticating as: kcinimod
> Password:
> =3D=3D=3D=3D AUTHENTICATION COMPLETE =3D=3D=3D
> Connected to the local host. Press ^] three times within 1s to exit sessi=
on
> # journalctl -rb
> sh: journalctl: command not found
> # bash
> # journalctl -rb | grep denied | head -n 1
> Sep 07 15:14:29 julius audit[1983]: AVC avc:  denied  { getattr } for  pi=
d=3D1983 comm=3D"sh" path=3D"/usr/bin/journalctl" dev=3D"dm-1" ino=3D275618=
3 scontext=3Dsysadm.id:sysadm.role:sysadm_systemd.subj:s0 tcontext=3Dsys.id=
:sys.role:journalctl.cmd_file:s0 tclass=3Dfile permissive=3D0
> # ps auxZ | grep sysadm_systemd.subj
> sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1983 0.2  0.0 14452 450=
0 pts/4 Ss 15:14   0:00 -bin/sh
> sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1988 0.2  0.0 82036 795=
6 ?   Ss   15:14   0:00 /usr/lib/systemd/systemd --user
>=20
> So systemd --system runs -bin/sh using its pam_selinux which tells it to =
associate "sysadm_systemd.subj" with the login process, but that type is fo=
r the systemd --user instance of this user
> then there is an automatic transition from sysadm_systemd.subj to sysadm.=
subj on cmd.shell.cmd_file that eventually makes the transition work when m=
anually running bash
>=20
> I put in that auto type transition (sysadm_systemd.subj > (cmd.shell.cmd_=
file) -> sysadm.subj) not realizing that the shell initially ends up with s=
ysadm_systemd.subj via pam_selinux
>=20
> So i should remove that auto type transition as well since i shouldnt end=
 up in sysadm_systemd.subj in the first place

So to answer your question as to whether i would be able to block this acce=
ss without polkit:

Yes i would be able to do this by just not allowing the systemd --user inst=
ances to execute a shell

>=20
> >=20
> > Ideally, I'd like to get rid of security_compute_user() entirely, take
> > the logic for determining user context entirely to userspace, and
> > simplify it significantly, both in libselinux and in pam_selinux.=20
> > That's been discussed previously on the list.
> >=20
>=20
> --=20
> Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
> https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
> Dominick Grift



--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmxSgMACgkQJXSOVTf5
R2nCBgv/Z+f4Pgcv7fDkCj0QouRzBEcxTBxGrMP7WcGLJc4VQrHHrylNs43RtfEK
WMBDVjW67gbbp6RAogAvrI0MzC9TJ0TMj7zHJP2IsS5bOSspmSqSjhEVZjF7OVwk
fEz+vbGvfU6ddW8K9r7yus2aO87s4dQm+kAqd3BWVah0T1nhbmM7WwxHrl647U0s
UzvJ81JH3S976bAqtcD4idbLcpjiMwPX6yWO7f1TjtmJHMt3n4SSssNctvQTWCSJ
PljbyihZvo/XdE+KJGiyIYhoFhEYV+lVrOycchjLO6Zdk3ylyYNKOMY2sJXSZuTu
92QxRRKbGaHcXCEDHuy9TzbNKYKDpU4XI3ygNav0T1Pc3yRJub7JjDjKqLTKuJHy
nPdgOEjo7nRTTQ0U8vl81Ntc5+jVCNgOR2UwuDelTEyloZBjH3u92o/5P8c7dWPv
N7Z2ZIM6Mo6R3l2ZiaqBTl8lceTVefSqHvf9sniXYevjEsXNhToic+eD4Lp+g4R/
oMRh4OHA
=hPRT
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
