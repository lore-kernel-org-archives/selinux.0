From: ljf@semandex.net
Content-Type: text/plain; charset=iso-8859-1
MIME-Version: 1.0
To: rwashington@crucialsecurity.com
Cc: SELinux@tycho.nsa.gov
Subject: Re: Kernel panic: VFS: Unable to mount root fs
Date: Fri, 06 Sep 2002 12:42:11 -0700 (PDT)
Message-Id: <20020906124213.19641.h022.c001.wm@mail.semandex.net.criticalpath.net>
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

I got this the first time I tried RH7.3 I think you may find that you did not enable the EXT3 filing system support when
you configured LSM.  Your config file should contain:

CONFIG_EXT3_FS=y

This is set from the Configuration Menu when you start the LSM make.

I can send you my exceedingly minimal config file it you want it.

Leslie

"Ryan Washington" wrote:

> 
> 
> 
> hey,
> i'm pretty new at this, but i can not get selinux 2.4 to load on a fresh
> install of redhat 7.3. are there any special configs that need to be
> done(since the README file is for 7.1 and 7.2)
> 
> i keep getting this error:
> 
> VFS: Cannot open root device &quot;sda2&quot; or 08:02
> Please append a correct &quot;root= &quot; boot option
> Kernel panic: VFS: Unable to mount root fs on 08:02
> 
> has anyone seen this before? i've tried adding &quot;mem=96M&quot; after the boot
> option, but still hangs at this error.
> any help would be greatly appreciated.
> 
> thanks,
> ryan
> 
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
> the words &quot;unsubscribe selinux&quot; without quotes as the message.

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
