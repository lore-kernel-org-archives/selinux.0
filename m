Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i98F2xrT022190
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 11:02:59 -0400 (EDT)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i98F1lBk004656
	for <selinux@tycho.nsa.gov>; Fri, 8 Oct 2004 15:01:50 GMT
Message-ID: <4166AC69.1010306@gentoo.org>
Date: Fri, 08 Oct 2004 18:04:09 +0300
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for ntpd
References: <41625A62.7080609@gentoo.org> <41629E45.8050107@gentoo.org> <4163CDD3.3@gentoo.org> <200410071702.33618.russell@coker.com.au>
In-Reply-To: <200410071702.33618.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE2BF0B9AA44C6C85C9A9176A"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE2BF0B9AA44C6C85C9A9176A
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi Russell,

Russell Coker wrote:
> On Wed, 6 Oct 2004 20:49, petre rodan <kaiowas@gentoo.org> wrote:
> 
>>this is a new diff with distro_gentoo ifdefs dropped.
>>also, logrotate is not part of the gentoo base-policy and it shouldn't be a
>>dependency for ntpd, so I'm also ifdef-ing that.
> 
> 
> Having daemon binaries in /usr/bin instead of /usr/sbin is a bug.
> 
> ntpd and ntpdate can not be used by regular users, they can only be used by 
> the administrator.  Therefore any distribution that follows the LSB (or the 
> FHS which the LSB is based on) will put them in /usr/sbin.

You are correct. I have sent patches to gentoo bugzilla and upstream.
Let's hope at least one of those will like the idea.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enigE2BF0B9AA44C6C85C9A9176A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBZqxwGSBEIeh4AEYRAkOEAJ9YKxwYa9JN27Uo1ItoSTrBs8LemwCgi+fh
4qNxzrsE/qsWQlgk9zEHH1Y=
=BNLi
-----END PGP SIGNATURE-----

--------------enigE2BF0B9AA44C6C85C9A9176A--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
