Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id iBFFD2Ii018675
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 10:13:03 -0500 (EST)
Received: from gotham.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id iBFFBGxm004602
	for <selinux@tycho.nsa.gov>; Wed, 15 Dec 2004 15:11:16 GMT
Subject: Re: ANN: SELinux Policy Server Project
From: Joshua Brindle <jbrindle@tresys.com>
Reply-To: jbrindle@tresys.com
To: Steve G <linux_4ever@yahoo.com>
Cc: selinux@tycho.nsa.gov, selinux-dev@tresys.com
In-Reply-To: <20041215144654.34582.qmail@web50602.mail.yahoo.com>
References: <20041215144654.34582.qmail@web50602.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 15 Dec 2004 10:15:16 -0500
Message-Id: <1103123717.758.4.camel@twoface>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

This is just the project announcement and a very preliminary release.
There is no daemon yet, what this release provides is the initial
support for hierarchal policy structure and a way to verify the policy.
This is an important first step to being able to refer to yet-unknown
parts of the policy for access control.

In selinux-doc/README.MODULES there are instructions for using the
hierarchy checker with the semodule framework. 

Joshua Brindle

On Wed, 2004-12-15 at 06:46 -0800, Steve G wrote:
> Hi,
> 
> >We at Tresys have started a project to design and implement an 
> >SELinux policy server.
> 
> Simple question...when I untar the source, where exactly is the source code for
> the daemon? I'll give it a going over.
> 
> Thanks,
> -Steve Grubb
> 
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around 
> http://mail.yahoo.com 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
