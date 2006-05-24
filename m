Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4OIB3SE014291
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 14:11:03 -0400
Received: from wr-out-0506.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4OIB2bH028194
	for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 18:11:02 GMT
Received: by wr-out-0506.google.com with SMTP id 68so675837wri
        for <selinux@tycho.nsa.gov>; Wed, 24 May 2006 11:11:02 -0700 (PDT)
Message-ID: <4474A024.5010103@gmail.com>
Date: Thu, 25 May 2006 03:04:20 +0900
From: Tetsuji Maverick Rai <tetsuji.maverick.rai@gmail.com>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Gentoo SELinux problem in enforcing mode
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi,

I installed SELinux on one of my Gentoo box but it doesn't work in
enforcing mode at all.   It looks like almost anything is denied even
with the base policy as provided in Gentoo's package.  For example, if
enforcing mode is enabled during an X Window session, all inputs from
the mouse or keyboard is denied.   On commandline console,
"ctrl+alt+del" gives "reboot not permitted"-like error...

I have tried SELinux with old Redhat some years ago, and didn't find
such a problem and now I feel this is very unusual.  What wrong do you
think I am doing?   I have tried with generic 2.6.16.16, but now I'm
installing 2.6.16-rc6 plus nsa's patch at
http://www.nsa.gov/selinux/code/download5.cfm (but other file, policy,
libselinux etc are from Gentoo's package).  What's the difference in
this patch from the generic kernel?

Any hint/suggestion is appreciated!

regards,

- -Tetsuji
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

iD8DBQFEdKAj1ZfmZ4IzXNkRAnz6AJ9XlBTLXMqr1gU+s8gjjYGWeMNN/gCfYhSy
UqCzqeRnwMccMwVrxmbPZeg=
=GAHq
-----END PGP SIGNATURE-----

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
