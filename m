Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m6FKooPZ014819
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 16:50:50 -0400
Received: from mail.wrs.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m6FKonMO004460
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 20:50:49 GMT
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m6FKom43018116
	for <selinux@tycho.nsa.gov>; Tue, 15 Jul 2008 13:50:48 -0700 (PDT)
Message-ID: <487D0B1B.1020203@windriver.com>
Date: Tue, 15 Jul 2008 16:39:55 -0400
From: Vikram Ambrose <Vikram.Ambrose@windriver.com>
MIME-Version: 1.0
To: SELinux List <selinux@tycho.nsa.gov>
Subject: 32bit -> 64bit x-compile fail (audit2why)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


---
In file included from 
/vambrose/build_2008-07-15/host-cross/include/python2.4/Python.h:55,
                 from audit2why.c:1:
/vambrose/build_2008-07-15/host-cross/include/python2.4/pyport.h:612:2: 
error: #error "LONG_BIT definition appears wrong for platform (bad 
gcc/glibc config?)."
---

The header in question is pyport.h
----------------->
#ifndef LONG_MAX
#if SIZEOF_LONG == 4
#define LONG_MAX 0X7FFFFFFFL
#elif SIZEOF_LONG == 8
#define LONG_MAX 0X7FFFFFFFFFFFFFFFL
#else
#error "could not set LONG_MAX in pyport.h"
#endif
#endif

#ifndef LONG_MIN
#define LONG_MIN (-LONG_MAX-1)
#endif

#ifndef LONG_BIT
#define LONG_BIT (8 * SIZEOF_LONG)
#endif

#if LONG_BIT != 8 * SIZEOF_LONG
/* 04-Oct-2000 LONG_BIT is apparently (mis)defined as 64 on some recent
 * 32-bit platforms using gcc.  We try to catch that here at compile-time
 * rather than waiting for integer multiplication to trigger bogus
 * overflows.
 */
#error "LONG_BIT definition appears wrong for platform (bad gcc/glibc 
config?)."
#endif
<-----------------

Toolchain std-gcc i586 toolchain with x86_64 target support.
Source: svn 2924

This does not seem to be a problem when compiling for another 32bit 
architecture, ie i can go from i386 to arm32|ppc32|mips32 and its fine, 
but from i386 to ppc64, x86_64, etc.. it fails...



-- 
Vikram Ambrose | Linux Products Division | WindRiver Corporation


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
