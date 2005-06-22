Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id j5MKvZgA021425
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 16:57:36 -0400 (EDT)
Received: from mail.nagafix.co.uk (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id j5MKlrrk017003
	for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2005 20:47:53 GMT
Subject: Re: general selinux questions
From: antoine <antoine@nagafix.co.uk>
To: Colin Walters <walters@verbum.org>
Cc: SELinux <selinux@tycho.nsa.gov>
In-Reply-To: <1118770638.3422.27.camel@nexus.verbum.private>
References: <1118281858.9481.4.camel@localhost>
	 <1118341614.30110.122.camel@moss-spartans.epoch.ncsc.mil>
	 <1118433604.10190.353.camel@localhost>
	 <1118433283.3774.218.camel@moss-spartans.epoch.ncsc.mil>
	 <1118769876.10262.52.camel@localhost>
	 <1118770638.3422.27.camel@nexus.verbum.private>
Content-Type: text/plain
Date: Wed, 22 Jun 2005 20:54:52 +0100
Message-Id: <1119470092.9358.43.camel@localhost>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

> > audit(1118762231.596:0): avc:  denied  { transition } for  pid=28871
> > exe=/usr/lib/postfix/master path=/usr/lib/postfix/pipe dev=md3
> > ino=670776 scontext=system_u:system_r:postfix_master_t
> > tcontext=system_u:object_r:postfix_pipe_t tclass=process
> > So I've added this to postfix.te (from audit2allow):
> > allow postfix_master_t postfix_pipe_t:process transition;
> > But it has no effect and the same audit message keeps coming up!
> > I have absolutely no idea where to go from here...
> 
> Tried audit2why?  Could be constraints or RBAC denial.
Many thanks, it helped! I thought I had tried it but I needed one of:
role system_r types postfix_pipe_t;
role system_r types postfix_master_t;

Antoine (now in enforcing mode!)


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
