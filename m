Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QMmKrT016605
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 18:48:20 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QMlXfU001529
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 22:47:33 GMT
Date: Thu, 26 Aug 2004 23:59:28 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Greg KH <greg@kroah.com>, Bill Nottingham <notting@redhat.com>,
   harald@redhat.com, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
Message-ID: <20040826225928.GD6058@lkcl.net>
References: <20040223213614.GA12242@devserv.devel.redhat.com> <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com> <412E34EB.1030909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <412E34EB.1030909@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

perhaps the style should be that the Makefile adds some code
add_selinux.c based on a configure-time option,

and that some #ifdefs in a header file call a function which
is a stub in the header if WITH_SELINUX is not defined.

bizarre_but_likely_quite_good_coding_style_never_encountered_before.h:

#ifdef WITH_SELINUX
int do_add_selinux_stuff(args) { return 0; }
#else
#define do_add_selinux_stuff the_real_add_selinux_stuff
#endif

and add_selinux.c contains:

int the_real_add_selinux_stuff(args)
{
	....

	return err;
}


On Thu, Aug 26, 2004 at 03:07:23PM -0400, Daniel J Walsh wrote:
> Greg KH wrote:
> 
> >On Thu, Aug 26, 2004 at 01:41:03PM -0400, Daniel J Walsh wrote:
> > 
> >
> >>Greg KH wrote:
> >>
> >>   
> >>
> >>>On Thu, Aug 26, 2004 at 11:15:07AM -0400, Daniel J Walsh wrote:
> >>>
> >>>
> >>>     
> >>>
> >>>>This will create the security contexts on the fly.
> >>>>
> >>>>Please comment on what would be needed to get this acceptable?
> >>>> 
> >>>>
> >>>>       
> >>>>
> >>>Same things I said on the mailing list:
> >>>	- fix coding style
> >>>	- no ifdefs in .c files
> >>>	- make the selinux stuff all be in its own file
> >>>	- make the build flag look like the other build flags
> >>>	- not make the makefile changes have silly line continuations
> >>>	  when not needed :)
> >>>	- post the patch on the mailing list (linux-hotplug-devel) for
> >>>	  others to comment on after fixing the above.
> >>>
> >>>thanks,
> >>>
> >>>greg k-h
> >>>
> >>>
> >>>     
> >>>
> >>Another pass at a cleaned up patch.  This time attempting to folow Greg 
> >>guidelines.
> >>   
> >>
> >
> >Looks good.  Do you really want it all in a .h file?  I don't mind
> >having the selinux functions being in a .c file and building that if
> >USE_SELINUX is enabled.
> >
> >But it's your call, as you are the one going to have to live with the
> >code :)
> >
> >thanks,
> >
> >greg k-h
> > 
> >
> I copied the way it was being done with logging.h
> 
> I already have some updates from comments from other people.
> 
> Dan
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov 
> with
> the words "unsubscribe selinux" without quotes as the message.

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
