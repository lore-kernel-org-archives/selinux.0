Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAG8unIi028887
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 03:56:49 -0500 (EST)
Received: from passage.avira.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAG8tKAa011510
	for <selinux@tycho.nsa.gov>; Tue, 16 Nov 2004 08:55:22 GMT
Message-ID: <4199C7EE.7080605@gentoo.org>
Date: Tue, 16 Nov 2004 11:27:10 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Thomas Bleher <bleher@informatik.uni-muenchen.de>
CC: selinux@tycho.nsa.gov
Subject: Re: gentoo diff for snmpd
References: <4198D752.2020405@gentoo.org> <20041116081610.GA2546@jmh.mhn.de>
In-Reply-To: <20041116081610.GA2546@jmh.mhn.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig027101C95639A90CB4D19796"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig027101C95639A90CB4D19796
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi Thomas,

Thomas Bleher wrote:
> * petre rodan <kaiowas@gentoo.org> [2004-11-15 18:04]:
> 
>>gentoo as a special context for /proc/net:
>>genfscon proc /net  system_u:object_r:proc_net_t
> 
> 
> This seems generally useful.
> Care to provide a patch which adds this genfscon line plus the necessary
> policy?
> 
> Thomas

Chris is currently working on a base-policy patch that will be sent here. I'm not sure if that will also contain proc_net-related rules.

If he wants it, I can come up with a diff about this issue.

bye,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig027101C95639A90CB4D19796
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFBmcfuGSBEIeh4AEYRAgK8AJ4uqeKo3XpBsoevD5gABqttojaURQCY0b9J
7eJodyp3SZegLdICiPMFdQ==
=zLfm
-----END PGP SIGNATURE-----

--------------enig027101C95639A90CB4D19796--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
