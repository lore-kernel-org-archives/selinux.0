Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79J3xrT027571
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 15:04:00 -0400 (EDT)
Received: from epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id i79J3Nnn015380
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 19:03:23 GMT
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
In-Reply-To: <20040809190901.GM3868@lkcl.net>
References: <20040809175246.GK3868@lkcl.net>
	 <1092077016.29199.166.camel@moss-spartans.epoch.ncsc.mil>
	 <20040809190901.GM3868@lkcl.net>
Content-Type: text/plain
Message-Id: <1092078176.29199.179.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Date: Mon, 09 Aug 2004 15:02:57 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2004-08-09 at 15:09, Luke Kenneth Casson Leighton wrote:
>  thank you: i found this: i was more concerned that i should
>  be setting mount -o fscontext=....fs_t instead?

No, I think device_t is appropriate here.

>  allow initrc_t device_t:lnk_file { create };
>  for a symlink to be created between /proc/self/fd and /dev/fd
> 
>  i realise it would be better to move stuff in /etc/init.d/udev
>  to a separate program, e.g. /sbin/udev-init, and to have that
>  program be given a separate domain instead of having to add
>  this to initrc_t.

I already see an 'allow initrc_t device_t:lnk_file { unlink };' rule in
initrc.te related to udev operation, so this isn't too surprising.

>  allow udev_t device_t:file { getattr unlink };
>  for /sbin/udev to stat and remove /dev/null...

/dev/null should show up as chr_file, and should be created with
null_device_t anyway.  Is this actually an attempt to unlink udev.tbl?

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
