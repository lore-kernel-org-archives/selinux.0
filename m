Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1B8omrk032758
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 03:50:48 -0500
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id n1B8okBb013007
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 08:50:47 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: Question about su
Date: Wed, 11 Feb 2009 16:50:29 +0800
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3699500.Yj3ZTiVvib";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200902111650.39754.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart3699500.Yj3ZTiVvib
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

As I am working again on adjusting the reference policy to my distro I have=
=20
run into a problem with su that raised the following question:

What use is su if a normal user after running su is still user_u:user_r:use=
r_t=20
and thus has no permissions to do stuff?

Sure, he's root, but as because of SELinux that alone isn't worth much, as=
=20
being user_u still limits the user's options pretty much.

Is there anything I misunderstand here? I don't think there should be an=20
automtic transition from user_r to sysadm_r, and newrole-ing this doesn't w=
ork=20
as user_u doesn't have the sysadmin-role.

So, what the heck is the use of su on a SELinux-system?

To give you a little overview on what I am trying to do here with my system:
I have configured the policy to be MLS, thus split up powers to different=20
roles.
root can compile a new policy in sysadm_r, but needs to be secadm_r to load=
=20
it.
Regular users can compile stuff, root can't (at least not as sysadm_r, I mi=
ght=20
enable this for staff_r and then require sysadm_r to the install-process).

But for now the problem really is that su to me seems pretty useless right=
=20
now.

Thanks and best regards,
Dennis

--nextPart3699500.Yj3ZTiVvib
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmSkV8ACgkQ1sXw8/2VziR2KwCbB2sMk9Ie9sK4Rmi2WPMzAAcm
e24Anid8HlkixUatgKJV0Jejx+xU+0j+
=/czH
-----END PGP SIGNATURE-----

--nextPart3699500.Yj3ZTiVvib--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
