Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j8CL90Ns016894
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 17:09:00 -0400 (EDT)
Received: from smtp2-g19.free.fr (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j8CL6Fl1006710
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 21:06:16 GMT
Received: from [172.16.3.24] (mail.epinetworx.com [82.224.217.20])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 940B425862
	for <selinux@tycho.nsa.gov>; Mon, 12 Sep 2005 23:06:16 +0200 (CEST)
Message-ID: <4325F143.8030301@9online.fr>
Date: Mon, 12 Sep 2005 23:21:07 +0200
From: Pierre <pierre42d@9online.fr>
MIME-Version: 1.0
To: selinux@tycho.nsa.gov
Subject: Re: Problem compiling libselinux 1.26
References: <4325DE1A.2000408@9online.fr> <1126556261.19011.2.camel@estila>
In-Reply-To: <1126556261.19011.2.camel@estila>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Lorenzo Hernández García-Hierro wrote:
> El lun, 12-09-2005 a las 21:59 +0200, Pierre escribió:
> 
>># make
>>make -C src
>>make[1]: Entering directory `/tmp/libselinux-1.26/src'
>>gcc -s -O3 -march=i686 -I../include -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 
>>-c -o fgetfilecon.o fgetfilecon.c
>>fgetfilecon.c:6:23: sys/xattr.h: No such file or directory
>>make[1]: *** [fgetfilecon.o] Error 1
>>make[1]: Leaving directory `/tmp/libselinux-1.26/src'
>>make: *** [all] Error 2
> 
> 
> You need the file-system extended attributes related header files, but
> you lack of them for some reason.
> 
> You can try to get them from http://sosdg.org/~coywolf/lxr/source/ or
> re-install your kernel headers packages, or just get updated ones.

Which software is providing these headers ? glibc ?

-- 
Pierre.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
