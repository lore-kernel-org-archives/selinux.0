Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t8EDO9FZ023324
 for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2015 09:24:09 -0400
Received: by wicgb1 with SMTP id gb1so141749090wic.1
 for <selinux@tycho.nsa.gov>; Mon, 14 Sep 2015 06:24:07 -0700 (PDT)
Received: from x250 (84-245-28-90.dsl.cambrium.nl. [84.245.28.90])
 by smtp.gmail.com with ESMTPSA id im10sm15552764wjb.40.2015.09.14.06.24.06
 for <selinux@tycho.nsa.gov> (version=TLSv1/SSLv3 cipher=OTHER);
 Mon, 14 Sep 2015 06:24:06 -0700 (PDT)
Date: Mon, 14 Sep 2015 15:24:05 +0200
From: Dominick Grift <dac.override@gmail.com>
To: selinux@tycho.nsa.gov
Subject: Re: secilc: segfault on what should be "Recursive block call found"?
Message-ID: <20150914132404.GA15129@x250>
References: <20150912125321.GB4006@x250>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <20150912125321.GB4006@x250>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Sat, Sep 12, 2015 at 02:53:21PM +0200, Dominick Grift wrote:
<snip>
> 
> secilc helpfully threw a message telling me:
> 
>     Recursive macro call found
>     Failed to compile cildb: -1
> 

The above is an example for how error message should *not* look. Here is
an example of how they *should* look:

macro statement is not allowed in optionals (/run/user/1000/dssp/sources/modules/contrib/system/usersubj/macros.cil:819)

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV9spwAAoJENAR6kfG5xmcx4kL/i4JxNAuu3csjwi2RK+CsbNY
1E/Bqwuo4YARC5pXdxHRuOd6NPeJYZg1ZY0zB44qDN17iMGfjzcI5zCfO8HDerov
HkoG/h462Z2JC/qdu0hyrhic5tY1t+kh5l4cIHVsxPfbvpDv27+UKRa4ufGzpqTd
moqXlh84T/6IOVhEH9bHF5gp5vFRyXkM5B8Fb3p6Q7pvVwtxDn2js3YljcrxBrOo
6NHZ4BrLSw4sJgfllnVt3HzwucrruyMZwR1F7aB5b+sErsFRV/akl2Bq+ULf1uDU
EVhblfIJyy2HvJkzHKNxpOIS+iYb7GMSmdZ4CWXIMTwewRekmHjvwhzXbahjrM53
bv3KK7J1Z3YF69ORzonbDLIzCHWuXfoDCmFxEseG19yxpyhPgHnfOwrwIBuTUeD4
b/bRUDmKwI5qGDjFQu9fCyNRDQ9nLENLHI3lqBeFYP+7dqPuQIfLOHjAnjV28J2a
gAJFv6eFBsItDQmF5BxuKeA6EdRGpv6IUu8emw04+A==
=4D0w
-----END PGP SIGNATURE-----
