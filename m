Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v87FpSw0009473
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 11:51:28 -0400
Received: by mail-wm0-f66.google.com with SMTP id x17so1214878wmd.5
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 08:00:02 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id b43sm3666253edc.52.2017.09.07.07.59.56
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Sep 2017 07:59:57 -0700 (PDT)
Date: Thu, 7 Sep 2017 16:59:55 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170907145955.GB8005@julius.enp8s0.d30>
References: <20170907090534.GA1813@julius.enp8s0.d30>
 <1504788923.22845.10.camel@tycho.nsa.gov>
 <20170907132242.GC1813@julius.enp8s0.d30>
 <20170907133047.GD1813@julius.enp8s0.d30>
 <20170907135002.GF1813@julius.enp8s0.d30>
 <20170907135636.GG1813@julius.enp8s0.d30>
 <20170907143036.GA8005@julius.enp8s0.d30>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
In-Reply-To: <20170907143036.GA8005@julius.enp8s0.d30>
Subject: Re: pam_selinux and systemd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 04:30:36PM +0200, Dominick Grift wrote:
> On Thu, Sep 07, 2017 at 03:56:36PM +0200, Dominick Grift wrote:
> > On Thu, Sep 07, 2017 at 03:50:02PM +0200, Dominick Grift wrote:
> > > On Thu, Sep 07, 2017 at 03:30:47PM +0200, Dominick Grift wrote:
> > > > On Thu, Sep 07, 2017 at 03:22:42PM +0200, Dominick Grift wrote:
> > > > > On Thu, Sep 07, 2017 at 08:55:23AM -0400, Stephen Smalley wrote:
> > > > > > On Thu, 2017-09-07 at 11:05 +0200, Dominick Grift wrote:
> > > > > > > pam_selinux requirements are generally pretty simple: its use=
d to
> > > > > > > associate a context with a login shell.
> > > > > > >=20
> > > > > > > With systemd things have becomes a bit more complicated.
> > > > > > >=20
> > > > > > > systemd uses pam_selinux to associate a context with both a l=
ogin
> > > > > > > shell (via container-shell@.service) as well as with a system=
d --user=20
> > > > > > > instance.
> > > > > > >=20
> > > > > > > Ideally one would not associate a login shell context with a =
systemd
> > > > > > > --user instance because a systemd --user instance needs permi=
ssions
> > > > > > > that do not make sense for a login shell to have.
> > > > > > >=20
> > > > > > > I am not aware of any way to make pam_selinux associate a con=
text
> > > > > > > based on variable like for example: if its a login shell then
> > > > > > > associate this context , and if its a systemd --user instance=
 then
> > > > > > > associate that context
> > > > > > >=20
> > > > > > > This is an issue for me currently because if users are allowe=
d to
> > > > > > > "host-shell" (machinectl shell .host) then they are able to o=
pen a
> > > > > > > shell with the context of the systemd --user instance and esc=
ape
> > > > > > > their shell restrictions
> > > > > > >=20
> > > > > > > For now I can just block host-shell access with polkit but I =
am
> > > > > > > trying to figure out what it would take to address this chall=
enge
> > > > > > > with pam_selinux
> > > > > >=20
> > > > > > The logic for determining a security context from pam_selinux (=
using
> > > > > > libselinux get_ordered_context_with_level) can take the source/=
=66rom
> > > > > > context (i.e. the context in which the caller of pam_selinux is=
 running
> > > > > > ) into account as a factor in selecting which context to use, s=
ince it
> > > > > > checks reachability (transition permission) as part of
> > > > > > security_compute_user().  So that's a possible approach if you =
can
> > > > > > distinguish what contexts are reachable for systemd --user vs l=
ogin
> > > > > > daemons.
> > > > >=20
> > > > > The challenge here is that the source/from context is the same wh=
ether systemd --system spawns a login shell on behalf of a login user or wh=
ether systemd --system spawns a systemd --user instance on behalf of a logi=
n user
> > > > >=20
> > > > > >=20
> > > > > > What SELinux permissions are required to host-shell?  Can you b=
lock
> > > > > > that via SELinux policy rather than just polkit?
> > > > >=20
> > > > > Might be possible but probably tricky. Not sure what it would tak=
e.
> > > > >=20
> > > > > machinectl shell can also be used to spawn a shell in a container=
 and this doesnt use pam_selinux, only machinectl shell .host makes systemd=
 --system use pam_selinux to determine the pam characteristics to associate=
 with the login shell on the host for the user
> > > > >=20
> > > > > So "machinectl shell $container" makes machinectl itself a shell =
in $container (no pam), and "machinectl shell .host" makes machinectl tell =
systemd --system to spawn a login shell on the host (where systemd --system=
 is using pam_selinux)
