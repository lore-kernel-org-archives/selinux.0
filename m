Received: from jazzswing.ncsc.mil (jazzswing.ncsc.mil [144.51.68.65])
	by tycho.ncsc.mil (8.9.3/8.9.3) with ESMTP id GAA05337
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 06:13:51 -0400 (EDT)
Received: from jazzswing.ncsc.mil (localhost [127.0.0.1])
	by jazzswing.ncsc.mil  with ESMTP id KAA17547
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 10:13:40 GMT
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com [194.25.134.80])
	by jazzswing.ncsc.mil  with ESMTP id KAA17543
	for <selinux@tycho.nsa.gov>; Mon, 3 Jun 2002 10:13:40 GMT
Message-ID: <3CFB4398.97404F23@dr-baldeweg.de>
Date: Mon, 03 Jun 2002 12:23:20 +0200
From: Carsten Grohmann <carsten.grohmann@dr-baldeweg.de>
MIME-Version: 1.0
To: jw@centraltexasit.com, selinux@tycho.nsa.gov
Subject: Re: SE-Linux on SuSE
References: <200205281111.39926.jw@centraltexasit.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Jonathan!

I've install SE-Linux on SuSE (7.1). It is easy to install. You should
run it a few days in the permissive mode to add a few new rules e.g. to
add the blogd to the initrc domain. And you should remove a lot of cron
jobs, if you like or you write rules for this jobs. And the mingettys,
but SE-Linux works fine on SuSE too. 

Carsten

JW schrieb:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hello,
> 
> I am interested in running SE-Linux on SuSE.
> 
> I'd appreciate hearing from anyone who's tried it.
> 
> Esp. how hard/easy it was to install/configure, anything special you had to do to get it working, and what you like/dislike about it now that you have it working.
> 
> Thanks.
> - --
> 
> - ----------------------------------------------------
> Jonathan Wilson
> System Administrator
> Cedar Creek Software     http://www.cedarcreeksoftware.com

--
You have received this message because you are subscribed to the selinux list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
