Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7REHgrT020196
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 10:17:42 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7REGtpX026400
	for <selinux@tycho.nsa.gov>; Fri, 27 Aug 2004 14:16:56 GMT
Date: Fri, 27 Aug 2004 15:28:55 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Greg KH <greg@kroah.com>
Cc: Daniel J Walsh <dwalsh@redhat.com>, Bill Nottingham <notting@redhat.com>,
   harald@redhat.com, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
Message-ID: <20040827142855.GC3850@lkcl.net>
References: <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com> <412E34EB.1030909@redhat.com> <20040826225928.GD6058@lkcl.net> <20040826225640.GA13818@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040826225640.GA13818@kroah.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 26, 2004 at 03:56:40PM -0700, Greg KH wrote:
> On Thu, Aug 26, 2004 at 11:59:28PM +0100, Luke Kenneth Casson Leighton wrote:
> > perhaps the style should be that the Makefile adds some code
> > add_selinux.c based on a configure-time option,
> > 
> > and that some #ifdefs in a header file call a function which
> > is a stub in the header if WITH_SELINUX is not defined.
> > 
> > bizarre_but_likely_quite_good_coding_style_never_encountered_before.h:
> 
> You've never read Linux kernel code, have you :)
 
 all the tiime :)

 no, but seriously i have: i spent about three months porting linux
 to the xda-2 (400mhz intel-arm pxa263)

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
