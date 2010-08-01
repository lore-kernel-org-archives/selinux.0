Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id o71FZvOp013344
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 11:35:57 -0400
Received: from mail-gw0-f53.google.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id o71FZpuB021572
	for <selinux@tycho.nsa.gov>; Sun, 1 Aug 2010 15:35:51 GMT
Received: by gwb1 with SMTP id 1so1333524gwb.12
        for <selinux@tycho.nsa.gov>; Sun, 01 Aug 2010 08:35:54 -0700 (PDT)
Message-ID: <4C55942D.9010509@gmail.com>
Date: Sun, 01 Aug 2010 11:35:09 -0400
From: Ralph Blach <chipper19522@gmail.com>
MIME-Version: 1.0
To: Jason Axelson <jaxelson@referentia.com>
CC: selinux@tycho.nsa.gov
Subject: Re: semanage
References: <4C4F77D6.1080700@chipblach.net> <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com>
In-Reply-To: <AANLkTin+L3kZFqLzsy8ioQze7nD3Vf45C+TPrcAYnm38@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Thanks for the hint, now how do I find out which policies contain which
ports ?

Thanks

Chip

On 07/27/2010 08:29 PM, Jason Axelson wrote:
> On Tue, Jul 27, 2010 at 2:20 PM, Ralph Blach <chipper19522@gmail.com> wrote:
>> how do I use semanage to list the policy modules.
> 
> Hi Chip,
> 
> Perhaps you are looking for "semodule -l"? That will list out all the
> installed policy modules (besides base).
> 
> Jason
> 

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJMVZQnAAoJEI46azFTGsehxt4P/3W2xUW9eUZ7w4y09EuxRMSf
8TmTSlp+yfWNfzq5ps9VuduJj6xf+vl8B6FRSswvj6U8QT1Kg/REo71FhIuGlW15
dKk7LMfVrWgRyx3SEYzl42jwCPgn9K/oXiDz71pAG92rmc3srMyN17wGwZKveXsE
vq85UgjvR5CnxmyjpUni/boAxg21Uj8VBTe7QfqXyFN0gbJ/4aZvAwTlGr3QJpdT
G+y9GO46e+UFMJ9lwyqzIjjtOSFW1HYqJzjlTw0Xqqu+mGPm9SU6wLNKTN98RrfO
h2eIoaSXK+URav4PqO9L/rmEimUrbF3Ox5Hxg5/cZSC0tX10rNoRkrOYFt3mVRMc
08KeURJ+/gsDfsNiyii7uPfDu0asOfGo4peRgCy91azc2FdRsGQpj9QU6tXgUP0l
9ALz5UvEXVELG2pWzIB9Q7TLCeSnLsEB21nox8zWGBGZWo2a0ntJJt7THMODEwI+
1LZFQnfRfjnYNVabuX0H2nLe5akp9irsUPuCI22q5JgAyyWKGvJ5dSR3G4/NG5yh
qDBGTytsGqETREHAdwlaMCsP3zhslvSmr3pfUqeWdDBmL7tXhgCsMpA1/JP9prTf
SwG6E+kPJ1+xZ8fBmqTC9PLfz57NK44a3QuQg/hnaCylXHntlO37wfBVmd15BSYO
rz7y7Z4/85JFIlG+Uy80
=d8BN
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
