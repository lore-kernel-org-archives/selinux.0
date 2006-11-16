Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAGDnE9a024642
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 08:49:14 -0500
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with SMTP id kAGDlaBv000627
	for <selinux@tycho.nsa.gov>; Thu, 16 Nov 2006 13:47:37 GMT
Subject: Re: Latest Diffs
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: russell@coker.com.au
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <200611160433.09138.russell@coker.com.au>
References: <453E2A8C.4070207@redhat.com>
	 <200611152049.38615.russell@coker.com.au> <455B18AE.6050901@redhat.com>
	 <200611160433.09138.russell@coker.com.au>
Content-Type: text/plain
Date: Thu, 16 Nov 2006 08:49:40 -0500
Message-Id: <1163684980.7374.26.camel@sgc.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 2006-11-16 at 04:33 +1100, Russell Coker wrote:
> On Thursday 16 November 2006 00:39, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > > I think it's best if Red Hat compiles just don't include dpkg.te.
> > >
> > > Have apt-get and yum run in the same context in Fedora.
> >
> > That is the way it is now, but it is unacceptable to upstream.  Chris
> > does not like the conflicting
> > file context.
> 
> There is no conflict if rpm.te and dpkg.te are never included in the same 
> build.
> 
> Having a one-line .fc supposed conflict (it's not a conflict if the two .fc 
> files in question are never used at the same time) is much better than 
> massively hacking up an entire .te file.

Any configuration of modules where all dependencies are met should be a
valid configuration.  Having a file context conflict would make it an
invalid configuration.

> > >>>> squid wants to rw_tmpfs for diskd mode.
> > >>>
> > >>> I'm wondering if this is tmpfs_t because there is no squid_tmpfs_t+type
> > >>> transition, or if it is because the machine is targeted.
> > >>
> > >> Not sure, this was in the old policy as well.  Never used squid.
> > >
> > > I believe that it was a mistake in the Squid policy.
> >
> > I have just recently received an AVC requiring it, which is why I put it
> > back.
> 
> Do you have any more information?  If the user is doing something odd like 
> using tmpfs for squid backing store then it's not something we want to 
> support in policy in that manner.

I don't think I agree with that.  If it can be made to work with a
squid_tmpfs_t, then why not support it?

> Maybe we could have restorecon run on the Squid spool directory to
> cater for the case of using tmpfs for it if people want to do that.

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
