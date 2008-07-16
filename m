Message-ID: <487E0E5E.5050900@windriver.com>
Date: Wed, 16 Jul 2008 11:06:06 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SELinux List <selinux@tycho.nsa.gov>
Subject: Re: 32bit -> 64bit x-compile fail (audit2why)
References: <487D0B1B.1020203@windriver.com> <1216208454.17602.62.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1216208454.17602.62.camel@moss-spartans.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Stephen Smalley wrote:
> On Tue, 2008-07-15 at 16:39 -0400, Vikram Ambrose wrote:
>   
>> ---
>> In file included from 
>> /vambrose/build_2008-07-15/host-cross/include/python2.4/Python.h:55,
>>                  from audit2why.c:1:
>> /vambrose/build_2008-07-15/host-cross/include/python2.4/pyport.h:612:2: 
>> error: #error "LONG_BIT definition appears wrong for platform (bad 
>> gcc/glibc config?)."
>> ---
>>
>> The header in question is pyport.h
>> ----------------->
>> #ifndef LONG_MAX
>> #if SIZEOF_LONG == 4
>> #define LONG_MAX 0X7FFFFFFFL
>> #elif SIZEOF_LONG == 8
>> #define LONG_MAX 0X7FFFFFFFFFFFFFFFL
>> #else
>> #error "could not set LONG_MAX in pyport.h"
>> #endif
>> #endif
>>
>> #ifndef LONG_MIN
>> #define LONG_MIN (-LONG_MAX-1)
>> #endif
>>
>> #ifndef LONG_BIT
>> #define LONG_BIT (8 * SIZEOF_LONG)
>> #endif
>>
>> #if LONG_BIT != 8 * SIZEOF_LONG
>> /* 04-Oct-2000 LONG_BIT is apparently (mis)defined as 64 on some recent
>>  * 32-bit platforms using gcc.  We try to catch that here at compile-time
>>  * rather than waiting for integer multiplication to trigger bogus
>>  * overflows.
>>  */
>> #error "LONG_BIT definition appears wrong for platform (bad gcc/glibc 
>> config?)."
>> #endif
>> <-----------------
>>
>> Toolchain std-gcc i586 toolchain with x86_64 target support.
>> Source: svn 2924
>>
>> This does not seem to be a problem when compiling for another 32bit 
>> architecture, ie i can go from i386 to arm32|ppc32|mips32 and its fine, 
>> but from i386 to ppc64, x86_64, etc.. it fails...
>>     
>
> Hmmm...does it help to move the #include <Python.h> in audit2why.c after
> the #include <limits.h>?
>
>   
Figured it out, this is actually a common hole a lot of people fall 
into. Python headers unlike most headers are not arch independent. 
During compilation of python, a pyconfig.h is created with arch 
dependent code. Which basically means there is no clean way of detecting 
where and what python headers are available when doing cross 
compilation. ie you have to explicitly say, my python headers are 
/over/here/

eg. You need to cross compile libselinux from 32bit x86 to 64bit x86 
which uses python headers.
You have python already cross compiled and kept in your target's rootfs. 
Now because the "python" binary is the only tool that can correctly tell 
where it's home is, there is no means of accessing this information from 
your host operating system.

AM_PATH_PYTHON used by automake falls into this hole. as it defines the 
python includedir by using the host's python interpreter.

-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
