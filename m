Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9EDYVR5026211
 for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2015 09:34:31 -0400
Received: by wicge5 with SMTP id ge5so237299134wic.0
 for <selinux@tycho.nsa.gov>; Wed, 14 Oct 2015 06:34:25 -0700 (PDT)
Received: from x250 ([84.245.63.179])
 by smtp.gmail.com with ESMTPSA id iw8sm10108423wjb.5.2015.10.14.06.34.12
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Wed, 14 Oct 2015 06:34:12 -0700 (PDT)
Date: Wed, 14 Oct 2015 15:34:11 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: does load_policy default to loading the lowest polvers available?
Message-ID: <20151014133408.GA5222@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512


I had some issue that just confused me (to say the least) It seems that
I have now solved this.

There were two policy.X files in my /etc/selinux/SELINUXTYPE/policy dir,
on 29 an one 30. The 29 seemingly had a bug in it.

It seems that load_policy (or its libselinux equivalent) defaults to
the lowest policy available (29 instead of 30 in this case)

Why is that?

I fixed the issue by removing the policy.29 file (i think at least)

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWHlnMAAoJENAR6kfG5xmc0IsL+gPvY2hmVUW/77tfYW4ruSJS
F29xdIZiFh/70Nv10T8rWmyY/8YzMELucGMg8117FeFUe0V8YRdBtkOYDwCDrZLh
9uAs3Jrnfa109XxE5PQGAgqIZtfAFTKSpNylDoQPg6kcFWCo1nna3EjgaIC8KuW7
FxpWv/27DtequhIjgwNiW2jhzBhwmfKlCSa1BryRzecoboIz7ApDqdiGQAeNCc8i
I+x6MXZ8P/F2K1aTutJhzjmOUR+7Oy+0il9wtdxGwEbD+GrVLLFBXi5/k9/pNyVX
+hwQTTputG1SJ3JAX3/mFa7OmDvdADxWBXvcw7yWLD6moO3nMcW76QiphbNFu1aF
Vtu037e+TnbQGMqSi2sFllzlGXR9MmWeKcDcF5Nl0P4pVmDbuFcvBcYmlR6VfAqE
fpooQinx130pLHe2vVQqfdPChIlT6wmTX7uPO9/ax16xWrZYjY2bZqaycI5uYCV9
RZIdWUCF+i5JiNKoNjQkJVCI3hdzEoM5aI9iZ3H3MA==
=CMCd
-----END PGP SIGNATURE-----
