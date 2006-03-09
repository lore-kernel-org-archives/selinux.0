Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k29ElTRc018769
	for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2006 09:47:29 -0500
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k29Ejsba005848
	for <selinux@tycho.nsa.gov>; Thu, 9 Mar 2006 14:45:55 GMT
Subject: Re: Patch to add a "netuser" role and user
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Erich Schubert <erich@debian.org>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141845239.8134.8.camel@wintermute.xmldesign.de>
References: <1141773189.5082.39.camel@wintermute.xmldesign.de>
	 <1141842611.30819.182.camel@sgc.columbia.tresys.com>
	 <1141845239.8134.8.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 09:46:57 -0500
Message-Id: <1141915618.30819.202.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-03-08 at 20:13 +0100, Erich Schubert wrote:
> > The patch is a reasonable example for adding roles, but I'm not sure
> > that it should be added.  I can't think of a compelling need for it,
> > especially since its basically user_r with user_tcp_server enabled, as
> > you mention above.
> 
> Except that you might not want to allow user_tcp_server for all users,
> and with netuser you can give this permission easily to individual users
> on a per-user basis.

That is true, but I don't find binding to generic ports to be a
compelling reason to add another role to the upstream policy.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
