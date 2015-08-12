Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7C12CqO007539
 for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2015 21:02:14 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 5326B79BE5
 for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2015 18:02:07 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id JPDFlpe2mYpc for <selinux@tycho.nsa.gov>;
 Tue, 11 Aug 2015 18:02:07 -0700 (PDT)
Received: from taipei.bbky.org (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 1765D79763
 for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2015 18:02:07 -0700 (PDT)
Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
References: <55C13DA1.2070601@jlbond.com>
 <20150805065406.GA17019@meriadoc.omgwtfbbq>
From: Bond Masuda <bond.masuda@jlbond.com>
To: selinux@tycho.nsa.gov
Message-ID: <55CA9B0E.9050109@jlbond.com>
Date: Tue, 11 Aug 2015 18:02:06 -0700
MIME-Version: 1.0
In-Reply-To: <20150805065406.GA17019@meriadoc.omgwtfbbq>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 08/04/2015 11:54 PM, Jason Zaman wrote:
> On Tue, Aug 04, 2015 at 03:33:05PM -0700, Bond Masuda wrote:
>> Hello,
>>
>> Normally, if I need to ensure that all the SELinux file contexts are
>> correct, I run:
>>
>> restorecon -R -v /
>>
>> However, in the current situation, I need to do that on a system that is
>> offline, where I have it's root and entire file system mounted under
>> /mnt. I tried:
>>
>> chroot /mnt /usr/sbin/restorecon -R -v /mnt
>>
>> hoping it would have the same effect, but it does not appear to. When I
>> boot the offline system, it shows a lot of SELinux mislabelings.
>>
>> Is there a way to fix SELinux file contexts of another system while it
>> is offline?
>>
>> Thanks for any help...
>> -Bond
> Look at setfiles, you want something like this:
>
> setfiles -vr /mnt/ /etc/selinux/strict/contexts/files/file_contexts /mnt/
>
> from setfiles(8):
>        -r rootpath
>               use an alternate root path.
>
> -- Jason

Thanks to your hint and the other replies, I was able to use setfiles to
solve most of the labeling issues. However, there are a few remaining
problems.

I also learned that setfiles doesn't seem to traverse distinct
filesystems, so I had to iterate through the list of filesystems mounted
under /mnt and iterate through each fcontext file. What remains after
all this are the following that remain mislabeled:

[root@localhost /]# restorecon -v -n -r /
restorecon reset / context system_u:object_r:mnt_t:s0->system_u:object_r:root_t:s0
restorecon reset /usr/sbin/tzdata-update context system_u:object_r:bin_t:s0->system_u:object_r:tzdata_exec_t:s0
restorecon reset /sbin/shutdown context system_u:object_r:bin_t:s0->system_u:object_r:shutdown_exec_t:s0
restorecon reset /sbin/consoletype context system_u:object_r:bin_t:s0->system_u:object_r:consoletype_exec_t:s0
restorecon reset /.autofsck context system_u:object_r:mnt_t:s0->system_u:object_r:etc_runtime_t:s0

I looked through the fcontexts files, and sure enough, they are mislabeled:

[root@localhost files]# pwd
/etc/selinux/targeted/contexts/files
[root@localhost files]# grep -E
"tzdata-update|/sbin/shutdown|/sbin/consoletype" *
file_contexts:/sbin/shutdown    --    system_u:object_r:shutdown_exec_t:s0
file_contexts:/sbin/consoletype    --   
system_u:object_r:consoletype_exec_t:s0
file_contexts:/usr/sbin/shutdown    --   
system_u:object_r:shutdown_exec_t:s0
file_contexts:/usr/sbin/tzdata-update    --   
system_u:object_r:tzdata_exec_t:s0

The way I'm running setfiles is basically like this:

chroot /mnt/test /sbin/setfiles -v -F -e /proc -e /sys -e /dev -e
/selinux /etc/selinux/targeted/contexts/files/file_contexts /

But iterating through each filesystem under "/" (in the chroot /mnt/test).

Can anyone help me explain why the 5 file paths above remain mislabeled
after running setfiles?

Thanks,
-Bond
