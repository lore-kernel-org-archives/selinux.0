Received: from jazzband.ncsc.mil (jazzband.ncsc.mil [144.51.5.4])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id hALEdpRb028825
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 09:39:51 -0500 (EST)
Received: from jazzband.ncsc.mil (localhost [127.0.0.1])
	by jazzband.ncsc.mil  with ESMTP id hALEdoqY015354
	for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 14:39:50 GMT
Received: from PETER.wheaton.edu (peter.wheaton.edu [192.138.89.55])
        by jazzband.ncsc.mil  with ESMTP id hALEdn0o015351 for <selinux@tycho.nsa.gov>; Fri, 21 Nov 2003 14:39:49 GMT
Date: Fri, 21 Nov 2003 08:39:44 -0600 (CST)
From: John Hayward <John.C.Hayward@wheaton.edu>
To: "Achanta, Venkata Phani" <ZVPA2@imail.etsu.edu>
cc: russell@coker.com.au, selinux <selinux@tycho.nsa.gov>
Subject: Re: Kernel panic: No init found with SE patched kernel 2.6.0-test6
In-Reply-To: <200311202137.AA25034968@imail.etsu.edu>
Message-ID: <Pine.NEB.4.21.0311210816260.3692-100000@ar1203.wheaton.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Hi,
   I have had similar trouble.

   It seems the best current approach to get up on selinux is to install
Fedora and use:

ftp://people.redhat.com/dwalsh/SELinux/selUpgrade

to install a new kernel (2.6.0-test9) along with the SELinux packages.

   Using the NSA's pages I found the following problems with redhat 9:
1) The README documentation in the patched kernel download is out of date
   and does not document how the kernel needs to be configirured.
2) The documentation contained in the SE userland does contain some of 
   the required kernel configuation information.
3) When building an installing the configured kernel while I was able to 
   bring up the system - however SELinux was not enabled because for some
   reason the registration of the security package seems to be done twice
   and the failure of the second attempt causes SELinux to not be
   enabled.  It might be an issue with modules not being enabled.

   In your case it appears that you need to configure the kernel to use
ex3 - check the userland documentation on other kernel options you need.
I'm kind of poking at the kernel to find out why there seems to be two 
registration of security modules being attempted.

johnh...
On Thu, 20 Nov 2003, Achanta, Venkata Phani wrote:

>Date: Thu, 20 Nov 2003 21:37:48 -0500
>From: "Achanta, Venkata Phani" <ZVPA2@imail.etsu.edu>
>To: russell@coker.com.au
>Cc: selinux <selinux@tycho.nsa.gov>
>Subject: Kernel panic: No init found with SE patched kernel 2.6.0-test6
>
>hi everybody,
>
>I have applied SELinux patch against kernel 2.6.0-test6 and i get the following error when i boot the new kernel.
>
>VFS:Mounted root(ext2 filesystem)
>Red hat nash version 3.4.42 starting 
>Mounting /proc filesystem
>creating block devices
>creating root device
>Mounting root file system 
>mount: error 19 mounting ext3
>pivotroot: pivot_root(/sysroot,/sysroot/initrd) failed:2
>umount /initrd/proc failed:2
>Freeing unused kernel memory:228k freed
>kernel panic:No init found.Try passing init= option to kernel
>
>Any help will be appriciated.Is this a issue with ext3 fs support?
>
>Thanks in Advance,
>
>Venkata Phani Achanta
>Graduate Student
>Dept of Computer Science
>East Tennessee state university
>USA
> 
>
>
>
> 
>                   
>
>--
>This message was distributed to subscribers of the selinux mailing list.
>If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>the words "unsubscribe selinux" without quotes as the message.
>

johnh...


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
