Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t7C3bNL1015436
 for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2015 23:37:23 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id 1C7D279BE5
 for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2015 20:37:18 -0700 (PDT)
Received: from mail.jlbond.com ([127.0.0.1])
 by localhost (mail.jlbond.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id jNyUs9dNCmef for <selinux@tycho.nsa.gov>;
 Tue, 11 Aug 2015 20:37:17 -0700 (PDT)
Received: from taipei.bbky.org (firewall.bbky.org [192.168.0.1])
 by mail.jlbond.com (Postfix) with ESMTP id D251379764
 for <selinux@tycho.nsa.gov>; Tue, 11 Aug 2015 20:37:17 -0700 (PDT)
Subject: Re: How do you relabel all SELinux file contexts of an offline
 system's file system?
To: selinux@tycho.nsa.gov
References: <55C13DA1.2070601@jlbond.com>
 <20150805065406.GA17019@meriadoc.omgwtfbbq> <55CA9B0E.9050109@jlbond.com>
From: Bond Masuda <bond.masuda@jlbond.com>
Message-ID: <55CABF6D.70408@jlbond.com>
Date: Tue, 11 Aug 2015 20:37:17 -0700
MIME-Version: 1.0
In-Reply-To: <55CA9B0E.9050109@jlbond.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

So, further troubleshooting this myself, I found these errors from
'setfiles':

/sbin/setfiles reset /usr/sbin/tzdata-update context
system_u:object_r:bin_t:s0->system_u:object_r:tzdata_exec_t:s0
/sbin/setfiles set context
/usr/sbin/tzdata-update->system_u:object_r:tzdata_exec_t:s0
failed:'Invalid argument'
/sbin/setfiles reset /sbin/pam_timestamp_check context
system_u:object_r:pam_timestamp_exec_t:s0->system_u:object_r:pam_exec_t:s0
/sbin/setfiles reset /sbin/shutdown context
system_u:object_r:bin_t:s0->system_u:object_r:shutdown_exec_t:s0
/sbin/setfiles set context
/sbin/shutdown->system_u:object_r:shutdown_exec_t:s0 failed:'Invalid
argument'
/sbin/setfiles reset /sbin/consoletype context
system_u:object_r:bin_t:s0->system_u:object_r:consoletype_exec_t:s0
/sbin/setfiles set context
/sbin/consoletype->system_u:object_r:consoletype_exec_t:s0
failed:'Invalid argument'

I'm guessing this is because the "host" system doesn't have these types
in it's own policy? The "host" is a Fedora 21 system, while the system
mounted in /mnt/test is a CentOS6 system.

Grepping the "types" above that give "invalid argument" on the host's
file_context* files indeed comes up empty.

So, I'm guessing this is where I need to use runcon -t setfiles_mac_t to
run setfiles so it doesn't require the type to be one that is loaded in
the host's SELinux policy?

How do I use runcon? I tried:

# chroot /mnt/test /usr/bin/runcon -t setfiles_mac_t -- /sbin/setfiles
-v -n -F -e /proc -e /sys -e /dev -e /selinux
/etc/selinux/targeted/contexts/files/file_contexts /
/usr/bin/runcon: /usr/bin/runcon may be used only on a SELinux kernel

Or, trying the -r option in setfiles:

# /usr/bin/runcon -t setfiles_mac_t -- /sbin/setfiles -v -n -F -e /proc
-e /sys -e /dev -e /selinux -r /mnt/test
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts /mnt/test

/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 762
has invalid context system_u:object_r:hald_log_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 763
has invalid context system_u:object_r:hald_var_run_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 827
has invalid context system_u:object_r:hald_var_run_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 855
has invalid context system_u:object_r:hotplug_etc_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 856
has invalid context system_u:object_r:hotplug_var_run_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 880
has invalid context system_u:object_r:hald_var_lib_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 883
has invalid context system_u:object_r:l2tp_etc_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 915
has invalid context system_u:object_r:hald_log_t:s0
/mnt/test/etc/selinux/targeted/contexts/files/file_contexts: line 1009
has invalid context system_u:object_r:hald_var_run_t:s0
Exiting after 10 errors.

Not sure I understand these errors?

Please help?
-Bond

On 08/11/2015 06:02 PM, Bond Masuda wrote:
>
> On 08/04/2015 11:54 PM, Jason Zaman wrote:
>> On Tue, Aug 04, 2015 at 03:33:05PM -0700, Bond Masuda wrote:
>>> Hello,
>>>
>>> Normally, if I need to ensure that all the SELinux file contexts are
>>> correct, I run:
>>>
>>> restorecon -R -v /
>>>
>>> However, in the current situation, I need to do that on a system that is
>>> offline, where I have it's root and entire file system mounted under
>>> /mnt. I tried:
>>>
>>> chroot /mnt /usr/sbin/restorecon -R -v /mnt
>>>
>>> hoping it would have the same effect, but it does not appear to. When I
>>> boot the offline system, it shows a lot of SELinux mislabelings.
>>>
>>> Is there a way to fix SELinux file contexts of another system while it
>>> is offline?
>>>
>>> Thanks for any help...
>>> -Bond
>> Look at setfiles, you want something like this:
>>
>> setfiles -vr /mnt/ /etc/selinux/strict/contexts/files/file_contexts /mnt/
>>
>> from setfiles(8):
>>        -r rootpath
>>               use an alternate root path.
>>
>> -- Jason
> Thanks to your hint and the other replies, I was able to use setfiles to
> solve most of the labeling issues. However, there are a few remaining
> problems.
>
> I also learned that setfiles doesn't seem to traverse distinct
> filesystems, so I had to iterate through the list of filesystems mounted
> under /mnt and iterate through each fcontext file. What remains after
> all this are the following that remain mislabeled:
>
> [root@localhost /]# restorecon -v -n -r /
> restorecon reset / context system_u:object_r:mnt_t:s0->system_u:object_r:root_t:s0
> restorecon reset /usr/sbin/tzdata-update context system_u:object_r:bin_t:s0->system_u:object_r:tzdata_exec_t:s0
> restorecon reset /sbin/shutdown context system_u:object_r:bin_t:s0->system_u:object_r:shutdown_exec_t:s0
> restorecon reset /sbin/consoletype context system_u:object_r:bin_t:s0->system_u:object_r:consoletype_exec_t:s0
> restorecon reset /.autofsck context system_u:object_r:mnt_t:s0->system_u:object_r:etc_runtime_t:s0
>
> I looked through the fcontexts files, and sure enough, they are mislabeled:
>
> [root@localhost files]# pwd
> /etc/selinux/targeted/contexts/files
> [root@localhost files]# grep -E
> "tzdata-update|/sbin/shutdown|/sbin/consoletype" *
> file_contexts:/sbin/shutdown    --    system_u:object_r:shutdown_exec_t:s0
> file_contexts:/sbin/consoletype    --   
> system_u:object_r:consoletype_exec_t:s0
> file_contexts:/usr/sbin/shutdown    --   
> system_u:object_r:shutdown_exec_t:s0
> file_contexts:/usr/sbin/tzdata-update    --   
> system_u:object_r:tzdata_exec_t:s0
>
> The way I'm running setfiles is basically like this:
>
> chroot /mnt/test /sbin/setfiles -v -F -e /proc -e /sys -e /dev -e
> /selinux /etc/selinux/targeted/contexts/files/file_contexts /
>
> But iterating through each filesystem under "/" (in the chroot /mnt/test).
>
> Can anyone help me explain why the 5 file paths above remain mislabeled
> after running setfiles?
>
> Thanks,
> -Bond
>
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
