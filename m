Date: Tue, 31 Aug 2004 12:27:15 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831102715.GJ10151@lbsd.net>
References: <20040830173744.GD10151@lbsd.net> <20040830203140.GB31497@lkcl.net> <20040831050252.GF10151@lbsd.net> <20040831094908.GA2098@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uJrvpPjGB3z5kYrA"
In-Reply-To: <20040831094908.GA2098@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--uJrvpPjGB3z5kYrA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 31, 2004 at 10:49:08AM +0100, Luke Kenneth Casson Leighton wrot=
e:
> > yep, or /udev (configured in the udev config file)
> =20
>  oh.
>=20
>  yes.
>=20
>  redhat :)

no... it just depends how you want it configured ;-)


> > I applied the patch to tmpfs to make it store xattr attributes which i
> > found on the mailing list, seems your patch forgets xattr.h?
>=20
>  ??  oops.
>=20
>  okay, i had put it at http://www.hands.com/~lkcl/selinux/2.6.6/
>  and when i posted copies to the list i must have missed it out.
>=20
>  if you _do_ know how to properly create patches that other people
>  can apply simply, that'd be great.
>=20

*nod*, i'm pondering creating the patches... let me see what i can do


> > I also applied the patch which adds  "matchpathcon()" &=20
> > "setfscreatecon()" support,=20
>=20
>  dan is working on a new version of that, for udev-0.030-10.
>=20

cool, that will at least remove 1 patch out my build tree


>=20
> > and modified udev to set the correct=20
> > context of its root_path on startup.
>=20
>  mount -o fscontext=3Dsystem_u:object_r:device_t yes?
>

nope....   mount -t ramfs none /dev

then run   udevstart   (udevstart does the C call to restorecon on
root_path, so it ends up being labeled with whatever is configured)=20
=20
>  did you patch selinux/hooks.c to relax the constraints on
>  the fscontext=3D parameter to allow the correct context to be
>  correctly applied?  :)
>

correct, not sure if this is the 100% right way to do it though, I think
it would be better for the capabilities of the fs to be set properly
instead of commenting out code, this will have better chance being
included mainstream.
=20
> > >=20
> > >  so, not only must udev be patched to restore contexts but also
> > >  the policies and various hacks added to "cope" with /dev being
> > >  incredibly basic at startup - prior to udev running.
> >=20
> > i have a simple persistent /dev which is used before udev runs, udev is
> > then initialized, mounts a tmpfs over /dev (and restores its context)=
=20
>=20
>  oh.  ah.... you _restore_ its context (i.e. run restorecon
>  /dev), you don't mount it with the modified mount -o fscontext=3D
>  parameter?

correct!, it does the restore in udevstart

> > Seeing as my initial /dev is on a persistent=20
> > filesystem i don't have a problem with pre-udev stuff running.
>=20
>  well.... you shouldn't... until you reinitialise or somehow delete,
>  upgrade or otherwise modify the "old" /dev [which you will find is
>  remounted --rbind to /.dev].

got no reason to add other entries to the pre-udev /dev, so as I said
ItWorksForMe(tm).

>=20
>  try it: do setfiles /etc/selinux/src/file_contexts/file_contexts /.dev
>  and then reboot [in permissive mode!!!]
>=20
>  due to the present files/types.fc, you will find that the entire
>  /.dev gets relabelled to something completely useless: root_t
>  or default_t.  i think it's default_t.

yep, i'm 100% aware of this... i don't need /.dev, nor do I have it, nor
do I want it ... heh, on installation of our distribution the pre-udev
/dev is created and labeled correctly.

>=20
>  consequently your next reboot in enforcing mode will fail because
>  /sbin/init tries to access /dev/null and /dev/initctl etc. as
>  default_t ... and it can't.
>=20

yep, but as I said... i don't label pre-udev /dev when udev is running,
before I added it to our distro installer I mounted /dev/hda1 (root) as
/mnt/hda1, chroot'd onto it and re-labeled the files there  (basically
the same thing our installer does)

>  should you choose to deal with this, replace /u?dev with /[\.u]dev or
>  some suitable regexp that i haven't a clue how to write so i just
>  did /.?u?dev and that did the trick.
>=20

thats a good idea  ;-), although in "my" case didn't need it.

>=20
>  the only _other_ thing you might find is that things like dialup
>  don't or won't have been loaded.
>

i don't have any problems with this  ;-)
=20
>  so i had to add in a _second_ version of /etc/init.d/modutils which
>  does exactly the same as /etc/init.d/modutils ... but with a different
>  list of modules, and AFTER udev has been run, not before.
>=20
>  the list i have so far in /etc/modules.postudev contains (for my purpose=
s):
>=20
>  ppp_generic
>  nvidia
>  sg
>=20

no probs with any of these either (and yes we do use them), the pc i'm
on runs dual-head nvidia ;-)

every distro is different, so i would expect some to gulp bubbles and
some not to... *shrug*

>  i don't believe that these modules should be loaded prior to udev
>  being run: maybe they can, maybe they can't, maybe the nodes being
>  loaded prior will result in a pending hotplug event such that when
>  udev is run, the node gets created.

we load them after udev, and everything ends up labeled correctly...

for instance...

ot@localhost.localdomain policy]# ls -Z /dev/ppp
ls: /dev/ppp: No such file or directory
[root@localhost.localdomain policy]# modprobe ppp_generic
[root@localhost.localdomain policy]# ls -Z /dev/ppp
crw-------  root     root     system_u:object_r:ppp_device_t   /dev/ppp
[root@localhost.localdomain policy]#

>  perhaps there should be a "hook" into tmpfs to be able to pass
>  filenames accessed in /dev on to udev, such that udev can go
>  "oo, they tried to access /dev/ppp, let's kick off that module,
>   then".

if you need any of my initscripts or anything, give me a shout, i've
nearly got a 100% functional selinux enabled server!  ;-)

just writing a few security policies

--=20
Nigel Kukard, PhD CompSc
(Chief Executive Officer)
Linux Based Systems Design (Non-Profit)
Web: www.lbsd.net          Email: nkukard@lbsd.net
Tel: (+27) 023 349 8000     Cell: (+27) 082 333 3723
Fax: (+27) 023 349 1395  Support: 086 747 7600
Address: LIGT House, 2 Klipdrift Rd, Rawsonville
Linux Systems Design & Technology Solutions


   The best language to use is the language that was designed for
                  what you want to use it for.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Disclaimer
----------
The contents of this message and any attachments are intended=20
solely for the addressee's use and may be legally privileged and/or=20
confidential information. This message may not be retained,=20
distributed, copied or used if you are not he addressee of this=20
message. If this message was sent to you in error, please notify=20
the sender immediately by reply e-mail and then destroy the message=20
and any copies thereof.

Opinions, conclusions and other information in this message may be=20
personal to the sender and is not that of Linux Based Systems Design,
LinuxRulz or any of it's subsideries, associated companies or=20
principals and is therefore not endorsed by Linux Based Systems=20
Design or LinuxRulz. Due to e-maill communication being insecure,=20
Linux Based Systems Design and LinuxRulz do not guarantee=20
confidentiality, security, accuracy or performance of the e-mail.=20
Any liability for viruses is excluded to the fullest extent.

--uJrvpPjGB3z5kYrA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNFKDKoUGSidwLE4RAgPfAJ9BWlbn0WTkv3ZBFqB4kpoIVpHTGwCgkulO
HdKsc458FP8o1V1WTiIfLkE=
=e2GR
-----END PGP SIGNATURE-----

--uJrvpPjGB3z5kYrA--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
