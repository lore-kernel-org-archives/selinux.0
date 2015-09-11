Date: Fri, 11 Sep 2015 18:02:16 +0200
From: Dominick Grift <dac.override@gmail.com>
To: Steve Lawrence <slawrence@tresys.com>
Cc: James Carter <jwcart2@tycho.nsa.gov>, selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150911160215.GB4106@x250>
References: <20150903094844.GA18832@x250> <55E83A89.5010208@tycho.nsa.gov>
 <20150903132041.GD2118@x250> <55F093C9.2080508@tycho.nsa.gov>
 <20150910070853.GA26300@x250> <55F187A5.8050207@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <55F187A5.8050207@tresys.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Thu, Sep 10, 2015 at 09:37:41AM -0400, Steve Lawrence wrote:
<snip>
> 
> The segfault is cause by the in-statement. I'll send a patch shortly.
> 
> We don't allow block (and blockinherits/blockabstract) inside macros
> because of ordering issues. For example, say you had something like this:
> 
>   (block a
>     (blockinherit b)
>     (call m))
> 
>   (block b
>     (macro m ()
>        ...)
> 
>   (macro m ()
>     (blockinherit c))
> 
>   (block c
>     (macro m ()
>        ...))
> 
> If we performed the blockinherit b first, that would add b.m to block a.
> Then if we performed the call m, that would call that b.m that was added
> to a. So the global macro m would never be called.
> 
> However, if we instead had
> 
>   (block a
>     (call m)
>     (blockinherit b))
> 
> and we performed the call m first, that would be equivalent to
> 
>   (block a
>     (blockinherit c)
>     (blockinherit b))
> 
> Which would result in the macros from b and c being merged into block a.
> So in once case the macro c.m isn't part of block a, but in the other
> case it is.
> 
> Because of these ordering issues, it was decided to resolve all
> blockinherit statements before calls. This has the effect that we can't
> allow block, blockinherit, and blockabstract inside macros. This is a
> similar reason why we don't allow in-statements and macro statements
> inside of macros.
> 
> The patch I send out will also include changes to properly restrict
> blocks from being defined inside macros.

Thanks. I have spent some time updating my libsepol/secilc, and I have
to say compared to whatever what I was using this makes a world of
difference.

I haven't tried the above and the "class_permissionset in tunable" yet
but some things i noticed:

- - Some memory leak was fixed ( compiling policy took very long on
  low-spec kvm/qemu guests and occassionally caused secilc to get
  oom-killed ). Now it is compiling fast.

- - My policy had "type bounds violations" which i didnt know about. Now
  secilc reports warnings about those. Which allows me to identify and
  fix them.

- - When some identifiers in a context spec in an optional block were
  unavailable secilc use to print messages about them. This is no longer
  the case
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV8vsCAAoJENAR6kfG5xmc6o4MAMEg+sgUa2426u8C8m/OPjGU
vOr2VqHi/UW//DJ5J8fJ1DH7xN2WTgY2i5FmEfCWMmdAZZU6VPaW6U8tSgdQ8rBj
zcJ2DblMwjdbGLuDxHY5m7IHkaUrgBxXGJ9lKbjRWYOTvKO3ROuN6xrKubxKw58G
n1w8vtYWfppBQAUW1bEXHjigKfhtbd4nJRdC4PHwTZWf2P+KrbDvT+TtUqCAfuYL
YC1ENl+/+tCMCkitz3Uhtf7EVlicTYdX9r44xNLgVVYYTk+hc8UErY41pfWLaF7D
zl6C+seHszLiJQe37ENkepzoVuE7Tu1EIKDZar66pe9cC01//Sr9/1NApNJp14gi
YdvRwk4D6WKfvGItprh15DoPh999bZHH/8ZhjRQyKmxNUAJUgEmywY5RGLGnzia3
TMOwAEk3P9CAjTjvkpp5k5mw0HBJsEqn7M+b4A7gSQ5wN9oDkDFeecJG2PhG/ZSB
RjQxfsQ2zwFWkOCvbgkQjfb58xJ18Xw2pteeh+cXAA==
=SPBX
-----END PGP SIGNATURE-----
