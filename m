Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8BHKdrT025241
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 13:20:39 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8BHKc6V005955
	for <selinux@tycho.nsa.gov>; Sat, 11 Sep 2004 17:20:38 GMT
Date: Sat, 11 Sep 2004 18:31:52 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: policy patch against latest CVS
Message-ID: <20040911173152.GB12835@lkcl.net>
References: <200409111954.15823.russell@coker.com.au> <20040911115308.GB24787@lkcl.net> <200409120123.28663.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200409120123.28663.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Sun, Sep 12, 2004 at 01:23:28AM +1000, Russell Coker wrote:
> On Sat, 11 Sep 2004 21:53, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > On Sat, Sep 11, 2004 at 07:54:15PM +1000, Russell Coker wrote:
> > > +file_type_auto_trans(init_t, device_t, initctl_t, fifo_file)
> > > +ifdef(`distro_redhat', `
> > > +file_type_auto_trans(init_t, tmpfs_t, initctl_t, fifo_file)
> > > +')
> >
> >  debian will need this too, yes?
> 
> [...]
> 
> >  and this?
> >
> >  if this is as you say to support tmpfs_t in udev, and i am to keep
> >  current with the present selinux policy, i'll need these in debian
> >  not just redhat!
> 
> That is for tmpfs in initrd.  

any chance of a comment in the policy to that effect?


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
