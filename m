Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7UKM3rT007707
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 16:22:03 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7UKM210002782
	for <selinux@tycho.nsa.gov>; Mon, 30 Aug 2004 20:22:02 GMT
Date: Mon, 30 Aug 2004 21:33:17 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: "Fedora SELinux support list for users & developers." <fedora-selinux-list@redhat.com>,
   russell@coker.com.au, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: Progress! .532 boots! -- but dbus/hotplug/udev problems remain?
Message-ID: <20040830203316.GC31497@lkcl.net>
References: <4130CF1B.3090909@comcast.net> <200408291737.17497.russell@coker.com.au> <41323421.7050904@comcast.net> <41336FF0.2060701@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <41336FF0.2060701@redhat.com>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 30, 2004 at 02:20:32PM -0400, Daniel J Walsh wrote:
> Tom London wrote:
> 
> >Russell,
> >
> >The following changes to udev.te seem needed....
> >(If udev shouldn't be reading file_contexts, then dontaudit?)
> >
> udev needs to read file_contexts.  It is doing a matchpathcon in order 
> to setup the devices with the correct context.
 
 dan, dan, you MUST fix the bug in that patch before making changes to
 the selinux policy files for udev!!!

 matchpathcon() is being called with S_IFDIR not with the mode argument!

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
