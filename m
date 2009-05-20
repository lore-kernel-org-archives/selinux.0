From: Dennis Wronka <linuxweb@gmx.net>
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux@tycho.nsa.gov
Subject: Re: Policy loading problem
Date: Wed, 20 May 2009 21:46:50 +0800
References: <1242641994.470.5.camel@notebook2.grift.internal> <20090520072118.226550@gmx.net> <1242820009.20082.374.camel@localhost.localdomain>
In-Reply-To: <1242820009.20082.374.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2219355.pDvJ5j9IAm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200905202146.54559.linuxweb@gmx.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--nextPart2219355.pDvJ5j9IAm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have actually tried both.
The way it's usually done is through a patched init, which used to work som=
e=20
time ago (I don't remember which version of the kernel, the policy and the=
=20
SELinux-tools/-libraries I used then, as everything always is being updated=
=20
and I worked on a lot of other stuff in between).
I also tried the approach Fedora uses, pretty much taking apart their initr=
d=20
and reimplementing the load_policy-command from nash into a seperate progra=
m=20
as I had trouble compiling nash). I got it partially working later, but not=
 in=20
the way I used to do it and not the way it's supposed to be.

So, as said, the it's supposed to be is a patched init, although I could li=
ve=20
with doing it in my initramfs (I use that instead of an initrd, but it's=20
basically the same anyway).

Still I find it quite confusing that the policy gets loaded when I set SELi=
nux=20
to enforcing, but not when I set it to permissive.

On Wednesday 20 May 2009 19:46:49 you wrote:
> On Wed, 2009-05-20 at 09:21 +0200, Dennis Wronka wrote:
> > Hello folks,
> >
> > currently I am experiencing quite a strange problem during system-boot.
> > The problem is that the policy only gets loaded when I boot into
> > enforcing-mode. Booting into permissive mode (doesn't matter if via
> > kernel-parameter or config-file) does not load the policy at all.
> >
> > I am using Kernel 2.6.29.3 and Reference Policy 2.20081210.
> > Did anything change in the latest kernel or policy that triggers this? =
Is
> > it possible to create a policy that cannot be loaded in permissive mode?
> >
> > Any help or suggestion would be great.
>
> What mechanism are you using to perform the initial policy load (Fedora
> originally patched /sbin/init then migrated to performing the load from
> the initrd; Ubuntu does the load from initrd but in a different manner;
> Debian still uses a patched init I believe)?
>
> Can you post the logic for your initial policy load, whether it is a
> patch to /sbin/init or an initrd script?



--nextPart2219355.pDvJ5j9IAm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)

iEYEABECAAYFAkoUCc4ACgkQ1sXw8/2VziRnvQCaAoi86YPOzVaOvkIsoBfVQljm
0iYAn2FGtHpo7cdgeFhp1f0t13WfCF8I
=mgta
-----END PGP SIGNATURE-----

--nextPart2219355.pDvJ5j9IAm--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
