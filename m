Subject: Re: writing rules to disallow a domain to read particular files
From: Colin Walters <walters@verbum.org>
To: jsingh@ensim.com
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1098086321.5142.11.camel@jsingh.india.ensim.com>
References: <1097940101.2569.5.camel@jsingh.india.ensim.com>
	 <1097948413.3872.3.camel@x-infinity.verbum.private>
	 <1098017660.2740.33.camel@jsingh.india.ensim.com>
	 <1098030922.15741.20.camel@x-infinity.verbum.private>
	 <1098086321.5142.11.camel@jsingh.india.ensim.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-TRJHgTTzJ6ZHiEaX6kin"
Date: Mon, 18 Oct 2004 09:18:00 -0400
Message-Id: <1098105480.9768.21.camel@x-infinity.verbum.private>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-TRJHgTTzJ6ZHiEaX6kin
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-10-18 at 13:28 +0530, Jaspreet Singh wrote:

> That was an eye opener .. i didn't know so much was possible with
> SELinux. Could you pass me on some document which can elaborate on
> policy rules and configuration (and discusses whats all possible with
> these policies).

http://www.nsa.gov/selinux/papers/policy2-abs.cfm

> Just to test the above approach i tried the following on on my FC2 box
> with FC3 selinux-files , but i had some bad time compiling my changes
> ...

You'll need the strict policy for this, basically.


--=-TRJHgTTzJ6ZHiEaX6kin
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBc8KIOIkJWWp2WGURAuHfAJ9eFZT0+X+zWMb2nAKaE9ndi6s01gCeL6Vx
0Z2KVmrUbhtsqvFGxRzlPAw=
=XPPM
-----END PGP SIGNATURE-----

--=-TRJHgTTzJ6ZHiEaX6kin--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
