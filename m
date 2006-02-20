Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k1KNM41W022815
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 18:22:04 -0500
Received: from mailrelay2.lrz-muenchen.de (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k1KNM0Qp028681
	for <selinux@tycho.nsa.gov>; Mon, 20 Feb 2006 23:22:00 GMT
Received: from cobalt.jmh.mhn.de ([192.168.10.2] [192.168.10.2]) by mailout.lrz-muenchen.de for selinux@tycho.nsa.gov; Tue, 21 Feb 2006 00:22:00 +0100
Date: Tue, 21 Feb 2006 00:21:57 +0100
From: Thomas Bleher <bleher@informatik.uni-muenchen.de>
To: SELinux ML <selinux@tycho.nsa.gov>
Subject: How to build external policy modules outside of the main tree
Message-Id: <20060220232156.GD7304@thorium.jmh.mhn.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7AUc2qLy4jB3hD7Z"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Reference policy allows policy modules to be built outside of the main
source tree. I didn't find any instructions on how to do it, so here are
my notes:

You will need the following directories and files:
  Makefile
  build.conf
  policy/
  policy/modules/
  policy/modules/apps/
  policy/modules/apps/example.fc
  policy/modules/apps/example.if
  policy/modules/apps/example.te
  policy/modules/apps/metadata.xml

Additionally, you will need to have policy sources installed (probably
not full sources, but at least the Makefile, all interfaces you are
going to use, everything under support/ and likely some more files).
I assume the source is available at /etc/selinux/refpolicy/src/policy .

The Makefile is just three lines long:
> ROOT=/etc/selinux/refpolicy/src/policy
> LOCAL_ROOT=.
> include /etc/selinux/refpolicy/src/policy/Makefile

The build.conf should contain build options equivalent to the ones your
policy was built with. You can try to symlink your build.conf from the
policy sources, but please keep in mind that the build.conf shipped as
part of the source may not accurately reflect how the base policy was
built; that's because the variables in build.conf can be overridden on
the command line.

Without comments, my build.conf looks like this:
> TYPE = strict-mcs
> NAME = refpolicy-strict
> DISTRO = debian
> DIRECT_INITRC=y
> MONOLITHIC=n
> POLY=n
> QUIET=n

Now you can create your policy in the appropriate layer under
policy/modules/. For every layer, you will need a file "metadata.xml";
just copy it from the policy sources.

To actually build the module you'll need a policy/modules.conf. Just
create it by calling "make conf".
Presumably you don't want to rebuild every shipped module when building
your module, so edit the generated file and do an s/= base/= off/g and
s/= module/= off/g and then enable your module again. Don't completely
remove the lines of the other modules, otherwise you won't be able to
use their interfaces.

After that, a "make modules" will build your shiny new policy module and
put it in your base directory. From there you can load it using
"semodule -i".

Happy policy hacking,
Thomas


--7AUc2qLy4jB3hD7Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD+k8UD9qpeVMU938RAmjbAKCRH8bAFxCRXQ+FhVBgcESSU/AjpACeM2fm
BCzKSE20q5ge1JRpdSyhbU4=
=YMQE
-----END PGP SIGNATURE-----

--7AUc2qLy4jB3hD7Z--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
