From: Richard Herbert Wanner <richard.wanner@cgi.com>
To: "lky" <lky77@sjtu.edu.cn>
Cc: "SELINUX" <SELinux@tycho.nsa.gov>
Message-ID: <376013375d87.375d87376013@wshs>
Date: Thu, 23 Oct 2003 12:26:06 -0400
MIME-Version: 1.0
Subject: Re: problem about boot
Content-Type: text/plain; charset=us-ascii
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Just a guess... but did you remember to change the root=LABEL=/ entry 
in your bootloader file to root=/dev/hda2 (or whatever the root is on 
your system).

Rick

----- Original Message -----
From: "lky" <lky77@sjtu.edu.cn>
Date: Wednesday, October 22, 2003 9:28 am
Subject: problem about boot

> Hi,I installed 2.6-based SELinux (linux-2.6-2003100110.tgz) on 
> Redhat9.0.But when I reboot with the initrd I got the kernel 
> panic,as below:
> -------------------------------------------------------------------
> -----------------------
> Mounting /proc filesystem
> Creating block devices
> Creating root device
> Mounting root filesystem
> mount: error 19 mounting ext3
> pivotroot: pivot_root (/sysroot, /sysroot/initrd) failed : 2
> umount /initrd/proc failed : 2
> Freeing unused kernel memory : 232k freed
> kernel panic : No init found . Try passing init = option to kernel
> -------------------------------------------------------------------
> -----------
> The policy has been loaded before this. And I got the same result 
> if I reboot the kernel with it's own initrd. So I think the initrd 
> isn't the reason. Have I wrongly configured the kernel?
> Thanks!
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
