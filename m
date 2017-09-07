Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v87DN8JW007378
 for <selinux@tycho.nsa.gov>; Thu, 7 Sep 2017 09:23:08 -0400
Received: by mail-wm0-f44.google.com with SMTP id r10so3794027wmf.1
 for <selinux@tycho.nsa.gov>; Thu, 07 Sep 2017 06:22:48 -0700 (PDT)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id e56sm3051142edb.7.2017.09.07.06.22.43
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 07 Sep 2017 06:22:43 -0700 (PDT)
Date: Thu, 7 Sep 2017 15:22:42 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20170907132242.GC1813@julius.enp8s0.d30>
References: <20170907090534.GA1813@julius.enp8s0.d30>
 <1504788923.22845.10.camel@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="s9fJI615cBHmzTOP"
In-Reply-To: <1504788923.22845.10.camel@tycho.nsa.gov>
Subject: Re: pam_selinux and systemd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--s9fJI615cBHmzTOP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2017 at 08:55:23AM -0400, Stephen Smalley wrote:
> On Thu, 2017-09-07 at 11:05 +0200, Dominick Grift wrote:
> > pam_selinux requirements are generally pretty simple: its used to
> > associate a context with a login shell.
> >=20
> > With systemd things have becomes a bit more complicated.
> >=20
> > systemd uses pam_selinux to associate a context with both a login
> > shell (via container-shell@.service) as well as with a systemd --user=
=20
> > instance.
> >=20
> > Ideally one would not associate a login shell context with a systemd
> > --user instance because a systemd --user instance needs permissions
> > that do not make sense for a login shell to have.
> >=20
> > I am not aware of any way to make pam_selinux associate a context
> > based on variable like for example: if its a login shell then
> > associate this context , and if its a systemd --user instance then
> > associate that context
> >=20
> > This is an issue for me currently because if users are allowed to
> > "host-shell" (machinectl shell .host) then they are able to open a
> > shell with the context of the systemd --user instance and escape
> > their shell restrictions
> >=20
> > For now I can just block host-shell access with polkit but I am
> > trying to figure out what it would take to address this challenge
> > with pam_selinux
>=20
> The logic for determining a security context from pam_selinux (using
> libselinux get_ordered_context_with_level) can take the source/from
> context (i.e. the context in which the caller of pam_selinux is running
> ) into account as a factor in selecting which context to use, since it
> checks reachability (transition permission) as part of
> security_compute_user().  So that's a possible approach if you can
> distinguish what contexts are reachable for systemd --user vs login
> daemons.

The challenge here is that the source/from context is the same whether syst=
emd --system spawns a login shell on behalf of a login user or whether syst=
emd --system spawns a systemd --user instance on behalf of a login user

>=20
> What SELinux permissions are required to host-shell?  Can you block
> that via SELinux policy rather than just polkit?

Might be possible but probably tricky. Not sure what it would take.

machinectl shell can also be used to spawn a shell in a container and this =
doesnt use pam_selinux, only machinectl shell .host makes systemd --system =
use pam_selinux to determine the pam characteristics to associate with the =
login shell on the host for the user

So "machinectl shell $container" makes machinectl itself a shell in $contai=
ner (no pam), and "machinectl shell .host" makes machinectl tell systemd --=
system to spawn a login shell on the host (where systemd --system is using =
pam_selinux)

>=20
> Running machinectl shell .host locally doesn't seem to work:
> $ machinectl shell .host
> Failed to get shell PTY: Access denied

Probably SELinux blocking then?

$ id -Z
wheel.id:wheel.role:wheel.subj:s0
$ machinectl shell .host
=3D=3D=3D=3D AUTHENTICATING FOR org.freedesktop.machine1.host-shell =3D=3D=
=3D
Authentication is required to acquire a shell on the local host.
Authenticating as: kcinimod
Password:
=3D=3D=3D=3D AUTHENTICATION COMPLETE =3D=3D=3D
Connected to the local host. Press ^] three times within 1s to exit session
# journalctl -rb
sh: journalctl: command not found
# bash
# journalctl -rb | grep denied | head -n 1
Sep 07 15:14:29 julius audit[1983]: AVC avc:  denied  { getattr } for  pid=
=3D1983 comm=3D"sh" path=3D"/usr/bin/journalctl" dev=3D"dm-1" ino=3D2756183=
 scontext=3Dsysadm.id:sysadm.role:sysadm_systemd.subj:s0 tcontext=3Dsys.id:=
sys.role:journalctl.cmd_file:s0 tclass=3Dfile permissive=3D0
# ps auxZ | grep sysadm_systemd.subj
sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1983 0.2  0.0 14452 4500 =
pts/4 Ss 15:14   0:00 -bin/sh
sysadm.id:sysadm.role:sysadm_systemd.subj:s0 root 1988 0.2  0.0 82036 7956 =
?   Ss   15:14   0:00 /usr/lib/systemd/systemd --user

So systemd --system runs -bin/sh using its pam_selinux which tells it to as=
sociate "sysadm_systemd.subj" with the login process, but that type is for =
the systemd --user instance of this user
then there is an automatic transition from sysadm_systemd.subj to sysadm.su=
bj on cmd.shell.cmd_file that eventually makes the transition work when man=
ually running bash

I put in that auto type transition (sysadm_systemd.subj > (cmd.shell.cmd_fi=
le) -> sysadm.subj) not realizing that the shell initially ends up with sys=
adm_systemd.subj via pam_selinux

So i should remove that auto type transition as well since i shouldnt end u=
p in sysadm_systemd.subj in the first place

>=20
> Ideally, I'd like to get rid of security_compute_user() entirely, take
> the logic for determining user context entirely to userspace, and
> simplify it significantly, both in libselinux and in pam_selinux.=20
> That's been discussed previously on the list.
>=20

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--s9fJI615cBHmzTOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlmxSB4ACgkQJXSOVTf5
R2lsGAv9FSH6xg3E/hWONrIpqdtTzas23F4Ki3MuqGqHsOwz4UOCzDbXgktOjwD1
bxKaqCRys6Gqr5p8yA7SJKnta9kTnsICYn8DlBpJkG2JHa2J9nRUY6NLfxWvPnjx
SYyEP9nQwgy7BGuQb64bTRvkxEe1U4rZiZS/0TtZyFQ1YHg4urmXytGFyb+GrIta
Juho9lw1sJvHYon/RAzJNu0p99mUtjyhT6D3nfDcekZHJpM+OYgoXHa+uuEzfauV
FSnqpR3ajMoW/0OaNkF3WJ5c2eU94GSZo1mG5bUJElCLaxHEwmbqTU+s0yMdF8/E
2+zT+uITEigOKq4E8XAzGMj/cdz9437RmLFX3mJ/K0h0jTIDq0S4ekvIoqDSfur3
4gpq8EaCVW3akX9HVt2A5966A+zawZ93Xahl2caZ0JdLikWm22McacS+gSWT5VyD
n/Gt4PTMxbmFghVH6m0HCi/01e2vTOY+AHj6eULXPiYWMB63i4a5gKr1MZjiNE9j
Oj+1ioJ5
=Tbw3
-----END PGP SIGNATURE-----

--s9fJI615cBHmzTOP--
