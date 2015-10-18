Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t9ICptas009998
 for <selinux@tycho.nsa.gov>; Sun, 18 Oct 2015 08:51:55 -0400
Date: Sun, 18 Oct 2015 12:48:12 +0000 (UTC)
From: Richard Haines <richard_c_haines@btinternet.com>
Reply-To: Richard Haines <richard_c_haines@btinternet.com>
To: Dominick Grift <dac.override@gmail.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Message-ID: <1002427504.3006115.1445172492797.JavaMail.yahoo@mail.yahoo.com>
In-Reply-To: <20151017105311.GA7010@x250>
References: <20151017105311.GA7010@x250>
Subject: Re: did libselinux grow a new build dependency? (openssl-devel:
 openssl.h)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

I added openssl to libselinux to support the new selabel_digest(3)
function.

I'm not aware of any issues between openssl and gnutls, however as

selabel_digest was only added last week I guess not much testing.
Well apart from myself as I'm currently adding the selinux_restorecon
feature that makes use of it.





> On Saturday, 17 October 2015, 11:55, Dominick Grift <dac.override@gmail.com> wrote:
> > -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> if so, would gnutls be affected in some way?
> 
> - -- 
> 02DFF788
> 4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
> https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
> Dominick Grift
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2
> 
> iQGcBAEBCgAGBQJWIiiTAAoJENAR6kfG5xmcDecL/3X2VRp3dR0UXDQSXAayD9P+
> BEz+hJ9rhZTMoBdiDWvYVpsCVUL6ASIkKocGSvdV5cDfFPOs+wu3t8Xwo+KgNJqy
> rMoPGm4QwkZyw9T3lzSMU6oE7l99FiQMDO3I41iDx52GQr+dvSoTHs5eRlU6ldyk
> M9dSBIa/p9noQu3xCCWh8wVZSCLTC5b4PiCPwenyAecVZ3tJf7EOZssM4j7FPxnB
> ropmU7MGauYUImBbVHFLcBWULIRo8Awwqadcnne4sxugPeFH332HeRcgUKCHGiQU
> wovjWgGAKn/oC3tTTW9Tmo8F9rRC33BzP9P7p25MvMFiXPchid/iJiQG7k++qk/g
> 9+p3vkhqvavff1eDG5pDKOh8hA+pcIzng91/NDGh5+8D+o1uvNxPPyQFHOhnn24p
> DhxRk2uD5oiiB7o85Yh3ZubmWLR6UiI/SiNsm9POSEr0QH+ePdg/fSuKGKHxoeF0
> DfZuIh4ZorjIQU4oGG+zg+kKB3XNwZph2UtshjUPEQ==
> =mhIs
> -----END PGP SIGNATURE-----
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
> 
