Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ONIRrT001638
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 19:18:27 -0400 (EDT)
Received: from legolas.drinsama.de (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ONIPCV022921
	for <selinux@tycho.nsa.gov>; Tue, 24 Aug 2004 23:18:25 GMT
Subject: Re: selinux and kde
From: Erich Schubert <erich@debian.org>
To: Andreas Schuldei <andreas@schuldei.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
In-Reply-To: <20040824122646.GA1655@lukas.schuldei.com>
References: <20040823234320.GC12720@lkcl.net>
	 <20040824122646.GA1655@lukas.schuldei.com>
Content-Type: text/plain; charset=ISO-8859-15
Date: Wed, 25 Aug 2004 01:18:20 +0200
Message-Id: <1093389500.3905.12.camel@wintermute.xmldesign.de>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi Andreas,

> i agree. i set up a debian unstable server some weeks ago and
> installed (quite painfully) selinux, running into most of the
> problems you encountered before. when it was up it crashed

I set up two SELinux machines a couple of weeks ago and they have been
doing just fine (apart from some crashes at the beginning which
disappeared with a newer kernel)

> the amount of avc messages i got when running normal operation
> without any special stuff (postfix mostly, where spam filtering
> with spamd is the most advanced operation i do) discouraged me
> slightly to pursue this path right now.

I got these down quite easily and have none left now in everyday usage.
One machine is doing firewall, bind (with dyn updates) and pptp, the
other is running postfix+amavis+clamav and some custom script to get the
mail addresses out of the ldap interface of a notes server.

Of course, the more applications you run on it the more policy you'll
need to write. I havn't even thought about running SELinux on a desktop
machine yet.

Greetings,
Erich Schubert
-- 
   erich@(vitavonni.de|debian.org)    --    GPG Key ID: 4B3A135C    (o_
    Go away or i'll replace you with a very small shell script.     //\
   Jede Frau erwartet von einem Mann, dass er hält, was sie sich    V_/_
                         von ihm verspricht.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
