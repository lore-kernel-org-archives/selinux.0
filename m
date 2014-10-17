Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id s9HDFtsb017181
 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2014 09:15:55 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so896057wgh.10
 for <selinux@tycho.nsa.gov>; Fri, 17 Oct 2014 06:15:52 -0700 (PDT)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id fx2sm1653869wjb.37.2014.10.17.06.15.51
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Fri, 17 Oct 2014 06:15:51 -0700 (PDT)
Date: Fri, 17 Oct 2014 15:15:49 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: cilc: name space inconsistency
Message-ID: <20141017131548.GA1524@e145.network2>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I started rewriting my policy using name spaces again. I was assuming the t=
he name space issues were fixed.

However I am encountering, what i believe, is an inconsistency.

The block statement is used to declare a name space

in module a i declare the a (root) name space

    (block a
        ...
    )

in module b i declare the b name space in the existing a (root) name space

    (in a
        (block b
            ...
        )
    )

All is well so far... However if i now want to declare the c name space in =
the existing a.b name space then cilc is unable to resolve the a.b name spa=
ce

    (in a.b
        (block c
            ...
        )
    )

    "Unable to resolve a.b in in statement..."

The a.b name space exists

The workaround to this inconsistency is to create duplicate declarations:

    (in a
        (block b
            (block c
                ...
            )
        )
    )

Now the b name space is declared two times, but it works around the issue

Why can it not resolve the existing a.b name space?

--=20
Dominick Grift

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUQRaAAAoJENAR6kfG5xmcgL0MAJJDeYcDfxI7vv24IwMladIU
nOOEQ6RS+TIKmEqNt8lRbq4/ZjjlPyh/6y+sr1tudtL5Zt7i1kJs6//diGQe6sbT
/mvyW6J80ingxqRO9Jq0IhbzX6rM/3IKwXydd8uMEZSoIFQxQqGt4h/diGHXyfAY
8AGiM3fNJKV5UjQ9bVKyAgGyklJwPl+e6pBBVO7rq2hqkY7NzSXLSjgJ15mMJFw/
x4jBQ5Fv2ccoRJp0Weo3/q9miuNY6oiAJP+b2abx2w0nxnUFG4OO1Dg6XSHCMsxG
EBoYPtMHrlmDg+tRThMXfpvpR1THQvjuNvvlcBgTeSfxUrACYi3WpI+NSraDKkhz
9wbaQnIX1094jc0Q40P+nw9QtrtMqMdhAZ1a3oE/ToGYT8P/VU+yf5dkQoZ4oR2Y
fqhmXOWcssdlt8oWFlAfezyAAP5U6sj+RdLhPBxycd+x3E5C0m76MO0SXF0Y9o/p
r1+kolSHRJtCXyvs/MT0Z96ESvsMBnM9AQL4pjbcDg==
=JEqE
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
