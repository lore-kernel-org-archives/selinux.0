From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Tom <tom@lemuria.org>
Subject: Re: Default Policy question?
Date: Tue, 3 Jun 2003 23:31:13 +1000
Cc: SELinux@tycho.nsa.gov
References: <3EDB7585.8050308@redhat.com> <200306030951.59964.russell@coker.com.au> <20030603083059.A4056@lemuria.org>
In-Reply-To: <20030603083059.A4056@lemuria.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200306032331.13700.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 3 Jun 2003 16:30, Tom wrote:
> On Tue, Jun 03, 2003 at 09:51:59AM +1000, Russell Coker wrote:
> > > * his home directory (environment)
> > > * policy and policy tools
> > > * kernel and kernel modules
> >
> > So who runs debugfs/fdisk/mkfs?
>
> Note that I'm not trying to protect against DESTRUCTION of the system,
> but against subversion.

mkfs and debugfs can be used for subversion of the system by replacing files.

If you can manage block devices then you can manage almost everything else if 
you try hard enough.  Palladium and TCPA are attempts to change this, but 
AFAIK no-one is working on integrating such technology with SE Linux.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
