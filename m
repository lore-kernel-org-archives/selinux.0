Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id vB58eGTX014595
 for <selinux@tycho.nsa.gov>; Tue, 5 Dec 2017 03:40:16 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC10.oob.disa.mil (Postfix) with SMTP id 3yrZv03Fyzz4KRWk
 for <selinux@tycho.nsa.gov>; Tue,  5 Dec 2017 08:40:12 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC10.oob.disa.mil (Postfix) with ESMTP id 3yrZtw3hCVz4KRVx
 for <selinux@tycho.nsa.gov>; Tue,  5 Dec 2017 08:40:08 +0000 (UTC)
Received: by mail-wm0-f54.google.com with SMTP id g75so10427851wme.0
 for <selinux@tycho.nsa.gov>; Tue, 05 Dec 2017 00:40:07 -0800 (PST)
Received: from julius.enp8s0.d30 ([217.19.26.10])
 by smtp.gmail.com with ESMTPSA id h2sm9167597edc.89.2017.12.05.00.40.05
 for <selinux@tycho.nsa.gov>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 05 Dec 2017 00:40:06 -0800 (PST)
Date: Tue, 5 Dec 2017 09:40:04 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Message-ID: <20171205084004.GD19951@julius.enp8s0.d30>
References: <935734452.20069825.1512155793791.JavaMail.zimbra@redhat.com>
 <1512156497.5144.17.camel@tycho.nsa.gov>
 <1770894405.20077010.1512156904680.JavaMail.zimbra@redhat.com>
 <CAPMH7-_-GpDCKmiiJx72jsdbkmviNm3o7QMkE6DpxdQxEP-WYA@mail.gmail.com>
 <1512402030.20988.22.camel@tycho.nsa.gov>
 <CAPMH7--RQXXPH4iWzgi6_OnidDSNYFRBT0aDdV6jxLTZBn-AHg@mail.gmail.com>
 <1512403784.20988.27.camel@tycho.nsa.gov>
 <CAPMH7--Sow6Pvkti+Dk_yL67CANPSZojRuAvGk8a2-dPonKxPw@mail.gmail.com>
 <1512405482.20988.32.camel@tycho.nsa.gov>
 <CAPMH7-89cWy9SRK9CHBe-j2AHsEeW==SjMAK8qKFvPQmg0DXTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
In-Reply-To: <CAPMH7-89cWy9SRK9CHBe-j2AHsEeW==SjMAK8qKFvPQmg0DXTg@mail.gmail.com>
Subject: Re: Qwery regarding Selinux Change Id context
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 02:02:37PM +0530, Aman Sharma wrote:
> Hi Stephen,
>=20
> Below is the changes which I made in Login and ssh file :
>=20
> cat /etc/pam.d/sshd
> #%PAM-1.0
> auth    required pam_sepermit.so

side note: this is a "bug"
https://src.fedoraproject.org/rpms/openssh/c/e044c5cf76618b023a4315f41fe126=
c80c06b833?branch=3Dmaster