> > > > >=20
> > > > > >=20
> > > > > > Running machinectl shell .host locally doesn't seem to work:
> > > > > > $ machinectl shell .host
> > > > > > Failed to get shell PTY: Access denied
> > > > >=20
> > > > > Probably SELinux blocking then?
> > > > >=20
> > > > > $ id -Z
> > > > > wheel.id:wheel.role:wheel.subj:s0
> > > > > $ machinectl shell .host
> > > > > =3D=3D=3D=3D AUTHENTICATING FOR org.freedesktop.machine1.host-she=
ll =3D=3D=3D
> > > > > Authentication is required to acquire a shell on the local host.
> > > > > Authenticating as: kcinimod
> > > > > Password:
> > > > > =3D=3D=3D=3D AUTHENTICATION COMPLETE =3D=3D=3D
> > > > > Connected to the local host. Press ^] three times within 1s to ex=
it session
> > > > > # journalctl -rb
> > > > > sh: journalctl: command not found
> > > > > # bash
> > > > > # journalctl -rb | grep denied | head -n 1
> > > > > Sep 07 15:14:29 julius audit[1983]: AVC avc:  denied  { getattr }=
 for  pid=3D1983 comm=3D"sh" path=3D"/usr/bin/journalctl" dev=3D"dm-1" ino=
=3D2756183 scontext=3Dsysadm.id:sysadm.role:sysadm_systemd.subj:s0 tcontext=
=3Dsys.id:sys.role:journalctl.cmd_file:s0 tclass=3Dfile permissive=3D0
> > > > > # ps auxZ | grep sysadm_systemd.subj
> > > > > sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1983 0.2  0.0 1=
4452 4500 pts/4 Ss 15:14   0:00 -bin/sh
> > > > > sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1988 0.2  0.0 8=
2036 7956 ?   Ss   15:14   0:00 /usr/lib/systemd/systemd --user
> > > > >=20
> > > > > So systemd --system runs -bin/sh using its pam_selinux which tell=
s it to associate "sysadm_systemd.subj" with the login process, but that ty=
pe is for the systemd --user instance of this user
> > > > > then there is an automatic transition from sysadm_systemd.subj to=
 sysadm.subj on cmd.shell.cmd_file that eventually makes the transition wor=
k when manually running bash
> > > > >=20
> > > > > I put in that auto type transition (sysadm_systemd.subj > (cmd.sh=
ell.cmd_file) -> sysadm.subj) not realizing that the shell initially ends u=
p with sysadm_systemd.subj via pam_selinux
> > > > >=20
> > > > > So i should remove that auto type transition as well since i shou=
ldnt end up in sysadm_systemd.subj in the first place
> > > >=20
> > > > So to answer your question as to whether i would be able to block t=
his access without polkit:
> > > >=20
> > > > Yes i would be able to do this by just not allowing the systemd --u=
ser instances to execute a shell
> > >=20
> > > So that will be my short term solution. Eventually I would like to fi=
gure out a way to make this work though.
> > >=20
> > > That would require, i suspect, that pam_selinux be modified somehow s=
o that systemd --system spawns -bin/sh (ex. sysadm.id:sysadm.role:sysadm.su=
bj:s0) with a different context than when it spawns /usr/lib/systemd --user=
 (ex. sysadm.id:sysadm.role:sysadm_system.subj:s0)
> >=20
> > Actually that wont work because then a user service unit in ~/.config/s=
ystemd/user with a ExecStart=3D/bin/sh -c /bin/id wouldnt work anymore ...
> >=20
> > mind bending...
>=20
> I imagine that some start to wonder whether it is worth confining systemd=
 --user instances in the first place.
>=20
> One reason that i find kind of compelling is socket activation
>=20
> systemd --user also supports socket activation (actually dbus --user is s=
ocket activated but so can be many others)
>=20
> That means that systemd --user needs to be able to create sockets on beha=
lf of socket activated entities with setsockcreate, but besides that system=
d --user would also need to be able to bind sockets to ports on behalf of f=
or example tcp socket activated entities
>=20

for reference:

https://github.com/DefenSec/dssp2-standard/issues/6

> >=20
> > >=20
> > > >=20
> > > > >=20
> > > > > >=20
> > > > > > Ideally, I'd like to get rid of security_compute_user() entirel=
y, take
> > > > > > the logic for determining user context entirely to userspace, a=
nd
> > > > > > simplify it significantly, both in libselinux and in pam_selinu=
x.=20
> > > > > > That's been discussed previously on the list.
> > > > > >=20
> > > > >=20
> > > > > --=20
> > > > > Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B=
 6B02
> > > > > https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1=
D2C7B6B02
> > > > > Dominick Grift
> > > >=20
> > > >=20
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

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmxXucACgkQJXSOVTf5
R2kO1wv+M3Jr3jVmWH5UBTPOJVkq8ghqMQiSbZ1tyWnIOFEemosB566jxwkKiqYq
mO01j2hPginZ8mJziO6tGkDOt5rVXCdxeGrBNmdhRCsqcRH7OX2xoYq7OFA1GrnY
3bPzN/8oMxuOsWf5y/jH92CMLRWGcGbrKlG0K+uZtu0PVzRRZa/LFNvRP7F48d99
H6RQs7r00BDukny3Ry/cRrcZW15KVQ9diTt1oPehQ4ElMnYUd6RM+f4et4i4m4xL
ALRZmdNXdX3VorohTVZId74xxIet8H/hWEROc9h0/PHRHp3wCkaCWE+TwkQzNuNj
Efswr/njhsxAt34M42xhVya73MsqX52WADVarxxfmF9/6/MuDnCySV+yyheXLNSO
ISx19jJwt2hr1MCL373S89/BdR4l6iehq8/g3q91ekXM3hK3Jc5lK6uqz7YN0Txu
G8JkYT+hcayyR6QBQFCOCCjTTVvScPAvfECnYoGAfBgEa2eRLIye4wMRSvT9QGl+
wbMfhaAG
=VuKs
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
