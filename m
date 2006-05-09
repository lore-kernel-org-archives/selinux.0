Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k49CZKMi013710
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 08:35:20 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k49CZHa2008222
	for <selinux@tycho.nsa.gov>; Tue, 9 May 2006 12:35:19 GMT
Subject: Re: [PATCH] fix warnings in selinux-usr
From: Karl MacMillan <kmacmillan@tresys.com>
To: Ivan Gyurdiev <ivg2@cornell.edu>
Cc: selinux <selinux@tycho.nsa.gov>, selinux-dev <selinux-dev@tresys.com>
In-Reply-To: <445FC8F8.3090809@cornell.edu>
References: <1146845884.2208.15.camel@jackjack.columbia.tresys.com>
	 <445CF147.1000300@cornell.edu>
	 <1147091194.32719.4.camel@jackjack.columbia.tresys.com>
	 <445FC8F8.3090809@cornell.edu>
Content-Type: text/plain
Date: Tue, 09 May 2006 08:32:38 -0400
Message-Id: <1147177959.32719.83.camel@jackjack.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2006-05-08 at 18:40 -0400, Ivan Gyurdiev wrote:
> Karl MacMillan wrote:
> > Sure, conversions would solve the problem, though removing some of this
> > duplication would be even better. Any chance you will have a chance to
> > take care of this?
> >   
> I've stopped working on these things for the moment...

That's too bad.

> How are you suggesting we should get rid of the duplication - use sepol 
> structures directly?

Potentially or investigate whether the presence of the same APIs in both
places exposes some deeper issues.

Karl


-- 
Karl MacMillan
Tresys Technology
www.tresys.com

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
