Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id CAA18859
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 02:54:16 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id GAA23040
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 06:52:56 GMT
Received: from two.aba.krakow.pl (aba.krakow.pl [62.233.163.30])
	by jazzswing.ncsc.mil  with SMTP id GAA23036
	for <selinux@tycho.nsa.gov>; Wed, 11 Sep 2002 06:52:55 GMT
Date: Wed, 11 Sep 2002 08:53:56 +0200
From: =?iso-8859-2?Q?Pawe=B3?= Krawczyk <kravietz@aba.krakow.pl>
To: Russell Coker <russell@coker.com.au>
Cc: Tracy R Reed <treed@ultraviolet.org>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: IBM's Multics paper
Message-ID: <20020911065356.GC11721@aba.krakow.pl>
References: <20020909163557.K20187@ultraviolet.org> <200209101119.12834.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <200209101119.12834.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Sep 10, 2002 at 11:19:12AM +0200, Russell Coker wrote:

> The recent OpenWall patches include trampoline support.  I've run it on some 
> production servers and have not been able to find any problems caused by it.
> Hopefully at some time in the near future we'll be able to combine this with 
> SE Linux, or even better if we could have functionality equivalent to PAX in 
> GRSEC.  http://www.grsecurity.net/

Actually, as you touched that topic, for a quite long time I was
thinking how good would it be to have combined functionality of
GRsecurity and SElinux. GRsecurity has many general system hardening
functions (including Openwall and PAX for non-executable stack)
and a MAC/ACL system. However, the latter seems to be much more complete
and mature in SElinux.

As for the Openwall and PAX, there's no good answer for which system
to use, as PAX seems to be more actively developed but has bigger
performance overhead (up to 10% AFAIK) than OW. Currently I'm using
OW with several PAX features (address space randomizing) in production
embedded systems and it works well.

Also, it might be interesting for all of you - one such device (Linux
based) is being now evaluated for E2 level by ABW (Polish NSA equivalent).

-- 
Pawe³ Krawczyk, Kraków, Poland  http://echelon.pl/kravietz/
crypto: http://ipsec.pl/
horses: http://kabardians.com/

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
