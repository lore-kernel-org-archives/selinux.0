Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j0P8Ytsj002208
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 03:34:57 -0500 (EST)
Received: from moutng.kundenserver.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id j0P8WkcF017396
	for <selinux@tycho.nsa.gov>; Tue, 25 Jan 2005 08:32:50 GMT
Received: from [212.227.126.208] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1CtM9r-0006cS-00
	for selinux@tycho.nsa.gov; Tue, 25 Jan 2005 09:34:43 +0100
Received: from [80.229.223.243] (helo=[192.168.1.2])
	by mrelayng.kundenserver.de with asmtp (Exim 3.35 #1)
	id 1CtM9r-0003SC-00
	for selinux@tycho.nsa.gov; Tue, 25 Jan 2005 09:34:43 +0100
Message-ID: <41F6048C.1010309@tomaw.org>
Date: Tue, 25 Jan 2005 08:34:20 +0000
From: Tom Wesley <tom@tomaw.org>
MIME-Version: 1.0
To: SELinux <selinux@tycho.nsa.gov>
Subject: Problem logging into GDM after SELinux enable
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB3B6843F8DC06DF5FDD7988F"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB3B6843F8DC06DF5FDD7988F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Hopefully I've managed to follow the "conversion guide" on the Gentoo 
website and have run into a problem after the initial setup.

When logging in using GDM I get a message saying "Unable to set default 
execution context" and it returns me to the login screen.

I'm also getting

Jan 21 22:54:08 tom GDM[30170]: SELinux GDM login: unable to obtain 
default security context for tom.

in /var/log/messages.

I have

   user tom roles { staff_r staff_r sysadm_r };

in my users file and have rebuilt the profile, loaded it and relabeled 
the file system but am still getting the same message.

Does anyone have any ideas what I should try next?

-- 
Tom Wesley <tom@tomaw.org>

--------------enigB3B6843F8DC06DF5FDD7988F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9gSPVYNIRGKYOlIRAklhAJ9HNiYNKtNyO08KvOvff4c93lAxlACeOMzR
iVNFN5oKGXVAnjeJlctewWQ=
=ImSa
-----END PGP SIGNATURE-----

--------------enigB3B6843F8DC06DF5FDD7988F--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
