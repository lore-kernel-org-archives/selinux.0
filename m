Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id TAA13802
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 19:28:17 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id XAA20909
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 23:27:23 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id XAA20905
	for <selinux@tycho.nsa.gov>; Mon, 5 Aug 2002 23:27:21 GMT
Content-Type: text/plain;
  charset="iso-8859-1"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Chris Wright <chris@wirex.com>
Subject: Re: 2.4.19 lsm kernel patch
Date: Tue, 6 Aug 2002 01:28:05 +0200
Cc: linux-security-module@wirex.com, SE Linux <selinux@tycho.nsa.gov>
References: <20020803134653.A7A9E20B@lyta.coker.com.au> <20020805152212.B18583@figure1.int.wirex.com>
In-Reply-To: <20020805152212.B18583@figure1.int.wirex.com>
MIME-Version: 1.0
Message-Id: <20020805232805.9511B2F4C@lyta.coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 6 Aug 2002 00:22, Chris Wright wrote:
> * Russell Coker (russell@coker.com.au) wrote:
> > Anyone have any tips on how to solve this?
>
> What outut do you get from Keith Owens' script?
> http://www.kernelnewbies.org/scripts/reference_discarded.pl
> (i've compiled and run 2.4.19-rc3-lsm1 fine here with
> binutils-2.11.93.0.2-11 and gcc-2.96-110).

Should I try an even older binutils?  I was previously using 2.12.90.0.15...

rjc@test:/usr/src/tmp/linux$ /tmp/reference_discarded.pl
Finding objects, 319 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 26 conglomerate(s)
Scanning objects
Error: ./security/selinux/hooks.o .text.init refers to 000000bf R_386_PC32
  .text.exit
Done
rjc@test:/usr/src/tmp/linux$ dpkg -l binutils
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=(none)/Hold/Reinst-required/X=both-problems (Status,Err: 
uppercase=bad)
||/ Name           Version        Description
+++-==============-==============-============================================
ii  binutils       2.12.90.0.14-1 The GNU assembler, linker and binary utiliti
rjc@test:/usr/src/tmp/linux$


-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
