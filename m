Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h7696RHa025374
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 05:06:28 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id h7695CFB015293
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 09:05:12 GMT
Received: from mail.vegaa.de (mail.vegaa.de [213.203.196.181])
	by jazzswing.ncsc.mil  with ESMTP id h7695CGD015290
	for <selinux@tycho.nsa.gov>; Wed, 6 Aug 2003 09:05:12 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Carsten Grohmann <carsten.grohmann@raumbildsysteme.de>
To: Glen Boyd <glenb@napier.govt.nz>, selinux@tycho.nsa.gov
Subject: Re: libsecure Compilation Failure
Date: Wed, 6 Aug 2003 10:02:46 +0200
References: <86170000.1060141226@glenb.napier.govt.nz>
In-Reply-To: <86170000.1060141226@glenb.napier.govt.nz>
MIME-Version: 1.0
Message-Id: <200308061002.47802.carsten.grohmann@raumbildsysteme.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

you can found help about this in Kerrys faq 
(http://www.crypt.gen.nz/selinux/faq.html) or some mails like 
Stephens Mail "Re: SELinux Compilation Error on Redhat 8.0 with LSM 
2.5" from 02.05.2003

Am Mittwoch, 6. August 2003 05:40 schrieb Glen Boyd:
> Hi,
>
> I am attempting to compile libsecure on a RedHat 8 based system
> and I get the following error message when running make:
>
> *****
>
> cc -o fstat_secure.o -c -I../include
> -I/usr/local/seclinux/include fstat_secure.c
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
> *****
>
> Is there any workaround to this to enable compilation?
>
> If you require further details or if this is in fact the
> completely wrong place to post this question please let me know.
>
> thanks
>
> Glen Boyd               <glenb@napier.govt.nz>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
