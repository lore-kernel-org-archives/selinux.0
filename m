Message-Id: <200503181658.j2IGwvuT012404@turing-police.cc.vt.edu>
To: Tom <tom@lemuria.org>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Do you trust X server? 
In-Reply-To: Your message of "Fri, 18 Mar 2005 09:35:12 +0100."
             <20050318093512.E5491@lemuria.org>
From: Valdis.Kletnieks@vt.edu
References: <200503172228.AA00008@bbb-jz5c7z9hn9y.digitalinfra.co.jp> <200503180526.j2I5Q5OP012774@turing-police.cc.vt.edu>
            <20050318093512.E5491@lemuria.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1111165136_4882P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 18 Mar 2005 11:58:57 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1111165136_4882P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Mar 2005 09:35:12 +0100, Tom said:
> On Fri, Mar 18, 2005 at 12:26:04AM -0500, Valdis.Kletnieks@vt.edu wrote:
> > For a remote exploit of the X server itself, you'd have to find a way to
> > exploit the X protocol, 
> 
> Not true.
> 
> This was 2002, and it was a DoS, but it shows that the X server can be
> attacked through remote applications:
> 
> http://web.lemuria.org/security/mozilla-dos.html
> 
> The short: A font-rendering bug in X can cause a system freeze if mozilla
> is instructed to render a huge (like 1666666 pixels) font.

Which is what I said - you'd have to find a bug that you can exploit through
the client.  And as I *also* said, even if you *found* such a bug, it would
*probably* result in a crash of either the browser or X.

And how many issues have there been with Mozilla and Firefox since 2002?

I'd worry more about those...

--==_Exmh_1111165136_4882P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCOwjQcC3lWbTT17ARAh/3AKDO5y/GKoNZvU+2tQwQy1tjm2NBMQCeJLGL
EDdG6Phb5Z1uQz+FZNftCgo=
=4noz
-----END PGP SIGNATURE-----

--==_Exmh_1111165136_4882P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
