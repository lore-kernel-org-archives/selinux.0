Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7QJcDrT015647
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 15:38:13 -0400 (EDT)
Received: from moss-huskies.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7QJbQfU022895
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 19:37:26 GMT
Received: from moss-huskies.epoch.ncsc.mil (localhost.localdomain [127.0.0.1])
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11) with ESMTP id i7QJcafN014731
	for <selinux@tycho.nsa.gov>; Thu, 26 Aug 2004 15:38:36 -0400
Received: (from hdholm@localhost)
	by moss-huskies.epoch.ncsc.mil (8.12.11/8.12.11/Submit) id i7QJcakV014730
	for selinux@tycho.nsa.gov; Thu, 26 Aug 2004 15:38:36 -0400
Date: Thu, 26 Aug 2004 12:14:22 -0700
From: Greg KH <greg@kroah.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: Bill Nottingham <notting@redhat.com>, harald@redhat.com,
   SELinux <SELinux@tycho.nsa.gov>,
   "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   linux-hotplug-devel@lists.sourceforge.net
Subject: Re: Cleaned up udev-selinux patch
Message-ID: <20040826191422.GB13310@kroah.com>
References: <20040223213614.GA12242@devserv.devel.redhat.com> <20040224233859.GA3265@kroah.com> <20040224234652.GA14775@devserv.devel.redhat.com> <403C8AE4.10403@redhat.com> <20040228005300.GA13860@kroah.com> <412DFE7B.6060409@redhat.com> <20040826155716.GA30726@kroah.com> <412E20AF.7000102@redhat.com> <20040826175139.GA12225@kroah.com> <412E34EB.1030909@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <412E34EB.1030909@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Aug 26, 2004 at 03:07:23PM -0400, Daniel J Walsh wrote:
> Greg KH wrote:
> 
> >Looks good.  Do you really want it all in a .h file?  I don't mind
> >having the selinux functions being in a .c file and building that if
> >USE_SELINUX is enabled.
> >
> >But it's your call, as you are the one going to have to live with the
> >code :)
> 
> I copied the way it was being done with logging.h

Yeah, but logging.h has such tiny functions :)

Anyway, it's your decision.

> I already have some updates from comments from other people.

Ok, feel free to send me a patch when you feel it should be applied.

thanks,

greg k-h

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
