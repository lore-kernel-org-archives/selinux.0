Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k43IZ83B004371
	for <selinux@tycho.nsa.gov>; Wed, 3 May 2006 14:35:08 -0400
Subject: Re: appletalk sockets
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Cc: James Morris <jmorris@redhat.com>,
        SELinux Mail List <selinux@tycho.nsa.gov>
In-Reply-To: <1146680736.16160.4.camel@sgc>
References: <1146676995.20331.113.camel@sgc>  <1146680736.16160.4.camel@sgc>
Content-Type: text/plain
Date: Wed, 03 May 2006 14:39:28 -0400
Message-Id: <1146681568.27735.131.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, 2006-05-03 at 14:25 -0400, Christopher J. PeBenito wrote:
> On Wed, 2006-05-03 at 13:23 -0400, Christopher J. PeBenito wrote:
> > On Tue, 02 May 2006 at 13:57 -0400, Christopher J. PeBenito wrote:
> > > On Tue, 2006-05-02 at 13:30 -0400, Daniel J Walsh wrote:
> > > > Christopher J. PeBenito wrote:
> > > > > On Tue, 2006-05-02 at 10:08 -0400, Daniel J Walsh wrote:
> > > > >> cups needs to be able to create socket to itself.
> > > > >
> > > > > This needs more investigation; we need to find out more about this
> > > > > generic socket so we can add a specific class for it.
> > > > >
> > > > >   
> > > >
> > > http://www.redhat.com/archives/fedora-selinux-list/2006-April/msg00216.html
> > > 
> > > So it appears that a class for appletalk sockets needs to be added.
> > 
> > How about the attached patches?
> 
> Perhaps permissions should be added to netif for appletalk send/receive
> too, so it doesn't fall through to rawip send/receive?

netif checks are going away altogether.

-- 
Stephen Smalley
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
