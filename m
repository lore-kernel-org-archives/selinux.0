Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79IvdrT027496
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 14:57:39 -0400 (EDT)
Received: from smtp807.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i79IvbIn005004
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 18:57:38 GMT
Date: Mon, 9 Aug 2004 20:09:01 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
Message-ID: <20040809190901.GM3868@lkcl.net>
References: <20040809175246.GK3868@lkcl.net> <1092077016.29199.166.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1092077016.29199.166.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, Aug 09, 2004 at 02:43:36PM -0400, Stephen Smalley wrote:
> On Mon, 2004-08-09 at 13:52, Luke Kenneth Casson Leighton wrote:
> > i'm getting an awful lot of the above due to udev creating
> > inodes in /dev which i decided to associate with device_t.
> 
> allow device_type device_t:filesystem associate;
> should cover most cases.
 
 thank you: i found this: i was more concerned that i should
 be setting mount -o fscontext=....fs_t instead?


> > now i have had to add about 15 or 20 lines so far each for pretty
> > much every xxx_device_t under the sun, and am concerned that i
> > am taking the wrong approach.
> 
> Other than the associate permission, what else do you need to add?
 
 eek.

 allow initrc_t device_t:lnk_file { create };
 for a symlink to be created between /proc/self/fd and /dev/fd

 i realise it would be better to move stuff in /etc/init.d/udev
 to a separate program, e.g. /sbin/udev-init, and to have that
 program be given a separate domain instead of having to add
 this to initrc_t.


 allow udev_t device_t:file { getattr unlink };
 for /sbin/udev to stat and remove /dev/null...

 exactly what is going on here i don't know.


 allow udev_t self:process { setfscreate };
 surprise surprise, it's doing the same thing as restorecon,
 so, duh, udev needs this.

 more later.

 l.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
