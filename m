From: Russell Coker <russell@coker.com.au>
Reply-To: russell@coker.com.au
To: James Morris <jmorris@redhat.com>
Subject: Re: inode_doinit_with_dentry messages
Date: Wed, 13 Apr 2005 03:53:39 +1000
Cc: SELinux@tycho.nsa.gov
References: <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0504121252030.17231-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504130353.42587.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wednesday 13 April 2005 02:52, James Morris <jmorris@redhat.com> wrote:
> On Wed, 13 Apr 2005, Russell Coker wrote:
> > Would it be possible to have a file in /selinux to determine whether such
> > messages are displayed?
> >
> > When we convert a machine between strict and targeted policies we (the
> > developers) expect many such messages.  The users however will not be
> > expecting such messages to fill their logs, so it would be good if we
> > could turn off the logging of such messages for the duration of setfiles
> > operation.
>
> How are you doing the conversion?
>
> I usually edit the config file, boot with selinux=0, relabel, then reboot
> with selinux=1.

That's two reboots and it's not the way we designed things.  Quite a bit of 
work has already been done to get it working that way.

> How many people really need to do this though?

Everyone who wants to use strict policy, which is probably everyone for whom 
SE Linux is a major factor in choosing a distribution.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
