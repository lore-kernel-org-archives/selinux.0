Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4EJ0nRb013534
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 15:00:49 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id i4EJ0kMi002444
	for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 19:00:46 GMT
Received: from gorn.pebenito.dhs.org (c-24-15-25-98.client.comcast.net [24.15.25.98])
        by jazzband.ncsc.mil  with ESMTP id i4EJ0ipI002437 for <selinux@tycho.nsa.gov>; Fri, 14 May 2004 19:00:45 GMT
Subject: Re: X policy classes
From: Chris PeBenito <pebenito@gentoo.org>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <jbrindle@snu.edu>,
   SELinux Mail List <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Eamon Walsh <ewalsh@epoch.ncsc.mil>
In-Reply-To: <1084556829.18592.5.camel@moss-spartans.epoch.ncsc.mil>
References: <40A464EB.5030008@snu.edu>
	 <1084536340.17741.15.camel@moss-spartans.epoch.ncsc.mil>
	 <40A5014A.9060400@snu.edu>
	 <1084556829.18592.5.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZbYhNkv2xIVcMvI64TmC"
Message-Id: <1084561241.7518.222.camel@gorn.pebenito.net>
Mime-Version: 1.0
Date: Fri, 14 May 2004 14:00:41 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ZbYhNkv2xIVcMvI64TmC
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-05-14 at 12:47, Stephen Smalley wrote:
> Hmmm...applying that diff now will perturb the values of the X window
> classes, requiring regeneration of the libselinux headers that went out
> in the release we just made and requiring a rebuild of any modified X
> servers upon a migration from libselinux-1.12 to any newer version.  How
> much trouble is it for you to relocate the pax definition after the X
> classes and migrate your users?

Yeah, we can just move the PaX stuff after the X classes.  We won't be
releasing a policy with the new X classes for a while anyway.

One thing I noticed was that when I regenerated the headers from the
policy flask dir, there were several differences between those, and the
ones that are in the mainline kernel's security/selinux/include
directory.  I'm not referring to the new devnull stuff, the SE-X, or our
PaX stuff, but in the current classes.  I came up with:

 /etc/security/selinux/src/policy/flask/av_perm_to_string.h     |    7
 /etc/security/selinux/src/policy/flask/av_permissions.h        |  467 ++++=
+-----
 /etc/security/selinux/src/policy/flask/flask.h                 |    3
 /etc/security/selinux/src/policy/flask/initial_sid_to_string.h |    1
 4 files changed, 242 insertions(+), 236 deletions(-)

Wouldn't these mismatches cause problems?

--=20
Chris PeBenito
<pebenito@gentoo.org>
Developer,
Hardened Gentoo Linux
Embedded Gentoo Linux
=20
Public Key: http://pgp.mit.edu:11371/pks/lookup?op=3Dget&search=3D0xE6AF924=
3
Key fingerprint =3D B0E6 877A 883F A57A 8E6A  CB00 BC8E E42D E6AF 9243

--=-ZbYhNkv2xIVcMvI64TmC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBApRdZvI7kLeavkkMRAjR4AKCNGt81W2c5KbV1HAw70oMxjx0GwQCfTgDg
OLwpOUnFdztXBTwlB5Qs4+M=
=MvHE
-----END PGP SIGNATURE-----

--=-ZbYhNkv2xIVcMvI64TmC--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
