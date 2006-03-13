Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2DECsiX008155
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 09:12:58 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2DEBHoC003849
	for <selinux@tycho.nsa.gov>; Mon, 13 Mar 2006 14:11:18 GMT
Subject: Re: Patch to add a "netuser" role and user
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141927510.5348.5.camel@wintermute.xmldesign.de>
References: <1141773189.5082.39.camel@wintermute.xmldesign.de>
	 <1141842611.30819.182.camel@sgc.columbia.tresys.com>
	 <1141845239.8134.8.camel@wintermute.xmldesign.de>
	 <1141915618.30819.202.camel@sgc.columbia.tresys.com>
	 <1141927510.5348.5.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 09:12:58 -0500
Message-Id: <1142259178.30819.206.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-03-09 at 19:05 +0100, Erich Schubert wrote:
> Hi Christopher,
> > > Except that you might not want to allow user_tcp_server for all users,
> > > and with netuser you can give this permission easily to individual users
> > > on a per-user basis.
> > 
> > That is true, but I don't find binding to generic ports to be a
> > compelling reason to add another role to the upstream policy.
> 
> So you want tons of admins to enable user_tcp_server (which apparently
> currently doesn't give all the needed permissions to fullfil it's
> promises) when they are running a user tcp service?

If the user templates are missing rules, then they need to be fixed.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
