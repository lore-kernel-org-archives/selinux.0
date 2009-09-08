Received: from msux-gh1-uea02.nsa.gov (msux-gh1-uea02.nsa.gov [63.239.67.2])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n88DFeLv017769
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 09:15:44 -0400
Received: from exchange.columbia.tresys.com (localhost [127.0.0.1])
	by msux-gh1-uea02.nsa.gov (8.12.10/8.12.10) with SMTP id n88DGxbm021048
	for <selinux@tycho.nsa.gov>; Tue, 8 Sep 2009 13:16:59 GMT
Subject: Re: [refpolicy] shutdown domain
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1252256475.22458.5.camel@vogon.seekline.net>
References: <1252256475.22458.5.camel@vogon.seekline.net>
Content-Type: text/plain
Date: Tue, 08 Sep 2009 09:15:10 -0400
Message-Id: <1252415710.17700.1.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2009-09-06 at 19:01 +0200, Stefan Schulze Frielinghaus wrote:
> Hi,
> 
> are there any plans to create a shutdown domain? For example a comment
> in apcupsd.te asks for such a domain too:
> 
> # apcupsd runs shutdown, probably need a shutdown domain
> 
> Today, I'm running into the same problem. Are there any reasons _not_ to
> create a shutdown domain? Otherwise I would like to create one.

I'm not sure what the purpose of this would be.  I would think it would
effectively telinit to the shutdown runlevel, which would be fine for
apcupsd to do.  The shutdown actions would then be performed by init
scripts.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
