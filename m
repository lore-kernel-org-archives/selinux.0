Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i6THGwrT020643
	for <selinux@tycho.nsa.gov>; Thu, 29 Jul 2004 13:16:58 -0400 (EDT)
Date: Thu, 29 Jul 2004 13:06:15 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
cc: Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
   Joshua Brindle <method@gentoo.org>, SE-Linux <selinux@tycho.nsa.gov>
Subject: Re: temporary hack to use udev in selinux
In-Reply-To: <1091120226.21971.110.camel@moss-spartans.epoch.ncsc.mil>
Message-ID: <Xine.LNX.4.44.0407291305360.16390-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Thu, 29 Jul 2004, Stephen Smalley wrote:

> SELinux determines filesystem labeling behavior (policy/fs_use) based on
> filesystem type, and shmem subsystem happens to use an instance of the
> tmpfs filesystem type.  James Morris introduced a new mount option
> (context=) a while back to allow assigning a single security context to
> all inodes in a particular mount; I suppose that this could be
> generalized to allow you to specify the labeling behavior itself on a
> per-mount basis.

This could be done by simply allowing context= to override any other 
behavior, right?


- James
-- 
James Morris
<jmorris@redhat.com>



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
