Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id tA6GQZeP019105
 for <selinux@tycho.nsa.gov>; Fri, 6 Nov 2015 11:26:44 -0500
Received: by wmll128 with SMTP id l128so38862987wml.0
 for <selinux@tycho.nsa.gov>; Fri, 06 Nov 2015 08:26:39 -0800 (PST)
Date: Fri, 6 Nov 2015 17:26:37 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Paul Moore <pmoore@redhat.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: New SELinux userspace release supporting extended ioctl
 permissions?
Message-ID: <20151106162635.GA10239@x250>
References: <1852496.Nbh2u1K4Uk@sifl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <1852496.Nbh2u1K4Uk@sifl>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Nov 06, 2015 at 10:37:35AM -0500, Paul Moore wrote:
> Now that Linux 4.3 has been released with the extended ioctl permissions, are 
> we planning to make a new userspace release so that we can take advantage of 
> this new functionality?  I believe all the necessary patches have been merged, 
> no?
> 

Are you referring to anything in particular?

There is already some support: https://github.com/SELinuxProject/selinux/commit/ef93dfe0393c4a60483c3f7729dd98a2f886606a

Applying ioctl whitelisting on GNU/Linux systems looks to me pretty hard
to do though. Many drivers, and their ioctls to support.

I also had a hard time determining what is what. This tool[1] helped a
little but it is still very hard to add support for the appropriate
ioctls to the appropriate interfaces.

- From a policy perspective I am just going to wait it out for now, see where
androids' sepolicy goes with this. I think they have the benefit of
limited hardware to support.

[1] https://bitbucket.org/billcroberts/fixup/src/0e49a67015a98f856199e41d1681117b4ae179b5/ioctl.c?at=master

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWPNS3AAoJENAR6kfG5xmcp+4MAJX3wIdQElrLifArveurVbOD
WVzcdFPtPVw9AL3SBM8A8Crjkc463STcwlv8S+lGpQWo3fpes60uIYK/+0sxN1r7
BFFYdisf+WtRQvC070kCBB+bmNejs8zX6Tz4XoV1yXG5EpuoPecn4EPT7vylg8Gm
+3s0gkqrOeTDZ+MW+HfKOZgxNHASvHDSwnCt+U9f9a2TINx1ceoN/r5vGLCB0dvQ
EXBtPjHSKFGAPGLF7xqq397OdofHxMBEfZbogsxyPXAJeF9/CuAIhKHQOcSA3waV
k5cAF7snEcYD9NpU965An+a1TcjAotxwYSj1SoTeJns6ZxQmZHfI1STKMaJBQpAv
GGJD7aNxBwzYYiUt4v9SIGVq+B0hrJpa/vm+rGNyc/f6ra3LZdRz9BpM9rwFV0eS
Qv2uYrkkcB3XC7t4gfYtmaa0ERRolsMfwDufAwhXFWrmgLktGB1RKWbwEc/TytKp
C6NmP3VunZzA0RwbQIMccuWQSKj+DxCtVmQQ7GYX+w==
=PTyE
-----END PGP SIGNATURE-----
