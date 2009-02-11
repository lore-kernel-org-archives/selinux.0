Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n1BDH4Er005964
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 08:17:04 -0500
Received: from mail-ew0-f20.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id n1BDH2AP025834
	for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 13:17:03 GMT
Received: by ewy13 with SMTP id 13so305120ewy.18
        for <selinux@tycho.nsa.gov>; Wed, 11 Feb 2009 05:17:01 -0800 (PST)
Subject: Re: Question about su
From: Dominick Grift <domg472@gmail.com>
To: Dennis Wronka <linuxweb@gmx.net>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200902112101.05913.linuxweb@gmx.net>
References: <200902111650.39754.linuxweb@gmx.net>
	 <1234349196.13112.16.camel@notebook1.grift.internal>
	 <200902112101.05913.linuxweb@gmx.net>
Content-Type: text/plain
Date: Wed, 11 Feb 2009 14:16:59 +0100
Message-Id: <1234358219.14058.3.camel@notebook1.grift.internal>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2009-02-11 at 21:01 +0800, Dennis Wronka wrote:
> Thanks. This info helped a lot.
> So user_u is for regular users that are just supposed to do stuff with what 
> the system offers. Anything else, like installing stuff is loaded off to users 
> that are at least staff_u or above.
> 
> It's something one has to get used to, especially the part of newrole-ing 
> first and afterwards using su.

In Fedora (targeted policy) we use sudo to transition to root and
privileged user domains. This has the advantage that one can delegate
privileged tasks without having to share roots password. It also saves
you from having to authenticate two times.

Yes user_u is for users that should never be able to do privileged
tasks.

Staff_u can domain transition to more permissive user domains.

> > --
> > This message was distributed to subscribers of the selinux mailing list.
> > If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov
> > with the words "unsubscribe selinux" without quotes as the message.
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
