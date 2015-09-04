Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84C8kv4007230
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 08:08:46 -0400
Received: by wicfx3 with SMTP id fx3so20399589wic.1
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 05:08:43 -0700 (PDT)
Date: Fri, 4 Sep 2015 14:08:41 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Enable user_xattr - Selinux failing
Message-ID: <20150904120840.GB3733@x250>
References: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
 <20150904113418.GA3733@x250>
 <CA+=dQ-_AesBZxnWWu80W0sr0gAQu9G=+NjbHkYF0qoQDnAf7MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ-_AesBZxnWWu80W0sr0gAQu9G=+NjbHkYF0qoQDnAf7MA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 04, 2015 at 05:29:53PM +0530, Divya Vyas wrote:
<snip>
> 
> My filesystem is ext3 . I think all configs are enabled.
> 
> How to check whether policy supports filesystem?
>

Looks like it

seinfo --fs_use | grep ext

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6YnEAAoJENAR6kfG5xmcgoUMAJM921GYecpUb3AFKFtLo6bW
2r3wckkKcv0S2QDSa1kSfyCmXp2blGFYtI3ywn1U0xo+jCsNirsE+MZrEzJU8HcI
rXh+SF4BxxwZKBNqH+CqcR4S+XQ3Z2hkUjjLDljpLz3tgsmQVNTCRnjMa+8zqcq/
uK+fyNeR2aO8GAq1Xmd+MKE0lTmnq7EkU/lcvLOEQzhiBisdrV7DzI0yV3nw7dI0
3S/PXga2yAWEurHroPPGlFM0PLmb8B4VQHM3e711r/jRKuxmFe4eAtzPzS71qDxM
0FopQYfXRJWu/NqPdkp5xaGEtP865A5wJsOBeAkA3mNiBdhF6gDW5we5/+Vw4DPQ
A6gUMjprcpNXDRxqeJPxq2Fz5wQYaNsGvGANLydIFzttSYZbAqmfNR5k4UR1iE7a
0hMS8LOiqN0jwzGlCacldJbGlO7am5emAJ62EmVeFUAQAkYPJrMJzdMul9KaFjm8
nTLeOv/1XgxGkCRkLde2R+t6GFLBg6PeVw7d+IAzNw==
=G1xo
-----END PGP SIGNATURE-----
