Message-ID: <72222DC86846D411ABD300A0C9EB08A101524408@csoc-mail-box.csoconline.com>
From: "Westerman, Mark" <Mark.Westerman@csoconline.com>
To: "'rwashington@crucialsecurity.com'" <rwashington@crucialsecurity.com>,
        SELinux <SELinux@tycho.nsa.gov>
Subject: RE: Kernel panic: VFS: Unable to mount root fs
Date: Fri, 6 Sep 2002 14:40:01 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Did you orginal install use an initrd disk ?

If so you will need to create an initrd disk
with the policy build into it.

Mark

> -----Original Message-----
> From: Ryan Washington [mailto:rwashington@crucialsecurity.com]
> Sent: Friday, September 06, 2002 12:26 PM
> To: SELinux
> Subject: Kernel panic: VFS: Unable to mount root fs
> 
> 
> 
> 
> hey,
> i'm pretty new at this, but i can not get selinux 2.4 to load 
> on a fresh
> install of redhat 7.3. are there any special configs that need to be
> done(since the README file is for 7.1 and 7.2)
> 
> i keep getting this error:
> 
> VFS: Cannot open root device "sda2" or 08:02
> Please append a correct "root= " boot option
> Kernel panic: VFS: Unable to mount root fs on 08:02
> 
> has anyone seen this before? i've tried adding "mem=96M" 
> after the boot
> option, but still hangs at this error.
> any help would be greatly appreciated.
> 
> thanks,
> ryan
> 
> --
> This message was distributed to subscribers of the selinux 
> mailing list.
> If you no longer wish to subscribe, send mail to 
> majordomo@tycho.nsa.gov with
> the words "unsubscribe selinux" without quotes as the message.
> 

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
