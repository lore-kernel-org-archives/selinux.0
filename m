Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8BGpuwo029583
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 12:51:56 -0400
Received: by wiclk2 with SMTP id lk2so65102414wic.1
 for <selinux@tycho.nsa.gov>; Fri, 11 Sep 2015 09:51:53 -0700 (PDT)
Date: Fri, 11 Sep 2015 18:51:51 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Divya Vyas <dvyas@mvista.com>
Cc: selinux <selinux@tycho.nsa.gov>
Subject: Re: Can I change default policy from targeted to minimum
Message-ID: <20150911165150.GA1906@x250>
References: <CA+=dQ-8E2jMNN0i5=Bomp3g=hkFN=_qiQ3G5UtiXU8rNm6Ap1A@mail.gmail.com>
 <20150911134151.GA6297@x250>
 <CA+=dQ--_H_vrh2sLp4UePBaSBipVba+CX-tbsLR3u9Ft8P-MUg@mail.gmail.com>
 <20150911155344.GA4106@x250>
 <CA+=dQ-_fxDCjHZmO39O9=S0eQpWN7fhpQQRyqv9d-f82zXahdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CA+=dQ-_fxDCjHZmO39O9=S0eQpWN7fhpQQRyqv9d-f82zXahdA@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Fri, Sep 11, 2015 at 10:13:34PM +0530, Divya Vyas wrote:
> Hi Dominick,
> 
> I have a question, What is role of policy.29/28/27 . If I understand
> correctly  It is a binary policy called while kernel booting. Is is
> symbolic lick with policy.kern.

the /etc/selinux/SELINUXTYPE/policy/policy.X file is supposed to be the
actually policy database. I am not sure why in your case this is a
symlink to policy.kern

see:

http://selinuxproject.org/page/NB_PolicyType

> 
> Thanks,
> Divya
> 
> On Fri, Sep 11, 2015 at 9:23 PM, Dominick Grift <dac.override@gmail.com>
> wrote:

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV8waiAAoJENAR6kfG5xmcKDgMAIeO5dBCzoDW/C1K6DiiKWk6
P8okCWnjclLhOQsvUjnHRvrRUf19aVkHfAjzG6qaV/NoHXbP3OsQc4UQelCRuflF
0uNMz+cyCumjSAVXcdDorUCVQ688vOSe0jFRV9kudycCrL8s1TeKFHtpXcyYj5pC
oWvUNZgdAkQle8A208UVeEOFfKsMVa1c9BKhpWXLiBvuyfYL+qNod6tx4YWIqkbT
R21wEVsm4FoI50bNXNQ3sqhElS4M81kKgohbIHha6yVi6BRHlVcWgRSrxkuwQyYc
o0R422FJKEGLHO3WM9Z2CGXglaZoyUtp8xLEQ+NvsP8xvX+PDpNPDAdkSiZZ2yue
hwk+svXeQas7mIRZBHDcRMWQwj8ZdsQOnMuXSAMZEJF0bazjNwvrI4//qUq0n4yq
USi9YJm58Ghj8H5UFtk80d0iyQEl1jg4819MSoEhrBeMqddfmZ14lq8DvPl/m3SH
n7uQ21YZfy3VDBPPiO+cyQmx0JWJgRUO3GWrzFCzWg==
=IJ/r
-----END PGP SIGNATURE-----
