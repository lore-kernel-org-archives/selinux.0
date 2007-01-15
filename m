Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id l0F5FqMr020232
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 00:15:52 -0500
Received: from mail.and.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id l0F5GjV3015321
	for <selinux@tycho.nsa.gov>; Mon, 15 Jan 2007 05:16:45 GMT
Subject: Re: We currently have a problem with cp -a /media/cdrom  /etc
From: James Antill <jantill@redhat.com>
To: Jim Meyering <jim@meyering.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <873b6ffdi6.fsf@rho.meyering.net>
References: <45A7D773.8040800@redhat.com>
	 <1168628100.7993.525.camel@moss-spartans.epoch.ncsc.mil>
	 <1168632626.13080.212.camel@code.and.org>
	 <1168633494.7993.546.camel@moss-spartans.epoch.ncsc.mil>
	 <1168636513.13080.227.camel@code.and.org> <873b6ffdi6.fsf@rho.meyering.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-31rp1SqHd4gLdcAe/vFP"
Date: Mon, 15 Jan 2007 00:16:37 -0500
Message-Id: <1168838197.25232.9.camel@code.and.org>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-31rp1SqHd4gLdcAe/vFP
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-01-13 at 11:05 +0100, Jim Meyering wrote:

> Isn't that fsetfilecon call useful, since your example must
> also handle an existing destination file?

 Ahh, I see. I'd somehow missed the if check before the ifdef, or not
parsed what it meant.

 Note that this does mean that:

% echo me > uid
% sudo touch ouid_r ouid_w
% sudo chmod o+w ouid_w
% cp -a uid ouid_r
cp: cannot create regular file `ouid_r': Permission denied
zsh: 25994 exit 1     cp -a uid ouid_r
% cp -a uid ouid_w
zsh: 25995 exit 1     cp -a uid ouid_w


> This is a good opportunity to ask about an old note I made:
>   - is it worthwhile to check for getfscreatecon failure?
>     The documentation says it can fail, but not how.
>     Even it's truly a "can't happen" condition now, that might change.

 IIRC it:

 open's /proc/self/task/$$/attr/fscreate
 reads the data
 malloc's the correct length for the result and copies.

...either of these three operations can fail.

> I presume the lack of a diagnostic for failed fsetfilecon
> is just an oversight.

 Yeh, probably the test case above wasn't obvious so it was hard to
test.


 So any ideas on how to make cp do the right thing in all cases ?:)

--=20
James Antill <jantill@redhat.com>

--=-31rp1SqHd4gLdcAe/vFP
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFqw4111eXTEMrxtQRAunjAJ9Qt9g5rbLSsB2zqV11n89TLradewCghWY4
uxGUPAqfplXcrc4xR0uQybY=
=whZn
-----END PGP SIGNATURE-----

--=-31rp1SqHd4gLdcAe/vFP--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
