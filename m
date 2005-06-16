Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5GFuigA001666
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 11:56:47 -0400 (EDT)
Received: from turing-police.cc.vt.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5GFlaI8017453
	for <selinux@tycho.nsa.gov>; Thu, 16 Jun 2005 15:47:37 GMT
Message-Id: <200506161547.j5GFlq24013760@turing-police.cc.vt.edu>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: KaiGai Kohei <kaigai@kaigai.gr.jp>,
   SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: ANN: SELinux Reference Policy Release 
In-Reply-To: Your message of "Thu, 16 Jun 2005 11:17:23 EDT."
             <1118935044.18294.75.camel@sgc.columbia.tresys.com>
From: Valdis.Kletnieks@vt.edu
References: <1118871745.18294.28.camel@sgc.columbia.tresys.com> <42B18324.6020502@kaigai.gr.jp>
            <1118935044.18294.75.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1118936871_5710P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Thu, 16 Jun 2005 11:47:52 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--==_Exmh_1118936871_5710P
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jun 2005 11:17:23 EDT, =22Christopher J. PeBenito=22 said:

> I don't know much about encodings, but apparently editors (I tried vim
> and gedit) will save it as ASCII if there are no non-ASCII characters,
> even if you explicitly set UTF-8.

That's because UTF-8 with no non-ASCII characters is defined to be the sa=
me
as the equivalent ASCII.  You end up using the UTF-8 encoding escapes to =
encode
non-ASCII characters - no non-ASCII, no escapes, and it's just plain ASCI=
I.

--==_Exmh_1118936871_5710P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFCsZ8ncC3lWbTT17ARAlbwAKCQ/sALCDHAHJapN6+lKNlmemnrDwCgjQRo
Dgnw/OkmKKf+g9CQM5cLHSY=
=7NEC
-----END PGP SIGNATURE-----

--==_Exmh_1118936871_5710P--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
