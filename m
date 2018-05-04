Received: from moss-pluto.infosec.tycho.ncsc.mil (moss-pluto [192.168.25.131])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w44DZ2a1028603
 for <selinux@tycho.nsa.gov>; Fri, 4 May 2018 09:35:02 -0400
To: selinux@tycho.nsa.gov
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <83e8bd2a-a2c9-5d2e-4667-e98ab2821cd9@tycho.nsa.gov>
 <709e6b08-2a3a-84ec-da43-f514469d45f7@tycho.nsa.gov>
 <20180504075510.GB5101@baraddur.perfinion.com>
 <3c51abc9-2d3a-3cef-2ba1-d976dee651c5@tycho.nsa.gov>
 <20180504132629.GC3263@julius.enp8s0.d30>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <acd4d278-d819-4491-7cae-9644a2b9adfb@tycho.nsa.gov>
Date: Fri, 4 May 2018 09:36:12 -0400
MIME-Version: 1.0
In-Reply-To: <20180504132629.GC3263@julius.enp8s0.d30>
Content-Type: text/plain; charset=utf-8
Subject: Re: Last call for selinux userspace 2.8 release
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2018 09:26 AM, Dominick Grift wrote:
> On Fri, May 04, 2018 at 09:08:36AM -0400, Stephen Smalley wrote:
>> On 05/04/2018 03:55 AM, Jason Zaman wrote:
>>> On Thu, May 03, 2018 at 10:52:24AM -0400, Stephen Smalley wrote:
>>>> Hi,
>>>>
>>>> If you have encountered any unreported problems with the 2.8-rcX releases or have any
>>>> pending patches you believe should be included in the 2.8 release, please post them soon.
>>>
>>> the rc2 release has been fine for me for several days now. And I havent
>>> heard any issues from any gentoo users either so we're probably good to
>>> go. -rc1 failed to boot properly for me because some important things in
>>> /run or /dev didnt get labeled but that was fixed in rc2.
>>
>> Hmm...I'd like to understand that better. The change was verifying file_contexts when using restorecon,
>> which was reverted in -rc2.  But the fact that it prevented labeling files in -rc1 means that either
>> you have a bug in your file_contexts configuration or there is some other bug there.
> 
> If it cannot validate_context then it will be unhappy:
> 
> [root@julius ~]# dnf history info last
> Transaction ID : 364
> Begin time     : Fri 04 May 2018 01:12:36 PM CEST
> Begin rpmdb    : 1404:e739a03c49fec80ed41a1ea4c599d8f877b01d76
> End time       : Fri 04 May 2018 01:14:01 PM CEST (85 seconds)
> End rpmdb      : 1404:27bd40dce7edbf226ffad80f482cd75231f1b6ab **
> User           : kcinimod <kcinimod>
> Return-Code    : Success
> Command Line   : update --exclude efi-filesystem
> Transaction performed with:
>     Installed     dnf-2.7.5-12.fc29.noarch @rawhide
>         Installed     rpm-4.14.1-8.fc28.x86_64 @tmp-rawhide
> 	Packages Altered:
> 	    Upgraded cockpit-166-1.fc29.x86_64                      @rawhide
> ... snip ...
> Scriptlet output:
>    1 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
>       2 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
>          3 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> 	    4 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0
> 	       5 restorecon: /etc/selinux/dssp2-standard/contexts/files/file_contexts: has invalid context sys.id:sys.role:files.generic_boot.boot_file:s0

So, just to be clear: these contexts are in fact valid but the lack of permission to use the /sys/fs/selinux/context interface (for security_check_context) causes it to think the context is invalid and therefore fails?  If so, then 
that makes sense and would be another reason for reverting that change.  In any case, -rc2 should have the fix.
