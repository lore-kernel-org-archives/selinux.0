Date: Tue, 8 Dec 2015 17:29:59 +0100
From: Dominick Grift <dac.override@gmail.com>
To: Michal Marciniszyn <michal.marciniszyn@gooddata.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: Performance issues - huge amount of AVC misses
Message-ID: <20151208162957.GC32680@x250>
References: <CAL8PO=1-23M4Mj8zwF+gqS4ythkR=-vJqJbiGzq=xWrKSc8Ddw@mail.gmail.com>
 <20151208104442.GA32680@x250>
 <CAL8PO=3Dy-SFzE_DMA=99YcuK5+LXybUwAJgTBY1QZaODEM5Ew@mail.gmail.com>
 <5666F8A8.3040703@tycho.nsa.gov>
 <CAL8PO=2TMsT=DUJ-1oKKC+OutuHWVH1VqTsNDqKxKRVwon7Urw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <CAL8PO=2TMsT=DUJ-1oKKC+OutuHWVH1VqTsNDqKxKRVwon7Urw@mail.gmail.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Tue, Dec 08, 2015 at 05:21:17PM +0100, Michal Marciniszyn wrote:
> 
> I'll try to reduce amount of dontaudit rules and I'll see how much this
> reduces cache misses. The hard truth is, that vertica is looking at many
> places during the run, most of which it does not need. Maybe the way we
> have rules defined is creating a lot of stress on the amount of rules in
> the policy, I'll try to get the data on that.
> 

Yes, no after second thought I now believe it is totally unrelated and
not an issue. The amount of dontaudit rules is huge in stock 6.6 as well
(You are adding like 10% (?) so that is pretty insignificant)

Also there little you can do about the majority of dontaudit rules.

So stock SL6.6 comes with 91 permissive domains? wow, just wow.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJWZwWBAAoJENAR6kfG5xmccvUMAJmXVcoBvqrXzN5kTHpWnHBM
wPrGdx18tEyHeokE0U6FSlqXSh8/Hl9Fn2VSZLUyYO5mYm2dMoCFHkw45zs9svAB
2ugG9hEmoNgaX8KPxSm1LwWn23zTxnngeq8HU4n+ZSblQiW+EAeLPTtSHhqtA2OC
sXIBm6B3lfp5OPinQTsZ5xvpfTNe8eyswhEej3DCzr02tw5rheYzk3KvPKXKP6wV
OpQH7CwZ5Fi/7Ik298lU4tR321qtvLwxMUGcSMGT3Nkakul/GhH/RQOis2SFKlAy
HZGr4z/eLtAiwTgKFt+TuEgS+auFyZIeu4rlnky8qUhcc+j4fAVzDTNPtRV6LDHG
+Z2kbjgvR0Qk7QI7szuHiFYUfV/8ts6uzGMLEaQtBNEH0K7X1d0wk5qLOBiKrZOa
Zp0Sjnsv/ADhlRMD4WnqJ4R5NvU/p7rhYq5Xlh9/NadBXOon9Q4KBFzGUa+ZDvpy
YH7hgaRMQoQuPW/3FPlU47v2o1lMusuyYXqgGsZZyA==
=W08P
-----END PGP SIGNATURE-----
