Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8DNHXrT006790
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 19:17:33 -0400 (EDT)
Received: from open.hands.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with ESMTP id i8DNHVSW003169
	for <selinux@tycho.nsa.gov>; Mon, 13 Sep 2004 23:17:32 GMT
Date: Tue, 14 Sep 2004 00:28:41 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: James Carter <jwcart2@epoch.ncsc.mil>
Cc: Colin Walters <walters@redhat.com>, SELinux <selinux@tycho.nsa.gov>,
   Daniel J Walsh <dwalsh@redhat.com>, rcoker@redhat.com
Subject: Re: [patch] don't relabel sub-subdirectories of /mnt, /media by default
Message-ID: <20040913232841.GB30524@lkcl.net>
References: <1094828936.7061.20.camel@nexus.verbum.private> <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1095106896.2161.21.camel@moss-lions.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov


> On Fri, 2004-09-10 at 11:08, Colin Walters wrote:

> > One thing that might be nice is to have a "removable_context" config
> > file.  Then we modify HAL to automatically mount removable media with -o
> > context=$(cat $SELINUXROOT/contexts/removable_context).  (Really getting
> > the context via libselinux of course).  People who want to override that
> > behavior can simply add the device manually to fstab, that will cause
> > HAL not to create a new entry.

 GREAT idea, because i am having the same difficulty with
 usbmount + autofs.

 yes, this is essential.

 colin, what do you propose _be_ in the removable_context because i
 guessed about putting {username}:object_r:home_dir_t in there, where
 {username} is determined by who owns /dev/console or simply by
 an over-ride in /etc/usb-mount.conf.

 obviously, if it's say a usb hard drive  that has ext2 /
 ext3 partitions on it.... something that is likely to become
 increasingly common with the introduction of SATA ... my hacked-up
 idea ain't gonna cut it.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
