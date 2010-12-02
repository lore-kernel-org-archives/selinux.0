Message-ID: <4CF8089B.7020301@redhat.com>
Date: Thu, 02 Dec 2010 13:59:07 -0700
From: Eric Blake <eblake@redhat.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
Subject: Re: libselinux memory leak in multi-threaded processes due to abuse
 of __thread
References: <4CF58D24.1020609@redhat.com>
In-Reply-To: <4CF58D24.1020609@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig7F1BBA29A2AD0930BCC3E452"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7F1BBA29A2AD0930BCC3E452
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/30/2010 04:47 PM, Eric Blake wrote:
> Here's a simple program that demonstrates that libselinux's attempts to=

> cache data ends up being a memory leak instead.  The problem is that
> __thread variables have no destructor, so when a long-running program
> that uses multiple pthreads, where each thread uses selinux functions
> which stash malloc'd memory into a __thread cache, then the cache memor=
y
> is leaked when the threads exit.

Eamon's patch[1] looks good to me; and a quick test with my sample
program proves that it avoids the leak.

[1] https://bugzilla.redhat.com/attachment.cgi?id=3D464338, found at
https://bugzilla.redhat.com/show_bug.cgi?id=3D658571

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig7F1BBA29A2AD0930BCC3E452
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM+AibAAoJEKeha0olJ0NqW4YH/392FkS/+ZXKL+DwRW8KkeAk
ZOIqgZ6qTjfl2/eiCJNo/AOBFZVs3GgrO/rZmJ2U/hY80BLS7ApXkmFn9N8xyexE
31XeZo50rXliYGEhburqykxcisufEG3av3KBv4CG8v+wtjLvRzXFIaWJzhjXRpbH
X1xFYT4bkVWLUEC/yjEQ4ukX8e6Zt+sQXFGaJY62DkPLmjRax6TAR3nDzY7v+JgF
sT6LJYIdd47Ki6qJudXliFOxDXqaAXRRV8e3WjETRsayzfIqDVaEMBrh8VSg9Ykz
Oq3f5IGVzPIb/QgXFJ1PlKlOJsSjPAlHpagEfCKPzQ+oWm0qa8fB4/k5lhBGgQ0=
=PNk9
-----END PGP SIGNATURE-----

--------------enig7F1BBA29A2AD0930BCC3E452--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
