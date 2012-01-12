Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q0C9Exn8018830
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 04:14:59 -0500
Received: from mail-wi0-f181.google.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id q0C9ErmI026184
	for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 09:14:53 GMT
Received: by wibhr12 with SMTP id hr12so1254782wib.12
        for <selinux@tycho.nsa.gov>; Thu, 12 Jan 2012 01:14:52 -0800 (PST)
Message-ID: <4F0EA482.5050109@gmail.com>
Date: Thu, 12 Jan 2012 17:14:42 +0800
From: Xin Ouyang <xinpascal@gmail.com>
MIME-Version: 1.0
To: Daniel J Walsh <dwalsh@redhat.com>
CC: eparis@redhat.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH 20/25] libsemanage: Fallback_user_level can be NULL if
 you
References: <4EEFAC91.6060903@redhat.com>
In-Reply-To: <4EEFAC91.6060903@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------010101050408030503050601"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is a multi-part message in MIME format.
--------------010101050408030503050601
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

segfault still not exist.

1. Download and extract refpolicy-2.20110726.tar.bz2
2. cd refplicy && edit build.conf
TYPE = standard
...
3. make conf && make policy && make load
...
make: *** [load] Segmentation fault (core dumped)


The attached patch will be OK. :)

- Pascal O.Y.


On 2011年12月20日 05:28, Daniel J Walsh wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
>     This patch looks good to me. acked.
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.11 (GNU/Linux)
> Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/
>
> iEYEARECAAYFAk7vrJEACgkQrlYvE4MpobP4ewCfUTl1JHSaXTpPtNUn1yJWDo1j
> TMgAn0HPi8GRUqi8WdOugTGJReqXBKUV
> =MQcr
> -----END PGP SIGNATURE-----


--------------010101050408030503050601
Content-Type: text/x-patch;
 name="0001-libsemanage-Fix-segfault-for-building-standard-polic.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-libsemanage-Fix-segfault-for-building-standard-polic.pa";
 filename*1="tch"


--------------010101050408030503050601--
