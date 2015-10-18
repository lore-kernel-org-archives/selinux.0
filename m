Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9IF5cHW016998
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 11:05:38 -0400
Date: Sun, 18 Oct 2015 15:00:47 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Dominick Grift <dac.override@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1360366462.3121760.1445180447166.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <20151018140730.GB19335@x250>
References: <20151018140730.GB19335@x250>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> On Sunday, 18 October 2015, 15:07, Dominick Grift <dac.override@gmail.com> wrote:

> > -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On Sun, Oct 18, 2015 at 12:48:12PM +0000, Richard Haines wrote:
>>  I added openssl to libselinux to support the new selabel_digest(3)
>>  function.
>> 
>>  I'm not aware of any issues between openssl and gnutls, however as
>> 
>>  selabel_digest was only added last week I guess not much testing.
>>  Well apart from myself as I'm currently adding the selinux_restorecon
>>  feature that makes use of it.
>> 
> 
> Thanks for clarifying, I am not hitting any issues with it just
> wondering if instead of openssl, gnutls could be used for this and if

> so, if this should be somehow supported or not.

I tried using gnutls after I read your initial email, however I
could not find a way to generate the same digest as openssl
(I changed the SHA1 function to gnutls_hmac_fast(3) with various
algorithms and used the selabel_digest util to compare digests).
It could be that I should use some other function but I could

not find any useful info on this (including web searches).
If anyone knows how to resolve this please let me know.

I guess what is supported (openssl or gnutls) would be down to
the maintainers.


>> >> 
>> 
>> 
>>  > On Saturday, 17 October 2015, 11:55, Dominick Grift 
> <dac.override@gmail.com> wrote:
>>  > > -----BEGIN PGP SIGNED MESSAGE-----
>>  > Hash: SHA512
>>  > 
>>  > if so, would gnutls be affected in some way?
>>  > 
>>  > - -- 
>>  > 02DFF788
>>  > 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
>>  > 
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
>>  > Dominick Grift
>>  > -----BEGIN PGP SIGNATURE-----
>>  > Version: GnuPG v2
>>  > 
>>  > iQGcBAEBCgAGBQJWIiiTAAoJENAR6kfG5xmcDecL/3X2VRp3dR0UXDQSXAayD9P+
>>  > BEz+hJ9rhZTMoBdiDWvYVpsCVUL6ASIkKocGSvdV5cDfFPOs+wu3t8Xwo+KgNJqy
>>  > rMoPGm4QwkZyw9T3lzSMU6oE7l99FiQMDO3I41iDx52GQr+dvSoTHs5eRlU6ldyk
>>  > M9dSBIa/p9noQu3xCCWh8wVZSCLTC5b4PiCPwenyAecVZ3tJf7EOZssM4j7FPxnB
>>  > ropmU7MGauYUImBbVHFLcBWULIRo8Awwqadcnne4sxugPeFH332HeRcgUKCHGiQU
>>  > wovjWgGAKn/oC3tTTW9Tmo8F9rRC33BzP9P7p25MvMFiXPchid/iJiQG7k++qk/g
>>  > 9+p3vkhqvavff1eDG5pDKOh8hA+pcIzng91/NDGh5+8D+o1uvNxPPyQFHOhnn24p
>>  > DhxRk2uD5oiiB7o85Yh3ZubmWLR6UiI/SiNsm9POSEr0QH+ePdg/fSuKGKHxoeF0
>>  > DfZuIh4ZorjIQU4oGG+zg+kKB3XNwZph2UtshjUPEQ==
>>  > =mhIs
>>  > -----END PGP SIGNATURE-----
>>  > _______________________________________________
>>  > Selinux mailing list
>>  > Selinux@tycho.nsa.gov
>>  > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>  > To get help, send an email containing "help" to 
>>  > Selinux-request@tycho.nsa.gov.
>>  > 
> 
> - -- 
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
> 
> iQGcBAEBCgAGBQJWI6edAAoJENAR6kfG5xmccrgL/i7kT1+kuuBjGBqGAVl3W+ri
> Zgx7NnPKslS+dcx9lAMR2nVwG9A7Suh58E/HaUQv4RkFkNiX3Xqv9gRsrw4baWqZ
> 7at3qy1F/daa9U4hC/SdPwuwpQZYbKhquyfN09YAOb06XR9OtVE1z0DgEqiS5y7f
> lWCiYyCUoqu6ifJYEpNVWDgxsdXykfLMsTSWPttEJAkFQHK0/E8/HA3DVxh81mhB
> h6vBcFzoAPAyUbWf8n7EfmEVP3JeCoxOyQi61/qVdNyDdYuisZPRM6rAppurR+30
> AkGUj7U8YKbaBjhr4u0pOKcUx8/kYRYvkDenvcenuCALH+sGBdIK9ip/i9E5wjxJ
> k2HwiZb32t2wKfg3+MSkbfxgCgubErD7ZLMCC1x8TWDLbdonOISufZgal94GpCZf
> DyevvV30Ieo3yxwLQj4L8Z0PwfKPTedLhenw1ZjK1tQCgR8KNOaffpW53//Kpcwq
> 6qN87fA8cB+/fHDIUpaItm3b+vZeI9ElvG/06ruhAw==
> =+hHw
> 
> -----END PGP SIGNATURE-----
> 
