From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: Stephen Smalley <sds@tycho.nsa.gov>
Subject: Re: inode_doinit_with_dentry messages
Date: Wed, 13 Apr 2005 04:13:03 +1000
Cc: James Morris <jmorris@redhat.com>, SELinux@tycho.nsa.gov
References: <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com> <200504130353.42587.russell@coker.com.au> <1113328522.25217.181.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1113328522.25217.181.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200504130413.07216.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 13 April 2005 03:55, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2005-04-13 at 03:53 +1000, Russell Coker wrote:
> > Everyone who wants to use strict policy, which is probably everyone for
> > whom SE Linux is a major factor in choosing a distribution.
>
> Sorry, doesn't strict policy define a superset of the file types in the
> targeted policy?  Thus, there shouldn't be inode_doinit errors upon
> targeted -> strict conversion,

True.  However my observation indicates that of the people who use the strict 
policy in Fedora few of them use it from the start without ever going back.  
Often they deploy test machines, play with strict, get annoyed and go back to 
targeted, give it another go when someone explains things to them on IRC, 
etc.

The people who will go for strict policy and never look back can probably deal 
with a few error messages.  ;)

> only the reverse (which should be rare). 

In live production servers it should be rare!  In fact we should probably 
write some documentation about the issues related to moving servers between 
strict and targeted.  For Fedora desktop machines I don't expect it to be 
rare at all.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
