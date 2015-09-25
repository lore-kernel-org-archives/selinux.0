Date: Fri, 25 Sep 2015 18:44:52 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: selinux network control question
Message-ID: <20150925164451.GD29665@x250>
References: <20150925151543.GA29665@x250> <560567F4.8010800@tycho.nsa.gov>
 <20150925154528.GB29665@x250> <5605755F.3050405@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
In-Reply-To: <5605755F.3050405@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2015 at 12:25:03PM -0400, Stephen Smalley wrote:

<snip>

> >=20
> >>> 4. peers are checked with netlabel, but you only need on peer type
> >>> (ie. you can't associate different peer types with different peers)
> >=20
> >> peer labeling can be based on labeled IPSEC or netlabel.
> >> NetLabel can only pass MLS labels across the network, although it can =
convey full contexts locally (see the selinux-testsuite for a configured ex=
ample under tests/inet_socket or the SELinux Notebook for further examples).
> >> Labeled IPSEC can pass full labels locally or across the network (ditt=
o).
> >=20
> > So i only need a single "peer type" (the one associated with the peer i=
sid)
>=20
> Guessing you mean the netmsg isid here; that's for NetLabel only and only=
 to provide a default user/role/type for CIPSO packets.  netlabelctl can be=
 configured to specify other fallbacks.
>=20
>

Thanks a lot. That cleared it up for me. Yes indeed i meant netmsg isid.

I basically exposed a macro that allowed one to create additional "peer
types" earlier. So i removed that. There is now only one peer type
(peer.peer), and that is the one associated with the netmsg isid.

Pretty much everything else seems to be in order. Thanks again for your
patience and guidance

--=20
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=3Dget&search=3D0x314883A202DFF788
Dominick Grift

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWBXn/AAoJENAR6kfG5xmcq7UL/23Rs41h605jPWiU8CT0fh8s
P7HHMQuh8KezECwMP8yyi+k+/zwmGv6T/6rHaO6Hjm4y0/KUO8Htknz/WUcG+B2z
5CnAenTX8pY6nbuUaeXqYnjbSnEgsEK1pcv31xvzaDrN4Lfj0IzOo0Xb9dXhmwOH
O9LvRX3zYEJaEhS6ily8aIsuP1FGqQJ+tXuIEjJ7lA2X5iT9qmdFnNA2Bfq7CRlk
NGMl2mi0NKLtDM1heyNYeC/Q7x5+aFbS4PoZxtMqmXhWAo1S1pImCt2LxEpvPu9G
HuFqgm0kywd2cQl9Mj7YfJq2OvZfSO/wFkggKkg85vGE3DZSV8ue3xB/J57askbh
Hz5/I2cbJlQabPGrJZu9D1NqDDi5TAdUeVYxTVRUytUneAhukqzz9k/SGIsqzNHu
CodxgR8F3bmqhVXYK2mPCoUWAuFAuWewJZY0GexaXw5g6R35FkbTAH6OMzwzL0A0
4T2ryPXAwprM97MZdLmqFXBzZ1WYkh5tAgRrkzl+6A==
=jfYe
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
