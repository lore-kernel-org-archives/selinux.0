Message-Id: <200503180526.j2I5Q5OP012774@turing-police.cc.vt.edu>
To: Jun OKAJIMA <okajima@digitalinfra.co.jp>
Cc: SELinux@tycho.nsa.gov
Subject: Re: Do you trust X server? 
In-Reply-To: Your message of "Fri, 18 Mar 2005 07:28:58 +0900."
             <200503172228.AA00008@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
From: Valdis.Kletnieks@vt.edu
References: <200503172228.AA00008@bbb-jz5c7z9hn9y.digitalinfra.co.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1111123563_5017P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Fri, 18 Mar 2005 00:26:04 -0500
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1111123563_5017P
Content-Type: text/plain; charset=us-ascii

On Fri, 18 Mar 2005 07:28:58 +0900, Jun OKAJIMA said:

> Then, if it has ( and it must have ) a buffer overflow or any vulnerability,
> and it would execute some cruel code if a certain drawing commands set comes.
> A cracker makes web sites contain htmls or SVG or ... to make a such commands
> set to be displayed. Then, you can be cracked with just browsing the pages,
> not being required to click untrusted contents explicitly.

Much more likely, a malicious website will cause the *browser* to become
exploited due to a bug in the browser (which *is* a real threat, and the
reason there's a mozilla_t policy).

For a remote exploit of the X server itself, you'd have to find a way to
exploit the X protocol, which is *very* low-level - even something like a
scrollbar is just 10 or 20 "draw this set of pixels" requests, a button is
a request to draw the pixels in the face, then maybe write a string at a
given location on the screen (for the label), then several more requests for
drawing pixels for any highlights/shadows for a 3-d effect. Then the X server
sends back things like "mouse button 1 clicked at X,Y coordinates", and the
program has to figure out if it's on the scrollbar or button, and if it is, ask
the X server to draw *new* pixels for the "pushed in" button's border, and so on.

There's probably plenty of bugs left in the X protocol - but you'd have to find
a way to make a browser make the buggy request without also crashing the browser,
and the exploit would likely crash the X server as well.

--==_Exmh_1111123563_5017P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCOmZrcC3lWbTT17ARAj5EAKC2kh+Z2YjpKMJhB9QOGpf2IWyZ8QCgwNG6
IPtIAPXfdmDminjunosyRx0=
=BsFZ
-----END PGP SIGNATURE-----

--==_Exmh_1111123563_5017P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
