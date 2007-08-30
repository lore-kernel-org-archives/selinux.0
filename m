Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l7UEtMGE027670
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 10:55:22 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l7UEtHXa006626
	for <selinux@tycho.nsa.gov>; Thu, 30 Aug 2007 14:55:17 GMT
Subject: Re: [PATCH]interface name of certwatch_run in admin layer
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
Cc: selinux <selinux@tycho.nsa.gov>
In-Reply-To: <f71a82820708300641k1bd08f10n44cdd6ba6912f943@mail.gmail.com>
References: <f71a82820708300641k1bd08f10n44cdd6ba6912f943@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 30 Aug 2007 10:54:10 -0400
Message-Id: <1188485650.6723.74.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-08-30 at 22:41 +0900, Shintaro Fujiwara wrote:
> Not certwatach_run but certwatch_run ?
> 
> 47c47
> < interface(`certwatach_run',`
> ---
> > interface(`certwatch_run',`

I have manually fixed this in trunk.  In the future, please submit
unified diffs.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
