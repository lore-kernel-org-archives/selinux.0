Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7IDc8rT020200
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 09:38:08 -0400 (EDT)
Received: from wowbagger.gapholdings.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7IDbSho013914
	for <selinux@tycho.nsa.gov>; Wed, 18 Aug 2004 13:37:28 GMT
Date: Wed, 18 Aug 2004 09:43:52 +0000
From: Eric Andreychek <Eric.Andreychek@rwcwarranty.com>
To: SELinux@tycho.nsa.gov
Subject: Re: Port Binding Being Allowed
Message-ID: <20040818094352.GG19197@rwcwarranty.com>
References: <200408171523.21707.steven.harp@adventiumlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <200408171523.21707.steven.harp@adventiumlabs.org>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Howdy,

On Tue, 17 Aug 2004, Steven Harp wrote:
> Suggest making sure the CONFIG_SECURITY_NETWORK security option 
> in the kernel build has been enabled.  Curiously, this is off
> by default in this config....

Aha!

After enabling that and rebooting, port binding is restricted as expected:

 $ nc -l -p 9001
 Can't grab 0.0.0.0:9001 with bind : Permission denied

Thanks for your help!
  -Eric

- -- 
Eric Andreychek
Residential Warranty Corporation
(717) 561-4480 x2245
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBIyTYR5UKaDAjAG4RAkG5AJ9vdbJgh6N9Ilme3aLmUzcVezTUHQCfSa2q
/y3d47Cly1UyR95AdQCIIRg=
=Ct6T
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
