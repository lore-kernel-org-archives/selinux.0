Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8A9ogrT017630
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 05:50:42 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8A9nnvo022400
	for <selinux@tycho.nsa.gov>; Fri, 10 Sep 2004 09:49:49 GMT
Date: Fri, 10 Sep 2004 11:01:51 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Daniel J Walsh <dwalsh@redhat.com>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   fedora-devel-list@redhat.com, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: tmpfs /dev
Message-ID: <20040910100151.GD14060@lkcl.net>
References: <200409100536.59711.russell@coker.com.au> <4140BAB8.8070808@redhat.com> <200409101508.27612.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409101508.27612.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Fri, Sep 10, 2004 at 03:08:27PM +1000, Russell Coker wrote:
> On Fri, 10 Sep 2004 06:19, Daniel J Walsh <dwalsh@redhat.com> wrote:
> > You will need to talk to Bill Nottingham about modifying /sbin/init to
> > do this.  They are not crazy about
> > putting additional code into /sbin/init since it is very hard to debug.
> 
> We've done it once, we can do it again.
> 
> > They prefer rc.sysinit.  They also do not
> 
> rc.sysinit means changing the policy for init_t, initrc_t, and maybe others.
> 
> > want to relabel the /dev file system if it is not a tmpfs,  since with
> > 8000 or more files it could take a while and
> > slow down the boot up.
> 
> On the slowest machine I have access to (a machine that can never run Fedora 
> because it doesn't meet the hardware requirements) it takes 12 seconds to run 
> setfiles on a fully loaded /dev.  On machines that are a mere four years old 
> it takes about 2 seconds, I doubt that you will be able to measure the 
> difference that this makes on any hardware that can be purchased now.  But 
> writing some code to check for the file system type is not too difficult.
 
 on my 1.6Gz athlon, it takes somewhere between 30 and 50
 seconds to do the setting up of udev entries (ttyS0->ttyS63
 and tty0->tty63) which would make it more of a priority to
 be sorted than the above!

 l.

 
-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
