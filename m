Message-ID: <41E576BF.8020404@gentoo.org>
Date: Wed, 12 Jan 2005 21:13:03 +0200
From: petre rodan <kaiowas@gentoo.org>
MIME-Version: 1.0
To: Park Lee <parklee_sel@yahoo.com>
CC: SELinux@tycho.nsa.gov
Subject: Re: SELinux with IPSec - something going on ?
References: <20050112170231.39090.qmail@web51502.mail.yahoo.com>
In-Reply-To: <20050112170231.39090.qmail@web51502.mail.yahoo.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3479274DED62DC67FF641AF3"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3479274DED62DC67FF641AF3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Hi,

Park Lee wrote:
> On 2004-10-25 at 15:51, petre rodan wrote:
>
>>Hi,
>>here is a fresh ipsec-tools [1] policy made for
>>gentoo. works flawlessly with my setup [2] (the doc
>>is work in progress).
>>
>>[1] http://ipsec-tools.sourceforge.net/
>>[2] http://dev.gentoo.org/~kaiowas/doc/wifi_ipsec-
>>howto.html
>>
>>is this usable for any of you?
>
>
> In racoon.fc, you wrote:
>
>   ... ...
> /var/run/pluto\.ctl	-s
> system_u:object_r:racoon_var_run_t
>   ... ...
>
> But, when we use IPsec-Tools, it seems that there is
> no such a file (i.e. /var/run/pluto.ctl). Then, Why
> should we write this rule for it?

you are correct, that rule should be removed.
it's a leftover from the prior implementation

thanks,
peter

--
petre rodan
<kaiowas@gentoo.org>
Developer,
Hardened Gentoo Linux

--------------enig3479274DED62DC67FF641AF3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFB5Xa/GSBEIeh4AEYRAjjkAJ4pU/KqaK+6oE/fM2wX8WYq3iM3AACffTpn
BwEZKp8XXlDr8ggYvAieYWw=
=vU6Z
-----END PGP SIGNATURE-----

--------------enig3479274DED62DC67FF641AF3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
