Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id EAA19151
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 04:10:01 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id IAA25262
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 08:08:42 GMT
Received: from tsv.sws.net.au (tsv.sws.net.au [203.36.46.2])
	by jazzswing.ncsc.mil  with ESMTP id IAA25258
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 08:08:40 GMT
Content-Type: text/plain;
  charset="iso-8859-2"
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: =?iso-8859-2?q?Pawe=B3=20Krawczyk?= <kravietz@aba.krakow.pl>
Subject: Re: IBM's Multics paper
Date: Wed, 11 Sep 2002 10:09:38 +0200
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>
References: <20020909163557.K20187@ultraviolet.org> <200209101119.12834.russell@coker.com.au> <20020911065356.GC11721@aba.krakow.pl>
In-Reply-To: <20020911065356.GC11721@aba.krakow.pl>
MIME-Version: 1.0
Message-Id: <200209111009.38406.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 11 Sep 2002 08:53, Pawe³ Krawczyk wrote:
> As for the Openwall and PAX, there's no good answer for which system
> to use, as PAX seems to be more actively developed but has bigger
> performance overhead (up to 10% AFAIK) than OW. Currently I'm using
> OW with several PAX features (address space randomizing) in production
> embedded systems and it works well.

Ideally you would be presented with a choice of what level of stack/memory 
protection to have, varying from the basic stack-smashing protection in 
OpenWall to the full PAX support.

-- 
I do not get viruses because I do not use MS software.
If you use Outlook then please do not put my email address in your
address-book so that WHEN you get a virus it won't use my address in the
>From field.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
