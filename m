Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id XAA17700
	for <selinux@tycho.nsa.gov>; Fri, 6 Jul 2001 23:57:39 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id DAA09351
	for <selinux@tycho.nsa.gov>; Sat, 7 Jul 2001 03:57:27 GMT
Received: from mail.harborside.com (mail.harborside.com [12.45.56.18])
	by jazzband.ncsc.mil  with SMTP id DAA09347
	for <selinux@tycho.nsa.gov>; Sat, 7 Jul 2001 03:57:26 GMT
From: "Randy -Harborside Internet" <randymb@harborside.com>
To: <selinux@tycho.nsa.gov>
Cc: <mcclellr@oit.edu>
Subject: SELinux + Engarde
Date: Fri, 6 Jul 2001 20:52:30 -0700
Message-ID: <JMECKPIMOJNMLPBBEGBDAEIJCAAA.randymb@harborside.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

 
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I'm currently putting together an engarde linux box
(www.engardelinux.org), and am going to attempt to compile the
SElinux kernel into it.
So far the only complications that I've run across is that the
default engarde installation comes with no compilers, etc.
whatsoever, so I'm brute-forcing those into the installation using
older Redhat RPMS. It didn't seem to like some of them, but it looks
like it will work with some tweaking.

My two questions are this:

1. There isn't a way to combine the LIDS kernel module with SELinux,
correct? I remember seeing something about LIDS earlier on the
mailing list, but didn't think it regarded to combining the two into
one kernel.

2. Has anyone played around with this, and if so...did it work or
fail disasterously? I'm trying it on a non-production server we have
laying around, so there's no worries if I mess up something, but I
was just checking so I'm prepared.

So far I've gotten the kernel configured, and I'll work on the build
tomorrow or after I get back from my week vacation starting Sunday.
If anyone replies and I don't respond, I've already left, but I'll
send something out to the list to let everyone know if I could get it
working or not, and what the results and performance of the kernel
integrated with that distro is.

Thanks,

Randy McClelland-Bane
Harborside Internet Network Operations
- --------------------------------------
1.866.435.3394 -- 469.8844 ext 409 
Mobile 541.290-8849
"Sed Quis Custodiet Ipsos Custodes?"
- --------------------------------------

-----BEGIN PGP SIGNATURE-----
Version: PGPfreeware 7.0.3 for non-commercial use <http://www.pgp.com>

iQA/AwUBO0aHfsXIY+0JvubyEQI5LwCfeZka0zUgyS7oDlNu/+f9GRmCYv0AoPac
Cjglz1ZnQr1FfUg/g2sZFK9O
=Bve7
-----END PGP SIGNATURE-----


--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
