Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sAHLt8uD018616
 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2014 16:55:08 -0500
Received: by mail-wi0-f173.google.com with SMTP id r20so4002285wiv.6
 for <selinux@tycho.nsa.gov>; Mon, 17 Nov 2014 13:55:00 -0800 (PST)
Received: from e145.network2 ([84.245.1.4])
 by mx.google.com with ESMTPSA id dm10sm16912479wib.18.2014.11.17.13.54.59
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Mon, 17 Nov 2014 13:54:59 -0800 (PST)
Date: Mon, 17 Nov 2014 22:54:57 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: Question on unconfined_t
Message-ID: <20141117215456.GA7768@e145.network2>
References: <CAOK12DaUYM-Pq5d8E0CGyLZTz_+ihOBF6hPUbp7hh20OuQEi+w@mail.gmail.com>
 <546A1634.1070900@tycho.nsa.gov> <546A5C6F.6030805@redhat.com>
 <CAOK12DarQLB3QcmRLd4xTWTDS0kBD+zAXfh_0oHK3_gYxnniiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
In-Reply-To: <CAOK12DarQLB3QcmRLd4xTWTDS0kBD+zAXfh_0oHK3_gYxnniiQ@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2014 at 09:18:51PM +0000, Paddie O'Brien wrote:
> Thanks. I was under the mistaken impression that unconfined_t got
> something for free. My new understanding is that it's by convention
> that policy writers give access to unconfined_t to their domains and
> they do so by adding explicit rules.
>=20
> Also I was missing file_type(mytype_exec_t) although I had
> domain_type(mytpe_t). Is there a way to see what things like file_type
> and domain_type expand to? I want to know what's going on in the
> background.
>=20

Yes, Generally what file_type() and domain_type() do is associate a "type a=
ttribute" with the calling type

type attributes are a way to group common rules. You could look at them as =
tags in a way

consider this example

attribute cars

type pinto, cars;
type chevy, cars;

attribute bicycle=20

type specialized, bicycle;
type cannondale, bicycle;

Now we have 4 types grouped into two categories using type attributes: cars=
 and bicycles

now the type attributes can be used to write rules that apply to all the ty=
pes associated with a particular type attribute.

allow cars i85:interstate 100mph;

stupid example that allows "all cars (pinto and chevy)" to drive 100mph on =
the i95 interstate

This concept of grouping types by associating type attributes with them is =
what is used a lot

file_type(myfile_t) associates the files_type attribute with the myfile_t t=
ype, effectively categorizing myfile_t as a type for a file
similarely domain_type(myprocess_t) categorizes myprocess_t as a type for p=
rocesses

so if you want to give some type access to all "files" rather than individu=
al types:

allow myprocess_t files_type:file read;

or if you want to allow all types associated with processes to write all ty=
pes associated with files:

allow domain_type files_type:file write;

There are alot of type attributes and types (and other identifiers like rol=
es) are grouped in many ways

To see which rules apply you can use the seinfo and sesearch command creati=
vely.

Example:

to list all attributes: seinfo -a
to example all attributes: seinfo -xa

see which attributes are associated with the unconfined_t type: seinfo -xtu=
nconfined_t

to see all rules associated with a particular attribute: sesearch -A -t fil=
es_type

it takes a while to get creative with those two commands and with those con=
cepts.

Just remember selinux is like accounting in some ways, its all about groupi=
ng and associating.

--=20
Dominick Grift

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJUam6rAAoJENAR6kfG5xmcog0MAKAG76/NQUZIcxZquAaqWUTK
HNvGGm/5h236FmVykCvV8IyMq2ohAx3WCRCypkMD43epwaMfAe4ZXQvGbDg4owB+
2DCNErZ+8w31J+g/R5UY5o8ujClFuFhxUInlHn+2klXDed5y2ZHZvf0ekIPx1lmM
1Nynrb7krD2cQifbzQz173sr8F9s9CSw/tzWR/+6SILIEuf8CeJzLiV87gyd7lE4
oIzYaWNdNQHmWsYyN82/SJlDLwKoeJHOOelx4pKYpsKCMbnJyeSpfi/JSCNPEWwG
ka/bnSvKT5+W+kHEcYNukJxB9OdR1qYrxJOo8G8c9L21+MRLDXu9P7I4IP03yX66
I1S3I4L+U1eeH1tcSkUVivxU1O/5jtN07QuU4Cai2TZlzKatKWo6nhCX+K7V/L0O
i4x4cx5MUEtzlDHDXPDX1QZBISy/DuevL+nFJKjgK2gtI0yDdqIXVG+DLnatkDdD
/LxoH6h1bpnbtVRgCTB1z7zBq22JZd3Y16tEGXNsIA==
=I8V8
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
