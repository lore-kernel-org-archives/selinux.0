Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75FNs4p028879
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 11:23:54 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m75FNm0u015008
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 15:23:48 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Question about newrole
Date: Tue, 5 Aug 2008 23:23:44 +0800
References: <200808052155.18105.linuxweb@gmx.net> <200808052232.03624.linuxweb@gmx.net> <1217947735.2994.88.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217947735.2994.88.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1520008.tuEEPK6Meg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808052323.48362.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart1520008.tuEEPK6Meg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 05 August 2008 22:48:55 Stephen Smalley wrote:
> On Tue, 2008-08-05 at 22:32 +0800, Dennis Wronka wrote:
> > Thanks.
> > That seems to help quite a bit.
> > I now get some messages. For example it seems that newrole wants to
> > read /etc/shadow directly.
> > Will check those messages and play around with the policy.
>
> The way it works is that pam_unix attempts to open /etc/shadow directly
> for reading, and if it fails, it falls back to running unix_chkpwd to
> perform the password check.  SELinux policy prohibits most programs from
> directly reading /etc/shadow, including even ones that run as root, and
> forces them to go through unix_chkpwd instead, in order to limit the set
> of processes that have full read access to the shadow password file.
>
> The logic to try to open /etc/shadow and fall back to unix_chkpwd
> already existed before SELinux in order to support non-root processes
> re-authenticating the current user.  What changed with SELinux was that
> it could also happen for root processes.
>
> The current policy dontaudit's the attempt to directly read /etc/shadow
> to avoid noise.  When you did semodule -DB, you turned on that auditing.
> But those denials are what is expected, and allowing them will mean
> giving newrole direct read access to /etc/shadow (although that will
> only work if running as root, of course, as otherwise it has to use a
> suid helper like unix_chkpwd anyway).
>
> Does newrole work for you as a non-root user?

Okay, it looks like that unix_chkpwd is not allowed to read /etc/shadow whe=
n=20
running in newrole_t.

Here's the message:
type=3D1400 audit(1217920543.235:26): avc: denied { read } for pid=3D1210=20
comm=3D"unix_chkpwd" name=3D"shadow" dev=3Ddm-0 ino=3D29366926=20
scontext=3Dstaff_u:staff_r:newrole_t tcontext=3Dsystem_u:object_r:shadow_t=
=20
tclass=3Dfile

Is it safe to add the rule suggested by audit2allow "allow newrole_t=20
shadow_t:file read;" to the policy or would there be a better way?

Wouldn't it in general be better if unix_chkpwd would transition into a dom=
ain=20
for itself which then in turn is allowed to access /etc/shadow?

--nextPart1520008.tuEEPK6Meg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYcIQACgkQ1sXw8/2VziSUgQCfX6vfR/CkKVXMdRwEP5mSGtS0
LPQAn2Bgx0t1yEMACD7O924o8jYNw0y5
=d1hl
-----END PGP SIGNATURE-----

--nextPart1520008.tuEEPK6Meg--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
