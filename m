Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG94VIi028951
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 04:04:31 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG934Aa011615
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 09:03:04 GMT
Message-ID: <4199C9BD.1020806@gentoo.org>
Date: Tue, 16 Nov 2004 11:34:53 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo policy for stunnel
References: <4198D4CA.3020708@gentoo.org> <20041116082800.GB2546@jmh.mhn.de>
In-Reply-To: <20041116082800.GB2546@jmh.mhn.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig96833B869901C3025B03B20C"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig96833B869901C3025B03B20C
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Thomas Bleher wrote:
> * petre rodan <kaiowas@gentoo.org> [2004-11-15 17:51]:
[..]
>>type stunnel_port_t, port_type;
> Are there any default ports for stunnel? If yes, can you provide a patch
> to net_contexts? If no, it would be nice to have a line like "to use
> stunnel for IMAP, add the following line to net_contexts..." and so on.

as you have correctly guessed, there is no default port whatsoever for this daemon.

since it's up to the user to assign the label to his particular port net_contexts might contain a
#ifdef(`stunnel.te', `portcon tcp xxxx system_u:object_r:stunnel_port_t')

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig96833B869901C3025B03B20C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmcm9GSBEIeh4AEYRAnNSAJ9h2sV4UQYe9MYUb9C5VlSDHYdf/gCeNerW
mP7Zqmoar2ktpCz4WWOK6KE=
=RMUD
-----END PGP SIGNATURE-----

--------------enig96833B869901C3025B03B20C--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