> auth       include     password-auth
> # Used with polkit to reauthorize users in remote sessions
> account    required     pam_nologin.so
> account    include      password-auth
> password   include      password-auth
> # pam_selinux.so close should be the first session rule
> session    required     pam_selinux.so close
> session    required     pam_loginuid.so
> # pam_selinux.so open should only be followed by sessions to be executed =
in
> the user context
> session    required     pam_selinux.so open env_params
> session    required     pam_namespace.so
> session    optional     pam_keyinit.so force revoke
> session    include      password-auth
> # Used with polkit to reauthorize users in remote sessions
>=20
>=20
> cat /etc/pam.d/login
> #%PAM-1.0
> auth [user_unknown=3Dignore success=3Dok ignore=3Dignore default=3Dbad]
> pam_securetty.so
> auth       include      system-auth
> account    required     pam_nologin.so
> account    include      system-auth
> password   include      system-auth
> # pam_selinux.so close should be the first session rule
> session    required     pam_selinux.so close
> session    required     pam_loginuid.so
> session    optional     pam_console.so
> # pam_selinux.so restore should only be followed by sessions to be execut=
ed
> in the user context
> session    required     pam_selinux.so open
> session    required     pam_namespace.so
> session    optional     pam_keyinit.so force revoke
> session    include      system-auth
> -session   optional     pam_ck_connector.so
>=20
> Please Let me know if any comments are there.
>=20
> On Mon, Dec 4, 2017 at 10:08 PM, Stephen Smalley <sds@tycho.nsa.gov> wrot=
e:
>=20
> > On Mon, 2017-12-04 at 22:04 +0530, Aman Sharma wrote:
> > > Hi Stephen,
> > >
> > > Thanks alot for the help.
> > >
> > > I got the issue. Its due to the problem in /etc/pam.d/sshd file.
> > >
> > > After fixing this, now is working fine. Thanks alot once again.
> >
> > Ok, can you explain what exactly what wrong in your /etc/pam.d/sshd
> > file, so that if someone else encounters this behavior in the future,
> > they can find a solution in the list archives?
> >
> > >
> > > On Mon, Dec 4, 2017 at 9:39 PM, Stephen Smalley <sds@tycho.nsa.gov>
> > > wrote:
> > > > On Mon, 2017-12-04 at 21:31 +0530, Aman Sharma wrote:
> > > > > Hi Stephen,
> > > > >
> > > > > I got the below logs from the file .Can you please if these logs
> > > > are
> > > > > fine or not :
> > > > >
> > > > > journalctl | grep selinux
> > > > > Dec 05 02:55:46 localhost.localdomain kernel: EVM:
> > > > security.selinux
> > > > > Dec 04 21:26:10 cucm audispd[569]: node=3Dlocalhost.localdomain
> > > > > type=3DUSER_START msg=3Daudit(1512402970.129:107): pid=3D7145 uid=
=3D0
> > > > auid=3D0
> > > > > ses=3D2 subj=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c1023
> > > > > msg=3D'op=3DPAM:session_open
> > > > >
> > > > grantors=3Dpam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_k=
ey
> > > > in
> > > > > it,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> > > > > acct=3D"root" exe=3D"/usr/sbin/sshd" hostname=3D10.97.7.209
> > > > > addr=3D10.97.7.209 terminal=3Dssh res=3Dsuccess'
> > > > > Dec 04 21:26:10 cucm audispd[569]: node=3Dlocalhost.localdomain
> > > > > type=3DUSER_START msg=3Daudit(1512402970.131:108): pid=3D7568 uid=
=3D0
> > > > auid=3D0
> > > > > ses=3D3 subj=3Dsystem_u:system_r:sshd_t:s0-s0:c0.c1023
> > > > > msg=3D'op=3DPAM:session_open
> > > > >
> > > > grantors=3Dpam_selinux,pam_loginuid,pam_selinux,pam_namespace,pam_k=
ey
> > > > in
> > > > > it,pam_keyinit,pam_limits,pam_systemd,pam_unix,pam_lastlog
> > > > > acct=3D"root" exe=3D"/usr/sbin/sshd" hostname=3D10.97.7.209
> > > > > addr=3D10.97.7.209 terminal=3Dssh res=3Dsuccess'
> > > > >
> > > > > Please let me know if any comments are there.
> > > >
> > > > Those are normal.  Check journalctl and /var/log/secure for any
> > > > errors
> > > > from sshd.
> > > > Also try the selinuxdefcon command I mentioned.
> > > >
> > > > >
> > > > > On Mon, Dec 4, 2017 at 9:10 PM, Stephen Smalley <sds@tycho.nsa.go
> > > > v>
> > > > > wrote:
> > > > > > On Sat, 2017-12-02 at 09:29 +0530, Aman Sharma wrote:
> > > > > > > Hi All,
> > > > > > >
> > > > > > > Thanks for the information.
> > > > > > >
> > > > > > > But after resetting the semanage User/login, and moving the
> > > > > > targeted
> > > > > > > folder to old one and then install the default target. then
> > > > also
> > > > > > its
> > > > > > > still showing the
> > > > > > > Id context as context=3Dsystem_u:system_r:unconfined_t:s0-
> > > > > > s0:c0.c1023.
> > > > > > >
> > > > > > > What I observed is after changing the permission using
> > > > semanage
> > > > > > > command also, its still showing the system_u:system_r.
> > > > > > >
> > > > > > > Check the semanage login/User output :
> > > > > > >
> > > > > > > semanage login -l
> > > > > > >
> > > > > > > Login Name           SELinux User         MLS/MCS Range
> > > >
> > > > > > > Service
> > > > > > >
> > > > > > > __default__          unconfined_u         s0-s0:c0.c1023
> > > >  *
> > > > > > > root                 unconfined_u         s0-s0:c0.c1023
> > > >  *
> > > > > > > system_u             system_u             s0-s0:c0.c1023
> > > >  *
> > > > > > >
> > > > > > >
> > > > > > > semanage user -l
> > > > > > >
> > > > > > >                 Labeling   MLS/       MLS/
> > > >
> > > > > >
> > > > > > > SELinux User    Prefix     MCS Level  MCS Range
> > > >
> > > > > >
> > > > > > > SELinux Roles
> > > > > > >
> > > > > > > guest_u         user       s0         s0
> > > >
> > > > > >
> > > > > > >  guest_r
> > > > > > > root            user       s0         s0-s0:c0.c1023
> > > >
> > > > > >
> > > > > > >  staff_r sysadm_r system_r unconfined_r
> > > > > > > staff_u         user       s0         s0-s0:c0.c1023
> > > >
> > > > > >
> > > > > > >  staff_r sysadm_r system_r unconfined_r
> > > > > > > sysadm_u        user       s0         s0-s0:c0.c1023
> > > >
> > > > > >
> > > > > > >  sysadm_r
> > > > > > > system_u        user       s0         s0-s0:c0.c1023
> > > >
> > > > > >
> > > > > > >  system_r unconfined_r
> > > > > > > unconfined_u    user       s0         s0-s0:c0.c1023
> > > >
> > > > > >
> > > > > > >  system_r unconfined_r
> > > > > > > user_u          user       s0         s0
> > > >
> > > > > >
> > > > > > >  user_r
> > > > > > > xguest_u        user       s0         s0
> > > >
> > > > > >
> > > > > > >  xguest_r
> > > > > > >
> > > > > > >
> > > > > > > Looks like its related to some other issue. What you think
> > > > about
> > > > > > > this.
> > > > > >
> > > > > > Do you have any relevant error messages in /var/log/secure or
> > > > > > journalctl -rb?  Look for anything that refers to selinux or
> > > > > > context.
> > > > > >
> > > > > > I'm guessing that pam_selinux is unable to determine a valid
> > > > > > context
> > > > > > for your login for some reason, and this is causing it to fall
> > > > back
> > > > > > to
> > > > > > this one.  Or something like that.
> > > > > >
> > > > > > You could try to emulate this process via selinuxdefcon,
> > > > although
> > > > > > I'm
> > > > > > not sure how closely it matches pam_selinux anymore.  Sample
> > > > usage:
> > > > > >
> > > > > > 1. See what context sshd is running in.
> > > > > >
> > > > > > ps -eZ | grep sshd
> > > > > >
> > > > > > It should be:
> > > > > > system_u:system_r:sshd_t:s0-s0:c0.c1023
> > > > > >
> > > > > > 2. Run selinuxdefcon to compute the default context for root
> > > > when
> > > > > > logging in from sshd:
> > > > > >
> > > > > > # Second argument should be whatever was shown by ps -eZ | grep
> > > > > > sshd
> > > > > > above.
> > > > > > selinuxdefcon root system_u:system_r:sshd_t:s0-s0.c0123
> > > > > >
> > > > > > It should be:
> > > > > > unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
> > > > > >
> > > > > >
> > > > > >
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > >
> > > > > Thanks
> > > > > Aman
> > > > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> > > >
> > >
> > >
> > >
> > > --
> > >
> > > Thanks
> > > Aman
> > > Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com
> >
>=20
>=20
>=20
> --=20
>=20
> Thanks
> Aman
> Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--=20
Key fingerprint =3D 5F4D 3CDB D3F8 3652 FBD8  02D5 3B6C 5F1D 2C7B 6B02
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x3B6C5F1D2C7B6B02
Dominick Grift

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCAAdFiEEujmXliIBLFTc2Y4AJXSOVTf5R2kFAlomW2AACgkQJXSOVTf5
R2kh4QwAnisbUPsuhGqOx0+P48+VLF6wZuLQRi8oL/j9sMcYG+jMIuxK6EvF3HkH
5jKErUfZNxcPq/0Gn866/VY0mQ96k+Qui3JDnpG/3ZpQUl/icEfnHL+GTpaqZ8Ka
Epllm75HAuSbLHqgcqQNWZxWAQs+YF1DRDf7yuYJqZP3ReQHbTqQcoV4zKmWSS1e
S4a3QBA/1ng/OUCq2za7myiiI/5TbTSEzKV5WQkSyjNUA0qoZFvYLJDG08z+oMqM
3cLrbGSdXz7R8v6Vw59JYDUzSPcFp5FhYZ1soCzilEhQ3PWS/4PnMKR+vusaOVLU
wkLk+w4kyNSfx8DaM2gW7pOKwTBvoJNB1/iVEqHQ+esCFnW1PO4OvwY6jbGAGYEV
YpHPcEVoKYR3Vue3+3fhaIQIihDWINweCc7OcgefzwuUzxsw5v7VLBf643cH4XP6
jayOoar21kGnBMBa/jxKL1awwS4OcYL04c739CljFU0TNpYSRv35unDanf09xY5A
rIr/a7UN
=C+7X
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
