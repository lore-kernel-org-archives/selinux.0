Date: Thu, 26 Aug 2004 15:56:40 -0700
From: Greg KH <greg@kroah.com>
To: Daniel J Walsh <dwalsh@redhat.com>, Bill Nottingham <notting@redhat.com>,
   harald@redhat.com, SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
Message-ID: <20040826225640.GA13818@kroah.com>
References: <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com> <412E34EB.1030909@redhat.com> <20040826225928.GD6058@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040826225928.GD6058@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 26, 2004 at 11:59:28PM +0100, Luke Kenneth Casson Leighton wrote:
> perhaps the style should be that the Makefile adds some code
> add_selinux.c based on a configure-time option,
> 
> and that some #ifdefs in a header file call a function which
> is a stub in the header if WITH_SELINUX is not defined.
> 
> bizarre_but_likely_quite_good_coding_style_never_encountered_before.h:

You've never read Linux kernel code, have you :)

> #ifdef WITH_SELINUX
> int do_add_selinux_stuff(args) { return 0; }

Logic is backwards here.

> #else
> #define do_add_selinux_stuff the_real_add_selinux_stuff

This define is unncessary.  Just call the function
do_add_selinux_stuff(), and protype it.

Actually, inline functions that do nothing if selinux is disabled is
better to catch compiler errors with types if things change in the
future.

thanks,

greg k-h

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
