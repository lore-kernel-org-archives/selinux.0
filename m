Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i4HJBuRb026494
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 15:11:57 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id i4HJ9WB2023151
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 19:09:33 GMT
Received: from smtp.sws.net.au ([61.95.69.6])
	by jazzswing.ncsc.mil  with ESMTP id i4HJ9Vwi022985
	for <selinux@tycho.nsa.gov>; Mon, 17 May 2004 19:09:31 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: suggestion to help transition to selinux: dynamic loading of libselinux
Date: Tue, 18 May 2004 05:10:40 +1000
Cc: selinux@tycho.nsa.gov
References: <20040515232606.GA9378@lkcl.net>
In-Reply-To: <20040515232606.GA9378@lkcl.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405180510.40047.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 16 May 2004 09:26, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> and i presume that if such programs are compromised, and someone
> attempts to _stop_ libselinux from being loaded, well then
> those programs will not be capable of making domain transitions
> etc. and they will be useless [am i right?]

The first candidate for such changes would be init.  We would have to 
hard-code a check for selinux=0 in the init source to avoid having init just 
not enable SE Linux if file system corruption causes libselinux.so to 
disappear.

I think that init is the program that needs such changes most, the current 
situation makes libselinux one of the most important packages in the system 
(can't boot without it).

> then, for example, in the patch to coreutils,
> http://selinux.lemuria.org/newselinux/coreutils/coreutils.diff
>
> in coreutils-5.0.91/src/copy.c line 1444 approx, instead of
> ++#ifdef WITH_SELINUX
> ++	if (x->preserve_security_context)
> ++	  setfscreatecon(NULL);
> ++#endif
>
> you have:
>
> if (sel != NULL && x->preserve_security_context)
> 	sel->setfscreatecon(NULL);
>
>
> yes, correct: no #ifdef WITH_SELINUX :)

In any case I think that we want #ifdef WITH_SELINUX.  People who don't want 
to use SE Linux should have the option to compile without any of that code 
for small memory systems.

> the advantage of deploying it is that at present there is
> completely justifiable resistance upstream in accepting
> patches to the core functionality of linux useability that
> makes it impossible to use the core utilities for a non-selinux
> environment (!), and this suggestion makes the reason for that
> resistance go away.

Of course we can do this on a per-application basis.  If there is some 
application for which we can't get the current patches included but for which 
changes such as you suggest would be accepted then we should definitely do it 
for that app.

Of course that doesn't require changing libselinux, we could just call dlsym() 
for every function we want to use.  Do any applications use so many functions 
that calling dlsym() repeatedly is excessive overhead?

> p.s. please ask me for clarifications if needed or even for
> patches rather than go "uhn?  weirdo, weird language, can't
> even touch a shift key, don't talk to him".  i _want_ selinux
> to be adapted mainstream by debian, quickly, so talk to me.

The main thing that is needed for better SE Linux support in Debian is to have 
more people working on it.  Doing this sort of thing properly requires that 
most than one person work on it.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
