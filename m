Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA10895
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 19:37:02 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id XAA10094
	for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 23:35:18 GMT
Received: from ultraviolet.org ([192.215.175.10])
        by jazzband.ncsc.mil  with SMTP id XAA10090 for <selinux@tycho.nsa.gov>; Mon, 9 Sep 2002 23:35:07 GMT
Date: Mon, 9 Sep 2002 16:35:58 -0700
From: Tracy R Reed <treed@ultraviolet.org>
To: SE Linux <selinux@tycho.nsa.gov>
Subject: IBM's Multics paper
Message-ID: <20020909163557.K20187@ultraviolet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="Xb8pJpF45Qg/t7GZ"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Xb8pJpF45Qg/t7GZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

As seen on slashdot today...

http://domino.watson.ibm.com/library/cyberdig.nsf/papers/FDEFBEBC9DD3E35485=
256C2C004B0F0D/$File/RC22534.pdf

I read the entirety of the first paper and parts of the second paper which
is the original Multics vulnerability analysis.

At the top of page 3 of the report (page 5 in your pdf viewed) they
specifically mention SE Linux. They compared Multics 768k bytes of
executable code and data 1767k bytes and suggest that it is far too big to
be secure and that the complexity leading to that large size needs to be
corrected. I infer that due to the Linux kernels monolithic design that
this may not be possible.

Is it realistic to compare a modern OS to Multics? Of course the logical
requirements of multi-level OS security haven't really changed in 28 years
and there is no reason why it should take more bytes to implement the same
ideas so perhaps they are right.

It is also noted that their system never had any exploitable buffer
overflows found due to the way the hardware segmentation worked, the
direction the stack grows (away from occupied stack space instead of
towards such as on x86), the implementation language which has much
better array bounds handling, and the fact that the hardware would not
allow you to execute memory marked as data.

There isn't much we can do about the hardware, stack direction, or
implementation language at the moment. We are stuck with x86 and C for a
good long time it seems. But doesn't x86 hardware now have the ability to
prevent execution of data? That's what Solar Designers patch does iirc.
But there has been some reason for not making it part of the standard
kernel. I've heard about how it prevents intentionally executing
trampoline code on the stack which some compilers use etc. but I have also
heard that this can be fixed. Of course I recall Linus saying that if we
disabled data execution on the stack they would just code around it. I
don't understand how they would do this and if they could do it on x86
surely they could have done it on Multics unless it were very difficult
and if it is that difficult then by all means include the patch in the
kernel! I seem to recall a very long debate about this on the linux-kernel
list some years ago. I have also heard people say that you can get around
the stack direction growth problem although I don't understand how.

I think it is very interesting how Russell's paper "Partioning a Server
with NSA SE Linux" starts out with "The requirement to purchase multiple
machines is often driven by the need to have multiple administrators with
root access who do not trust each other" when that is basically what the
original Multics paper started out with also. The reason they were looking
into multi-level security with mandatory access controls was so that they
could allow secret, top secret, and perhaps even unclassified users, to
all use the same system and thus greatly cut down on hardware acquisition
costs. Having secret, top secret, and unclassified users on one box sounds
rather like you would want them all in their own chroot'd environments or
UML sessions. But from the point of view of the Multics designers, the
steps required to set up domains/chroots or UML etc. are a rather large
kludge with such complexity that it is impossible to verify that all of
the code works as it should with no back doors or unintended side effects.

The parallels between then and now (27 years later) are striking. It is
rather depressing that we are still trying to solve the same problems they
were trying to solve and end up reinventing the wheel.  What's worse is
that our wheel may be rather rickety compared to theirs.

--=20
Tracy Reed      http://www.ultraviolet.org
"Our products just aren't engineered for security." - Brian Valentine,
senior vice-president in charge of Microsoft's Windows development 5 Sept 2=
002

--Xb8pJpF45Qg/t7GZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj19MF0ACgkQ9PIYKZYVAq2iKQCaAoXzlSY3ZsdzT7cLedigoJ5M
iggAn2pQkksF2DZSvQC1eMMWezuwGugy
=0C0P
-----END PGP SIGNATURE-----

--Xb8pJpF45Qg/t7GZ--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
