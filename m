Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n89DJun0017950
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 09:19:56 -0400
Received: from relay.felk.cvut.cz (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n89DLGkE002958
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 13:21:16 GMT
Received: from labe.felk.cvut.cz (labe.felk.cvut.cz [147.32.85.34])
	by relay.felk.cvut.cz (8.14.3/8.14.3) with ESMTP id n89DJZ8o054477
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 15:19:35 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Received: from [147.32.84.251] ([147.32.84.251])
	by labe.felk.cvut.cz (8.13.8/8.13.8) with ESMTP id n89DJZm1069223
	for <selinux@tycho.nsa.gov>; Wed, 9 Sep 2009 15:19:35 +0200 (CEST)
	(envelope-from michal.svoboda@agents.felk.cvut.cz)
Date: Wed, 9 Sep 2009 15:19:35 +0200
From: Michal Svoboda <michal.svoboda@agents.felk.cvut.cz>
To: selinux@tycho.nsa.gov
Subject: Re: MCS and default labels
Message-ID: <20090909131935.GF24297@myhost.felk.cvut.cz>
References: <20090908055806.GA24297@myhost.felk.cvut.cz>
 <1252424128.13634.404.camel@moss-pluto.epoch.ncsc.mil>
 <20090908163628.GC24297@myhost.felk.cvut.cz>
 <1252429805.13634.423.camel@moss-pluto.epoch.ncsc.mil>
 <20090909100647.GE24297@myhost.felk.cvut.cz>
 <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I3tAPq1Rm2pUxvsp"
In-Reply-To: <1252498660.13634.618.camel@moss-pluto.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--I3tAPq1Rm2pUxvsp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stephen Smalley wrote:
> setfscreatecon(3) specifies a security context prior to file creation.

Thanks, this might make it doable in the svn server as an alternative.

> Any change would have to support either model (inherit from source
> context or inherit from target context), so logically it would be
> policy-driven.

It can also be derived as the least upper bound of both. If c1-c1,c2
process creates file in a c2 dir, it would make sense that the new file
is c1,c2.

Alternatively it could just use the default file context from policy.

> MLS gives you the same end result (the process would be labeled s0:c1
> and thus its files would get created as such). =20

Maybe I am not seeing something after all. Suppose I use the full MLS
variant and give a user the labels c1,c2. How exactly would it happen
that in a c1 dir he would automatically create c1 files, and in c1,c2
dir c1,c2 files?

> It isn't so odd then to recommend using something other than MCS.

It was meant in the context of the article you linked, where it is
stated that the goal of MCS is to be more acceptable than MLS for
general userbase. And the contrast being that first reply that was
given to me from various sources was 'dont use MCS, use MLS'.

Regards,
Michal Svoboda

--I3tAPq1Rm2pUxvsp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkqnq2cACgkQg/fU9pp1uX4czACfXEyepza8tkwt6OvWDj46fbQX
xycAn0x2aTP2olV8Wnn0QNSzIrxMgN+V
=VDQv
-----END PGP SIGNATURE-----

--I3tAPq1Rm2pUxvsp--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
