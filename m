Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n63G1qtn008071
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 12:01:52 -0400
Received: from mail1.asahi-net.or.jp (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with ESMTP id n63G2Sgl029886
	for <selinux@tycho.nsa.gov>; Fri, 3 Jul 2009 16:02:29 GMT
Message-ID: <4A4E2B6C.2090309@kaigai.gr.jp>
Date: Sat, 04 Jul 2009 01:01:48 +0900
From: KaiGai Kohei <kaigai@kaigai.gr.jp>
MIME-Version: 1.0
To: Shaz <shazalive@gmail.com>
CC: sepgsql@secureos.jp, selinux <selinux@tycho.nsa.gov>
Subject: Re: Building for Ubuntu 9.04 - too few arguments to 	heap_create_with_catalog
 error
References: <7b740b700906272212hfc68318p3904174ed4d43ecb@mail.gmail.com> <7b740b700907030011s762ef2ebwd901759e641187f9@mail.gmail.com>
In-Reply-To: <7b740b700907030011s762ef2ebwd901759e641187f9@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Shaz wrote:
> 
> 
> On Sun, Jun 28, 2009 at 11:12 AM, Shaz <shazalive@gmail.com 
> <mailto:shazalive@gmail.com>> wrote:
> 
>     Dear list,
> 
>     I am building sepgsql for Ubuntu 9.04. I am following steps provided
>     in
>     http://wiki.postgresql.org/wiki/SEPostgreSQL_Administration#Installation_from_source_tarball
> 
>     I encountered the following error:
> 
>     ----------
>     gcc -O2 -Wall -Wmissing-prototypes -Wpointer-arith
>     -Wdeclaration-after-statement -Wendif-labels -fno-strict-aliasing
>     -fwrapv -I. -I../../../src/include -D_GNU_SOURCE   -c -o bootparse.o
>     bootparse.c
>     bootparse.y: In function ‘boot_yyparse’:
>     bootparse.y:228: error: too few arguments to function
>     ‘heap_create_with_catalog’
>     make[3]: *** [bootparse.o] Error 1
>     ---------
> 
>     Help requested in this matter.
> 
> 
> I got it working with Fedora 11 (yum) but would love to make it work on 
> Ubuntu with source tarballs. Is the sepgsql@secureos.jp 
> <mailto:sepgsql@secureos.jp> active?

I could not reproduce the matter with pgsql-8.4.0 and corresponding patch.

Could you try it again with the official postgresql-8.4.0.tar.gz and the correct patch.

- postgresql-8.4.0.tar.gz
   ftp://ftp.postgresql.org/pub/source/v8.4.0/postgresql-8.4.0.tar.gz
- sepgsql-00-full-8.4.0-r2096.patch.gz
   http://sepgsql.googlecode.com/files/sepgsql-00-full-8.4.0-r2096.patch.gz

BTW, what version of libselinux is available on Ubuntu 9.04?
The v8.4.x based SE-PostgreSQL requires libselinux-2.0.80 or later.

Thanks,
-- 
KaiGai Kohei <kaigai@kaigai.gr.jp>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
