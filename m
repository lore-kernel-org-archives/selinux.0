Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tADFSiMk008865
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 10:28:45 -0500
Received: by wmww144 with SMTP id w144so33298618wmw.1
 for <selinux@tycho.nsa.gov>; Fri, 13 Nov 2015 07:28:33 -0800 (PST)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id u205sm4436005wmb.12.2015.11.13.07.28.32
 for <selinux@tycho.nsa.gov>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2015 07:28:32 -0800 (PST)
Date: Fri, 13 Nov 2015 16:28:31 +0100
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: CIL: question with regard to CIL ioctl filtering support and
 neverallow
Message-ID: <20151113152830.GA21890@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512


This commit added iotctl whitelisting support to CIL:
https://github.com/SELinuxProject/selinux/commit/ef93dfe0393c4a60483c3f7729dd98a2f886606a

then later CIL whitelisting was extended with neverallow support here:
https://github.com/SELinuxProject/selinux/commit/99fc177b5af4e1e8855d42d2d01cb93ac7f9d14b

would the CIL ioctl whitelisting support have to be extended with the
ioctl whitelisting neverallow support as well?


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWRgGZAAoJENAR6kfG5xmcZQQL/1ZzGHtKxJRYeyXn9rdrihG3
p5RgNiqNYrdlTHv2OF6E8YrTQ9pr6Qcg06x3aIMyewT3X/MekVN8B4Ren09oEqdR
50Oxw10/qPGSGglyU8o/jg+/gTUXHBUS3WYMIRtnTO0FkeZ+qEarF9FA/eNK1md+
AQ+ZLBVzXrU3Y386+AoBmi9MbE2YpVZ2D1O+3W4yssK15vsZatt3fTxs43K05rdX
9LrSPk2yl9RoICqWfPyvDPvgI3XCDynHktxs2mwuHkitnpAzWnKGPt1okaLVkrEu
lgLcum4aPHAGy+hBNCi+p7lVSa9+J4kCYCQ89Q1jno9Dj6mDt+SqECFMB/peeAN0
GCdotRhsf/lf1pi3fl0oS2UhUMOe6585ac0v/iPX+pEdJ7Tn/Kqqz4j78FSmpqbu
tO0RJa7v6+Ud5f5YiL84+ikzMe7DeVoeP1MM/laPBjB+Jg8/Lp9Bid9Iuk2yZjOd
xQBsvYuYowA8SfjNYafGAqfr477poW4L6lEPGdVVTg==
=JKo/
-----END PGP SIGNATURE-----
