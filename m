Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i89GuurT013119
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 12:56:56 -0400 (EDT)
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i89Gu0o3016242
	for <selinux@tycho.nsa.gov>; Thu, 9 Sep 2004 16:56:01 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Erich Schubert <erich@debian.org>
Subject: Re: domains/local/*.te file_contexts/local/*.fc
Date: Fri, 10 Sep 2004 02:56:50 +1000
Cc: SE-Linux <selinux@tycho.nsa.gov>
References: <1094489141.3973.40.camel@wintermute.xmldesign.de> <200409082329.56168.russell@coker.com.au> <1094674581.4181.6.camel@wintermute.xmldesign.de>
In-Reply-To: <1094674581.4181.6.camel@wintermute.xmldesign.de>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_TtIQB9yn1Ul/KZf"
Message-Id: <200409100256.51005.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


--Boundary-00=_TtIQB9yn1Ul/KZf
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Thu, 9 Sep 2004 06:16, Erich Schubert <erich@debian.org> wrote:
> > OK, maybe we should just change that to have file_contexts/misc/*
> > included last.  What do you think?
>
> Basically yes. but be careful: I havn't checked the contents of the misc
> files, but somewhere default contexts such as /bin, /usr/bin etc. need
> to be defined. So we need something to be listed first, too.
> Where is this done currently, i havn't checked.

Currently file_contexts/misc is empty, it's only used for custom stuff.  This 
may change at some future time, but anything that impacts the misc directory 
is not going to break anything now.

> Maybe we should name them appropriately: first and last, or "defaults"
> and "overrides"?

I don't like that idea.  If we were going to do that sort of thing then we 
would have to consider something like the numerical order used for init 
scripts.

The attached patch (not in unified format) changes the file_contexts/misc 
directory to have precedence.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--Boundary-00=_TtIQB9yn1Ul/KZf
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="Makefile.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile.diff"

52c52
< FCFILES=file_contexts/types.fc $(wildcard file_contexts/misc/*.fc) $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te))
---
> FCFILES=file_contexts/types.fc $(patsubst domains/program/%.te,file_contexts/program/%.fc, $(wildcard domains/program/*.te)) $(wildcard file_contexts/misc/*.fc)

--Boundary-00=_TtIQB9yn1Ul/KZf--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
