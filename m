Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79JW0rT027926
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 15:32:00 -0400 (EDT)
Received: from smtp814.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i79JVwIn006558
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 19:31:58 GMT
Date: Mon, 9 Aug 2004 20:43:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>, g@lkcl.net
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
Message-ID: <20040809194321.GO3868@lkcl.net>
References: <20040809175246.GK3868@lkcl.net> <1092077016.29199.166.camel@moss-spartans.epoch.ncsc.mil> <20040809190901.GM3868@lkcl.net> <1092078176.29199.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092078176.29199.179.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 09, 2004 at 03:02:57PM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-09 at 15:09, Luke Kenneth Casson Leighton wrote:
> >  thank you: i found this: i was more concerned that i should
> >  be setting mount -o fscontext=....fs_t instead?
> 
> No, I think device_t is appropriate here.
> 
> >  allow initrc_t device_t:lnk_file { create };
> >  for a symlink to be created between /proc/self/fd and /dev/fd
> > 
> >  i realise it would be better to move stuff in /etc/init.d/udev
> >  to a separate program, e.g. /sbin/udev-init, and to have that
> >  program be given a separate domain instead of having to add
> >  this to initrc_t.
> 
> I already see an 'allow initrc_t device_t:lnk_file { unlink };' rule in
> initrc.te related to udev operation, so this isn't too surprising.
> 
> >  allow udev_t device_t:file { getattr unlink };
> >  for /sbin/udev to stat and remove /dev/null...
> 
> /dev/null should show up as chr_file, and should be created with
> null_device_t anyway.  Is this actually an attempt to unlink udev.tbl?

no, it's definitely an attempt to unlink /dev/null (!).

and it's definitely saying device_t:file.

_after_ init level 1 has completed, ls -Z /dev/null shows
null_device_t on /dev/null.

fuuunnn...

l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
