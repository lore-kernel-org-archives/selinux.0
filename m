Date: Sun, 9 Oct 2005 23:08:38 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Dale Amon <amon@vnl.com>, Stephen Smalley <sds@tycho.nsa.gov>,
   SELinux List <SELinux@tycho.nsa.gov>
Subject: Re: More Debian bugs
Message-ID: <20051009220838.GZ18797@lkcl.net>
References: <20050923195227.GA21546@vnl.com> <200510092019.41106.russell@coker.com.au> <20051009145000.GU18797@lkcl.net> <200510100645.01903.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510100645.01903.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Oct 10, 2005 at 06:44:50AM +1000, Russell Coker wrote:
> On Monday 10 October 2005 00:50, Luke Kenneth Casson Leighton <lkcl@lkcl.net> 
> wrote:
> > > One thing to note is that udev now seems a standard part of sid.  Udev on
> > > it's own seems a bit broken in Debian (for example not mounting
> > > /dev/pts), and in conjunction with SE Linux there's even more fun.  I
> > > don't expect udev and SE Linux to work well together on Debian for some
> > > weeks or maybe months.
> >
> >  ah.
> >
> >  there are two ways this needs to be fixed.
> >
> >  1) initrd removed from debian
> >
> >  2) udev moved into initrd like you have with redhat.
> 
> 3)  Bugs in udev just get fixed.  This is the one I expect to happen.
 
 until 2) happens, debian/selinux is vulnerable to the "/dev
 being moved to /.dev and getting relabelled inappropriately or
 accidentally having selinux filecontexts removed by fsck and
 there being nothing to put them back" problem because no-one
 wants to or will acknowledge whether it's appropriate to add
 /.dev/* to the file contexts source alongside /dev and /udev
 *grumble, rhubarb* :)

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
