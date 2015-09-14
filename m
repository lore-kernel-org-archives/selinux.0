Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8EECt5k028031
 for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2015 10:12:55 -0400
Received: by wicge5 with SMTP id ge5so144727697wic.0
 for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2015 07:12:52 -0700 (PDT)
Date: Mon, 14 Sep 2015 16:12:50 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: segfault on what should be "Recursive block call found"?
Message-ID: <20150914141249.GB15129@x250>
References: <20150912125321.GB4006@x250> <20150914132404.GA15129@x250>
 <55F6CCAB.6030105@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <55F6CCAB.6030105@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Mon, Sep 14, 2015 at 09:33:31AM -0400, Steve Lawrence wrote:
> On 09/14/2015 09:24 AM, Dominick Grift wrote:
> > On Sat, Sep 12, 2015 at 02:53:21PM +0200, Dominick Grift wrote:
> > <snip>
> > 
> >> secilc helpfully threw a message telling me:
> > 
> >>     Recursive macro call found
> >>     Failed to compile cildb: -1
> > 
> > 
> > The above is an example for how error message should *not* look. Here is
> > an example of how they *should* look:
> > 
> > macro statement is not allowed in optionals (/run/user/1000/dssp/sources/modules/contrib/system/usersubj/macros.cil:819)
> > 
> 
> 
> The original issue was with recursive blockinherits. Should have a patch
> out shortly. Will also improve the error message for macros (and
> blockinherits) to show a trace of where the recursion came form.

Thanks. here is another one that could use the same threatment:

macro is not a block
Failed to compile cildb: -1


> 
> - Steve
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

iQGcBAEBCgAGBQJV9tXdAAoJENAR6kfG5xmcc8EL/A5ESNaKxoC12WPlpb5tK+xI
fYg3iZdSnQx9KPq1QQe4g9nk6NBQdXBfc/Z8lK9Dclna9NKsOyudc4KSqJW6Mx90
ja86g+if24oPQQ6jIONOI/JP1+TXVawCzLpcKGxrXgiTmVbtriBAgvc13p1TETYZ
JF1AuwP11N9J/vUVbhQx5WVewiwHMMtU3ilvp3lAJ3SGowDla/DB8ApB9P39A5T6
BZu2tn9IPq2NSjkcrVlutSwlPrpAdlqgRz6xwHOBFyIHQ64XdO5GxPKYA461Z4hI
TteLe3MiL8I+FMed2Y/cQWPn73EqP88I1DgZIlAj861L9niPsJQJ9ilZUUbn92xI
Vpu2lssfp3lPBzdIVkm+sgv/vjo7b4tROH7zyIzyGI9pB9K19Dq9fgFsP39yXspX
6TbDD0Fo1yvEnJrWcij7xfmwM22Ryt9jxyFUYQ1uEjr27xBUYcmgobSoChnjE8co
+fz0NyzH/54YE5Kstcshkvc9oK5NgYO1eJz3/yxsIg==
=0Zmh
-----END PGP SIGNATURE-----
