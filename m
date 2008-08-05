Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m75FkkgX002326
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 11:46:46 -0400
Received: from mail.gmx.net (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m75Fkd0u022642
	for <selinux@tycho.nsa.gov>; Tue, 5 Aug 2008 15:46:39 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Question about newrole
Date: Tue, 5 Aug 2008 23:46:34 +0800
References: <200808052155.18105.linuxweb@gmx.net> <200808052323.48362.linuxweb@gmx.net> <1217950600.2994.116.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1217950600.2994.116.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2203613.IBM3Zd4nZv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808052346.38916.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2203613.IBM3Zd4nZv
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 05 August 2008 23:36:40 Stephen Smalley wrote:
> On Tue, 2008-08-05 at 23:23 +0800, Dennis Wronka wrote:
> > On Tuesday 05 August 2008 22:48:55 Stephen Smalley wrote:
> > > On Tue, 2008-08-05 at 22:32 +0800, Dennis Wronka wrote:
> > > > Thanks.
> > > > That seems to help quite a bit.
> > > > I now get some messages. For example it seems that newrole wants to
> > > > read /etc/shadow directly.
> > > > Will check those messages and play around with the policy.
> > >
> > > The way it works is that pam_unix attempts to open /etc/shadow direct=
ly
> > > for reading, and if it fails, it falls back to running unix_chkpwd to
> > > perform the password check.  SELinux policy prohibits most programs
> > > from directly reading /etc/shadow, including even ones that run as
> > > root, and forces them to go through unix_chkpwd instead, in order to
> > > limit the set of processes that have full read access to the shadow
> > > password file.
> > >
> > > The logic to try to open /etc/shadow and fall back to unix_chkpwd
> > > already existed before SELinux in order to support non-root processes
> > > re-authenticating the current user.  What changed with SELinux was th=
at
> > > it could also happen for root processes.
> > >
> > > The current policy dontaudit's the attempt to directly read /etc/shad=
ow
> > > to avoid noise.  When you did semodule -DB, you turned on that
> > > auditing. But those denials are what is expected, and allowing them
> > > will mean giving newrole direct read access to /etc/shadow (although
> > > that will only work if running as root, of course, as otherwise it has
> > > to use a suid helper like unix_chkpwd anyway).
> > >
> > > Does newrole work for you as a non-root user?
> >
> > Okay, it looks like that unix_chkpwd is not allowed to read /etc/shadow
> > when running in newrole_t.
> >
> > Here's the message:
> > type=3D1400 audit(1217920543.235:26): avc: denied { read } for pid=3D12=
10
> > comm=3D"unix_chkpwd" name=3D"shadow" dev=3Ddm-0 ino=3D29366926
> > scontext=3Dstaff_u:staff_r:newrole_t tcontext=3Dsystem_u:object_r:shado=
w_t
> > tclass=3Dfile
> >
> > Is it safe to add the rule suggested by audit2allow "allow newrole_t
> > shadow_t:file read;" to the policy or would there be a better way?
> >
> > Wouldn't it in general be better if unix_chkpwd would transition into a
> > domain for itself which then in turn is allowed to access /etc/shadow?
>
> unix_chkpwd is supposed to transition into its own domain already.  Is
> it properly labeled (ls -Z /sbin/unix_chkpwd)?  It should have the
> chkpwd_exec_t type.  And newrole_t should transition to the
> system_chkpwd_t domain upon executing it.

Thanks Stephen, that was the magic hint I believe.
My unix_chkpwd and unix_update were still in the position they got put by t=
he=20
PAM-installation (gotta check the install-script if there's a way to put th=
em=20
directly into /sbin). I moved them over, checked with restorecon and now it=
=20
works.
Just had to put symlinks back to the original place because otherwise login=
=20
didn't work. Will have to check if I really need these symlinks or if I can=
=20
do without (Fedora 9 seems to get along without, so there must be a way for=
=20
me to do it too).

--nextPart2203613.IBM3Zd4nZv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiYdd4ACgkQ1sXw8/2VziRHxgCeOudWSGybuWxvewhmUc5CKB/O
AC4AnjrFg5GixxUk7nd61HQl03uli4be
=PqKl
-----END PGP SIGNATURE-----

--nextPart2203613.IBM3Zd4nZv--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
