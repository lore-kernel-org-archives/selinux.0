Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4GHXYna023128
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 13:33:34 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4GHXX07022009
	for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 17:33:33 GMT
Received: by wr-out-0506.google.com with SMTP id 57so24410wri
        for <selinux@tycho.nsa.gov>; Tue, 16 May 2006 10:33:33 -0700 (PDT)
Message-ID: <446A0CE9.6020708@gmail.com>
Date: Wed, 17 May 2006 02:33:29 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Is SELinux appropriate for my use?
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I'm considering SELinux on my Gentoo box, if it's worth installing.
My box is running apache2 with phpBB forum with mysql.   So only http
server is accessible from the Internet.   But I may begin to allow ssh
access.

I am dubious SELinux is necessary if I use only apache2 with phpBB and
other php based web applications.   Am I correct?   I am the only shell
user of the machine.

My understanding is SELinux is effective on a multi-user box.  Is it
effective when a hacker (cracker) tries to hack into my site using phpBB
or any other http based apps' vulnerabilities, executing his/her own
code?   Actually older version of phpBB had a vulnerability to run
arbitrary linux commands with apache permission.  If any such
vulnerability is found in the future, is SELinux effective?

Thanks in advance.

//tmr
- --
Tetsuji 'Maverick' Rai
Main http://maverick6664.bravehost.com/
Profile:
http://setiweb.ssl.berkeley.edu/beta/view_profile.php?userid=123
pubkey http://mav.atspace.com/tmr_at_gmail.txt
PGP Key ID: 82335CD9
Key fingerprint = 41CA 94B4 2A89 3FF1 5B11  BC37 D597 E667 8233 5CD9


-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEagzo1ZfmZ4IzXNkRAjIQAKDgECZnlABxzdDtHrXEEOWrg9fUmQCePiFr
08es4ztBpMDMEw5/hIhqA4E=
=aEBY
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
