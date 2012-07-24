Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6OB6Ce7005953
	for <selinux@tycho.nsa.gov>; Tue, 24 Jul 2012 07:06:12 -0400
Date: Tue, 24 Jul 2012 13:05:51 +0200
From: Ole Kliemann <ole@plastictree.net>
To: Ted Toth <txtoth@gmail.com>
Cc: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Subject: Re: Information about XSELinux
Message-ID: <20120724110551.GA2746@telvanni>
References: <20120719141823.GA19890@telvanni>
 <1342717308.5578.YahooMailClassic@web87704.mail.ir2.yahoo.com>
 <CAFPpqQHU_YkQzX9H9SXhA_hyDv3rpghfRrn_Va2aBDjx+tD7aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
In-Reply-To: <CAFPpqQHU_YkQzX9H9SXhA_hyDv3rpghfRrn_Va2aBDjx+tD7aw@mail.gmail.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 23, 2012 at 09:12:37AM -0500, Ted Toth wrote:
> FWIW we have a custom distro of RHEL 6 running MLS policy with X in
> enforcing however as you might imagine getting all of this working was
> non-trival. Because of schedule/budget/complexity we do not run GNOME
> but rather Openbox, fbpanel and idesk all of which we wrote policy
> for. Many apps (Firefox, OpenOffice) require policy tweeks with many
> of those due to our particular security requirements. We have dozens
> of custom X applications all of which require policy modules. Getting
> things like copy/paste to work under MLS is particularly challenging
> because of lack of visibility into what the X server (XACE) is doing.

I'm running X in enforcing too now with a simple setup. There is=20
a domain for every job (browser, mail, ...). These domains can't=20
access each other. The WM has access to all of them. Copy/paste=20
works like a charm with every domain having its own cutbuffer and=20
a small script called from the WM to copy the cutbuffer to other=20
domains.

Of course I had to allow some things in X that I do not fully=20
understand. But there is definitely no more sending synthetic=20
input events to foreign windows and no more keylogging.

Do you know of any documentation that lists all things in the X=20
protocol and their possible security implications?=20

Ole

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAOgY8ACgkQS1FjE303ERwcKACfZDW21UpqYOLf0y3VoyKjl2Wp
6WAAn3ec3GYep8nEMGhJObRbYIGdyMBt
=QGpN
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
