Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v0E8NMZB025210
 for <selinux@tycho.nsa.gov>; Sat, 14 Jan 2017 03:23:22 -0500
Date: Sat, 14 Jan 2017 00:23:12 -0800
From: Tracy Reed <treed@ultraviolet.org>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SELinux <selinux@tycho.nsa.gov>,
 Fedora SELinux Users <selinux@lists.fedoraproject.org>
Subject: Re: New Blog on how SELinux blocked Docker container escape.
Message-ID: <20170114082311.GN12376@tracyreed.org>
References: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="W4pDZ/VvazBYHhxQ"
In-Reply-To: <81c53826-f45f-8e01-e64b-8b16285d575d@redhat.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--W4pDZ/VvazBYHhxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 11:48:20AM PST, Daniel J Walsh spake thusly:
> http://rhelblog.redhat.com/2017/01/13/docker-0-day-stopped-cold-by-selinu=
x/

I have long been of the opinion that it is this sort of thing which best
advocates the use of SELinux. We need more examples like this. I posted
this to reddit a couple years ago:

https://www.reddit.com/r/linux/comments/1xdokz/selinux_saved_our_asses_xpos=
t_rselinux/

And just a few months ago we had another SELinux save. I would say that
in the years I've been using SELinux I've probably seen 5 cases where
SELinux successfully contained an attack. I wish I would have written
them all up at the time. Those 5 saves definitely made it worth it.

Check out the comments on that reddit post, Daniel. :)

--=20
Tracy Reed

--W4pDZ/VvazBYHhxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlh53+8ACgkQBhSTPg0d/nTzGQCfW6cRt2duMs2JCpHi1PC7Y+Cr
fA0An0f++pzK1wLJ5Eo/83MikzFVDqiR
=Eltd
-----END PGP SIGNATURE-----

--W4pDZ/VvazBYHhxQ--
