Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id h8AHxHLa010668
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 13:59:18 -0400 (EDT)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id h8AHxFn0018235
	for <selinux@tycho.nsa.gov>; Wed, 10 Sep 2003 17:59:16 GMT
Date: Wed, 10 Sep 2003 18:59:14 +0100
From: Dale Amon <amon@vnl.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Dale Amon <amon@vnl.com>, SELinux Mail List <selinux@tycho.nsa.gov>
Subject: Re: rfs xattr's, mkinitrd and other stories
Message-ID: <20030910175914.GP5397@vnl.com>
References: <20030910164854.GO5397@vnl.com> <1063213343.14458.35.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1063213343.14458.35.camel@moss-spartans.epoch.ncsc.mil>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Wed, Sep 10, 2003 at 01:02:23PM -0400, Stephen Smalley wrote:
> devfs will require a patch to support labeling, and appears to be
> obsolete in 2.6.

How so? It's still marked experimental in fact. devpts has been
made independant but I can't imagine why devfs would ever be
removed. If anything it is superseding the old static /dev.

As to the patch, I'm not sure what is needed there. I do know
I have an /etc/devfsd/conf.d/selinux that is used at boot time.
I've had some problems with it and disabled that temporarily to
avoid the /lib/devfsd/devfs-se.so error messages at boot time.

So what next? Try to get Richard Gooch's attention? 
 
> The mkinitrd script needs to copy the policy file and load_policy
> program onto the initrd, and the /linuxrc script that is placed on the
> initrd needs to mount selinuxfs and run load_policy before the root
> filesystem is mounted.

I'm still worried about what happens after the next apt-get or dselect
If it restores the standard mkinitrd during an upgrade and I don't
notice before rebooting... could be nasty.

I supposed I could make it /usr/local/sbin/mkinitrd if the path 
search order during early boot up happens to include that before
/usr/sbin.

That's why I'm wondering what Colin or Russ' thoughts are on the
matter.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
