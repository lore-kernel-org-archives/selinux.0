Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id kAHD6v9K029102
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 08:06:57 -0500
Received: from smtp.sws.net.au (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with ESMTP id kAHD6BaB006365
	for <selinux@tycho.nsa.gov>; Fri, 17 Nov 2006 13:06:13 GMT
From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: Latest Diffs
Date: Sat, 18 Nov 2006 00:07:04 +1100
Cc: Daniel J Walsh <dwalsh@redhat.com>, SE Linux <selinux@tycho.nsa.gov>
References: <453E2A8C.4070207@redhat.com> <200611160433.09138.russell@coker.com.au> <1163684980.7374.26.camel@sgc.columbia.tresys.com>
In-Reply-To: <1163684980.7374.26.camel@sgc.columbia.tresys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200611180007.07194.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Friday 17 November 2006 00:49, "Christopher J. PeBenito" 
<cpebenito@tresys.com> wrote:
> > Having a one-line .fc supposed conflict (it's not a conflict if the two
> > .fc files in question are never used at the same time) is much better
> > than massively hacking up an entire .te file.
>
> Any configuration of modules where all dependencies are met should be a
> valid configuration.  Having a file context conflict would make it an
> invalid configuration.

Can we add conflicts to modules?  Or just deal with this?

> > > >>>> squid wants to rw_tmpfs for diskd mode.
> > > >>>
> > >
> > > I have just recently received an AVC requiring it, which is why I put
> > > it back.
> >
> > Do you have any more information?  If the user is doing something odd
> > like using tmpfs for squid backing store then it's not something we want
> > to support in policy in that manner.
>
> I don't think I agree with that.  If it can be made to work with a
> squid_tmpfs_t, then why not support it?

Any directory on the system that contains application data could be replaced 
by a tmpfs filesystem and require a $1_tmpfs_t type for the least intelligent 
use.  As an example I once ran a MySQL database with a tmpfs for the database 
store.

The correct solution for such cases is to use either restorecon or a -o 
context= mount option to give it the expected type.  It's worked for me every 
time I've tried such things.

> > Maybe we could have restorecon run on the Squid spool directory to
> > cater for the case of using tmpfs for it if people want to do that.

-- 
russell@coker.com.au
http://etbe.blogspot.com/          My Blog

http://www.coker.com.au/sponsorship.html Sponsoring Free Software development

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
