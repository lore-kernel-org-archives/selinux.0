Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79JO0rT027818
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 15:24:00 -0400 (EDT)
Received: from smtp811.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i79JNNnn016918
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 19:23:23 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp811.mail.ukl.yahoo.com with SMTP; 9 Aug 2004 19:23:59 -0000
Date: Mon, 9 Aug 2004 20:35:21 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: lots of allow xxx_device_t device_t:filesystem { associate }
Message-ID: <20040809193521.GN3868@lkcl.net>
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
> 
> > now i have had to add about 15 or 20 lines so far each for pretty
> > much every xxx_device_t under the sun, and am concerned that i
> > am taking the wrong approach.
> 
> Other than the associate permission, what else do you need to add?

 okay, i'm attaching my horrible_hacks.te file...

# this is to deal with restorecon devices being associated with udev's
# mounting of /dev as a fscontext=device_t.  help, help, gloop!

allow console_device_t device_t:filesystem { associate };
allow devtty_t device_t:filesystem { associate };
allow fixed_disk_device_t device_t:filesystem { associate };
allow memory_device_t device_t:filesystem { associate };
allow mouse_device_t device_t:filesystem { associate };
allow null_device_t device_t:filesystem { associate };
allow ptmx_t device_t:filesystem { associate };
allow random_device_t device_t:filesystem { associate };
allow sound_device_t device_t:filesystem { associate };
allow tty_device_t device_t:filesystem { associate };
allow urandom_device_t device_t:filesystem { associate };
allow zero_device_t device_t:filesystem { associate };
allow device_t device_t:filesystem { associate };
allow initctl_t device_t:filesystem { associate };
allow udev_tbl_t device_t:filesystem { associate };
allow event_device_t device_t:filesystem { associate };

# this is to allow /etc/init.d/udev to do its horrible hacks
# if it wasn't done in /etc/init.d or it wasn't device_t under which
# /dev was mounted (mount ... -o fscontext=....device_t) then this
# would be different or not there:

allow initrc_t device_t:dir { create setattr };
	#EXE=/bin/mkdir  NAME=pts   :  create
	#EXE=/bin/touch  NAME=/   :  setattr

allow initrc_t device_t:lnk_file { create };
	#EXE=/bin/ln  NAME=fd   :  create

allow initrc_t device_t:blk_file { getattr };
	#EXE=/bin/ls  PATH=/dev/ram0   :  getattr

allow initrc_t device_t:chr_file { getattr read write };
	#EXE=/bin/bash  NAME=tty   :  read write
	#EXE=/bin/ls  PATH=/dev/ptmx   :  getattr

# not sure about this one

allow initrc_t fixed_disk_device_t:blk_file { getattr };
	#EXE=/bin/bash  PATH=/dev/ram0   :  getattr


allow init_t device_t:fifo_file { getattr read write };
	#EXE=/sbin/init  PATH=/dev/initctl   :  getattr
	#EXE=/sbin/init  NAME=initctl   :  read write

#
# plus the allow udev ones...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
