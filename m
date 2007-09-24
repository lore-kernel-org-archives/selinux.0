Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8OCtI4M017854
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 08:55:18 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id l8OCtCfc016352
	for <selinux@tycho.nsa.gov>; Mon, 24 Sep 2007 12:55:12 GMT
Subject: Re: [refpolicy] minor comment patch for cron.if
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Stefan Schulze Frielinghaus <stefan@seekline.net>
Cc: selinux@tycho.nsa.gov
In-Reply-To: <1190568688.3831.4.camel@vogon>
References: <1190568688.3831.4.camel@vogon>
Content-Type: text/plain
Date: Mon, 24 Sep 2007 08:52:57 -0400
Message-Id: <1190638377.15178.25.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, 2007-09-23 at 18:31 +0100, Stefan Schulze Frielinghaus wrote:
> The file cron.if at line 470 has a wrong comment I guess.
> Please have a look at the patch because I'm not 100% sure if I guessed
> the right comment. I saw that only while I run over the cron
> interfaces.

You're correct, it looks like a copy-paste typo.  Merged.

> --- ../refpolicy-20070629/policy/modules/services/cron.if       2007-06-27 16:23:21.000000000 +0100
> +++ policy/modules/services/cron.if     2007-09-23 18:25:02.000000000
> +0100
> @@ -465,7 +465,7 @@
>  
>  ########################################
>  ## <summary>
> -##     Execute APM in the apm domain.
> +##     Execute anacron in the cron system domain.
>  ## </summary>
>  ## <param name="domain">
>  ##     <summary>
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
