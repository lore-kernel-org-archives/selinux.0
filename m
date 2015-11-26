Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tAQGqHmb004077
 for <selinux@tycho.nsa.gov>; Thu, 26 Nov 2015 11:52:17 -0500
Received: by wmww144 with SMTP id w144so28251216wmw.1
 for <selinux@tycho.nsa.gov>; Thu, 26 Nov 2015 08:51:48 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id e83sm3514689wmc.23.2015.11.26.08.51.47
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Thu, 26 Nov 2015 08:51:47 -0800 (PST)
Date: Thu, 26 Nov 2015 17:51:46 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: does load_policy default to loading the lowest polvers available?
Message-ID: <20151126165145.GA26909@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I *think* i have this issue figured out now. It seems that it was
mcstransd. Now that I have disabled it, the issue seems to be gone (only
tested a couple of boots but i am hopefull)

When I did a firmware upgrade, requiring phyiscal access I noticed that
/bin/login requested mac_admin, and that it wanted to set the context of
tty1 with the translated security level (SystemLow), but that somehow
this didn't work and so it was unable the relabel the tty.

Obviously that is not directly related to the systemd issue since by
then systemd would already have failed. It did however prompted me to
think about the possibility of mcstransd's presence being related (since
only that system has mcstransd enabled, and this issue is only on this
system)

So i decided to just have a look and see what happens, and things
started working. Booted a couple of times without mcstransd enabled and
all if well so far.

So mcstransd causes problems, and i have disabled it

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWVzicAAoJENAR6kfG5xmc72QL/iR20UjuQfzDNSzLt21J2ypQ
SSJDf/3VB9qDnBJ/r+O3UBp3uCDl/UUHpi7hNziw6A875LE/3vB8Ohjg/YmQnVVP
lQo/LpFFAx78WeyUxjja956TimXwlDyEKaCwwh0zgTXt6rIEa3eKqtNN+qOt5mib
L/TmSdbVJmqn/ZyB57noENLMJcBplR2C8cJRiWmPvr8FVb3tEW+VXHZuQSjHWOWR
PT5JwLpRhjSLfBUvMdWD+pRpuUvqzZ1s2l82sP3vl66iq33jAUI/R6P13kC6yOnH
E1PJeyKd0IhH42UpmKGSelYL0dcyPEDWTA7a/yBBgeDyPhJfdHvYbB7bz5aS0qvw
BSohVOvF4fJ2gfIfckX30NY1JuN4LHTSGDGrMOT/UdXvS6J/JM38zeWh3UIkWgdN
VM5SDbj0/UV01LaPMDgPo0qZl2nEDtzXfjj33bDZsn5J+t/V4SZ/OQ5k3Ca5m0nN
9g6ysP7sy0K66fB3kbzRksxiyo6e6zbDbEwvyDVgrw==
=N1O+
-----END PGP SIGNATURE-----
