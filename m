Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8FIO7rT019605
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 14:24:07 -0400 (EDT)
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8FIO1hP011882
	for <selinux@tycho.nsa.gov>; Wed, 15 Sep 2004 18:24:04 GMT
Subject: Re: [patch] don't relabel sub-subdirectories of /mnt, /media by
	default
From: Colin Walters <walters@redhat.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: James Carter <jwcart2@epoch.ncsc.mil>, SELinux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, rcoker@redhat.com
In-Reply-To: <20040913232841.GB30524@lkcl.net>
References: <1094828936.7061.20.camel@nexus.verbum.private>
	 <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil>
	 <20040913232841.GB30524@lkcl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-rOnf35b6NEIOZ67S6Fu+"
Date: Wed, 15 Sep 2004 14:25:23 -0400
Message-Id: <1095272723.4231.38.camel@nexus.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-rOnf35b6NEIOZ67S6Fu+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-09-14 at 00:28 +0100, Luke Kenneth Casson Leighton wrote:

>  GREAT idea, because i am having the same difficulty with
>  usbmount + autofs.
>=20
>  yes, this is essential.
>=20
>  colin, what do you propose _be_ in the removable_context because i
>  guessed about putting {username}:object_r:home_dir_t in there, where
>  {username} is determined by who owns /dev/console or simply by
>  an over-ride in /etc/usb-mount.conf.

Dan, John Palmieri and I talked about this, and we agreed that it is bad
that currently file contexts on removable ext3 media is trusted.=20

Right now when a device is inserted HAL generates an fstab entry for it,
and includes "nosuid, noexec, nodev" (actually these are implied by the
"user" option).

So I think what we want is a single context for all removable media by
default.  Previously I suggested HAL could grab the context from a
policy config file, and add that to the fstab entry for it, similarly to
how it adds nosuid.  Let's say it's
system_u:object_r:removable_content_t by default. Then we'd want a
boolean for whether users can read it or not.  At this point we don't
need the "noexattrfile" attribute anymore.

However, this doesn't give an easy solution for someone who does want to
use the contexts on removable media, because then you get into the very
thorny issue of identifying removable media.  One idea John suggested
during the discussion was for the removable media to have an identifying
cryptographic key on it, and HAL could verify this key, and then use it
with a policy config file to map to either a particular context, or
"trusted".

I don't think the cryptographic key is doable anytime soon, so I suggest
for now we simply go with a single config file with a single context in
it, and patch HAL.

So to summarize, what we need from SELinux is a new libselinux function:
const char * get_media_type (void)
which would just read from a config file like initrc_context.

Luke: I'm not sure how this would fit in your usbmount+autofs setup.
But if you figure out which component is mounting the device, you can
modify that in the same way we'll modify HAL.  Then you could simply
modify your policy to allow users access to removable_content_t.


--=-rOnf35b6NEIOZ67S6Fu+
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBSIkTOIkJWWp2WGURAp8hAJ4kd6mLmWDkJtl+4fEOE8rPQ8U7AwCeOoJ3
NDHlxGM0da9H1WFtHLrSDOc=
=kJcM
-----END PGP SIGNATURE-----

--=-rOnf35b6NEIOZ67S6Fu+--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
