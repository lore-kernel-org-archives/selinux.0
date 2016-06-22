Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u5MISmkX022764
 for <selinux@tycho.nsa.gov>; Wed, 22 Jun 2016 14:28:49 -0400
Subject: Re: abnormal SELinux context labels
To: Simon Sekidde <ssekidde@redhat.com>
References: <05514320-f873-9b48-455e-e6c7caff4135@jlbond.com>
 <784644655.1539073.1466619738930.JavaMail.zimbra@redhat.com>
Cc: selinux@tycho.nsa.gov
From: Bond Masuda <bond.masuda@jlbond.com>
Message-ID: <80f5e883-c7d9-74b9-985b-f32d293bdae4@jlbond.com>
Date: Wed, 22 Jun 2016 11:28:42 -0700
MIME-Version: 1.0
In-Reply-To: <784644655.1539073.1466619738930.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 06/22/2016 11:22 AM, Simon Sekidde wrote:
>
> ----- Original Message -----
>> From: "Bond Masuda" <bond.masuda@jlbond.com>
>> To: selinux@tycho.nsa.gov
>> Sent: Wednesday, June 22, 2016 2:05:17 PM
>> Subject: abnormal SELinux context labels
>>
>> I'm installing CentOS 7 in a chroot'd environment to build new images of
>> CentOS 7 for a private cloud environment. I've done this successfully before
>> with CentOS 6 (with help from this list) and we have an automated process of
>> doing that now. I'm now porting our process to do similarly for CentOS 7.
>> However, after our process is complete, certain directories/symlinks have
>> abnormal SELinux contexts assigned to them. This causes the system to fail
>> to boot since we have SELinux enforcing by default and one of the
>> problematic symlinks is /lib64.
>>
>> Here is what we see in the CentOS 7 build tree root directory, right after a
>> fresh install of CentOS 7 from the full updates repo:
>>
>> # ls -alZ /
>> dr-xr-xr-x. root root system_u:object_r:root_t:s0 .
>> dr-xr-xr-x. root root system_u:object_r:root_t:s0 ..
>> drwxr-xr-x. root root system_u:object_r:auditd_log_t:s0 audit
>> lrwxrwxrwx. root root system_u:object_r:bin_t:s0 bin -> usr/bin
>> dr-xr-xr-x. root root system_u:object_r:boot_t:s0 boot
>> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 dev
>> drwxr-xr-x. root root system_u:object_r:etc_t:s0 etc
>> drwxr-xr-x. root root system_u:object_r:home_root_t:s0 home
>> lrwxrwxrwx. root root /usr/lib lib -> usr/lib
>> lrwxrwxrwx. root root /usr/lib lib64 -> usr/lib64
>> drwxr-xr-x. root root system_u:object_r:mnt_t:s0 media
>> drwxr-xr-x. root root system_u:object_r:mnt_t:s0 mnt
>> drwxr-xr-x. root root system_u:object_r:usr_t:s0 opt
>> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 proc
>> dr-xr-x---. root root system_u:object_r:admin_home_t:s0 root
>> drwxr-xr-x. root root /var/run run
>> lrwxrwxrwx. root root system_u:object_r:bin_t:s0 sbin -> usr/sbin
>> drwxr-xr-x. root root system_u:object_r:var_t:s0 srv
>> drwxr-xr-x. root root unconfined_u:object_r:unlabeled_t:s0 sys
>> drwxrwxrwt. root root system_u:object_r:tmp_t:s0 tmp
>> drwxr-xr-x. root root system_u:object_r:usr_t:s0 usr
>> drwxr-xr-x. root root system_u:object_r:var_t:s0 var
>>
>> As you can see, the SELinux context for "lib", is "/usr/lib"!!! and
>> similarly, for "lib64", it is "/usr/lib" ... those are not even valid
>> context labels!
>>
>> How can an invalid string like "/usr/lib" even be assigned as a SELinux label
>> in the first place?
>>
> Its not the SELinux label but a symbolic link
>
> /lib is a symbolic link to /usr/lib
> /lib64 is a symbolic link to /usr/lib64
>
> And both of which have the same type 'lib_t'
>
> $ matchpathcon /lib /lib64
>
Hi Simon:

Yes, i know they should have type "lib_t", but see above again... the 
label is actually "/usr/lib". The two examples of lib and lib64 are 
symlinks, but look above at the directory /run as well, which has label 
"/var/run". Furthermore, when I fix these labels manually, the CentOS 7 
image boots up with SELinux enforcing; when I don't fix these labels, 
almost everything breaks.
>> I can workaround this with a manual fix using 'chcon
>> system_u:object_r:type_label:s0 path', but I'm just wondering how this can
>> happen in the first place? When I try to manually reproduce the invalid
>> label, I get this:
>>
>> # chcon /usr/lib lib
>> chcon: invalid context: /usr/lib
>>
>> Any insights would be appreciated...
>> Bond
>>
>>
>> _______________________________________________
>> Selinux mailing list
>> Selinux@tycho.nsa.gov
>> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
>> To get help, send an email containing "help" to
>> Selinux-request@tycho.nsa.gov.
