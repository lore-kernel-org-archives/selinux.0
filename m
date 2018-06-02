Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w520UxSZ002053
 for <selinux@tycho.nsa.gov>; Fri, 1 Jun 2018 20:30:59 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 40yMYs0SS5z25sS6
 for <selinux@tycho.nsa.gov>; Sat,  2 Jun 2018 00:30:57 +0000 (UTC)
Received: from UPBD19PA04.eemsg.mil (unknown [192.168.18.5])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 40yMYq1SKRz25sRv
 for <selinux@tycho.nsa.gov>; Sat,  2 Jun 2018 00:30:55 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 Andreas Dilger <andreas.dilger@intel.com>,
 James Simmons <jsimmons@infradead.org>
Date: Sat, 02 Jun 2018 10:28:38 +1000
Cc: linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, selinux@tycho.nsa.gov,
 lustre-devel@lists.lustre.org
In-Reply-To: <20180601091133.GA27521@kroah.com>
References: <20180601091133.GA27521@kroah.com>
Message-ID: <87bmcurpzd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
Subject: Re: [lustre-devel] [PATCH] staging: lustre: delete the
 filesystem from the tree.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--=-=-=
Content-Type: text/plain

On Fri, Jun 01 2018, Greg Kroah-Hartman wrote:

>
> So, let's just delete the whole mess.  Now the lustre developers can go
> off and work in their out-of-tree codebase and not have to worry about
> providing valid changelog entries and breaking their patches up into
> logical pieces.

I find it incredible that anyone would think that not having to "worry
about providing valid changelogs" and not "breaking their patches up
into logic pieces" could ever be seen as a good idea.  I hope that if
lustre development is excluded from mainline for a time, that we can
still maintain the practices that demonstrably work so well.

For the record: I'm not in favor of ejecting this code from mainline.  I
think that the long term result may be that it never comes back, and
will like at least delay the process.
But you must do what you think is best.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlsR5LcACgkQOeye3VZi
gbmPsxAAvr7MWTuOxOV9FtPuu+c6OuCKo35Mg5WG3X4OpEUSqSitN8cmEB/2kAWX
kPkXgWBeoczSOCLG+hJgUD87iDgGqAn6A/D3vDlHOmcKWAipu7DurZhPKEt6qC3S
GjtNSejb98G/tAgeVnPAyTFXdQBx6KPCMeg+MfbNzzxQKCXfmUxNuASx1EmXQH6z
zuDERm9jnF5jbTIox53D4in0i5GEUBbUOiD4K+MnDNhiyh02Kr8dCkUoKs1UJOJX
H7sfaYJZumJuP9fL8GSqBk+AB1SJH/Box4o1JyI/u4XKHNxVw+BuT2ptWUA6vyBb
Snja80L/LDH0Mm/AgWZYt+yR5NSc1onAU1LgfwnRj/UFVMFJvc2ZWBSBzvVGG7eB
Uj2uBqCFYJ6az8wVWzWjhZfHlcemyTCR+nHIm+AwFXxmK5m5+hRbsJC9+sK3IWIv
zl9gGrfLJK1FBAAGzMZ5hyyQkAlHFoSN2lo/HxknfT6SLrMsjWgR2KnyiajdXVEs
rKF2/F8T4QeMaSMbWtpu2qtcV49v3/qpIC6L1ysWFHcLRhduFguunQjQOJdnJHHL
WReoEYi9ianU5tXrfDzJNZZOW5z9DaWSgxJAQ/MDxw1dREDN468xsIXf9GrVvKMv
nA4w+ADktG3het9Z6Hv3dHSq+Ffvi7ynuRW43r/Tj/BoGGk1N80=
=zyLF
-----END PGP SIGNATURE-----
--=-=-=--
