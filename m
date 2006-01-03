Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id k03ADCXf016565
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 05:13:13 -0500 (EST)
Received: from mailrelay1.lrz-muenchen.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k03ACCqa021415
	for <selinux@tycho.nsa.gov>; Tue, 3 Jan 2006 10:12:12 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 3 Jan 2006 11:13:09 +0100
Date: Tue, 3 Jan 2006 11:13:08 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Clif Flynt <clif@cflynt.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: SELinux novice and SuSE
Message-Id: <20060103101308.GA7505@thorium.jmh.mhn.de>
References: <20060103003446.GA21959@clif.cflynt.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
In-Reply-To: <20060103003446.GA21959@clif.cflynt.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Clif Flynt <clif@cflynt.com> [2006-01-03 01:57]:
> I need to configure a SuSE workstation to meet NISPOM security
> standards.
>=20
> A previous incarnation of this used SNARE, SuSE 9.1, a modified
> Fedora core and a lot of luck.  I'm hoping to do something more
> out-of-the-box this time.

The short answer is:
Don't do it with SUSE, if at all possible.
I have been maintaining packages for SUSE for a while and it's a lot of
work if you want to do it right.
After SUSE opened their bugzilla I tried to push various SELinux parts
into SUSE but failed. Now SUSE has announced that they will not include
SELinux (see https://bugzilla.novell.com/show_bug.cgi?id=3D132914)

I have not yet fully decided what to do but most probably I will switch
to Ubuntu and help maintain the packages there.

> My belief is that the basics for SELinux are compiled into SuSE 10.0. I
> could be wrong.

There are some packages, but they are really outdated.

> Here's what I've done to bring SELinux up on my test system:
>=20
> Edited /boot/grub/menu.lst
> Changed selinux=3D0 to selinux=3D1
>=20
> Downloaded rpms for SuSE from:
>=20
> http://www.cip.ifi.lmu.de/~bleher/selinux/suse/rpm-10.0/
>=20
> Installed with:
> rpm -Uv --force  *rpm
>=20
> Got base security policy from:
> http://www.cip.ifi.lmu.de/~bleher/arch/selinux/policy/policy--snapshot/po=
licy--$
>=20
> unpacked, did make.
> Fails for lack of new netlink class, but installed something.

Sorry, I haven't updated the policy on my site in a while. I can send
you a snapshot if you wish.

> rebooted.
> sestatus still returns disabled.
> There is no /selinux pseudodirectory

You have to create it by hand, so init can mount selinuxfs over it.

If you really need to go with SUSE, your best bet is to first install a
Fedora machine and look there how everything is supposed to look like.
Otherwise, see if Fedora can do what you want. RedHat is currently
working on LSPP support, see
https://www.redhat.com/mailman/listinfo/redhat-lspp

Hope this helps,
Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDuk40D9qpeVMU938RArdgAJ0Xh5xbMUFZX1nJESq0+MiUyLyqjwCbBlQG
0I5T80RbYM7JUhsODvGa0Us=
=edGb
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
