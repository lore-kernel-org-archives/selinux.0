Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5MIrCXW025733
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 14:53:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 2CB2779D88
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 11:53:03 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 2WRxoOw5jYJ4 for <selinux@tycho.nsa.gov>;
 Wed, 22 Jun 2016 11:53:02 -0700 (PDT)
Received: from [192.168.0.97] (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id E0F6478F93
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 11:53:02 -0700 (PDT)
Subject: Re: abnormal SELinux context labels
To: selinux@tycho.nsa.gov
References: <05514320-f873-9b48-455e-e6c7caff4135@jlbond.com>
 <784644655.1539073.1466619738930.JavaMail.zimbra@redhat.com>
 <1968089528.1541622.1466620243439.JavaMail.zimbra@redhat.com>
 <3ed516eb-a51a-e044-88c8-95555d247a37@jlbond.com>
From: Bond Masuda <bond.masuda@jlbond.com>
Message-ID: <87792a97-e1ef-4dbf-0d74-ef61cd28f591@jlbond.com>
Date: Wed, 22 Jun 2016 11:53:02 -0700
MIME-Version: 1.0
In-Reply-To: <3ed516eb-a51a-e044-88c8-95555d247a37@jlbond.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

To add some more info, I did a search for SELinux labels that include 
"/" and found some more mislabels:

# find . -context \*/\*
./etc/systemd/system
./usr/lib64
./usr/local/lib64
./run/lock

# ls -lZd ./etc/systemd/system ./usr/lib64 ./usr/local/lib64/ ./run/lock
drwxr-xr-x.  9 root root /usr/lib/systemd/system  4096 Jun 21 16:10 
./etc/systemd/system
drwxr-xr-x.  5 root root /var/lock                  46 Jun 21 16:08 
./run/lock
dr-xr-xr-x. 47 root root /usr/lib                32768 Jun 21 16:09 
./usr/lib64
drwxr-xr-x.  2 root root /usr/lib                    6 Aug 12  2015 
./usr/local/lib64/

strange...

On 06/22/2016 11:35 AM, Bond Masuda wrote:
>
>
> On 06/22/2016 11:30 AM, Simon Sekidde wrote:
>>
>> ----- Original Message -----
>>> From: "Simon Sekidde" <ssekidde@redhat.com>
>>> To: "Bond Masuda" <bond.masuda@jlbond.com>
>>> Cc: selinux@tycho.nsa.gov
>>> Sent: Wednesday, June 22, 2016 2:22:18 PM
>>> Subject: Re: abnormal SELinux context labels
>>>
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Bond Masuda" <bond.masuda@jlbond.com>
>>>> To: selinux@tycho.nsa.gov
>>>> Sent: Wednesday, June 22, 2016 2:05:17 PM
>>>> Subject: abnormal SELinux context labels
>>>>
>>>> I'm installing CentOS 7 in a chroot'd environment to build new 
>>>> images of
>>>> CentOS 7 for a private cloud environment. I've done this successfully
>>>> before
>>>> with CentOS 6 (with help from this list) and we have an automated 
>>>> process
>>>> of
>>>> doing that now. I'm now porting our process to do similarly for 
>>>> CentOS 7.
>>>> However, after our process is complete, certain 
>>>> directories/symlinks have
>>>> abnormal SELinux contexts assigned to them. This causes the system 
>>>> to fail
>>>> to boot since we have SELinux enforcing by default and one of the
>>>> problematic symlinks is /lib64.
>>>>
>>>> Here is what we see in the CentOS 7 build tree root directory, 
>>>> right after
>>>> a
>>>> fresh install of CentOS 7 from the full updates repo:
>>>>
>>>> # ls -alZ /
>>>> dr-xr-xr-x. root root system_u:object_r:root_t:s0 .
>>>> dr-xr-xr-x. root root system_u:object_r:root_t:s0 ..
>>>> drwxr-xr-x. root root system_u:object_r:auditd_log_t:s0 audit
>>>> lrwxrwxrwx. root root system_u:object_r:bin_t:s0 bin -> usr/bin
>>>> dr-xr-xr-x. root root system_u:object_r:boot_t:s0 boot
>>>> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 dev
>>>> drwxr-xr-x. root root system_u:object_r:etc_t:s0 etc
>>>> drwxr-xr-x. root root system_u:object_r:home_root_t:s0 home
>>>> lrwxrwxrwx. root root /usr/lib lib -> usr/lib
>>>> lrwxrwxrwx. root root /usr/lib lib64 -> usr/lib64
>>>> drwxr-xr-x. root root system_u:object_r:mnt_t:s0 media
>>>> drwxr-xr-x. root root system_u:object_r:mnt_t:s0 mnt
>>>> drwxr-xr-x. root root system_u:object_r:usr_t:s0 opt
>>>> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 proc
>>>> dr-xr-x---. root root system_u:object_r:admin_home_t:s0 root
>>>> drwxr-xr-x. root root /var/run run
>>>> lrwxrwxrwx. root root system_u:object_r:bin_t:s0 sbin -> usr/sbin
>>>> drwxr-xr-x. root root system_u:object_r:var_t:s0 srv
>>>> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 sys
>>>> drwxrwxrwt. root root system_u:object_r:tmp_t:s0 tmp
>>>> drwxr-xr-x. root root system_u:object_r:usr_t:s0 usr
>>>> drwxr-xr-x. root root system_u:object_r:var_t:s0 var
>>>>
>>>> As you can see, the SELinux context for "lib", is "/usr/lib"!!! and
>>>> similarly, for "lib64", it is "/usr/lib" ... those are not even valid
>>>> context labels!
>>>>
>> Taking a closer look, is Is /usr on a separate partition?
> No, /usr is not on separate partition. Here's the partition scheme:
>
> /dev/mapper/vg_system-lv_root -> /
> /dev/mapper/loop0p1 -> /boot
> /dev/mapper/vg_system-lv_audit -> /audit
> /dev/mapper/vg_system-lv_home -> /home
> /dev/mapper/vg_system-lv_tmp -> /tmp
> /dev/mapper/vg_system-lv_var -> /var
> /dev/mapper/vg_system-lv_var_log -> /var/log
>
> This is a disk image mounted via loopback, and we use LVM2. Thanks for 
> looking at it again...
>
>>>> How can an invalid string like "/usr/lib" even be assigned as a 
>>>> SELinux
>>>> label
>>>> in the first place?
>>>>
>>> Its not the SELinux label but a symbolic link
>>>
>>> /lib is a symbolic link to /usr/lib
>>> /lib64 is a symbolic link to /usr/lib64
>>>
>>> And both of which have the same type 'lib_t'
>>>
>>> $ matchpathcon /lib /lib64
>>>
>>>> I can workaround this with a manual fix using 'chcon
>>>> system_u:object_r:type_label:s0 path', but I'm just wondering how 
>>>> this can
>>>> happen in the first place? When I try to manually reproduce the 
>>>> invalid
>>>> label, I get this:
>>>>
>>>> # chcon /usr/lib lib
>>>> chcon: invalid context: /usr/lib
>>>>
>>>> Any insights would be appreciated...
>>>> Bond
>>>>
>>>>
>>>> _______________________________________________
>>>> Selinux mailing list
>>>> Selinux@tycho.nsa.gov
>>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>>> To get help, send an email containing "help" to
>>>> Selinux-request@tycho.nsa.gov.
>>> -- 
>>> Simon Sekidde * Red Hat, Inc. * Westford, MA
>>> gpg: 5848 958E 73BA 04D3 7C06 F096 1BA1 2DBF 94BC 377E
>>>
>>> _______________________________________________
>>> Selinux mailing list
>>> Selinux@tycho.nsa.gov
>>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>>> To get help, send an email containing "help" to
>>> Selinux-request@tycho.nsa.gov.
>>>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to 
> Selinux-request@tycho.nsa.gov.
