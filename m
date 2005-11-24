Subject: NSA SELinux on embedded devices: surveillance-oriented applications
Reply-To: lorenzo@gnu.org
To: NSA SELinux Mailing-List <SELinux@tycho.nsa.gov>
Cc: Craig Hughes <craig@gumstix.com>, Russell Coker <rcoker@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2Ep831b50vih5bCYmzru"
Date: Thu, 24 Nov 2005 17:35:38 +0000
Message-Id: <1132853738.13301.69.camel@localhost>
Mime-Version: 1.0
From: Lorenzo Hernandez Garcia-Hierro <lorenzohgh@gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--=-2Ep831b50vih5bCYmzru
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

Time ago I started working on SEGumstix, a fork of the Gumstix
distribution based on the uClibc buildroot which provides a reliable and
versatile development environment for embedded devices platforms. For
those who don't know about the Gumstix, it's a SBC (Single Board
Computer) ARMv5-based platform (Intel XScale PXA255, future boards with
PXA27X) providing serial output and input, GPIOs, bluetooth, etc.

SEGumstix would help to deploy low-cost (well, relatively "low" cost)
devices using well known technologies, including SELinux, the IBM
SSP/ProPolice, etc (see http://wiki.tuxedo-es.org/SEGumstix).

It's not really a project by itself, but more an independent effort
(with support from Craig at Gumstix Inc. who provides SVN and valuable
guidance) to know the possible applications of SELinux in embedded
devices.

I had difficulties for deploying it in a real world application that
could show the benefits of SELinux. Then started reading on UAVs
(Unmanned Air Vehicle, some variants and their acronym like URAV, TUAV,
etc).

After gathering some experience with embedded platforms and electronics
I started to work on a surveillance device, small and low-cost that
could be attached to an {U,TU,UR}AV for controlling and storing securely
the positioning/tracking information and any other sensors data. Using
polyinstantiation and roles, in couple with ciphered storage,
information could be contained in different levels and depending on it's
source.

Right now I have a prototype but not working yet (not yet developed
software, still finishing and assembling hardware). Photos at:

 http://pearls.tuxedo-es.org/photos/sdp-1/

Note that the Gumstix platform is missing, and the GPS unit is a
Motorola Oncore with RS232 interface. It's a prototype, don't expect it
to be as small as the final version nor using anything really
exceptional. Final version will probably make use of a Lassen IQ module
(http://www.trimble.com/lasseniq.html). The Oncore is a power
consumption beast. In any case I'll to have to look at industrial usage
rated devices rather than end-user ones. That will come hopefully after
the business. To see how the final version could look like, check photos
41, 42 and 45 (GSM/GPRS CF connected).

I can't give any further details now until I finish it as I'm planning
to patent the design of the whole system and try to find investors for
funding. The main reason is for being able to afford my relocation to US
in a near future (hopefully next year, that is, 2006). I would prefer to
work this on non-private-industry, as the main goal of this is to
provide confinement of data gathered by sensors driven platforms used in
military and intelligence-related operations, rather than end-user and
commercial usage.

Once it gets stable I'll start publishing information about how it
works, etc.

Anyways, SELinux development for this will be open and released to the
community (ie. buildroot integration, etc).

I'm interested on getting in touch with the guy who developed the JFFS2
xattr patch. If you're reading this, please drop me a line.

I'm CC'ing Craig (from Gumstix Inc.) and Russell, as he worked with
iPAQs and SELinux and more concretely the buildroot integration.

Cheers,
--=20
Lorenzo Hern=E1ndez Garc=EDa-Hierro <lorenzo@gnu.org>=20
[1024D/6F2B2DEC] & [2048g/9AE91A22][http://tuxedo-es.org]


--=-2Ep831b50vih5bCYmzru
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Esta parte del mensaje =?ISO-8859-1?Q?est=E1?= firmada
	digitalmente

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDhfnpDcEopW8rLewRAl4mAKCxeJrHlQa1B7mzJLCqxHZCReQutACgw5wK
iy2hQIo3RzNkEat6YSptv+M=
=p6tO
-----END PGP SIGNATURE-----

--=-2Ep831b50vih5bCYmzru--


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
