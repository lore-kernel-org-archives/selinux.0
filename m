Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8B6dATm024715
	for <selinux@tycho.nsa.gov>; Tue, 11 Sep 2012 02:39:10 -0400
Date: Tue, 11 Sep 2012 08:38:22 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Laurent Bigonville <bigon@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Assertion `new_role != ((void *)0) && new_role->flavor == 1'
 when installing modules
Message-ID: <20120911063822.GA4390@telmora.telvanni>
References: <20120909191000.74e83c73@fornost.bigon.be>
 <1347280786.2480.3.camel@moss-pluto.epoch.ncsc.mil>
 <20120911011349.0ecc2f99@eldamar.bigon.be>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20120911011349.0ecc2f99@eldamar.bigon.be>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2012 at 01:13:49AM +0200, Laurent Bigonville wrote:
> Le Mon, 10 Sep 2012 08:39:46 -0400,
> Stephen Smalley <sds@tycho.nsa.gov> a =E9crit :
>=20
> > Does this patch fix it?
>=20
> It's now unfortunately crashing with the following trace :(
>=20
> #0  __strlen_sse42 () at ../sysdeps/x86_64/multiarch/strlen-sse4.S:32
> #1  0x00007f30554c20b1 in ustr_replace_cstr (s1=3D0x7fff6721a668, oc=3D0x=
7f3055ea4ef9 "s0", nc=3D0x0, lim=3D0) at ustr-replace.h:58
> #2  0x00007f3055e8d398 in replace_all (str=3D0x7f3057796860 "HOME_DIR/.+\=
tsystem_u:object_r:user_home_t", repl=3D0x7fff6721a6c0) at genhomedircon.c:=
513
> #3  0x00007f3055e8d644 in write_home_dir_context (s=3D0x7fff6721a7d0, out=
=3D0x7f305779d9a0, tpl=3D0x7f305779c260, user=3D0x7f3057081660 "user_u", se=
user=3D0x7f3057081660 "user_u", home=3D0x7f3057791ef3 "/home/[^/]*", role_p=
refix=3D0x7f3057081640 "user", level=3D0x0) at genhomedircon.c:580
> #4  0x00007f3055e8e6d2 in write_context_file (s=3D0x7fff6721a7d0, out=3D0=
x7f305779d9a0) at genhomedircon.c:1012
> #5  0x00007f3055e8e977 in semanage_genhomedircon (sh=3D0x7f30570015b0, po=
licydb=3D0x7f30576fcbd0, usepasswd=3D1, ignoredirs=3D0x0) at genhomedircon.=
c:1090
> #6  0x00007f3055e8993e in semanage_direct_commit (sh=3D0x7f30570015b0) at=
 direct_api.c:994
> #7  0x00007f3055e8f7bc in semanage_commit (sh=3D0x7f30570015b0) at handle=
=2Ec:435
> #8  0x00007f305674c921 in main (argc=3D21, argv=3D0x7fff6721aac8) at semo=
dule.c:479
>=20
> I get this with the userspace version of Debian sid (and libsepol
> patched) and the following command:
>=20
> semodule -v -b base.pp -s refpolicy -n -i init.pp libraries.pp
> logging.pp selinuxutil.pp modutils.pp storage.pp userdomain.pp
> miscfiles.pp sysadm.pp authlogin.pp sysnetwork.pp application.pp
> locallogin.pp

You are building the policy without MLS/MCS, right?

Educated guess: It's the same here:

    http://marc.info/?l=3Dselinux&m=3D133003003018371

Patch would be (helped on Ubuntu):

    http://marc.info/?l=3Dselinux&m=3D132433039902439&w=3D2


Ole

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlBO3F4ACgkQS1FjE303ERzgSACfdRWRjk/JQO0u1FUsOuisMrVi
fuUAmwX8xVZ8licvaxurKnoicZTrJPF9
=hHSf
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
