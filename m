Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8BDfvNf001892
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 09:41:57 -0400
Received: by wicge5 with SMTP id ge5so63644978wic.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 06:41:54 -0700 (PDT)
Date: Fri, 11 Sep 2015 15:41:52 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Can I change default policy from targeted to minimum
Message-ID: <20150911134151.GA6297@x250>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 11, 2015 at 05:25:39PM +0530, Divya Vyas wrote:
> Hi,
> 
> I have mls and targeted policy installed on my system. I want to have a
> minimum policy with all user unconfined and nothing restricted.
> 
> I took a minimum policy from selinux-policy-minium noarch rpm and kept in
> /etc/selinux folder and edit SELINUXTYPE=minimum. Is this enough to load a
> new policy .
> 
> load_policy
> SELinux:  Could not open policy file <=
> /etc/selinux/minimum/policy/policy.28:  No such file or directory
> load_policy:  Can't load policy:  No such file or directory
> 
> Getting this error while the policy.28 exists in the path.
> 
> Please guide me to have a minimum unrestricted policy.

Looks like youre using Fedora. the "minimum" policy model is specific to
Fedora. You might be able to get support on the Fedora selinux maillist:
https://admin.fedoraproject.org/mailman/listinfo/selinux

With that said. You could try (if things break then you get to keep the pieces): sudo setenforce 0 && sudo semodule -B &&
sudo load_policy

> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.


- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV8tobAAoJENAR6kfG5xmcZc8L/R22F6gTxgCrQaOa6uZAQ+V3
G1Wyx8N31NYWJmJ4tpQCdOtKuLeNT3RTybPIGE7+W4tklAZRSob6ljpG4ySpJjO4
SaI03QDVr1L1Hn5EduZDYsEgWXr4rSbRwRbAfV7EW1G+7cKVQktV8OejLPXFLUhj
FsemqCJV44dvI8739w9T5KsmRJpVUvTDRwzlWPVWkmRk3Sj6yfPA/N2az3YAVq0B
FOV26XUqE8EmGJC4N93VqTEo+f9rH52PhTJVArzSElBdYsVsSDRrCJCuKSJd42Cr
MA1MtDu+DRwuGA0JZtEXekrKOG/6Jx/ZGKlfIwgMAqFjd3FSApWbtEpWDWvXD1Ol
i9NvOMheLi3PkyM0NUlaE73davDTbyb1hlk0h1WDFvSJCUlNYG5KVkk2metAYk5B
3NC7EYvrroqnClXq1DfQfPxFPk2KfnnB0A6I4szUK7pJyh1LXG9+BlcecbtQx8Oy
m1NC/L+9/+zv7hKl+SUMnkLimC2MrvM2qvYYMnm8aw==
=znWe
-----END PGP SIGNATURE-----
