Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA03200
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 04:21:17 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id JAA21922
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 09:20:40 GMT
Received: from rhenium (rhenium.btinternet.com [194.73.73.93])
	by jazzband.ncsc.mil (8.9.1/8.9.1) with ESMTP id JAA21918
	for <selinux@tycho.nsa.gov>; Tue, 16 Jan 2001 09:20:39 GMT
Received: from [213.1.153.114] (helo=security1)
	by rhenium with smtp (Exim 3.03 #83)
	id 14ISIj-0004mM-00
	for selinux@tycho.nsa.gov; Tue, 16 Jan 2001 09:21:14 +0000
Reply-To: <mpemble@isintegration.com>
From: "Matthew Pemble" <mpemble@isintegration.com>
To: <selinux@tycho.nsa.gov>
Subject: RE: Goal / Danger: Attack by malicious root
Date: Tue, 16 Jan 2001 09:22:45 -0000
Message-ID: <004801c07f9d$e2d86780$0a02a8c0@pemble.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <Pine.LNX.4.21.0101151453430.18627-100000@mail.thesportsregister.com>
Sender: owner-selinux@tycho.nsa.gov
List-ID: <selinux@tycho.nsa.gov>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Consider, for a moment, the irony here. 

For the record, the "boot from your own device" solution, I agree
with, as the only way of establishing trust in your OS (although
keystroke loggers that don't use OS functions, video capture devices
etc in tampered hardware can still get you).

Take a step back - we are assuming an attacker, whether a legitimate
holder of super-user privileges whom you do not want to have access
to your data or protection against an "Evil Minded Toad" who has
stolen root.  In the former case, limiting the privileges of the root
user through MAC is good protection (assuming you can generate or
request your own MAC labels and root is not the MAC privilege
assigner.)  In the latter case, if the lab environment allows you to
boot a CD, they don't need to "hack", they can craft a malicious
version of the OS and boot that.

You, a specialist user who reads a security mailing list may be safe,
but the vast majority of users will be at greater risk than if
booting from a CD was prevented.  Who are we trying to protect?  Us
or the normal user - consider, when your boss is writing your annual
report, will (s)he take these precautions.  Mine won't.

Matthew Pemble, Principal Consultant, IS Integration,
Preston Technology Management Centre, Marsh Lane, PRESTON,
Lancashire, PR1 8UD

Tel: +44 (0)1324 820690  Fax: +44 (0)1324 826034

Head Office: 
Tel: +44 (0)1772 885850  Fax: +44 (0)1772 558881
Mobile: +44 (0)7050 128620
Mailto:mpemble@isintegration.com  Web: http://www.isintegration.com

This email and any files transmitted with it are confidential and
intended
solely for the use of the individual or entity to whom they are
addressed.
If you have received this email in error please notify your system
manager
or IS Integration Limited on +44 (0) 1772 885850

Any Views expressed in this e-mail message are those of the
individual
sending the message, except where the sender specifically states them
to be
the views of IS Integration Limited. 

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 6.5.8 for non-commercial use <http://www.pgp.com>

iQA/AwUBOmQOhGrvMjpl5yaUEQLQwQCgjiquMMxqV4j54RiMZF0kptVtl2sAoOQm
NmCkT9tsDvLjwn6OyNGlMAlF
=/MHf
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
