Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h767e8Ha025213
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 03:40:08 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h767crFB011567
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 07:38:53 GMT
Received: from zaphod.crypt.gen.nz (203-79-124-65.adsl.paradise.net.nz [203.79.124.65])
	by jazzswing.ncsc.mil  with ESMTP id h767cqGD011564
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 07:38:53 GMT
Subject: Re: libsecure Compilation Failure
From: Kerry Thompson <kerry@crypt.gen.nz>
To: Glen Boyd <glenb@napier.govt.nz>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <86170000.1060141226@glenb.napier.govt.nz>
References: <86170000.1060141226@glenb.napier.govt.nz>
Content-Type: text/plain
Message-Id: <1060154580.1842.3.camel@edmond.crypt.gen.nz>
Mime-Version: 1.0
Date: Wed, 06 Aug 2003 19:23:01 +1200
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2003-08-06 at 15:40, Glen Boyd wrote:
> Hi,
> 
> I am attempting to compile libsecure on a RedHat 8 based system and I get 
> the following error message when running make:
> 
> *****
> 
> cc -o fstat_secure.o -c -I../include -I/usr/local/seclinux/include 
> fstat_secure.c
> In file included from fstat_secure.c:5
> xstat_conv.h: In function `xstat_conv':
> xstat_conv.h:59: structure has no member named `st_atim'
> xstat_conv.h:60: structure has no member named `st_atim'
> xstat_conv.h:61: structure has no member named `st_mtim'
> xstat_conv.h:62: structure has no member named `st_mtim'
> xstat_conv.h:63: structure has no member named `st_ctim'
> xstat_conv.h:64: structure has no member named `st_ctim'
> make: *** [fstat_secure.o] Error 1
> 
> 
> Is there any workaround to this to enable compilation?
> 
> If you require further details or if this is in fact the completely wrong 
> place to post this question please let me know.

Hi Glenn

You need to apply a patch to convert the new struct definitions back to
the old form for your version of gcc. It has been a common problem.

See http://www.crypt.gen.nz/selinux/faq.html#I.4

Kerry.

-- 
Kerry Thompson, CISSP
IT Security Consultant
http://www.crypt.gen.nz



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
