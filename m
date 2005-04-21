Message-ID: <42679D6B.1050300@redhat.com>
Date: Thu, 21 Apr 2005 08:32:43 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: russell@coker.com.au
CC: Jim Carter <jwcart2@epoch.ncsc.mil>, SELinux <SELinux@tycho.nsa.gov>
Subject: Re: Latest diffs
References: <425ED759.7070800@redhat.com> <200504202317.46457.russell@coker.com.au>
In-Reply-To: <200504202317.46457.russell@coker.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:

>On Friday 15 April 2005 06:49, Daniel J Walsh <dwalsh@redhat.com> wrote:
>  
>
>>Some cleanups in strict to handle turning off unlimitedRC
>>    
>>
>
>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/initrc.te 
>policy-1.23.11/domains/program/initrc.te
>--- nsapolicy/domains/program/initrc.te 2005-03-24 08:58:25.000000000 -0500
>+++ policy-1.23.11/domains/program/initrc.te    2005-04-14 15:30:19.000000000 
>-0400
>@@ -12,7 +12,7 @@
> # initrc_exec_t is the type of the init program.
> #
> # do not use privmail for sendmail as it creates a type transition conflict
>-type initrc_t, ifdef(`unlimitedRC', `admin, etc_writer, fs_domain, privmem, 
>auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', 
>`', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, 
>nscd_client_domain;
>+type initrc_t, fs_domain, ifdef(`unlimitedRC', `admin, etc_writer, privmem, 
>auth_write, ') domain, privlog, privowner, privmodule, ifdef(`sendmail.te', 
>`', `privmail,') ifdef(`distro_debian', `etc_writer, ') sysctl_kernel_writer, 
>nscd_client_domain;
> 
> role system_r types initrc_t;
> uses_shlib(initrc_t);
>
>Note that the above is needed for the following command:
>echo "raidautorun /dev/md0" | nash --quiet
>
>Below are the relevant bits from the strace output:
>mknod("/dev/md0", S_IFBLK|0600, makedev(9, 0)) = 0
>open("/dev/md0", O_RDWR)                = 0
>ioctl(0, 0x914, 0)                      = 0
>
>  
>
>What does ioctl 0x914 do?  Is there a better way we can manage the device node 
>creation?  Can udev create it?
>  
>
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=155556

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
