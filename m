Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k6SN4g86009634
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 19:04:42 -0400
Received: from rwcrmhc14.comcast.net (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k6SN4elq003111
	for <selinux@tycho.nsa.gov>; Fri, 28 Jul 2006 23:04:40 GMT
Subject: Re: mls policy
From: Chris PeBenito <pebenito@gentoo.org>
To: andy.suchoski@comcast.net
Cc: selinux@tycho.nsa.gov
In-Reply-To: <072820062151.6083.44CA86E3000E25F0000017C3220702455307059C01080C9A9CD2970B020E@comcast.net>
References: 
	 <072820062151.6083.44CA86E3000E25F0000017C3220702455307059C01080C9A9CD2970B020E@comcast.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VTM1texc6125gT4LTj9B"
Date: Fri, 28 Jul 2006 19:04:15 -0400
Message-Id: <1154127855.10967.10.camel@gorn.pebenito.net>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-VTM1texc6125gT4LTj9B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-28 at 21:51 +0000, andy.suchoski@comcast.net wrote:
> Hello all,
> I have been exploring SELinux and I am trying to figure out exactly
> what the mls=20
> policy is. I had initially thought that it was the strict policy with
> hierarchical labels added. I heard elsewhere that it was basically the
> targeted policy with hierarchical labels. But it seems to be something
> yet again different.=20
[cut]
> Once I saw that the number of types defined in the policy was closer
> with the targetedmls policy, I did some other analysis to try and
> account for the differences between them. I noticed that the mls
> (binary) policy had 47 types with the string 'secadm' in them, 49
> types with the string 'sysadm' in the type and 47 with the string
> 'auditadm' in the type. All told the targetedmls policy had a total of
> 3 types containing the string 'sysadm' with no types containing
> 'secadm' or 'auditadm'.=20
>=20
> I'm puzzled. I thought if I got the source rpm, I should be able to
> simply create the same policy as the rpm binary distribution by
> specifying the TYPE in the build.conf file.

The Fedora policies are based on reference policy [1], which has several
configuration options.  The Fedora MLS policy is strict-mls.  It is like
the Fedora strict policy (which is strict-mcs in terms of reference
policy), except with the graphical desktop policy modules turned off,
and 16 hierarchical sensitivity levels instead of 1.

There are a few settings in build.conf that need to be set, and what you
also need to make sure is that your modules.conf (which controls which
policy modules are built) is right.

You can see the files used by Red Hat on their CVS [2].

[1] http://oss.tresys.com/projects/refpolicy
[2] http://cvs.fedora.redhat.com/viewcvs/rpms/selinux-policy/FC-5/

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-VTM1texc6125gT4LTj9B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)

iD8DBQBEypfvvI7kLeavkkMRAo3ZAJ0dBhZLjQ8H+AZLADuv3tVD9Hc0oACfYvXZ
cOckU0ln00PWTFSKUA7FBW8=
=Khpb
-----END PGP SIGNATURE-----

--=-VTM1texc6125gT4LTj9B--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
