Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t77EEksp011954
 for <selinux@tycho.nsa.gov>; Fri, 7 Aug 2015 10:14:50 -0400
Received: by wibxm9 with SMTP id xm9so67707855wib.1
 for <selinux@tycho.nsa.gov>; Fri, 07 Aug 2015 07:14:48 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id pg9sm14848034wjb.40.2015.08.07.07.14.47
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 07 Aug 2015 07:14:47 -0700 (PDT)
Date: Fri, 7 Aug 2015 16:14:46 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: [PATCH v2 0/3] Add support for extracting modules
Message-ID: <20150807141445.GC1576@x250>
References: <1438871414-62292-1-git-send-email-ykhodorkovskiy@tresys.com>
 <CAPzO=NxAAr3QGYkxQ_rkyhRUQPGc6Gs0CKP5auTu6H-HLHaORA@mail.gmail.com>
 <55C4B26C.90508@tycho.nsa.gov> <55C4B482.5050208@quarksecurity.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0lnxQi9hkpPO77W3"
In-Reply-To: <55C4B482.5050208@quarksecurity.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--0lnxQi9hkpPO77W3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2015 at 09:37:06AM -0400, Joshua Brindle wrote:
>=20
> There is definitely an integrity violation with having such a privileged
> program read from user directories but I suppose that ship has sailed.
>=20

generic user content, to me, is meant to be the share-able, and widely acce=
ssible user content (compared to private user content types) and if anythin=
g in home or /tmp is sharable/accessible it should be them

when protecting the user content, things that shouldnt be sharable or be wi=
dely accessible should get a private user content type.

In my personal policy, i dont make a fuss about stuff manage generic user c=
ontent (if they need it ofcourse). However i do make it a point to give any=
 sensitive user content a private type

--0lnxQi9hkpPO77W3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJVxL1RAAoJENAR6kfG5xmcR5kMAInvB6DMDwZbHbeol/Qu4dGo
l8OgNufoainWmMpt2qFW0mauNYlU7atDUSBIlhe1+xJBusMpzgZKdLejRka/+oi+
pPPcQzeqGLzFebpNqvUDZTOElxnmj5Aqg17o9GzD5r5Y8lbgA4pMM0x/UI8z2pEW
tVEP47fXSRSDu2agF8nYKIlwlMjXWcJmCWnlIYOqyc/3pRWW9qHl6/y768PSO+F7
ljCHLXs47DoT2tTtoQcqbeUvIk31bwT74W4RWLnSAyf3BuPC5U7ADrERaJFFMYem
lqnBc1d6p4sXNfAAJuZNodsPn1JGs/DRMPWEFF1zgJuFjbIyB97vW2ZwZMPGGgVu
IX3IvfCg6j6UtXSsMYdra26kJMo2tKKAZCFmU+nrnKljsnM/CbtromSdjJOw6p6x
nPgaReZ4eOyB+1OJMX8pAYpM9x6Gsfdy8LF0giAvsvtNvleAKHofs1+I6RrUHFIq
DDIDT1JgVRrKcgHeOWtu3wQfEd8FPGSt+lhwH9aOYQ==
=fJVT
-----END PGP SIGNATURE-----

--0lnxQi9hkpPO77W3--
