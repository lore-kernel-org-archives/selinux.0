Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i7ACYErT001898
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 08:34:14 -0400 (EDT)
Received: from open.hands.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i7ACXbET019238
	for <selinux@tycho.nsa.gov>; Tue, 10 Aug 2004 12:33:37 GMT
Date: Tue, 10 Aug 2004 13:45:15 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Russell Coker <russell@coker.com.au>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, g@lkcl.net,
   SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
Message-ID: <20040810124515.GB4647@lkcl.net>
References: <20040809175246.GK3868@lkcl.net> <1092078176.29199.179.camel@moss-spartans.epoch.ncsc.mil> <20040809194321.GO3868@lkcl.net> <200408101645.28470.russell@coker.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200408101645.28470.russell@coker.com.au>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, Aug 10, 2004 at 04:45:28PM +1000, Russell Coker wrote:
> On Tue, 10 Aug 2004 05:43, Luke Kenneth Casson Leighton <lkcl@lkcl.net> wrote:
> > > /dev/null should show up as chr_file, and should be created with
> > > null_device_t anyway.  Is this actually an attempt to unlink udev.tbl?
> >
> > no, it's definitely an attempt to unlink /dev/null (!).
> >
> > and it's definitely saying device_t:file.
> 
> In that case you probably have a non-SE Linux bug.  I guess that some program 
> is trying to send output to /dev/null when there is no /dev/null device.
 
 that'd make sense because the comments in /etc/init.d/udev say
 "you can't do things like background scripts".

 so, this one for _not_ including in the policy files.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
