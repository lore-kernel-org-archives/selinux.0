Date: Tue, 31 Aug 2004 18:46:35 +0200
From: Nigel Kukard <nkukard@lbsd.net>
To: linux-hotplug-devel@lists.sourceforge.net, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   harald@redhat.com, Bill Nottingham <notting@redhat.com>
Subject: Re: [idea] udev + selinux
Message-ID: <20040831164635.GK10151@lbsd.net>
References: <20040830173744.GD10151@lbsd.net> <20040831160750.GM11456@lkcl.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4BlIp4fARb6QCoOq"
In-Reply-To: <20040831160750.GM11456@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--4BlIp4fARb6QCoOq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

>  you have patched the program udev (0.030-10?)
>=20
>  [and yes, i would highly recommend sending it to the list(s)
>  to make it clear what you mean].
>=20
>  this patch will run, when it starts up, a call to setfilecon()
>  on /dev (or /udev, or whatever the mount point of the devfs is).
>=20
>  and _just_ on "/dev".
>=20
>  yes?

correct

>=20
>  and it's done BEFORE any inodes are EVER created in the new
>  /dev, yes?
>=20

correct

>=20
>  assuming yes, then it kinda-solves the need for doing that hacked-up
>  relaxed-constraints-patch-to-hooks.c fscontext=3D option.
>=20

aha, u correct!!!!

>  why? because you can mount -t tmpfs /dev blah blah and you don't=20
>  care what the context is because udev will set the correct one
>  when it runs.
>=20
>=20

perfect!!!!, so that solves the need for the hooks patch, which is in
actual fact wrong.

>  that is - of course - assuming that file_contexts/file_contexts
>  _contains_ the correct file context for /dev.
>=20
>=20

*nod*

>  it might make (i dunno) for a simpler policy.
>=20

yep

>  what i mean is, have you had to add in the modifications to the
>  selinux policy that i sent to the lists last week?
>=20
>  e.g. these:
>=20
> 	 allow udev_tbl_t device_t:filesystem { associate };
> 	 allow initctl_t device_t:filesystem { associate };
>=20
>  and these:
>=20
> 	 +# needed for udev-mounted (/dev) tmpfs
> 	 +allow $1_tty_device_t device_t:filesystem { associate };
> 	 +
> 	 +# to allow users to run df on udev-mounted (/dev) tmpfs
> 	 +allow $1_t device_t:filesystem { getattr };
> 	 +   #EXE=3D/bin/df  NAME=3D/   :  getattr
> 	 +
>=20

had to add quite a couple more, but i'm still working on that to make it
"correct"

>  these are all there for reasons i cannot entirely fathom but
>  it starts, in types/file.te, with this:
>=20
>  	allow { device_type } device_t:filesystem associate;
>=20

i need this aswell.... which is very interesting, so my "way of doing
it" doesn't solve this problem. i'll keep looking for the solution

>  which is all because of this:
> =20
>  	mount tmpfs -o fscontext=3Dsystem_u:object_r:device_t /dev
>=20

this doesn't cause the problem, its something else

> =20
>  anyway what i am saying is that if you HAVE NOT got all these patches
>  in your selinux policy files, then your approach has distinct
>  advantages: less mods to the policy files and less differences between
>  a persistent and non-persistent udev filesystem.
>=20

correct, i'm still working on it though and it HAS TO BE COMPLETED
SOON!!!!

>=20
>  other than that, my intuition is saying "i don't like it" and what that
>  means is that in about two or three weeks i will be able to articulate
>  clearly and precisely why i don't think it's a good idea.
>

*shrug*, just a different outlook, patching userspace instead of kernel
space
=20
>  it'll likely be something to do with your solution being a two-step
>  operation whereas the hacked-up-relaxed-fscontext-hooks.c things is
>  a one-step (atomic?)  operation.
>=20

kernel developers will very much not like to get patches unless for a
very good reason... *shrug*... guess i have the totally oposite outlook
than you, i've had quite a number of my patches go mainstream though

>  l.

-Nigel


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



--4BlIp4fARb6QCoOq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBNKtrKoUGSidwLE4RAl+iAJ4mOfmBlVjOd4fiMMiZJj0VDkYRMQCglr1l
nKnVKu451yw4r7NHXeycng4=
=ni31
-----END PGP SIGNATURE-----

--4BlIp4fARb6QCoOq--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
