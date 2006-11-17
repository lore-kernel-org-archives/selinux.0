Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHLRpsm012274
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 16:27:51 -0500
Received: from smtp.sws.net.au (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHLQCaE016378
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 21:26:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Joshua Brindle <jbrindle@tresys.com>
Subject: Re: Latest Diffs
Date: Sat, 18 Nov 2006 08:27:55 +1100
Cc: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <453E2A8C.4070207@redhat.com> <200611180007.07194.russell@coker.com.au> <455E008E.3040707@tresys.com>
In-Reply-To: <455E008E.3040707@tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200611180827.57836.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Saturday 18 November 2006 05:33, Joshua Brindle <jbrindle@tresys.com> 
wrote:
> Russell Coker wrote:
> > On Friday 17 November 2006 00:49, "Christopher J. PeBenito"
> > <cpebenito@tresys.com> wrote:
> >
> > Any directory on the system that contains application data could be
> > replaced by a tmpfs filesystem and require a $1_tmpfs_t type for the
> > least intelligent use.  As an example I once ran a MySQL database with a
> > tmpfs for the database store.
>
> Eh? Why? MySQL has a memory backed database type, this is an unnecessary
> layer of indirection.

I wanted to prepare a database image for distribution to other people.  The 
database load took ages when used on a disk (due to synchronous writes) but 
was really fast on a tmpfs.  A memory backed database would not have worked 
as it's not something you can distribute.

> It makes sense for some apps but not others, why add lots of completely
> unnecessary policy?

I am opposing the addition of the unnecessary policy, which in this case is 
tmpfs access for squid.

> > The correct solution for such cases is to use either restorecon or a -o
> > context= mount option to give it the expected type.  It's worked for me
> > every time I've tried such things.
> >
> >>> Maybe we could have restorecon run on the Squid spool directory to
> >>> cater for the case of using tmpfs for it if people want to do that.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
