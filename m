Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG8hnIi028845
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 03:43:49 -0500 (EST)
Received: from passage.avira.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG8hpFO004006
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:43:52 GMT
Message-ID: <4199C4CC.5030102@gentoo.org>
Date: Tue, 16 Nov 2004 11:13:48 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>, selinux@tycho.nsa.gov
Subject: Re: gentoo policy for dante
References: <4198E94B.8070008@gentoo.org> <20041116082954.GC2546@jmh.mhn.de>
In-Reply-To: <20041116082954.GC2546@jmh.mhn.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig69EC1B4EF015C53C695A40B0"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig69EC1B4EF015C53C695A40B0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi Thomas,

Thomas Bleher wrote:
> * petre rodan <kaiowas@gentoo.org> [2004-11-15 19:35]:
> 
>>policy for dante [1], attached
>>
>>
>>type socks_port_t, port_type;
> 
> 
> The net_contexts part is missing.
> 
> Apart from the issues mentioned in my mails, all policies look very
> fine.
> 
> Thomas

the port the daemon binds to is configurable, but according to RFC 1700, socks should go to 1080.

so we have in the net_contexts:
ifdef(`dante.te', `portcon tcp 1080 system_u:object_r:socks_port_t')

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig69EC1B4EF015C53C695A40B0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBmcTeGSBEIeh4AEYRAjZyAJ4glVW7yLMziRFD0ixyNxptZTbsOQCfeLxC
WHYHAl3896NvfBhW2L5QLHQ=
=M741
-----END PGP SIGNATURE-----

--------------enig69EC1B4EF015C53C695A40B0--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
