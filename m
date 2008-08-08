Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m78HJW4k016806
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 13:19:32 -0400
Received: from cdptpa-omtalb.mail.rr.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with ESMTP id m78HJNvJ022574
	for <selinux@tycho.nsa.gov>; Fri, 8 Aug 2008 17:19:23 GMT
Message-ID: <489C801E.9040306@kutulu.org>
Date: Fri, 08 Aug 2008 13:19:26 -0400
From: Mike Edenfield <kutulu@kutulu.org>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: SELinux Mailing List <selinux@tycho.nsa.gov>
Subject: Re: Help: SELinux causing(?) boot failures...
References: <489C6A4F.3020704@kutulu.org> <200808081251.45453.paul.moore@hp.com>
In-Reply-To: <200808081251.45453.paul.moore@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:
> On Friday 08 August 2008 11:46:23 am Mike Edenfield wrote:
>> The reason I strongly suspect SELinux is the problem (or at least a
>> major factor), is that adding "selinux=0" to my boot command line
>> corrects the problem, and the system boots fine.  Everything appears
>> to be installed and configured correctly, except obviously SELinux is
>> now disabled.  The filesystems are all labeled correctly, and even on
>> the failing boot the AVC messages display the correct labels, like
>> tty_device_t and urandom_device_t.
> 
> Hi Mike,
> 
> In general, you are better off using "enforcing=0", which keeps SELinux 
> enabled but puts it into permissive mode, on the kernel command line 
> instead of "selinux=0", which disables SELinux entirely.  Have you 
> tried rebooting with "enforcing=0" and capturing the AVC messages from 
> the console/audit/syslog output and seeing if anything looks awry?  If 
> not go ahead and do so and send them to the list, this will tell us 
> what actions are being denied and why.

I have SELinux configured for permissive mode to begin with, but I tried 
adding "enforcing=0" to the boot command line to no effect. Here are the 
denials I am getting:

(transcribed by hand since neither syslog nor auditd are starting)

avc: denied { execute_no_trans } for pid=1 comm="init" path="/sbin/init" 
dev=sda3 ino=920038 scontext=system_u:system_r:kernel_t 
tcontext=system_u:object_r:file_t tclass=file
avc: denied { read } for pid=1 comm="init" name="ld-linux.so.2" dev=sda3 
ino=1785880 scontext=system_u:system_r:kernel_t 
tcontext=system_u:object_r:file_t tclass=lnk_file
avc: denied { getattr } for pid=1 comm="init" path="/etc/ld.so.cache" 
dev=sda3 ino=1090186 scontext=system_u:system_r:kernel_t 
tcontext=system_t:object_r:file_t tclass=file
avc: denied { read } for pid=1 comm="init" name="udanrom" dev=sda3 
ino=126002 scontext=system_u:system_r:kernel_t 
tcontext=system_u:object_r:urandom_device_t tclass=chr_file
avc: denied { getattr } for pid=1 comm="init" name="/" dev=selinuxfs 
ino=1 scontext=system_u:system_r:kernel_t 
tcontext=system_t:object_r:security_t tclass=filesystem
avc: denied { read write } for pid=1 comm="init" name="tty0" dev=sda3 
ino=126327 scontext=system_u:system_r:kernel_t 
tcontext=system_u:object_r:tty_device_t tclass=chr_file


There are apparently a lot of the latter since I usually get a message 
that printk is supressing several dozen messages at this point, then I 
get no more AVC's on the console.


Thanks,

--Mike

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
