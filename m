Subject: Re: problem about boot
From: Eamon Walsh <ewalsh@epoch.ncsc.mil>
To: lky <lky77@sjtu.edu.cn>
Cc: SELINUX <SELinux@tycho.nsa.gov>
In-Reply-To: <006c01c398a0$5f436ef0$5d38a8c0@lky>
References: <006c01c398a0$5f436ef0$5d38a8c0@lky>
Content-Type: text/plain
Message-Id: <1066929761.22348.17.camel@moss-tarheels.epoch.ncsc.mil>
Mime-Version: 1.0
Date: 23 Oct 2003 13:22:41 -0400
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Your kernel must be configured with built-in ext3 support if your root
partition is ext3.

--Eamon

On Wed, 2003-10-22 at 09:28, lky wrote:
> Hi,I installed 2.6-based SELinux (linux-2.6-2003100110.tgz) on
> Redhat9.0.But when I reboot with the initrd I got the kernel panic,as
> below:
> ------------------------------------------------------------------------------------------
> Mounting /proc filesystem
> Creating block devices
> Creating root device
> Mounting root filesystem
> mount: error 19 mounting ext3
> pivotroot: pivot_root (/sysroot, /sysroot/initrd) failed : 2
> umount /initrd/proc failed : 2
> Freeing unused kernel memory : 232k freed
> kernel panic : No init found . Try passing init = option to kernel
> ------------------------------------------------------------------------------
> The policy has been loaded before this. And I got the same result if I
> reboot the kernel with it's own initrd. So I think the initrd isn't
> the reason. Have I wrongly configured the kernel?
> Thanks!
-- 
Eamon Walsh <ewalsh@epoch.ncsc.mil>


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
