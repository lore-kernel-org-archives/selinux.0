Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84CcslV009855
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 08:38:54 -0400
Received: by wicge5 with SMTP id ge5so16276454wic.0
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 05:38:50 -0700 (PDT)
Date: Fri, 4 Sep 2015 14:38:47 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Enable user_xattr - Selinux failing
Message-ID: <20150904123846.GC3733@x250>
References: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 04, 2015 at 04:34:42PM +0530, Divya Vyas wrote:
> Hi,
> 
> I am getting this error while building the selinux enabled image.

What "selinux enabled image" are you refering to? What is your distribution?

> 
> 
> * SELinux requires the root '/' filesystem support extended
>   filesystem attributes (XATTRs).  It does not appear that this
>   filesystem has extended attribute support or it is not enabled.
> 
>   - To continue using SELinux you will need to enable extended
>     attribute support on the root device.
> 
>   - To disable SELinux, please add "selinux=0" in the kernel
>     command line.
> 
> * Halting the system now.

I do not think that the above is a "selinux message". Could this be some
third party script/application? Maybe the script/application is flawed.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6ZDSAAoJENAR6kfG5xmcMtkMAJtUpqfbHsd8bASrn+hsZxor
8SPoWpBR481kV6gv4pcuDRvzeyOqvdSBk5Y2OZATblwAuC7Uh49BeL7DsN8WzU4b
144IqZmqjUPhSZqBQBI8v6ZkST8hcxnNKrPIuWNDTPLhJd5VZ/F6XRa9bRUj8s2x
7rScvBVqD/w/nIK/6mL//sXwgQc4b90PHFppMwhu7/SJ6tJWtsPz8JdfsDd8Fw+L
gqdBE3dpMYS7y1o1AZNSnoVN1H+WXU1CRleCJ2h+/xf7fkx3HMpoqtzH50ZN0WBg
I0ofpTGbcXR1VjZ/DcIBAAmaCI4/UAvkQimC5JjYn2eO3h/p6DBG8lCf+rLntrf0
AUYQ8To7kcUFQffvSbxhE5Au1LUssCE/d22WBCsE671/6kCdabkLR+Rn+oRlY3Gw
h7snDftce3C5EMqFjPiRPHZdtXSp+slPVA85h3M8zkRHaIEyyidUu0UZlio4Wn8a
tXXGAG2+l7VWtSVHyW8IMCpUd42zrYGeVOwI7C7Tqg==
=xGwb
-----END PGP SIGNATURE-----
