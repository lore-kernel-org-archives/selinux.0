Date: Wed, 9 Sep 2015 22:45:13 +0200
From: Dominick Grift <dac.override@gmail.com>
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Subject: Re: secilc: in segfault
Message-ID: <20150909204512.GC22288@x250>
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
> This doesn't appear to be ONLY because of the "in" block. It still segfaults
> even with moving everything inside the block and removing the "in" block.
> 
> It looks like one problem is with the use of a blockinherit inside a macro.
> Blocks and blockinherits are not allowed to be used in macros. As we were
> fixing CIL's name resolution last Fall we came to the conclusion that
> allowing both of these would provide little benefit while causing a lot of
> potential problems. But we are open to a discussion if you can provide a
> compelling use case.
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

Thanks, That looks fine to me. I will try this out tomorrow and see how it goes. I am
not attached to any particular solution. Although I tried what, to me,
felt natural and intuitive. Thanks for the suggestion.

> 
> Jim
> 
> >I first thought it was because i was using "ARG1" in the blockabstract
> >(see first commit). However that seems to not be the case.
> >
> >I am left wondering: what am i doing wrong here (obviously secilc should
> >not segfault nevertheless)
> >
> 
> 
> -- 
> James Carter <jwcart2@tycho.nsa.gov>
> National Security Agency
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

iQGcBAEBCgAGBQJV8JpUAAoJENAR6kfG5xmcF7EL/3RpgagwqZHgF8HdbQBhuQBU
7uYaEBLDVgvDFTh8MZqPhNGXxmazCi/DYCL3XgFy96wCCjHG5Ea1HvHLWiy+kWcT
3TunGCAKPbyCX1gHf1MyOgsbmXjdK2aIeOv3FoRiCoY+q1cZZ1F18ORSbd9Qfkcb
Bfg4XEcwZNYcw0LQGjVnuuAIQthGHOisv1DSGcXP4HtVghEBNWwKKMji4dgGbpKP
7AyBfnAux8gFyNLQZVeaCXnDz62iTxGVvKRfSEETx/JWrsqNV4XqhLpRcJcOZGEU
4PLSUO/jz1wdG/CtC6/swq01D46BZwkwri5JrihXPEb2k2CFLjbvJ7Bie1LU1J1T
0s8vPIV/gVFsCfKX3ilnTX4mFCXsoAlOntpgjfk9PkPwTTRpsYbXhJYy91llyuR0
Deg3u9P2eO/yiEoPwpvB0kn7LEZN0vBiZSzCNW+NdVHy2pu2+uqanCUs4qUOj71E
DnAEeXlPBGtVwWyMqfbcU+0Fc119HRJeynJDrDKuig==
=JhA8
-----END PGP SIGNATURE-----
