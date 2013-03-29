From: Eric Mertens <emertens@galois.com>
Content-Type: multipart/mixed; boundary="Apple-Mail=_5CDD5666-2A00-4B12-991D-912FADE6EA1B"
Subject: Simple fixes for libsepol for DARWIN
Message-Id: <96AADC74-A6C5-4709-AB71-690E61F91B5D@galois.com>
Date: Fri, 29 Mar 2013 11:01:08 -0700
To: SELinux@tycho.nsa.gov
Mime-Version: 1.0 (Mac OS X Mail 6.3 \(1503\))
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Apple-Mail=_5CDD5666-2A00-4B12-991D-912FADE6EA1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello,

I=92ve attached a few simple fixes to libsepol for compiling with DARWIN =
defined.

Sincerely,
Eric Mertens


--Apple-Mail=_5CDD5666-2A00-4B12-991D-912FADE6EA1B
Content-Disposition: attachment;
	filename=0001-Fixes-for-DARWIN-support.patch
Content-Type: application/octet-stream;
	name="0001-Fixes-for-DARWIN-support.patch"
Content-Transfer-Encoding: quoted-printable

=46rom=2043f8a44a614be11d01527c5e7202a9e22a95dded=20Mon=20Sep=2017=20=
00:00:00=202001=0AFrom:=20Eric=20Mertens=20<emertens@galois.com>=0ADate:=20=
Fri,=2029=20Mar=202013=2010:52:25=20-0700=0ASubject:=20[PATCH]=20Fixes=20=
for=20DARWIN=20support=0A=0AConditionally=20hide=20unused=20variables=20=
to=20avoid=20compile-time=20errors.=0AConditionally=20define=20the=20=
nread=20variable=20in=20genusers.c=20to=20avoid=0Ausing=20the=20variable=20=
without=20initialization=20later.=0A---=0A=20libsepol/src/genbools.c=20|=20=
2=20++=0A=20libsepol/src/genusers.c=20|=203=20+++=0A=202=20files=20=
changed,=205=20insertions(+)=0A=0Adiff=20--git=20=
a/libsepol/src/genbools.c=20b/libsepol/src/genbools.c=0Aindex=20=
6a06ec9..e67cd6f=20100644=0A---=20a/libsepol/src/genbools.c=0A+++=20=
b/libsepol/src/genbools.c=0A@@=20-68,7=20+68,9=20@@=20static=20int=20=
load_booleans(struct=20policydb=20*policydb,=20const=20char=20*path,=0A=20=
{=0A=20=09FILE=20*boolf;=0A=20=09char=20*buffer=20=3D=20NULL;=0A+#ifndef=20=
DARWIN=0A=20=09size_t=20size=20=3D=200;=0A+#endif=0A=20=09char=20=
localbools[BUFSIZ];=0A=20=09char=20name[BUFSIZ];=0A=20=09int=20val;=0A=
diff=20--git=20a/libsepol/src/genusers.c=20b/libsepol/src/genusers.c=0A=
index=207826b71..5dea8fe=20100644=0A---=20a/libsepol/src/genusers.c=0A=
+++=20b/libsepol/src/genusers.c=0A@@=20-36,7=20+36,9=20@@=20static=20int=20=
load_users(struct=20policydb=20*policydb,=20const=20char=20*path)=0A=20{=0A=
=20=09FILE=20*fp;=0A=20=09char=20*buffer=20=3D=20NULL,=20*p,=20*q,=20=
oldc;=0A+#ifndef=20DARWIN=0A=20=09size_t=20len=20=3D=200;=0A+#endif=0A=20=
=09ssize_t=20nread;=0A=20=09unsigned=20lineno=20=3D=200,=20islist=20=3D=20=
0,=20bit;=0A=20=09user_datum_t=20*usrdatum;=0A@@=20-54,6=20+56,7=20@@=20=
static=20int=20load_users(struct=20policydb=20*policydb,=20const=20char=20=
*path)=0A=20=09}=0A=20=0A=20=09while(fgets(buffer,=20255,=20fp)=20!=3D=20=
NULL)=20{=0A+=09=09nread=20=3D=20strlen(buffer);=0A=20#else=0A=20=09=
__fsetlocking(fp,=20FSETLOCKING_BYCALLER);=0A=20=09while=20((nread=20=3D=20=
getline(&buffer,=20&len,=20fp))=20>=200)=20{=0A--=20=0A1.8.2=0A=0A=

--Apple-Mail=_5CDD5666-2A00-4B12-991D-912FADE6EA1B--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
