Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j6T6FNgA027782
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 02:15:25 -0400 (EDT)
Received: from estila.tuxedo-es.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j6T68ZhF012677
	for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2005 06:08:36 GMT
Subject: RE: SELinux for embedded devices...
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: "Sriram, Kannan" <ksriram@ti.com>
Cc: SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <45F366B1BC4F7C4A895F0F34C41E61A55113E1@dbde01.ent.ti.com>
References: <45F366B1BC4F7C4A895F0F34C41E61A55113E1@dbde01.ent.ti.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ipaLh4eQ/8Axm6xBgxeX"
Date: Fri, 29 Jul 2005 08:09:24 +0200
Message-Id: <1122617364.14844.51.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-ipaLh4eQ/8Axm6xBgxeX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

El vie, 29-07-2005 a las 10:17 +0530, Sriram, Kannan escribi=F3:
> Lorenzo,
>=20
>  First of all, thanks for the tip and insights!

My pleasure.

> > Also, what do you mean my "tamper-proof" in this context? Physically
> > protecting the chip which serves as storage for it? That sounds strange=
.
>=20
> By tamper-proofing, I mean that the kernel image that is on the flash
>  device cannot be altered - any image on the flash (bootloader, kernel,
>  etc) carries a cryptographically signed certificate (by the OEM of the
>  phone, using private key, of a public/ private pair), and the system
>  does not boot up if the certificate of the image is invalid. A "trust
>  chain" is constructed this way - boot ROM (not alterable)
>  authenticates the boot loader, boot loader then authenticates the
>  kernel and so on...

Well, I have some doubts on this. I'll try to organize the questions
from most trivial ones to others with more complexity.

 1) What type of firmware, engine or booting system you can use that:
reads a key (even PKI-inspired/based), checks boot media integrity, boot
loader turns control over the real boot loader which loads kernel at
memory, and then you're done? Apart of the complexity of such approach,
I seriously doubt it's reliable both technically and in terms of
available resources. That is, how do you want to do this in a embedded
device such a smart-phone or those with a very limited memory and
processing capability? Simple things tend to be less prone to errors...

 2) On the other hand, we have a certificate which is stored in the same
"image" (the term sounds quite confusing to me in this context) as the
kernel being loaded. What about poisoning the certificate?  Also,
against what you will certify the trustworthiness of the certificate
itself? If it relies on internal data it might as well accessible for
poisoning.

 3) How do you separate firmware, kernel image, file-system data and
integrity verification engine + data?


> Are their any caveats to this? If I can make the root to be a
>  non-privileged user, how can kernel modules be insmod'ed?=20

They shouldn't be introduced in kernel space after initialization.
Loadable kernel modules are weak by design and common target of a wide
range of infection/injection techniques which go from redirection
(hijacking) internal functions to other weird things like run-time
kernel patching.

Anyways, users with access to the sysadm_r role would be allowed to do
such operations.

> Sorry, I
>  know I can dig through the sources and find out how this is handled,
>  but any handholding at this study stage (for me) would be very
>  helpful.

Well, the documentation is maintained at the NSA website section for
SELinux and it's quite well structured, enough to make it a straight
forward reading. It's best to read the documentation first and then come
with concrete questions which we (everyone of us, subscribers of the
list, etc) can answer properly.

> Should I be creating one more privilege level and assign it
>  to a "central authority", purely for dealing with the setup and
>  configuration of the security policies itself (for example, the
>  network operator/carrier or some such entity)?

SELinux is not about a CA-based model, in any case.
You should just rely on roles. For example, security officer, user,
admin, operator, etc. I think you should mature your idea a bit more. It
might be an interesting literature for the case, the Simone
Fischer-H=FCbner  privacy model documentation (it's always good to talk
also about others' projects when they are well-done) already implemented
by the RSBAC folks. Sidenote: RSBAC hasn't been tested in the embedded
devices scenarios nor in other scenarios like multi-processor machines
with a certain level of complexity.

> Pls note that we are
>  trying to make the person with "physical access to the system" to be
>  able to do whatever a "privileged user" can do, but at the same time,
>  just not give enough power for configuration of the security policy
>  itself, without authorization.

Ironically, someone with physical access to the device can do literally
anything with minimal knowledge on electronics. As I said, everything is
important when talking about security, and more with the physical
factor. I would recall on Nokia and Siemens as examples. They don't
apply the typical obscurity techniques to mobile phones (ie. covering
the circuits with another layer of black, opaque material. Same as the
AlphaShield manufacturer did in the past, and maybe still does. It's
weird but works).

You need to truly assure both software-level and hardware-level
security.

> Does SELinux require a writeable filesystem always?

Try to remount / as read-only in any machine, be it running SELinux or
not.

>  What if I want to use CRAMFS which is a ReadOnly system?=20

CramFS is not intended for this, nor others like SquashFS. I don't know
a lot about these file-systems, anyways. I just know they're not for
your purposes.

> Also, do you
>  think that filesystem related issues will be the most important issues
>  to live with?=20

One of the most important ones, definitely.

> I'm asking this because there are only a countable
>  number of FS variants for embedded systems AFAIK, so we can *maybe*
>  take them on one at a time.

Or end up doing one at our own...

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-ipaLh4eQ/8Axm6xBgxeX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBC6cgUDcEopW8rLewRAqo/AJ9MSacdrtgC9WNAXrLSxv2eekO16wCdGi0x
U63VU196FGrxuWMyB4Uc1Gk=
=RDio
-----END PGP SIGNATURE-----

--=-ipaLh4eQ/8Axm6xBgxeX--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
