Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iAIKwVIi016542
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 15:58:31 -0500 (EST)
Received: from sunspire.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id iAIKwW3m011427
	for <selinux@tycho.nsa.gov>; Thu, 18 Nov 2004 20:58:33 GMT
Message-ID: <419D1ABD.4020901@gentoo.org>
Date: Thu, 18 Nov 2004 23:57:17 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: SELinux <selinux@tycho.nsa.gov>
Subject: Re: gentoo policy for dante
References: <4198E94B.8070008@gentoo.org> <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1100808438.26930.28.camel@moss-lions.epoch.ncsc.mil>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF475C0B55EC403CD14B5C178"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF475C0B55EC403CD14B5C178
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi James,

James Carter wrote:
> allow dante_t initrc_var_run_t:file { getattr write };
> 
> Why does dante need this?

The current gentoo init scripts create the pid file for the daemon. This will be fixed soon.
Please drop that particular rule from the policy.

thanks,
peter

-- 
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enigF475C0B55EC403CD14B5C178
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFBnRrCGSBEIeh4AEYRAsOvAJ9R0pJy7nfeRKHMIIPpSmTLttCs9ACeNs8I
fqtdGsMfdGWbJD4EHaKwRVY=
=lhta
-----END PGP SIGNATURE-----

--------------enigF475C0B55EC403CD14B5C178--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
