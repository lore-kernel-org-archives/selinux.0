Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j390DdtA009595
	for <selinux@tycho.nsa.gov>; Fri, 8 Apr 2005 20:13:40 -0400 (EDT)
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j390ApUH014832
	for <selinux@tycho.nsa.gov>; Sat, 9 Apr 2005 00:10:52 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Sat, 9 Apr 2005 02:10:50 +0200
Date: Sat, 9 Apr 2005 02:10:48 +0200
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Dwerryhouse <paul@dwerryhouse.com.au>, selinux@tycho.nsa.gov
Subject: Re: SELinux packages for SuSE 9.2
Message-Id: <20050409001048.GA7830@thorium.jmh.mhn.de>
References: <20050407231425.GA14489@dwerryhouse.com.au> <1112960241.32127.5.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
In-Reply-To: <1112960241.32127.5.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Stephen Smalley <sds@tycho.nsa.gov> [2005-04-08 22:55]:
> On Fri, 2005-04-08 at 09:14 +1000, Paul Dwerryhouse wrote:
> > Hi all,
> >=20
> > I have created SELinux-enabled packages for SuSE 9.2, and these can be
> > found here:
> >=20
> > http://suse-selinux.leapster.org/
> >=20
> > Packages such as libselinux, policycoreutils, etc, have been built from
> > the main NSA SELinux CVS tree.
> >=20
> > I built the other userspace packages by patching SuSE's 9.2 SRPMs with
> > the selinux patches from Fedora's devel CVS tree, and in many cases
> > modified them to make the patches apply properly.

Ah well. Your announcement came shortly after I finished building
packages myself. I'm currently adjusting policy and hadn't come around
to putting the packages on the web. Guess I'll send some mails before I
start building packages next time :)
For reference, my packages are available at
http://www.cip.ifi.lmu.de/~bleher/selinux/suse/
It's nice to see that other people are working on SELinux on SuSE.

I haven't had the time to look at your rpms in detail; you seem to have
patched more programs than I have. Most of my time was invested in
making sure that pam works correctly and that it uses unix_chkpwd if
possible (pam_unix2.so (a SuSE specific pam module) has SELinux support
but the support is complicated and outdated, so I decided to patch
pam_unix.so instead).

> > Also provided is an SELinux-enabled kernel, based on the 2.6.11.4
> > kernel-of-the-day source from SuSE's ftp server, with the latest
> > SELinux patch applied.
> >=20
> > I have not altered the policy yet, so as it stands, the system will hang
> > if placed into enforcing mode. This is fairly simple to fix - just a sm=
all
> > change to the getty policy is required - and I hope to have an updated
> > policy package available later today. However, there will still be a
> > considerable number of policy fixes needed before this is usable.
>=20
> Have you looked at Thomas Bleher's policy for SuSE?

For the record, I have just put a new suse policy there. The machine
works fine in enforcing mode; only a handful denials are left on boot
(haven't had the time to analyze them all). The policy is still rough
and contains lots of changes, but I hope to send some patches soon.

> Now if only someone could get these changes into the main SuSE
> distro...

Yes, that would be very nice. Well, they _are_ slowly adding SELinux
support, but development is rather closed (compared to eg Fedora) so only
a SuSE employee could speed integration up (please correct me if I'm
wrong and there's a way I can help!)
Let's see what SuSE 9.3 will bring.

Thomas

--=20
http://www.cip.ifi.lmu.de/~bleher/selinux/ - my SELinux pages
GPG-Fingerprint: BC4F BB16 30D6 F253 E3EA  D09E C562 2BAE B2F4 ABE7

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCVx2HxWIrrrL0q+cRAjpQAKCOe8nQotZNk+RnCQWAKwIAjs/QSACfaAm8
/MTpceGQwjc5Mb9kMezmHnc=
=7qTT
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
