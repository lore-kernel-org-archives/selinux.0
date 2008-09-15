Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m8FBABXk006365
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 07:10:11 -0400
Received: from ey-out-1920.google.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m8FB9Ma0026408
	for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 11:09:23 GMT
Received: by ey-out-1920.google.com with SMTP id 4so898597eyg.30
        for <selinux@tycho.nsa.gov>; Mon, 15 Sep 2008 04:10:09 -0700 (PDT)
Subject: Re: user guide draft: "Confined and Unconfined User Domains" review
From: Dominick Grift <domg472@gmail.com>
To: Murray McAllister <mmcallis@redhat.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, James Morris <jmorris@namei.org>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <48CDBA0A.3000801@redhat.com>
References: <48C6236D.4020408@redhat.com> <48C67DCD.2030104@redhat.com>
	 <48CDBA0A.3000801@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-NEQhiDL0Hh51Z9auMvri"
Date: Mon, 15 Sep 2008 13:10:07 +0200
Message-Id: <1221477007.13007.13.camel@sulphur.notebook.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-NEQhiDL0Hh51Z9auMvri
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2008-09-15 at 11:27 +1000, Murray McAllister wrote:

> Hi,
>=20
> I have made some changes:
>=20
> Confined and Unconfined Users
>=20
> Each Linux user is mapped to an SELinux user via SELinux policy. This

I would call it SEinux user group because you can map several users to
the same SELinux user group.
> =20
> allows Linux users to inherit the restrictions on SELinux users. By=20
> default, on Fedora 10, Linux users are mapped to the SELinux

I would say the Linux users are by default mapped to the __default__
login, which (usually) in Fedora is mapped to unconfined_u SELinux user
group.

Please note though that currently __default__ login is mapped to user_u
SELinux usr group in rawhide. You can verify this in rawhide by semanage
login -a. I do not now if this can be considered a bug.

> =20
> unconfined_u user. This Linux user mapping is seen by running the=20
> /usr/sbin/semanage login -l command as the Linux root user:
>=20
> # /usr/sbin/semanage login -l
>=20
> Login Name                SELinux User              MLS/MCS Range
>=20
> __default__               unconfined_u              s0-s0:c0.c1023
> root                      unconfined_u              s0-s0:c0.c1023
> system_u                  system_u                  s0-s0:c0.c1023
>=20
> The following defines the default-mapping:
>=20
> __default__               unconfined_u              s0-s0:c0.c1023
>=20
> The following example demonstates adding a new Linux user, and that=20
> Linux user being mapped to the SELinux unconfined_u user:
>=20
> 1. As the Linux root user, create a new Linux user named newuser:
>=20
> # /usr/sbin/useradd newuser

This may in many cases be right however in SELinux world root is not all
powerfull by itself. in this example you assume that root runs in the
unconfined_t domain, which it does by default however one can run root
in other domains as well.

> 2. As the Linux root user, assign a password to the Linux newuser user:
>=20
> # passwd newuser
> Changing password for user newuser.
> New UNIX password: Enter a password
> BAD PASSWORD: it is based on a dictionary word
> Retype new UNIX password: Enter the same password again
> passwd: all authentication tokens updated successfully.
>=20
> 3. Log out of your current session, and log in as the Linux newuser user.
>=20
> 4. When you log in, pam_selinux maps the Linux user to an SELinux user=20
> (in this case, unconfined_u), and sets up the resulting SELinux context.=20
> The Linux user's shell is then launched with this SELinux context. To=20
> view the SELinux context for a Linux user, run the id -Z command:
>=20

That is if __default__ login is mapped to unconfined SELinux user group.

> [newuser@localhost ~]$ id -Z
> unconfined_u:unconfined_r:unconfined_t:s0-s0:c0.c1023
>=20
> If mcstrans is running, s0-s0:c0.c1023 is translated to=20
> SystemLow-SystemHigh:

I am not sure if by default that user is assigned all categories.

> [newuser@localhost ~]$ id -Z
> unconfined_u:unconfined_r:unconfined_t:SystemLow-SystemHigh
>=20
> Confined and unconfined Linux users are subject to executable and=20
> writeable memory checks, and are also restricted by MCS (and MLS, if the=20
> MLS policy is used). If unconfined Linux users execute an application=20
> that SELinux policy defines can transition from the unconfined_t domain=20
> to its own confined domain, unconfined Linux users are still subject to=20
> the restrictions of that confined domain. The security benefit of this=20
> is that, even though a Linux user is running unconfined, they can not=20
> override the SELinux policy for a confined application, just because=20
> they (the user) are unconfined.
>=20
> The following confined SELinux users are available in Fedora 10:
>=20
> [ I have put most of this into a table, with with colums: User, Domain,=20
> X Window System, su and sudo, Execute in home directory and /tmp,=20
> Networking, and used ticks+crosses to minimize too much text]
>=20
> * Linux users in the guest_t, xguest_t, and user_t domains can only run=20
> set user ID (setuid) applications if SELinux policy permits it (such as=20
> passwd). They can not run the su and /usr/bin/sudo setuid applications,=20
> and therefore, can not become the Linux root user with these applications=
.
>=20
> * Linux users in the guest_t domain have no network access.
>=20
> * The only network access Linux users in the xguest_t domain have is=20
> Firefox connecting to web pages.
>=20
> * By default, Linux users in the guest_t, xguest_t, and user_t domains=20
> can not execute applications in their home directories or /tmp/,=20
> preventing them from executing applications (which inherit users'=20
> permissions) in directories that they have write access to. This=20
> prevents flawed or malicious applications from modifying files users' own=
.
>=20
> * Linux users in the guest_t can only log in via a terminal (including=20
> ssh).
>=20
> * Linux users in the xguest_t, user_t and staff_t domains can log in via=20
> the X Window System and a terminal.
>=20
>=20
> Thanks for your help.
>=20
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov =
with
> the words "unsubscribe selinux" without quotes as the message.
--=20
Dominick Grift <domg472@gmail.com>

--=-NEQhiDL0Hh51Z9auMvri
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkjOQokACgkQL00QnzrVtlxCXwCfbOd2sBP7P/AVlqIAaBUDwuvG
f+oAnjsp3Bka+uQ13ii6MKjo5TB6govz
=y04C
-----END PGP SIGNATURE-----

--=-NEQhiDL0Hh51Z9auMvri--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
