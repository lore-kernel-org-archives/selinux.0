Message-ID: <1328722790.23833.9.camel@foxtrot.cjac.ntr.f5net.com>
Subject: Re: SELinux on Wheezy
From: "C.J. Adams-Collier KF7BMP" <cjac@colliertech.org>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Dominick Grift <dominick.grift@gmail.com>,
        SE-Linux
 <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>
Date: Wed, 08 Feb 2012 09:39:50 -0800
In-Reply-To: <1328707470.19254.16.camel@moss-pluto>
References: <1328502407.14110.7074.camel@calcifer>
	 <1328543813.1905.2.camel@x220.mydomain.internal>
	 <1328545295.7648.14.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636118.4224.35.camel@foxtrot.cjac.ntr.f5net.com>
	 <1328636826.2162.60.camel@moss-pluto>
	 <1328640976.4224.39.camel@foxtrot.cjac.ntr.f5net.com>
	 <20120207200224.GB18478@colliertech.org>
	 <1328645305.2162.105.camel@moss-pluto>
	 <20120207210501.GE18478@colliertech.org>
	 <1328707470.19254.16.camel@moss-pluto>
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-peR0q1z3yhXoyFjRfCdu"
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-peR0q1z3yhXoyFjRfCdu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-08 at 08:24 -0500, Stephen Smalley wrote:
> On Tue, 2012-02-07 at 13:05 -0800, C.J. Adams-Collier wrote:
> > cjac@foxtrot:~$ sudo which seinfo
> > cjac@foxtrot:~$ apt-file search seinfo | grep bin | wc -l
> > 0
>=20
> seinfo is part of the setools package.

$ apt-cache search -n setools
erlang-parsetools - Erlang/OTP parsing tools

Hmm.

Would it be safe to build seinfo from source and use it along with the
distro-installed tools?  If so, what's the git repo I should clone from?

> > Sounds reasonable.  Do I get policy from my distribution, or should I
> > generate one myself?
>=20
> Normally from your distribution, assuming the selinux packages for
> Debian are still being maintained.

I believe they are.  I exchanged email with Russell about it not long
ago.  But then, gtkglarea is still officially maintained and I made the
first update in nearly a year 36 hours ago.  Perhaps the package needs 1
or more co-maintainers to improve coverage.

> IIRC, the Debian selinux policy package tries to minimize the set of
> installed policy modules based on the set of installed packages, but
> that isn't an exact mapping and might be leaving you without a complete
> policy.  Whereas Fedora installs all policy modules unconditionally.

If the overhead is not too great, perhaps this can be duplicated in
Debian.  I do hate paying for things I don't use, though.  Especially
when the cost is substantial.  The same is probably true of many other
Debian users.

> If the .pp files are on your filesystem and just not installed into the
> policy store, you can manually add them by running semodule -i on them.
> Try listing the files installed from your policy packages and see if
> xserver.pp is among them. =20

$ locate xserver.pp
/usr/share/selinux/default/xserver.pp

I'll run semodule -i after this morning's reboot.  I installed mutt
yesterday, so I'll work from the console until you folks sign off for
the evening.

> > cjac@foxtrot:~$ dpkg -l | grep selinux-policy
> > ii  selinux-policy-default               2:2.20110726-3                =
 Strict and Targeted variants of the SELinux policy
> > ii  selinux-policy-dev                   2:2.20110726-3                =
 Headers from the SELinux reference policy for building modules
> > ii  selinux-policy-doc                   2:2.20110726-3                =
 Documentation for the SELinux reference policy
> >=20
> > cjac@foxtrot:~$ apt-cache search selinux-policy
> > selinux-policy-default - Strict and Targeted variants of the SELinux po=
licy
> > selinux-policy-dev - Headers from the SELinux reference policy for buil=
ding modules
> > selinux-policy-doc - Documentation for the SELinux reference policy
> > selinux-policy-mls - MLS (Multi Level Security) variant of the SELinux =
policy
> > selinux-policy-src - Source of the SELinux reference policy for customi=
zation
> >=20
> > If I'm going to generate one myself, I need to understand them a bit
> > better.  I would like anything I generate to be useable by the rest of
> > the Debian world.  There seem to be some examples I ran review in the
> > selinux-policy-doc and selinux-policy-mls packages.
> >=20
> > Regarding re-labeling, every time I boot without the selinux arguments
> > to my kernel and then boot with them, the filesystem seems to get
> > re-labeled.  Is there a better way to do this?
>=20
> On Fedora, you could touch /.autorelabel or pass "autorelabel" on the
> kernel command line to force a relabel at boot.  You can also run
> fixfiles relabel as a command after booting.  No need to disable SELinux
> and then re-enable it.

Great.  I do have a copy of fixfiles.


--=-peR0q1z3yhXoyFjRfCdu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABCAAGBQJPMrNmAAoJEEyimPmPQm235pkIAJdYwCTHsPh1hip/uWGAimLP
iMOC2AGQyxrhExws7K8ckAlCyekPngGDrDZ9gg6Onqmw+zfUZrl4KL7nkgBlRbp8
Be+JOp/RqKNBzbSRqU3YoW7DDctJYwAFEfj/yH8Ww9HYUKtd8JtXHLLR8+AYbDFB
Fn6y1y6pZhIZV1nIoGaRD/xYLFN7mo9c6xE0f3X4m9uYfjrV/d4tbx7VKVSRqyPO
2ezpLhxAXnjgjHAteCx3pEljNR8o3q4DTJL90AtKd7UVj1alpiKgCs9t8oXU1F4s
z+d2cIqqzUovuw6CC30C69tDxtSR1n5iHtrpVmqKloJ0R20bA9zZorwscf0ocBs=
=ZSEU
-----END PGP SIGNATURE-----

--=-peR0q1z3yhXoyFjRfCdu--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
