Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8BFroJB024435
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 11:53:50 -0400
Received: by wicge5 with SMTP id ge5so68508370wic.0
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 08:53:47 -0700 (PDT)
Date: Fri, 11 Sep 2015 17:53:45 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Can I change default policy from targeted to minimum
Message-ID: <20150911155344.GA4106@x250>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250>
 <CA+=dQ--_H_vrh2sLp4UePBaSBipVba+CX-tbsLR3u9Ft8P-MUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ--_H_vrh2sLp4UePBaSBipVba+CX-tbsLR3u9Ft8P-MUg@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 11, 2015 at 09:15:56PM +0530, Divya Vyas wrote:
> Hi Dominick,
> 
> No its not fedora. It is basically yocto based kernel and root filesystem .
> 
> Is it possible to have a minimum policy to allow everything and try out
> limiting something.

Sure, you could write one yourself (configurable policy is what SELinux
is all about amongst other things). Theres also this:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/security/SELinux.txt?id=e22619a29fcdb513b7bc020e84225bb3b5914259

But it has a bug that only recently got fixed

No matter what you choose, it is going to be a little hard if you arent
confident with SELinux

For the real adventurous theres my base policy, which needs tweaking to
get it to work:

https://github.com/doverride/cilpolicy


> 
> 
> 
> On Fri, Sep 11, 2015 at 7:11 PM, Dominick Grift <dac.override@gmail.com>
> wrote:
> 
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA512
> >
> > On Fri, Sep 11, 2015 at 05:25:39PM +0530, Divya Vyas wrote:
> > > Hi,
> > >
> > > I have mls and targeted policy installed on my system. I want to have a
> > > minimum policy with all user unconfined and nothing restricted.
> > >
> > > I took a minimum policy from selinux-policy-minium noarch rpm and kept in
> > > /etc/selinux folder and edit SELINUXTYPE=minimum. Is this enough to load
> > a
> > > new policy .
> > >
> > > load_policy
> > > SELinux:  Could not open policy file <=
> > > /etc/selinux/minimum/policy/policy.28:  No such file or directory
> > > load_policy:  Can't load policy:  No such file or directory
> > >
> > > Getting this error while the policy.28 exists in the path.
> > >
> > > Please guide me to have a minimum unrestricted policy.
> >
> > Looks like youre using Fedora. the "minimum" policy model is specific to
> > Fedora. You might be able to get support on the Fedora selinux maillist:
> > https://admin.fedoraproject.org/mailman/listinfo/selinux
> >
> > With that said. You could try (if things break then you get to keep the
> > pieces): sudo setenforce 0 && sudo semodule -B &&
> > sudo load_policy
> >
> > > _______________________________________________
> > > Selinux mailing list
> > > Selinux@tycho.nsa.gov
> > > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > > To get help, send an email containing "help" to
> > Selinux-request@tycho.nsa.gov.
> >
> >
> > - --
> > 02DFF788
> > 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> > https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> > Dominick Grift
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v2
> >
> > iQGcBAEBCgAGBQJV8tobAAoJENAR6kfG5xmcZc8L/R22F6gTxgCrQaOa6uZAQ+V3
> > G1Wyx8N31NYWJmJ4tpQCdOtKuLeNT3RTybPIGE7+W4tklAZRSob6ljpG4ySpJjO4
> > SaI03QDVr1L1Hn5EduZDYsEgWXr4rSbRwRbAfV7EW1G+7cKVQktV8OejLPXFLUhj
> > FsemqCJV44dvI8739w9T5KsmRJpVUvTDRwzlWPVWkmRk3Sj6yfPA/N2az3YAVq0B
> > FOV26XUqE8EmGJC4N93VqTEo+f9rH52PhTJVArzSElBdYsVsSDRrCJCuKSJd42Cr
> > MA1MtDu+DRwuGA0JZtEXekrKOG/6Jx/ZGKlfIwgMAqFjd3FSApWbtEpWDWvXD1Ol
> > i9NvOMheLi3PkyM0NUlaE73davDTbyb1hlk0h1WDFvSJCUlNYG5KVkk2metAYk5B
> > 3NC7EYvrroqnClXq1DfQfPxFPk2KfnnB0A6I4szUK7pJyh1LXG9+BlcecbtQx8Oy
> > m1NC/L+9/+zv7hKl+SUMnkLimC2MrvM2qvYYMnm8aw==
> > =znWe
> > -----END PGP SIGNATURE-----
> >

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

iQGcBAEBCgAGBQJV8vkEAAoJENAR6kfG5xmcX90L+wQHC3H8XDMAT9F9ZbWQyz+P
4t32n22Q8o92p5vmVQeCUiQU6eBbkFtidW5f6gc8txtiW/+c+nccVjwXYxBh4SLn
t8P6zL6gknA2vpgSXspZgOhHtAaZY8jnPq2imHZvZIBbNHPna8JggTpDPHe2Ef4G
3asKRdwZY2cVDwGLdKph6yfgZq22WnhM3nG0UvE623JVubtUUWZ15sch31kU7bx1
qAA5jtEch38TOC1VZU+EjsUvGaX/HIrDV2C5v9uC6zUA++10x8mPKMn11/oV+KbW
6coANYiPf+Uer63wQLQCpXuzW/8ARhzJCRyxeNHk3pQTr4UDsk9r3dEyjZclG7wT
ryxNrgrrzBsizlPmuwL06kwi8/Nh+vZpyG6gU39U36/rP6fEyYvfiTL8/Pm1RavF
N6dOjDgKSMNRWT6qcS9/yCQ4WuNhgRxF9G2PlrZENnY9jYCiP0dPbrQXDJEa9nly
CK/lSaYqptSJ+zNMRhmZnEsFP/AIFw55guoaSWOZoQ==
=uFQg
-----END PGP SIGNATURE-----
