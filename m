Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k4JE8MtR005701
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 10:08:22 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k4JE8LfP013559
	for <selinux@tycho.nsa.gov>; Fri, 19 May 2006 14:08:21 GMT
Subject: Re: genhomedircon
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200605192028.32354.russell@coker.com.au>
References: <200605192028.32354.russell@coker.com.au>
Content-Type: text/plain
Date: Fri, 19 May 2006 10:09:56 -0400
Message-Id: <1148047796.31984.58.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2006-05-19 at 20:28 +1000, Russell Coker wrote:
[cut]
> The above code at line 282 in genhomedircon in FC5 has a bug in that it can't 
> handle a line in the file contexts file containing " ".
> 
> The attached patch fixes a bug in the FC5 policy which generates such a line 
> with only a space.

Merged.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
