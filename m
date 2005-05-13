Message-Id: <200505130553.j4D5rAHI014973@turing-police.cc.vt.edu>
To: russell@coker.com.au
Cc: Chad Sellers <cdselle@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: [RFC]{Patch 0/5] Polyinstantation 
In-Reply-To: Your message of "Fri, 13 May 2005 14:40:39 +1000."
             <200505131440.42410.russell@coker.com.au>
From: Valdis.Kletnieks@vt.edu
References: <1115825335.28084.27.camel@moss-huskies.epoch.ncsc.mil> <1115896944.32202.22.camel@moss-spartans.epoch.ncsc.mil> <1115904167.30162.7.camel@moss-huskies.epoch.ncsc.mil>
            <200505131440.42410.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1115963588_3671P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 13 May 2005 01:53:08 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1115963588_3671P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, 13 May 2005 14:40:39 +1000, Russell Coker said:
> Per user /tmp directories break the typical uses of Unix systems.  On U=
nix=20
> multi-user systems it's expected that you can copy a file to /tmp and g=
ive it
> mode 0644 to share it with other people.

Right. Unfortunately, we're swimming upstream against a quarter century
of common practice that happens to be almost =22couldn't design a worse s=
ecurity
model if we *tried*=22. A shared /tmp makes sense when everybody's in the=
 same
security domain, is essentially root anyhow, and file ownerships/permissi=
ons
are there mostly to limit friendly-fire accidents to ones *own* feet, and=
 not
the co-workers as well.  Of course, if you're deploying SELinux, you're n=
o
longer in Kansas anymore....

Is the polyinstantation addressing:

1) the fact that userB may be able to see/interfere with what userA is do=
ing
in /tmp, when userA may not desire userB doing so? (If we give userA his =
own
instance of /tmp, userB can't interfere).

2) The problem of userA intentionally using /tmp as a zone to pass sensit=
ive
data to userB, when the site security officer has other ideas? (If we giv=
e
userA his own instance of /tmp, he can't drop a file where userB can get =
it).

3) Attempting to solve both problems at the same time?

And Russell is correct - although it *does* work when A and B *shouldn't*=

communicate, we *do* need to make *some* provision for the case where use=
rs A
and B are cooperating and allowed to do so by site policy. I suspect that=

=22share via /tmp=22 won't be easily workable, but =22share via other fil=
e system
means=22 will be (we're already looking at a '=7E/Downloads' type of dire=
ctory - a
=7E/Shared perhaps?)




--==_Exmh_1115963588_3671P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFChEDEcC3lWbTT17ARAgnWAJsEZG4beL0Dbed029a1wMwxSkAwGACeLFMY
A9GXixydLiVKGlN6G222E2c=
=86Sh
-----END PGP SIGNATURE-----

--==_Exmh_1115963588_3671P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
