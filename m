Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6TDgBrT018629
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 09:42:12 -0400 (EDT)
Received: from smtp807.mail.ukl.yahoo.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie.ncsc.mil (8.12.10/8.12.10) with SMTP id i6TDgACb005113
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:42:11 GMT
Date: Thu, 29 Jul 2004 14:53:12 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>,
   James Morris <jmorris@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: temporary hack to use udev in selinux
Message-ID: <20040729135312.GA8858@lkcl.net>
References: <20040728232043.GF18711@lkcl.net> <410844F9.3010203@gentoo.org> <1091105008.21971.17.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1091105008.21971.17.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, Jul 29, 2004 at 08:43:28AM -0400, Stephen Smalley wrote:

> > that should patch cleanly into 2.6.7, but I'd like to note that at this 
> > point udev is braindead wrt SELinux.
> > Once upon a time udev had selinux support integrated so that setfscreate 
> > was called to set the context of the devices being written however it 
> > was changed at some point to make SELinux an after device creation addon 
> > script which makes it label the devices after they are created. Because 
> > of this Hardened Gentoo has decided not to support udev at this time.
> 
> I haven't tried udev myself, but I think Dan has used it successfully
> with SELinux.  

 also i've successfully got it to work under Debian (unstable) with
 my lovely 2.6.6-selinux1 kernel.

 i had to modify the file_contexts/types.fc file to that
 /.?u?dev/.... on every line because without that, if you
 run make relabel, it destroys all the permissions in the
 "old" /dev (which are remapped to /.dev when udev has control
 of /dev) and consequently you can't boot the machine [the "old"
 /dev is used on boot, of course, prior to udev being run].


 i don't know what dan has done, nor what fedora does, whether
 they use /udev for what debian uses /.dev for.

 looking at /etc/init.d/udev, it's probably something debian-specific,
 to be honest.

 also, something to watch out for: the /etc/init.d/udev from debian
 (0.030 this is) creates some directories and some symlinks and
 a couple of nodes (listed in /etc/udev/links.conf).

 /dev/pts and /dev/shm are both created.

 now, i don't know what happens, or what's supposed to happen, but
 i don't see a lot of restorecon action going onto those "horrible
 hack" locations.

 but hey, it seems to work.

> I'd agree that having udev directly call matchpathcon()
> and then setfscreatecon() prior to node creation would be preferable,
> but I'm not sure that it is strictly necessary - as long as the default
> creation type is suitably restrictive and nothing tries to access it
> prior to the restorecon.
 
 :)

 well, the design of udev is such that it's totally full of race
 conditions, and access between the creation and the restorecon
 is going to be the _least_ of a user's worries.

 i don't know what the default is.


 so, when that matchpathcon() and setfscreatecon() is called,
 does it:
 
 a ) guarantee that the device node "to be created" will be set with
     the correct se/linux permissions

 b ) update the selinux permissions post-creation.

 l.


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
