Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8PFFop3001559
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 11:15:50 -0400
Received: by wiclk2 with SMTP id lk2so26444981wic.0
 for <selinux@tycho.nsa.gov>; Fri, 25 Sep 2015 08:15:47 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id w1sm3804720wjz.37.2015.09.25.08.15.46
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Fri, 25 Sep 2015 08:15:46 -0700 (PDT)
Date: Fri, 25 Sep 2015 17:15:44 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: selinux network control question
Message-ID: <20150925151543.GA29665@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I am trying to clean up my network policy module but some things are
unclear. Could anyone shine some light (or correct me) on the below:

1.
network interface labels are no longer checked in any scenario (secmark,
netlabel, labeled-ipsec) and the netif isid is no longer used.

So i can remove my netif types and associate the netif isid with a
context reserved for unused isids?

2.
Above also applies to node labels (ie. nodes are no longer checked in
any scenarion (secmark, netlabel, labeled-ipset)

The question is then why is the node isid still working. And why do i
need to allow some processes to bind to nodes with the context
associated with the node isid?

why is the node isid still used?

3. packets are checked with secmark, and you can associate different
packet types with different packets)

4. peers are checked with netlabel, but you only need on peer type
(ie. you can't associate different peer types with different peers)

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWBWUbAAoJENAR6kfG5xmciHEL/iRIF1VO4uLwgabP3+YEhw80
exC7tyGPy/qKpYUOB9RWjdzRNVdGYIxj2rYpGRNsTJQXWkdEGcQBkMVsF1YeAJsi
55jtPcyc0R+pcn7abo9FbdeSUtx1Xd99ji6ZajOl0A39PauzMzxYFOE2F6bnVUKn
0C7MgiXCxN2SLya6//v3ZniszwSlEqLrUTkvoaUr92SLbQqUay9xpOhUaGqrwid9
5i6lKnuFihuQEhMuv8OgXfEPjY9WnY/m1MK7LUtU3xvMH6CaQEkuvm/KYwhzwjJG
f+wc4dyOX5Ap7W5o10wAcmpcVM3w11mocBt+dkYLXzZkpYFi3GZK3zI4yzRFUEVf
tWFspmE30PhAbvpzBSA82k3M5EB66pGYr1gja+I6BC0Ali2Booz8uaGp64SpqNOO
8hlinJu2ZLCq/00NVOITOgzVGUCGMeG2f6U2quze7DJvrIGpnQ1QIEJIPCtBiP8K
sY2D4CU+Q587oSueHRf9sxqZmvPUJiNx0zhdIRPnAA==
=uvyT
-----END PGP SIGNATURE-----
