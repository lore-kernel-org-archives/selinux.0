Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2NLVADn028896
	for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2006 16:31:10 -0500
Received: from mx1.redhat.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2NLV8on006069
	for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2006 21:31:09 GMT
Message-ID: <4423138D.7050007@redhat.com>
Date: Thu, 23 Mar 2006 16:30:53 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Latest Diffs.  This is a big one because we were frozen for so
 long.
References: <441B1A9D.7090903@redhat.com> <1143142519.3962.29.camel@sgc>
In-Reply-To: <1143142519.3962.29.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> Merged most of it, with some reordering.  Some notes:
>
> Moved fc regexes that changed from etc_t to bin_t to corecommands.
>
> Why does apmd_t need to transition to xdm_xserver_t?
>   
I think is how it tells the system to wake up, As I recall a lot of 
these fixes came about because of sleep/resume.
> Dropped change that added rules to seutil_rw_file_contexts() that would
> allow it to create and delete file contexts:
>
> @@ -675,8 +675,8 @@
>  
>         files_search_etc($1)
>         allow $1 selinux_config_t:dir search;
> -       allow $1 file_context_t:dir r_dir_perms;
> -       allow $1 file_context_t:file rw_file_perms;
> +       allow $1 file_context_t:dir rw_dir_perms;
> +       allow $1 file_context_t:file create_file_perms;
>         allow $1 file_context_t:lnk_file { getattr read };
>  ')
>
>   
OK I will drop and try on MLS machine again.
> Dropped change that added rules to seutil_manage_module_store() that
> allows it to create and delete create and delete selinux_config_t
> directories:
>
> @@ -853,7 +853,7 @@
>         ')
>  
>         files_search_etc($1)
> -       allow $1 selinux_config_t:dir rw_dir_perms;
> +       allow $1 selinux_config_t:dir create_dir_perms;
>         type_transition $1 selinux_config_t:dir semanage_store_t;
>  
>         allow $1 semanage_store_t:dir create_dir_perms;
>
>
> Why is this needed? load policy isn't even linked against libsemanage:
>
> @@ -192,6 +192,9 @@
>  selinux_load_policy(load_policy_t)
>  selinux_set_boolean(load_policy_t)
>  
> +seutil_get_semanage_trans_lock(load_policy_t)
> +seutil_get_semanage_read_lock(load_policy_t)
> +
>  term_use_console(load_policy_t)
>  term_list_ptys(load_policy_t)
>
>   
OK I will drop, but this might have been a leaked file descriptor????

> On Fri, 2006-03-17 at 15:22 -0500, Daniel J Walsh wrote:
>   
>> Add Xen policy
>>     
>
> moved xen_device_t to devices.
>
>   
>> Several commands search the /dev/ directory for fixed disk.  Need to 
>> dontaudit avcs
>>     
>
> trimmed this use back to chr_file and blk_file (interfaces already
> exist) since device_node types only should have these classes.
>
>   
I am not sure this covers all the avc's though.  What about the 
directories, files, links, pipes, sockets...
>> init needs to be able to unlink /.** files
>>     
>
> The files_unlink_boot_flag interface you added is confusing, those are
> supposed to be etc_runtime_t files, but you have root_t.
>   
Not if they are created by an unconfined domain.
>   
>> Add support for hfsplus Named it NFS????
>>     
>
> I've merged it for now and added a line for hfs, but perhaps we should
> make a new type, maybe macosfs_t?
>
>   
Sounds good but I think we would need to add a lot of allow rules...
>> Fix some kernel interfaces.  Add xen kernel interfaces
>>     
>
> This addition to kernel_rw_vm_sysctls() doesn't make sense to me:
>
> @@ -1044,6 +1044,7 @@
>  
>         allow $1 proc_t:dir search;
>         allow $1 sysctl_t:dir r_dir_perms;
> +       allow $1 sysctl_vm_t:dir rw_dir_perms;
>         allow $1 sysctl_vm_t:file rw_file_perms;
>  ')
>
> why isn't it just r_dir_perms?  Same with this change to
> kernel_rw_kernel_sysctls():
>
> @@ -1328,7 +1329,7 @@
>
>         allow $1 proc_t:dir search;
>         allow $1 sysctl_t:dir r_dir_perms;
> -       allow $1 sysctl_kernel_t:dir r_dir_perms;
> +       allow $1 sysctl_kernel_t:dir rw_dir_perms;
>         allow $1 sysctl_kernel_t:file rw_file_perms;
>  ')
>
>   
I guess they are creating new files in these directories or at least 
opening the dir file for write.  I think these came for suspend/resume.



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
