Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5HBrZgA008171
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 07:53:35 -0400 (EDT)
Received: from estila.tuxedo-es.org (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5HBim1R013451
	for <selinux@tycho.nsa.gov>; Fri, 17 Jun 2005 11:44:48 GMT
Subject: Re: [RFC]Kernel Built-in IDS extension
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: horietk@nttdata.co.jp
Cc: selinux@tycho.nsa.gov
In-Reply-To: <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
References: 
	 <E6ACF5196CB5AA4FB50C32559083A36901633F01@MAILSV12.msg.nttdata.co.jp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WfcBbOxwF0QgwwAeoKte"
Date: Fri, 17 Jun 2005 13:44:46 +0200
Message-Id: <1119008686.8987.80.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-WfcBbOxwF0QgwwAeoKte
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 17-06-2005 a las 18:16 +0900, horietk@nttdata.co.jp escribi=F3:
> The extensions have following features.
> 1. Detecting the access violation and can log that trial.
> 2. Operating booleans of 'Conditional Policy' when the access violation=20
> is detected.
> 3. Kernel built-in implementation. All the detections and the operations=20
> are performed within kernel.
> 4. To specify access contexts to be detected and boolean variables to be=20
> turned on, extended policy notation was introduced, which resembles the=20
> 'allow' statement.

As far as I have looked over it, it looks nice and useful, but as
everything does, it has some shortcomings.

> I believe that these features are useful in some cases.
> For examaple, it is possible to detect harzardous access context which=20
> appears only when malicious operation is tried and to apply more=20
> restricted policy by means of turning on booleans automatically.

There's a main problem regarding this implementation: false positives
and trapping limited to the end of the execution flow.

On the first it's just that, used in a messy manner and configured
improperly it would cause what any IDS can do: take the least
possibility as a great attack vector (ie. some commercial products that
try to catch up strings inside the requests against a web server, some
like "exec", "bash", etc).

On the latter: you're looking only at your side (in this case, you catch
the end of the attack). Not all the vulnerabilities will lead to
spawning a shell, there are many other areas of interest for the
attacker (ie. in format string handling bugs retrieving potentially
confidential information and, if well prepared and designed, lead the
application to return itself to the point where the execution flow was
crafted to catch up such confidential information).

In some cases, it won't be necessary for the attacker to execute an
arbitrary instruction in the right time, but only to force the
application itself to execute *code of it's own* at the wrong time, with
the wrong information.

If the above statement sounds confusing, let's try to clarify: if the
XYZ application is compromised by using a specifically designed attack
vector (ie. the attacker knows well the relevant information to exploit
the vulnerability at issue and has enough access and time to verify that
it will be successful), which doesn't make use of external
instructions/code/what-ever-else you call it, but leads the execution
flow to return to a foo() function which may rewrite a critical memory
area, and such area will be read by the function which was compromised,
does your kernel-land IDS trap the trick? Not at all (if there's no
policy that determines at runtime which memory areas the application
will need to protect, at the exact and right time, and how it will need
to un-protect them depending on the action to be performed. That is,
something pretty complex which would lead to have in mind the whole
specification of the architecture being used, the memory management code
and the segmentation for user-land application, and a long etc of other
really-weird-and-painful-complex stuff which makes it no worth effort,
but another reason for taking care at coding the user-land applications
themselves).

I don't say this a common case, but there are many cases, either
publicly available or not, that demonstrate that in such cases, IDS and
other so-called "Proactive security" technologies are useless.

I've written a little patch [1] for making IBM Stack Smashing Protector
(aka ProPolice) able to use kernel-land helpers for trapping the stack
smashing events caused by the implementation itself (currently it's only
implemented in libssp [2]), hence making possible to integrate it in a
near future with SELinux or any other thing relying in the Linux
Security Modules framework. but it's just an example of how "defense in
depth" would need to be deployed widely, and not only in small bits
inside the kernel (no mention to the possible overhead caused by
implementing an IDS in kernel space, on top of the SELinux overhead,
which is minimal indeed).

Anyways, great work. Keep it up.

[1]:http://pearls.tuxedo-es.org/patches/ssp-propolice/propolice_kernel_help=
ers.patch
(It might not work correctly for sparc, as I didn't take a lot of care
regarding the implementation for any other arch. rather than ia32/i386
and I couldn't test it under other architectures)
[2]: http://pearls.tuxedo-es.org/papers/libssp.pdf

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-WfcBbOxwF0QgwwAeoKte
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCsreuDcEopW8rLewRAnZeAJ9YMYarftx8rr+5FIX3JkT2N9QlyQCfa6I1
SInDG6eufunbnSO25Ut83+U=
=PpBM
-----END PGP SIGNATURE-----

--=-WfcBbOxwF0QgwwAeoKte--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
