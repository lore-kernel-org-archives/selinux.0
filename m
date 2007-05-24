Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with SMTP id l4OFSMue012465
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 11:28:22 -0400
Received: from mx1.redhat.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id l4OFSLc3011192
	for <selinux@tycho.nsa.gov>; Thu, 24 May 2007 15:28:21 GMT
Subject: Re: [patch 1/3] libsemanage: genhomedircon replacement
From: Karl MacMillan <kmacmillan@mentalrootkit.com>
To: Steve G <linux_4ever@yahoo.com>
Cc: Mark Goldman <mgoldman@tresys.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <608941.10928.qm@web51510.mail.re2.yahoo.com>
References: <608941.10928.qm@web51510.mail.re2.yahoo.com>
Content-Type: text/plain
Date: Thu, 24 May 2007 11:27:41 -0400
Message-Id: <1180020461.2940.31.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2007-05-24 at 08:05 -0700, Steve G wrote:

> > > +char *semanage_findval(char *file, char *var, char *delim)
> > > +{
> > > +	FILE *fd;
> > > +
> > > +	char *buff;
> > > +	char *temp = NULL;
> > > +
> > > +	if (!file || !var || !delim)
> > > +		return NULL;
> > 
> > assert?
> 
> Assert is bad as it calls SIGABRT. SIGABRT means dump core. Production software
> should not be dumping core as a habit.
> 

Assert is perfectly acceptable for checking for "impossible" situations
that would lead to a crash anyway. The assert assures that the crash is
immediate and there is no memory corruption or misuse.

See my other mail - I'm trying to determine whether this is a check for
an impossible state or something that needs runtime error checking.

Karl



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
