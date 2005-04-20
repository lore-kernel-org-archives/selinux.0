Message-ID: <4266673A.1020403@redhat.com>
Date: Wed, 20 Apr 2005 10:29:14 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Paul Moore <paul.moore@hp.com>
CC: SELinux <SELinux@tycho.nsa.gov>
Subject: Re: selinux-policy-mls is now available for your testing pleasure.
References: <42602C45.3030706@redhat.com> <42657740.9000005@hp.com>
In-Reply-To: <42657740.9000005@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Paul Moore wrote:

> Daniel J Walsh wrote:
>
>> Based off STRICT policy.
>>
>> ftp://people.redhat.com/dwalsh/SELinux/Fedora/selinux-policy-mls-*
>>
>> It is not in Rawhide, yet but I will provide it via my people page.
>>
>> This has not been tested.
>> I have not got an MLS machine up and running yet.
>
>
> Since I have been looking into this lately I figured I would give it a 
> whirl and report back my experiences, here they are:
>
>  1 Installed FC4T2 via the 'Workstation' option using two partitions,
>    one for '/' and one for swap
>  2 Applied all of the related updates via YUM (done on April 19th)
>  3 Installed the MLS policy (version 1.23-11-2) but continued to use
>    the default targeted policy
>  4 Rebooted into kernel 2.6.11-1.1240_FC4smp to verify everything was
>    OK (it was)
>  5 Enabled the MLS policy via the Fedora GUI tool and ensured that the
>    relabel option was selected
>  6 Rebooted with the new MLS policy only to have the machine lock,
>    it wasn't able to execute something related to init (I should have
>    taken better notes here - sorry)
>  7 Rebooted (the hard way, Ctrl-Alt-Del only resulted in more AVC
>    denial messages) with 'selinux=0 single'
>  8 Unmounted '/proc' and '/sys' then relabeled them to
>    'system_u:object_r:file_t:s0' and 'user_u:object_r:file_t:s0'
>    respectively; also relabeled '/var/lib/nfs/rpc_pipefs' to
>    'user_u:object_r:var_lib_nfs_t:s0'
>  9 Rebooted with 'enforcing=0 single' and this time the FS-wide
>    relabel happened as part of the boot process
> 10 Rebooted with 'single' and noticed lots of permission denied
>    messages pertaining to '/dev/.udevdb/*' files

udevdb/* files should be labeled udev_tbl_t  Accordiung to policy

> 11 Switched to runlevel 3 and saw a variety of AVC denial messages but
>    things went mostly to plan and I had a login prompt which appeared
>    to work as expected
> 12 Rebooted normally, i.e. 'rhgb quiet 5', and X failed to start
>
> I'm going to keep playing with this system, but I thought some people 
> here might want to see a quick little report on how the MLS policy RPM 
> worked.
>
Could you clear you /var/log/messages or /var/log/audit/audit.log file.  
Reboot and then send the AVC messages.

Dan

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
