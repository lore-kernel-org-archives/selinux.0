Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TK2LrT022058
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 16:02:21 -0400 (EDT)
Received: from smtp814.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TK2JCb019963
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 20:02:19 GMT
Received: from unknown (HELO hyd) (selinux@tycho.nsa.gov@81.152.10.162 with poptime)
  by smtp814.mail.ukl.yahoo.com with SMTP; 29 Jul 2004 20:02:19 -0000
Date: Thu, 29 Jul 2004 21:13:25 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Erich Schubert <erich@debian.org>
Cc: SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: udev and .dev...
Message-ID: <20040729201325.GG9950@lkcl.net>
References: <20040729091423.GC6443@lkcl.net> <20040729150921.GA17881@legolas.drinsama.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040729150921.GA17881@legolas.drinsama.de>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 05:09:21PM +0200, Erich Schubert wrote:
> > soooo... to fix that [rather than a patch, a sed command]:
> > 	:%s/u?dev/.?u?dev/g
> 
> Note that . has a special meaning in regular expressions.
> You should quote it, but you're approaching quoting hell right now with
> your sed expression... ;-)
 
 *sigh*.

 okay how about %s/u?dev/[.u]dev/g - is that right?

 [\.u] means one character either dot (a real dot) or a u neh?

 *struggling*.

> Also at least for some time udev used /etc/udev/.dev
> but i think this has been made deprecated by now.
> 
> > this will allow setfiles to set up the security contexts on
> > the /.dev which is the _real_ filesystem /dev stuff which will
> > allow things like, oh, init (!!) to access the hard drive.
> 
> Are you sure? 

 yes, because with it, init works, without it, it don't!


> i'd guess that using /dev is hardwired into init.

 don't know... oh, yes, i know: no it isn't [hardwired]: the
 job of the scripts [in debian initrd, written by herbert]
 is to detect it, or to pass the root=/something/something
 option from the kernel boot.


> FYI: i see
> /dev on /.dev type none (rw,bind)
> 
> but /proc/mounts shows
> 
> /dev/root /.dev ext3 rw,noatime 0 0
> none /dev tmpfs rw 0 0
> 
> So i think that /dev is moved via a bind mount to /.dev (kind of
> emergency device nodes) and /dev is then replaced by a ramdisk which is
> maintained by udev.

 yes: quoting this section of /etc/init.d/udev....

	# /.dev is used by /sbin/MAKEDEV to access the real /dev directory.
	# if you don't like it just remove it.
	[ -d /.dev ] && mount --bind /dev /.dev

	echo -n "Mounting a tmpfs over /dev..."
	mount -n -o size=$tmpfs_size,mode=0755 -t tmpfs none /dev
	echo "done."
	}


> This sounds like relabling hell :-) "make relabel" might even skip /.dev
> because it doesn't know the file system.
> You can't use "make relabel" to persistently fix labels on /dev.

 no, but if the /.dev ISN'T there, then you will find that the first
 time you run make relabel, subsequently you cannot boot.


> I don't know enough about automatic labelling by selinux. Maybe you'll
> need a udev which reads the file_contexts file. :-(
> (or a similar specification file)
>
 
 that would be very nice.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
