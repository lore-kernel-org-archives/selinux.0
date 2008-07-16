Subject: Re: 32bit -> 64bit x-compile fail (audit2why)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vikram Ambrose <Vikram.Ambrose@windriver.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
In-Reply-To: <487D0B1B.1020203@windriver.com>
References: <487D0B1B.1020203@windriver.com>
Content-Type: text/plain
Date: Wed, 16 Jul 2008 07:40:54 -0400
Message-Id: <1216208454.17602.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


On Tue, 2008-07-15 at 16:39 -0400, Vikram Ambrose wrote:
> ---
> In file included from 
> /vambrose/build_2008-07-15/host-cross/include/python2.4/Python.h:55,
>                  from audit2why.c:1:
> /vambrose/build_2008-07-15/host-cross/include/python2.4/pyport.h:612:2: 
> error: #error "LONG_BIT definition appears wrong for platform (bad 
> gcc/glibc config?)."
> ---
> 
> The header in question is pyport.h
> ----------------->
> #ifndef LONG_MAX
> #if SIZEOF_LONG == 4
> #define LONG_MAX 0X7FFFFFFFL
> #elif SIZEOF_LONG == 8
> #define LONG_MAX 0X7FFFFFFFFFFFFFFFL
> #else
> #error "could not set LONG_MAX in pyport.h"
> #endif
> #endif
> 
> #ifndef LONG_MIN
> #define LONG_MIN (-LONG_MAX-1)
> #endif
> 
> #ifndef LONG_BIT
> #define LONG_BIT (8 * SIZEOF_LONG)
> #endif
> 
> #if LONG_BIT != 8 * SIZEOF_LONG
> /* 04-Oct-2000 LONG_BIT is apparently (mis)defined as 64 on some recent
>  * 32-bit platforms using gcc.  We try to catch that here at compile-time
>  * rather than waiting for integer multiplication to trigger bogus
>  * overflows.
>  */
> #error "LONG_BIT definition appears wrong for platform (bad gcc/glibc 
> config?)."
> #endif
> <-----------------
> 
> Toolchain std-gcc i586 toolchain with x86_64 target support.
> Source: svn 2924
> 
> This does not seem to be a problem when compiling for another 32bit 
> architecture, ie i can go from i386 to arm32|ppc32|mips32 and its fine, 
> but from i386 to ppc64, x86_64, etc.. it fails...

Hmmm...does it help to move the #include <Python.h> in audit2why.c after
the #include <limits.h>?

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
