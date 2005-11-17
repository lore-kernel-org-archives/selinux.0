Date: Thu, 17 Nov 2005 18:18:04 +0000
From: Dale Amon <amon@vnl.com>
To: Erich Schubert <erich@debian.org>
Cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>, SELinux@tycho.nsa.gov
Subject: Re: Debian SELinux backports project
Message-ID: <20051117181803.GD2431@vnl.com>
References: <1132232710.16126.6.camel@wintermute.xmldesign.de> <20051117141118.GR3082@lkcl.net> <1132237644.16126.11.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Uwl7UQhJk99r8jnw"
In-Reply-To: <1132237644.16126.11.camel@wintermute.xmldesign.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Uwl7UQhJk99r8jnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 17, 2005 at 03:27:24PM +0100, Erich Schubert wrote:
> Hi Luke,
> I'll not support older kernels. I'll recommend to either build your own
> kernel, or get the linux-image 2.6.14+ from unstable.
> Fortunately, the linux kernel doesn't depend on much userspace programs.
> Obviously, the kernel cannot depend on a library, which is very
> nice. ;-)
> But the debian "vanilla" kernels do depend on a tool to generate
> appropriate init ramdisks, so I'll probably include an unmodified
> "backport" of yaird or one of the other initrd tool, once I've decided
> which I prefer. Yaird worked okay on a test machine of mine, but not on
> a second one, unfortunately; but I don't know why yet... Looked like
> some module was missing for mounting the root which is on software raid;
> the "old" kernel had these drivers built in, making it of course harder
> for yaird to detect the appropriate modules...

I've spent loads of time on the Debian battle myself ;-)

One of the issues with the kernel is that last time I
looked, even the kernel source packages in etch were
rather oldish. I'm not against doing my own from scratch
=66rom kernel.org, but for operational systems it is better
to depend on official debian kernel sources if at all
possible.

I expect I will come back to the selinux debian problem
within the next couple weeks as it is on my whiteboard
as something I would like to use in development project=20
I'm currently working on.

FWIW, count me in.

--=20
------------------------------------------------------
             Artemis Systems Development
   Dale Amon     amon@islandone.org    +44-7802-188325
       International linux systems consultancy
     Hardware & software system design, security
    and networking, systems programming and Admin
	      "Have Laptop, Will Travel"
------------------------------------------------------

--Uwl7UQhJk99r8jnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDfMlbZHES7UL0zXERAm/GAJ0ZQAEACr92ELVq4qZl2X9Vs0OPMQCZAXGG
i/wlhY5hDczlR0D5+JqMyOg=
=i1/L
-----END PGP SIGNATURE-----

--Uwl7UQhJk99r8jnw--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
