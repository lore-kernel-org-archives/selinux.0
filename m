Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8LI4rGO021306
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 14:04:53 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8LI4OcD010709
	for <selinux@tycho.nsa.gov>; Thu, 21 Sep 2006 18:04:24 GMT
Subject: Re: Latest diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Karl MacMillan <kmacmillan@mentalrootkit.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <1158856416.28640.41.camel@localhost.localdomain>
References: <45116881.3060406@redhat.com>
	 <1158846352.3920.33.camel@sgc.columbia.tresys.com>
	 <45129C7F.6090801@redhat.com>
	 <1158849263.3920.63.camel@sgc.columbia.tresys.com>
	 <1158856416.28640.41.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 14:05:00 -0400
Message-Id: <1158861900.3920.81.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-09-21 at 12:33 -0400, Karl MacMillan wrote:
> On Thu, 2006-09-21 at 10:34 -0400, Christopher J. PeBenito wrote:
> > On Thu, 2006-09-21 at 10:06 -0400, Daniel J Walsh wrote:
> > > Christopher J. PeBenito wrote:
> > > > On Wed, 2006-09-20 at 12:12 -0400, Daniel J Walsh wrote:
> > > >
> > > > I haven't looked at the patch but I have some initial reactions from
> > > > your description:
> > > >
> > > >   
> > > >> http://people.redhat.com/dwalsh/SELinux/policy.diff
> > > >>
> > > >> Changed to allow 1024 categories.
> > > >>     
> > > >
> > > > Why do we need this many?  This isn't even an incremental change up to
> > > > something like 384 or 512.
> > > >
> > > >   
> > > MLS People have past 256 and wanted a big jump to prevent hitting this 
> > > problem again.  I put it in for both to prevent confusion between MCS/MLS
> > 
> > Ok, we'll go with 1024, but that's where I draw the line; I consider any
> > higher to be a corner case.  Anyone that needs more than that will have
> > to build their own custom policy.
> > 
> 
> We have also discussed reserving category ranges for different purposes
> - e.g., categories local to a machine and categories managed across a
> network. With that usage model higher numbers start looking more
> reasonable quickly.
>
> What is the objection to the higher numbers of categories? It shouldn't
> have a large impact on policy size I wouldn't think.
> 
> If you are trying to prevent misuse I think that is a losing battle. We
> should provide tools that can be used reasonably not prevent potentially
> legitimate uses because some people are clueless.

The line has to be drawn somewhere.  If you want to argue another number
that's fine.  I'd prefer setting a max now, rather than bumping
categories every few months for every new use of categories.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
