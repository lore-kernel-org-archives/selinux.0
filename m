Subject: Re: Overlay Filesystem and SELinux
From: Jaspreet Singh <jsingh@ensim.com>
Reply-To: jsingh@ensim.com
To: Erich Schubert <erich@debian.org>
Cc: nsa <SELinux@tycho.nsa.gov>
In-Reply-To: <1104022405.29054.7.camel@wintermute.xmldesign.de>
References: <1098274225.12118.20.camel@jsingh.india.ensim.com>
	 <20041020151031.GB21185@lkcl.net>  <20041020174938.GL21185@lkcl.net>
	 <1098887565.1620.15.camel@jsingh.india.ensim.com>
	 <1104022405.29054.7.camel@wintermute.xmldesign.de>
Content-Type: text/plain
Date: Sun, 26 Dec 2004 14:11:00 +0530
Message-Id: <1104050461.14672.6.camel@jsingh>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,

I was initially involved in creating a unionfs (of BSD) for Linux. This
project was called "mini_fo". Search google for results.


That project is now .. not maintained .. and now I am involved in a much
more sophisticated implementation called - "unionfs" . Check this link -
www.fsl.cs.sunysb.edu/project-unionfs.html

Unionfs was initially only for 2.4 kernel, but i recently ported it to
2.6. The port is not official yet. But, its working.

> I'd love to use your overlay-fs when I needed to setup some virtual
> boxes. This is a great tool for virtualization. You can use this to
> manage a group of virtual hosts more easily (for example installing new
> software on them or upgrading existing)
> Do you also have some "hiding" features? With your concept right now,
> none of the overlayed files can be deleted. Or do you have a way of
> signalling that?
> 

Yups, it has all BSD unionfs/union-mount features. My 2.6 port is not
selinux compatible yet .. but would be in some time.


> How do you create the whole path? just by doing a number of mkdirs? IMHO
> you should copy the xattr attributes from the overlayed directories
> here. As long as you are inside the kernel, doing so shouldn't be too
> hard.
> 

nope .. just union mount some already mounted directories(called
branches) on a mount point and then any lookups/writes on mount-points
would follow COW semantics. And changes would be written to the topmost
RW branch. 

Howz it.

Greetings and Mary Christmas,
Jaspreet
-- 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
