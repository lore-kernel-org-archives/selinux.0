Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k35G9cb1026179
	for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2006 12:09:38 -0400
Received: from legolas.drinsama.de (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id k35G7oua005818
	for <selinux@tycho.nsa.gov>; Wed, 5 Apr 2006 16:07:51 GMT
Subject: Re: VPN module
From: Erich Schubert <erich@debian.org>
To: Joshua Brindle <jbrindle@tresys.com>
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <4433DC6D.9020209@tresys.com>
References: <1144238374.19128.11.camel@wintermute.xmldesign.de>
	 <1144248600.12875.2.camel@sgc.columbia.tresys.com>
	 <4433DC6D.9020209@tresys.com>
Content-Type: text/plain
Date: Wed, 05 Apr 2006 18:09:35 +0200
Message-Id: <1144253375.19128.56.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
> > Creating openvpn will be fine, but the vpn module has to stay as is,
> > because we can't rename modules, because it causes upgrade issues.  For

I think we'll hit that problem sooner or later, and in order to do some
automatic module loading we'll need much more magic anyway. Apart from
that I don't think we need to be very careful with upgrading policy
anyway, because the admin might have customized it.
So on the one hand, I'd try to change such obvious things like this as
early as possible (the module is badly named, it should be called vpnc!)
so it will effect as few people as possible, on the other hand we'll
probably need all this sooner or later anyway. So we should start
planning tools for that.
(e.g. how to extract dependency / conflict information from modules, how
to map packages to modules that should be loaded)

best regards,
Erich Schubert
-- 
    erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
   To understand recursion you first need to understand recursion.   //\
    Wirklich gute Freunde machen sich erst aus dem Staub, wenn man   V_/_
            sie braucht. --- Charles Maurice de Tayllerand


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
