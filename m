Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84CtiU0011157
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 08:55:44 -0400
Received: by wibz8 with SMTP id z8so16782697wib.1
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 05:55:14 -0700 (PDT)
Date: Fri, 4 Sep 2015 14:55:11 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Enable user_xattr - Selinux failing
Message-ID: <20150904125511.GD3733@x250>
References: <CA+=dQ-93w_WampuSFteVv6OU8RLiGMJ7XFVP-srpm6MwTE0aFw@mail.gmail.com>
 <20150904123846.GC3733@x250>
 <CA+=dQ--MhrCxc_s7HNwLCTvLWxQMpmh+8Vh9ZtxMAiSPDwu7Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ--MhrCxc_s7HNwLCTvLWxQMpmh+8Vh9ZtxMAiSPDwu7Ng@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 04, 2015 at 06:15:48PM +0530, Divya Vyas wrote:
> 
> If you see the below link, the error message is below:
> 
> 
> https://github.com/flihp/meta-selinux/blob/master/recipes-security/selinux/selinux-config/selinux-init.sh
> 
> The script just does the check-rootfs and some check steps.
> 

That check-rootfs function looks fragile. I suspect the script is the
problem but I am unsure. 

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
http://keys.gnupg.net/pks/lookup?op=vindex&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV6ZSqAAoJENAR6kfG5xmc3MEL/AztWNla1RvaGZdDk5iUw5lD
DM3gwIeUNgvx/VaQYPFQg5gCFigjeliNZITAIZH5AdEAJK1yO3CYrZpGeQ6kfRcj
Cb40qcUhPGglA4JtBeDqA2VmsRvfuoKhD3cUD0GIHZ1Lcw6xATYZ6sXH+3EgmUdR
9m6jkxpZmJezDzXq9X2a4WHAlix47vD05l63om7gcCbEdREzv2NXUFSUSUVn1Uk6
xKDC5wlgQrdTdocrg52LALlroqVOiJ+HItiYE3NWy3AoEkqXlbNFcBfr4JJtkxgW
IpYs3W8lYbmqM8RoYFbx3H1SQFIIrn7iFETTXGm0Jh8NBbfJQJGLGhBiPG3CE2Ue
W2b51ZQEnjfnkAHwgAq1ay38luyLp72pQvOrPnyw3cStpPIR5+5Nbm03Gg/dooYA
oo6jzpKNJPz7MW/i9Czl4/Gk23Yq58Q9YoLIXxHECMKYN/UwerlkUHyzKrjdao+z
N58DJ7ESSPdx9R1RmZDEe9SmJwxuFceXQd17A5gEDw==
=ua/M
-----END PGP SIGNATURE-----
