Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m951VJSI002670
	for <selinux@tycho.nsa.gov>; Sat, 4 Oct 2008 21:31:19 -0400
Received: from twinlark.arctic.org (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m951VJYR028130
	for <selinux@tycho.nsa.gov>; Sun, 5 Oct 2008 01:31:19 GMT
Message-ID: <48E818C0.3080109@kernel.org>
Date: Sat, 04 Oct 2008 18:30:40 -0700
From: "Andrew G. Morgan" <morgan@kernel.org>
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: Eric Paris <eparis@redhat.com>, James Morris <jmorris@namei.org>,
        linux-kernel@vger.kernel.org, sds@tycho.nsa.gov, selinux@tycho.nsa.gov
Subject: Re: [PATCH] capability: WARN when invalid capability is requested
 rather than BUG/panic
References: <1222782946.28251.63.camel@localhost.localdomain> <alpine.LRH.1.10.0810010008130.2068@tundra.namei.org> <1222785389.28251.83.camel@localhost.localdomain> <20080930153820.GA28616@us.ibm.com> <1222790843.28251.92.camel@localhost.localdomain> <20080930162830.GB31779@us.ibm.com>
In-Reply-To: <20080930162830.GB31779@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Serge E. Hallyn wrote:
> Andrew Morgan, any opinions?

[Sorry to get to this late.]

I'd prefer:

3) BUG_ON(!cap_valid(flag)) (garbage in BUG out, no panic)

It seems absurd to be guessing what a buggy driver might be wanting -
open source or not.

>> idea of mutating the inputs and then making the security decision based
>> on that mutation rather than on the original inputs (and yes, I realize
>> that exactly what 2.6.24 was doing)

and let's call it another bug fixed.

>>> Though I still think it's not unreasonable to simply ask for the driver
>>> to be fixed.
>> I'm not going to argue that the driver needs fixed and that is the real
>> problem.  I know its been filed with them and the response was that
>> there is no support for linux.  I have today tried to poke the path I
>> know of between Red Hat and them to ask them to take a look.

if distributions want to silently work around it (with some sort of
variant of 4 or perhaps 2) until the vendor of this driver has time to
fix it, then that doesn't seem unreasonable. But it seems to me that the
upstream kernel shouldn't institutionalize this sort of nonsense.

Cheers

Andrew
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFI6Bi9+bHCR3gb8jsRArIBAKCuODkju29dCosHWPiXZVKoNP0FSwCaAzPx
EWihO1+F0qd0BFZarm/CFKM=
=HJik
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
