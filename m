Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i79CPjrT024038
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 08:25:46 -0400 (EDT)
Received: from smtp801.mail.ukl.yahoo.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with SMTP id i79CP9nn015887
	for <selinux@tycho.nsa.gov>; Mon, 9 Aug 2004 12:25:10 GMT
Date: Mon, 9 Aug 2004 13:36:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: SE-Linux <selinux@tycho.nsa.gov>,
   Linux Hotplug Dev List <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: udev
Message-ID: <20040809123653.GG3868@lkcl.net>
References: <20040808224737.GA3825@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040808224737.GA3825@lkcl.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

these additions make it hardly necessary to add anything stackingly
significant to the selinux policy files.

in particular, no special exceptions for /dev/* because it's already
device_t by default (fscontext=....default_t)

no special stuff like having to create a udevfs_t and then going
through the policy looking for ways to add support for it *whew*.

no need to add "allow .... tmpfs_t or shmfs_t ... " stuff.

i _have_ had to add a few bits and pieces to allow init_t and initrc_t
access to /dev prior to /etc/init.d/udev starting.

i wish i knew if it was okay to swap the order of /etc/init.d/modutils
and /etc/init.d/udev.

l.

On Sun, Aug 08, 2004 at 11:47:37PM +0100, Luke Kenneth Casson Leighton wrote:

> okay, combination of patches and mods.
> 
> 1) xattr one which is  up on http://hands.com/~lkcl/selinux/2.6.6
> 
> 2) remove stuff which tells mount 'fscontext=' option to bog off
>    if it supports xattrs.
> 
>    don't know if this patch is needed, don't care either. 
>    ItWorksForMe(tm) hey for all i know i missed out an option
>    which makes it unnecessary to stop fscontext=....device_t
>    from working.
> 
> 3) make mount take option fscontext=....device_t   .... /dev
> 
> 4) patch /etc/init.d/udev _and_ /etc/init.d/modutils to call a
>    little program /sbin/restoredevicefiles.
> 
>    the horrible hack to make extra nodes in /dev needs to have
>    a restorecon done on each node so created: quickest way is
>    to do them all at once.
> 
> 5) restoredevicefiles greps everything in /dev hey i just noticed
>    it only does /dev/* not /dev/*/* oh well.
> 
>    i also had to copy /usr/bin/cut to /bin/cut hey there's probably
>    a way to do it with sed or something.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
