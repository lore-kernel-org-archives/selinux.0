Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id lATK79Ec006659
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 15:07:09 -0500
Received: from ppsw-4.csi.cam.ac.uk (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id lATK78aw004825
	for <selinux@tycho.nsa.gov>; Thu, 29 Nov 2007 20:07:08 GMT
Received: from mpo25.trin.private.cam.ac.uk ([172.16.113.134]:54945)
	by ppsw-4.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.134]:25)
	with esmtp id 1Ixpf5-0001Qg-FA (Exim 4.63) for selinux@tycho.nsa.gov
	(return-path <martin@martinorr.name>); Thu, 29 Nov 2007 20:07:03 +0000
Message-ID: <474F1BD4.2010908@martinorr.name>
Date: Thu, 29 Nov 2007 20:06:44 +0000
From: Martin Orr <martin@martinorr.name>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=_caligula-4864-1196366823-0001-2"
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: =?ISO-8859-1?Q?V=E1clav_Ovs=EDk?= <vaclav.ovsik@i.cz>,
        selinux@tycho.nsa.gov
Subject: Re: refpolicy HEAD, Debian, patch for udev.te
References: <20071126144547.GA334@bobek.pm.i.cz> <1196189369.30997.6.camel@gorn>
In-Reply-To: <1196189369.30997.6.camel@gorn>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_caligula-4864-1196366823-0001-2
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On 27/11/07 18:49, Christopher J. PeBenito wrote:
> On Mon, 2007-11-26 at 15:45 +0100, V=E1clav Ovs=EDk wrote:
>> Hi,
>> Debian Etch, refpolicy HEAD, udev produces during startup (udevsettle)=

>> wile creating symlinks into /dev/disk/by-uuid/...
>> following:
>>
>> audit(1195744042.060:3): avc:  denied  { relabelfrom } for  pid=3D836 =
comm=3D"udevd" name=3D"44517f56-2445-4330-bce7-5168aa534c1c" dev=3Dtmpfs =
ino=3D1646 scontext=3Dsystem_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=3D=
system_u:object_r:device_t:s0 tclass=3Dlnk_file
>> audit(1195744042.060:4): avc:  denied  { relabelto } for  pid=3D836 co=
mm=3D"udevd" name=3D"44517f56-2445-4330-bce7-5168aa534c1c" dev=3Dtmpfs in=
o=3D1646 scontext=3Dsystem_u:system_r:udev_t:s0-s0:c0.c1023 tcontext=3Dsy=
stem_u:object_r:device_t:s0 tclass=3Dlnk_file
>>
>> Attached patch solves this.
>> Can be merged into refpolicy please?
>=20
> This is interesting, it isn't seen on other distros.  Perhaps it has to=

> do with the way debian sets up tmpfs /dev before udev starts?

I get similar messages: note that the contexts being relabelled from and =
to
are the same.

I had a look, and the symlinks are created by udev running in the initram=
fs,
then the tmpfs /dev is mount --moved into the main root.  No labelling is=

done yet because no policy has been loaded.  Then when the main udev star=
ts
up it replays the coldplug events.  When it comes to create the symlink
again, it notices that it is already there and calls lsetfilecon.

Should udev or libselinux be checking whether it will be relabelling file=
s
to their existing label?  And indeed, it's not clear to me why udev shoul=
d
be calling lsetfilecon on existing symlinks at all.

--=20
Martin Orr


--=_caligula-4864-1196366823-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHTxvZZ6a/BjxtAMARAnspAJ4/3oHmTYt2xCUmBaN2iwzsE+CC2wCg8dCc
43KiHU+mSzWwTd9iNqBCfZM=
=lIfa
-----END PGP SIGNATURE-----

--=_caligula-4864-1196366823-0001-2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
