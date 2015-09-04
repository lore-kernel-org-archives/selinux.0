Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t84BYN96004228
 for <selinux@tycho.nsa.gov>; Fri, 4 Sep 2015 07:34:23 -0400
Received: by wiclk2 with SMTP id lk2so14843786wic.1
 for <selinux@tycho.nsa.gov>; Fri, 04 Sep 2015 04:34:20 -0700 (PDT)
Date: Fri, 4 Sep 2015 13:34:18 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: Enable user_xattr - Selinux failing
Message-ID: <20150904113418.GA3733@x250>
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
> 
> 
> * SELinux requires the root '/' filesystem support extended
>   filesystem attributes (XATTRs).  It does not appear that this
>   filesystem has extended attribute support or it is not enabled.

It is refering to "security" extended attributes and not "user" extended attributes

> 
>   - To continue using SELinux you will need to enable extended
>     attribute support on the root device.
> 
>   - To disable SELinux, please add "selinux=0" in the kernel
>     command line.
> 
> * Halting the system now.
> 
> My fstab is below :
> 
> rootfs                  /               ext3
> defaults,acl,user_xattr 0 1
> 
> Any idea where is the problem?
>

See whether your file system supports "security extended attributes",
and whether that support is enabled in your Linux configuration. When
those requirements are met nd it still does not work, see if your
selinux policy supports the file system.

> Thanks,

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

iQGcBAEBCgAGBQJV6YG1AAoJENAR6kfG5xmcj94L/iRCtn8pFqDOSqv1mrgmBBim
sAkAdtRq60w3YfLXblYeYxKwthZYYBamF/wsrMKxQ0X7vcpFO82ymzcOOb/AWGV/
LoI0I3w3OfdnFZyJrbc+C1KlXpmmVkvzmdWHW00oEMipGI9RBx0Wd2hY5/XVGG4B
+rAp4Kkvnnf4gGgKmZX3pa7OsS5j8fGvTSELqgg6/4UpO+yrkftTRu8y/E930JAF
eKbbE97vbZkIz57PjGiqLVTdsD0gCA46V2kVqNecFxxHAbrFJaHbjDxdw/u8uoaN
9Nftq7whzeDaWXOO97io6T8uVVmZd37+8ewBFR4Lc2+wXdX1G8dHhi15PIGQMfYw
nFuc4efQKeNd+mtAeN8gOBQySEkrVtfXBsr7WI4DgZ+Lh9ERmwz9ZuZwiUdegOMk
WRk/jamPyIska8JJPCvLLCMfkapN1ZNFLGalf7dVGNJjbnyDkIUPfA9GVaa+Z3rN
EWpOJwC+GC1BY36l6gW2y4WKaZU03XGYtan/ioCG9w==
=USvg
-----END PGP SIGNATURE-----
