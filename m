Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k0TM8fXf027054
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 17:08:41 -0500 (EST)
Received: from estila.tuxedo-es.org (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k0TM7PQA029328
	for <selinux@tycho.nsa.gov>; Sun, 29 Jan 2006 22:07:26 GMT
Subject: Re: labeling of compilers etc
From: Lorenzo =?ISO-8859-1?Q?Hern=E1ndez_?= =?ISO-8859-1?Q?Garc=EDa-Hierro?= <lorenzo@gnu.org>
To: russell@coker.com.au
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <200601291156.13076.russell@coker.com.au>
References: <200601291156.13076.russell@coker.com.au>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-U5Zn46Z3VoUi+57KTWP4"
Date: Sun, 29 Jan 2006 23:08:37 +0100
Message-Id: <1138572517.9012.27.camel@estila>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-U5Zn46Z3VoUi+57KTWP4
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On dom, 2006-01-29 at 11:56 +1100, Russell Coker wrote:
> In many discussions about hardening systems the idea is suggested that=20
> machines should not have compilers unless they are development machines.
>=20
> It would not be difficult to label compilers as compiler_exec_t and only=20
> permit user domains the ability to execute files of such type (daemons do=
n't=20
> need to compile software).  What do you think of this idea?  Maybe we wou=
ld=20
> want to have a more generic type such as devel_exec_t and label programs =
such=20
> as gdb with it as well.

It's definitely a good idea to keep daemon-related users away of using
compilers and debuggers. Current behavior of web application worms is
related to the usage of 'wget' or other tools to get either a binary or
a source file.

Access to those resources should be limited as well.

> Also interpreters could be modified to provide similar benefits.  Current=
ly=20
> many (most?) shell interpreters try to detect and prevent setuid operatio=
n=20
> with code roughly equivalent to if(getuid() !=3D geteuid()) seteuid(getui=
d). =20
> Bash currently has such code (just done a quick test) and other shells ha=
d=20
> such cost in place last time I tested them.  I believe that this establis=
hes=20
> a precedent for shell interpreters to check for and prevent insecure mode=
s of=20
> operation.

That's TPE after all. Interpreters shouldn't load files from untrusted
sources: user home directories (although this would need exceptions),
world writable directories, etc.

> A logical extension of this precedent to SE Linux would be to have it che=
ck=20
> the type of a file to be executed and confirm that the current domain is=20
> permitted to execute scripts of the type in question, for a regular file =
it=20
> would get the context (after opening it) and ask SE Linux whether the cur=
rent=20
> context has execute access for the file class.  For a character device no=
de=20
> (IE stdin but let's not assume that's the only device to be used) it woul=
d=20
> check for execute access of class chr_file for the context in question.  =
Does=20
> it even make sense to execute a block device node as a shell script?
> In some mailing lists related to SE Linux it's been mentioned that people=
=20
> desire these features.  I believe that I have come up with a reasonable=20
> design to solve the problems in question.  If it's considered worth-while=
=20
> then I'm willing to write a policy patch for the first one and a bash pat=
ch=20
> for the second one.

I would like to help with this, although the scope is a bit more complex
than it seems. The operations that can be done by the interpreters
should be limited, not only the instructions that can be loaded from a
file. In other words, flawed interpreters can be forced to perform
potentially harmful operations.

For example, binary format parsers: archive format related tools: RAR,
tar, bzip2; binary load related tools: binutils and readelf (the kernel
itself...), image processing related tools (there has been work on this
from someone else here, Colin's IMSEP?), etc.

I'm aware of some issues affecting interpreters related to binary
formats that aren't known yet, and SELinux is for sure the way to stop
them, since some of the tools that can really do an outstanding job on
this field (as in auditing work), have been prepared so anything found
before release date stays 0-day ;).

> Also it should be noted that if the perl interpreter is setuid then it'll=
=20
> happily do things as the EUID, this means that we have no good precedent =
to=20
> rely on in this case.  This doesn't stop us, just means that the chance o=
f=20
> getting code accepted upstream is dramatically reduced.

I think that getting code accepted by upstream maintainers isn't
mandatory. Things could get worked out later, and changes shouldn't be
made available by default (ie. we can either compile it with support for
the measures or not).

Cheers,
--=20
Lorenzo Hern=C3=A1ndez Garc=C3=ADa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]

--=-U5Zn46Z3VoUi+57KTWP4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD3TzlDcEopW8rLewRAh/2AJ97cdSHbrCZnQ6/izRTbRbMKBA+9QCeLGKt
S/V6EqQZF0cdnBm7+aZU+PM=
=Weet
-----END PGP SIGNATURE-----

--=-U5Zn46Z3VoUi+57KTWP4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
