Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m798oAJ5027483
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 04:50:10 -0400
Received: from mail.gmx.net (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id m798o8Yl021345
	for <selinux@tycho.nsa.gov>; Sat, 9 Aug 2008 08:50:09 GMT
From: Dennis Wronka <linuxweb@gmx.net>
To: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Problem with MLS because /dev is labeled tmpfs_t
Date: Sat, 9 Aug 2008 16:49:58 +0800
References: <20080804123456.679565839@hardeman.nu> <200808072211.00709.linuxweb@gmx.net> <200808081200.41418.russell@coker.com.au>
In-Reply-To: <200808081200.41418.russell@coker.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart12963761.Z3pv5MB8oo";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200808091650.01774.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart12963761.Z3pv5MB8oo
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Friday 08 August 2008 10:00:39 Russell Coker wrote:
> On Friday 08 August 2008 00:10, Dennis Wronka <linuxweb@gmx.net> wrote:
> > Does anybody know where this problem is? Is it udev? I already compiled
> > it with SELinux-support, but /dev is always tmpfs_t.
> > As said, I suspect udev here, but of course I might be wrong.
>
> Your udev script which mounts the tmpfs (which might be /etc/init.d/udev =
or
> a script called by it) needs to call restorecon.
>
> See the scripts in Debian and Fedora for examples of how it's done.

Thansk, this already helped with the wrongly labeled /dev, but not with the=
=20
error, which I believe will still stop the boot if I'd switch to enforcing.

Here's the message:
type=3D1401 audit(1218261917.800:3): security_validate_transition: denied f=
or=20
oldcontext=3Dsystem_u:object_r:fixed_disk_device_t:s0=20
newconext=3Dsystem_u:object_r:fixed_disk_device_t:s15:c0.c255=20
taskcontext=3Dsystem_u:system_r:lvm_t:s0-s15:c0.c255 tclass=3Dblk_file

As the message doesn't show anything I do not know for sure which file it=20
exactly is. As this message is caused by the call of dmsetup mknodes (I use=
=20
an encrypted root-partition in this setup) it must be either /dev/hdaX (all=
=20
three hda-partitions have this context, hda3 is the actual root-fs)=20
or /dev/mapper/cryptroot, which also has that context and is the file that'=
s=20
actually supposed to be created by dmsetup.

I had a look around in the policy but couldn't find a way to get around thi=
s.=20
Also Google wasn't very helpful as it points to patches and sources of the=
=20
SELinux-libraries.

Just for testing I removed the call of dmsetup mknodes, but the error still=
=20
happens, as lvm vgmknodes still is called and it causes the same problem.
I also switched (disabled the lvm-call and re-enabled the dmsetup-call) and=
 I=20
get the error. So, both calls give this error, as they both run in the same=
=20
domain lvm_t and want to do the same stuff with my files.

Now the problem is, how do I get rid of this problem? Both LVM and DevMappe=
r=20
are compiled with SELinux-support, but somehow MLS doesn't allow them to=20
perform this transition.

--nextPart12963761.Z3pv5MB8oo
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkidWjkACgkQ1sXw8/2VziThFACglXomLyDNGEqm4h8Y+sagiFow
qqAAoMfR5BZ1fAz5g8ViRhtZAG6eEC+C
=M38b
-----END PGP SIGNATURE-----

--nextPart12963761.Z3pv5MB8oo--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
