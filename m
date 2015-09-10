Date: Thu, 10 Sep 2015 09:08:54 +0200
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150910070853.GA26300@x250>
References: <20150903094844.GA18832@x250> <55E83A89.5010208@tycho.nsa.gov>
 <20150903132041.GD2118@x250> <55F093C9.2080508@tycho.nsa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; x-action=pgp-signed
In-Reply-To: <55F093C9.2080508@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

On Wed, Sep 09, 2015 at 04:17:13PM -0400, James Carter wrote:
<snip>

> 
> Why not use something like this:
> 
> (block exec_blk
> 	(blockabstract exec_blk)
> 	(macro exec ((type ARG1))
> 	       (call can_exec (ARG1 cmd_file))))
> 
> (block auditctl
> 	(blockinherit exec_blk))
> 
> (call auditctl.exec (some_type))
> 
> instead of:
> 
> (block exec_blk
> 	(blockabstract exec_blk)
> 	(call can_exec (ARG1 cmd_file)))
> 
> (block auditctl
>   	(macro exec ((type ARG1))
> 		(blockinherit exec_blk)))
> 
> (call auditctl.exec (some_type))
> 

I tried your suggestion above in the following two commits:

https://github.com/DefenSec/dssp/commit/ddb58e7832bf6a815c495f30ae8a4a4060d227b7
https://github.com/DefenSec/dssp-contrib/commit/6ecb6b2f5830aaa7b3f3ec081af95ce0d71d06dc

This time it "really" seems to segfault on "in" (i tried moving it out
of there and that built)

However I prefer to not put these "macros" in the existing blocks. I
want to keep these macros in seperate $module/macros.cil files. Thus i
depend on "in".

This implementation also feels a bit limited and unintuitive but i suppose i could live
with that.

- -- 
02DFF788
4D30 903A 1CF3 B756 FB48  1514 3148 83A2 02DF F788
https://sks-keyservers.net/pks/lookup?op=get&search=0x314883A202DFF788
Dominick Grift
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQGcBAEBCgAGBQJV8SyBAAoJENAR6kfG5xmcN3ML/iUukWuwzqYPWvd8VDYpIvSy
mEb+636cQxskiY/6kiw2hFfQm7wrFWYNIyAB+DGGS4jobcKaJ136GqCVjab45kiq
XzmPUs0GEuKLffVuQP02bTbpLLBEC0rtTV6ePpirudoF7ECGHW9mKZGTvWPVTp8N
2wdX4za/qUiloDl33drKOemSUHP/vyn7yu7SMHQgJ0cTYdzA4rweGt3rZCS5W0CA
tEq7CV4nInvNSDiqvNE9eCWAU9xsVV3KnML8LEoPUzd4Y1qYoMuZSkhFm4F0l6te
eZ/s6NdU4LqIaBoBZTVYvNdR4OU5ijzjhmYdv7Qspg+tk7zzvsY7+0qjsXa6G/w7
NEnh7aDuQ6+1QNbf65IaLETqg4Co6jYvfgCWIDk8me2OS6wCOiZWNkl7JTShXf5n
DRgUGKUIvJ78Gp8n6q6l+iBNfg6r+kh2wOMRFeWvBJ/IMgObWZOEH3fnYiozcFen
wV7fj5VDpbuZTEIXS/pv3Xk9J3yJ4TfpeJyMYIk6Dw==
=ORb3
-----END PGP SIGNATURE-----
