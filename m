Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l8ACiGDo009217
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2007 08:44:16 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id l8ACiEHV007250
	for <selinux@tycho.nsa.gov>; Mon, 10 Sep 2007 12:44:15 GMT
Subject: Re: apol on source policy
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Joe Nall <joe@nall.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <36012843-FAF9-41F2-AFE0-01752773F96A@nall.com>
References: <36012843-FAF9-41F2-AFE0-01752773F96A@nall.com>
Content-Type: text/plain
Date: Mon, 10 Sep 2007 08:42:49 -0400
Message-Id: <1189428169.13435.24.camel@gorn>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, 2007-09-07 at 14:18 -0500, Joe Nall wrote:
> How do you invoke apol on a source policy?

apol policy.conf

The source has to be a monolithic policy.conf or base module source
base.conf.  Loading sources of loadable modules is not supported.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
