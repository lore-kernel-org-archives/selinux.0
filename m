Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4NLZZqR025022
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 17:35:35 -0400
Received: from smtp-2.emich.edu (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4NLZY9T016621
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 21:35:34 GMT
Received: from [192.168.0.5] (c-69-140-139-57.hsd1.md.comcast.net [69.140.139.57])
	(authenticated bits=0)
	by smtp-2.emich.edu (8.13.1/8.13.1) with ESMTP id k4NLZTaX019858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <selinux@tycho.nsa.gov>; Tue, 23 May 2006 17:35:31 -0400
Message-ID: <44738020.3090200@tubbs-net.com>
Date: Tue, 23 May 2006 17:35:28 -0400
From: Christopher L Tubbs II <chris@tubbs-net.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: HTTPD network access Policy Problem
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm reasonably new to SELinux, but I noticed recently that a change I
made in my policy (from the GUI system-config-securitylevel) a while
back to allow the HTTPD to have network access so I can use Web-based
mail scripts now does not seem to work. The only change I've made since
then was period "yum update" with the occasionally policy updates
through that. However, despite the fact that the GUI still shows the
settings that I had changed in the past, the policy is still blocking
access (It works in Permissive mode). Can anybody perhaps explain why
this might be, and what specifically I should check to verify the
settings and make this functional again?

Rainman
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEc4Afc/oGTmWP/osRAuMQAJ4kkjm6paSyTq6cfWn+I+DximpXXgCcDZYj
4vYKYm2FIB462KuAeHVr+0c=
=/P3k
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
