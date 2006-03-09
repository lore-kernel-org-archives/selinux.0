Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2A5pNnR003886
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 00:51:23 -0500
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2A5nnkb010514
	for <selinux@tycho.nsa.gov>; Fri, 10 Mar 2006 05:49:49 GMT
Subject: Re: Patch to add a "netuser" role and user
From: Erich Schubert <erich@debian.org>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1141915618.30819.202.camel@sgc.columbia.tresys.com>
References: <1141773189.5082.39.camel@wintermute.xmldesign.de>
	 <1141842611.30819.182.camel@sgc.columbia.tresys.com>
	 <1141845239.8134.8.camel@wintermute.xmldesign.de>
	 <1141915618.30819.202.camel@sgc.columbia.tresys.com>
Content-Type: text/plain
Date: Thu, 09 Mar 2006 19:05:09 +0100
Message-Id: <1141927510.5348.5.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Christopher,
> > Except that you might not want to allow user_tcp_server for all users,
> > and with netuser you can give this permission easily to individual users
> > on a per-user basis.
> 
> That is true, but I don't find binding to generic ports to be a
> compelling reason to add another role to the upstream policy.

So you want tons of admins to enable user_tcp_server (which apparently
currently doesn't give all the needed permissions to fullfil it's
promises) when they are running a user tcp service?
E.g. an IRC bouncer? Maybe a "web service"? A custom java app?

I think this role is very interesting to have for admins.

And always remember what the AppArmor people say: that they are easier
to use. So why not add things like this role to make SELinux easier to
use for certain common situations, too?

best regards,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
            Reality continues to ruin my life --- Calvin            //\
   Die Freunde nennen sich aufrichtig. Die Feinde sind es: Daher    V_/_
     man ihren Tadel zur Selbsterkenntnis benutzen sollte, als
           eine bittere Arznei.  --- Arthur Schopenhauer


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
