Message-ID: <4CF58D24.1020609@redhat.com>
Date: Tue, 30 Nov 2010 16:47:48 -0700
From: Eric Blake <eblake@redhat.com>
MIME-Version: 1.0
To: SELinux@tycho.nsa.gov
CC: tmraz@redhat.com, sds@tycho.nsa.gov
Subject: libselinux memory leak in multi-threaded processes due to abuse of
 __thread
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigC457A01C8301F9E7B411BDB2"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC457A01C8301F9E7B411BDB2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Here's a simple program that demonstrates that libselinux's attempts to
cache data ends up being a memory leak instead.  The problem is that
__thread variables have no destructor, so when a long-running program
that uses multiple pthreads, where each thread uses selinux functions
which stash malloc'd memory into a __thread cache, then the cache memory
is leaked when the threads exit.

__thread is fine for stuff that doesn't need destruction (for example,
errno is a perfect candidate for __thread), but a recipe for disaster
when used with malloc'd memory.  The only thread-safe manner to cache
malloc'd memory is to use a thread-local mechanism that includes a
destructor, such as pthread_key_t.

While looking through the history of selinux.git, I see that there was a
past attempt made to use pthread_key_t instead of __thread for at least
setrans_client.c (Tomas Mraz' commit a842c9dae863, Jun 2009), but it was
done to solve a secondary bug related to crashing due to freeing
uninitialized data in a destructor; the pthread_key_t changes were
reverted by Stephen Smalley in commit 1ac1ff638250 in order to install a
lighter weight fix that avoided destroying uninitialized data in commit
8c372f665db4 (Jul 2009).  I'm not sure if anyone was aware of the
implications of __thread memory leaks during that exchange.

Meanwhile, __thread is abused in more than just setrans_client.c.

See also https://bugzilla.redhat.com/show_bug.cgi?id=3D658571

$ cat foo.c
#include <selinux/selinux.h>
#include <pthread.h>
#include <unistd.h>
#include <stdlib.h>

static void *
leaker(void *arg)
{
  security_context_t s;
  if (getfilecon (".", &s) < 0)
    exit (1);
  freecon (s);
  return arg;
}

int
main (int argc, char **argv)
{
  int limit =3D 1000;
  if (argc > 1)
    limit =3D atoi (argv[1]);
  while (limit--)
    {
      pthread_t t;
      if (pthread_create (&t, NULL, leaker, NULL))
	exit (1);
      if (pthread_join (t, NULL))
	exit (1);
    }
  return 0;
}
$ gcc -o foo -Wall foo.c -pthread -lselinux
$ valgrind --quiet --leak-check=3Dfull ./foo 2
=3D=3D5658=3D=3D 54 bytes in 2 blocks are definitely lost in loss record =
1 of 2
=3D=3D5658=3D=3D    at 0x4A05E46: malloc (vg_replace_malloc.c:195)
=3D=3D5658=3D=3D    by 0x37E3082A91: strdup (strdup.c:43)
=3D=3D5658=3D=3D    by 0x3864E111D3: selinux_raw_to_trans_context
(setrans_client.c:314)
=3D=3D5658=3D=3D    by 0x3864E102B9: getfilecon (getfilecon.c:64)
=3D=3D5658=3D=3D    by 0x400780: leaker (foo.c:10)
=3D=3D5658=3D=3D    by 0x37E3806D5A: start_thread (pthread_create.c:301)
=3D=3D5658=3D=3D    by 0x37E30E4AAC: clone (clone.S:115)
=3D=3D5658=3D=3D
=3D=3D5658=3D=3D 54 bytes in 2 blocks are definitely lost in loss record =
2 of 2
=3D=3D5658=3D=3D    at 0x4A05E46: malloc (vg_replace_malloc.c:195)
=3D=3D5658=3D=3D    by 0x37E3082A91: strdup (strdup.c:43)
=3D=3D5658=3D=3D    by 0x3864E111FA: selinux_raw_to_trans_context
(setrans_client.c:317)
=3D=3D5658=3D=3D    by 0x3864E102B9: getfilecon (getfilecon.c:64)
=3D=3D5658=3D=3D    by 0x400780: leaker (foo.c:10)
=3D=3D5658=3D=3D    by 0x37E3806D5A: start_thread (pthread_create.c:301)
=3D=3D5658=3D=3D    by 0x37E30E4AAC: clone (clone.S:115)
=3D=3D5658=3D=3D

If you're brave, run ./foo 1000000000, and hope that the OOM killer
doesn't randomly start killing off unrelated processes (or else you're
lucky to have that much RAM).

I'm wondering whether it is better to just restore the ideas in commit
a842c9dae, or whether we need to come up with some better way to avoid
leaking cache data on pthread_exit.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigC457A01C8301F9E7B411BDB2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJM9Y0kAAoJEKeha0olJ0NqqJYH/AwJHK+ZXKT/YgrAM5P39GMW
nWQ2WM3wL9oy54NYxJO1hLxCkbHGQrRpLppegpfthUkeLo/spEojWO53tOTYfmIr
EnwondCxZ/tGgfTByNnz0VoaPe05aqD12G+jFbEWjfnacn0oZ44+nDSnHNPGNtxn
qBr3w5f6zRnO8UK2YaMtwzbDycVzDs6imJZlod5jrTsdna44Cl2U3ConwBSdwLay
SIpxMqMPknyRgPYkJ5oCmeLCXJ3qlwgE/60G8mCw9ty4I/ELsZ5bi2P21CqUh3c2
I4TD0oK1RQoaozSrmGE4hyQwxbTGxjax+mHX5/fVG8uMh+gDzjT3zcraz/pIE88=
=+uES
-----END PGP SIGNATURE-----

--------------enigC457A01C8301F9E7B411BDB2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
