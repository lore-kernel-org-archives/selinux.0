Received: from zombie.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tycho.ncsc.mil (8.12.8/8.12.8) with ESMTP id i8KCZtrT017005
	for <selinux@tycho.nsa.gov>; Mon, 20 Sep 2004 08:35:55 -0400 (EDT)
Message-ID: <414ECE9E.8030001@redhat.com>
Date: Mon, 20 Sep 2004 08:35:42 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: jwcart2@epoch.ncsc.mil
CC: Russell Coker <russell@coker.com.au>, SE Linux <selinux@tycho.nsa.gov>
Subject: Re: Policy patches
References: <200409162151.44819.russell@coker.com.au>	 <1095346343.17251.6.camel@moss-lions.epoch.ncsc.mil>	 <414A0454.2060304@redhat.com> <1095454617.4295.55.camel@moss-lions.epoch.ncsc.mil>
In-Reply-To: <1095454617.4295.55.camel@moss-lions.epoch.ncsc.mil>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

James Carter wrote:

>On Thu, 2004-09-16 at 17:23, Daniel J Walsh wrote:
>  
>
>>New patches to allow hald to add a lines to the /etc/fstab with 
>>fscontext=system_u:object_r:removable_t.
>>
>>Dan
>>    
>>
>
>  
>
>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/nscd.te policy-1.17.17/domains/program/unused/nscd.te
>>--- nsapolicy/domains/program/unused/nscd.te	2004-09-16 09:48:15.000000000 -0400
>>+++ policy-1.17.17/domains/program/unused/nscd.te	2004-09-16 15:02:07.387150095 -0400
>>@@ -70,4 +70,8 @@
>> #
>> dontaudit nscd_t var_run_t:sock_file rw_file_perms;
>> 
>>+allow nscd_t self:file { getattr read };
>>+allow nscd_t proc_t:file { getattr read };
>>+allow nscd_t selinux_config_t:dir { search };
>>+r_dir_file(nscd_t, default_context_t)
>> 
>>    
>>
>
>Is this only for the targeted policy?  Maybe userspace_objectmgr.te
>  
>
I will look into it.  The problem is everytime we add one it seems to 
have expanding
concequences.

>should be part of the targeted policy.  I think we would gain most of
>these permissions in that case.
>
>When does nscd access a default_context_t?
>
>  
>
That probably was overzealous. Remove it.

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/portmap.te policy-1.17.17/domains/program/unused/portmap.te
>>--- nsapolicy/domains/program/unused/portmap.te	2004-09-16 09:48:15.000000000 -0400
>>+++ policy-1.17.17/domains/program/unused/portmap.te	2004-09-16 11:55:04.363237680 -0400
>>@@ -54,3 +54,4 @@
>> 
>> # do not log when it tries to bind to a port belonging to another domain
>> #dontaudit portmap_t port_type:{ tcp_socket udp_socket } name_bind;
>>+dontaudit portmap_t tty_device_t:chr_file { read write };
>>    
>>
>
>How about this, so it applies to more then just portmap?
>
>diff -u -r1.58 global_macros.te
>--- global_macros.te	15 Sep 2004 19:58:14 -0000	1.58
>+++ global_macros.te	17 Sep 2004 20:43:47 -0000
>@@ -294,6 +294,7 @@
> allow $1_t autofs_t:dir { search getattr };
> ')dnl end if automount.te
> ifdef(`targeted_policy', `
>+dontaudit $1_t tty_device_t:chr_file { read write };
> dontaudit $1_t devpts_t:chr_file { read write };
> dontaudit $1_t root_t:file { getattr read };
> ')dnl end if targeted_policy
>
>  
>
Looks good.

>>diff --exclude-from=exclude -N -u -r nsapolicy/domains/program/unused/updfstab.te policy-1.17.17/domains/program/unused/updfstab.te
>>--- nsapolicy/domains/program/unused/updfstab.te	2004-09-10 10:17:49.000000000 -0400
>>+++ policy-1.17.17/domains/program/unused/updfstab.te	2004-09-16 13:36:58.170098295 -0400
>>@@ -62,3 +62,10 @@
>> 
>> r_dir_file(updfstab_t, { selinux_config_t file_context_t default_context_t } )
>> can_getsecurity(updfstab_t)
>>+
>>+allow updfstab_t { sbin_t bin_t }:dir { search getattr };
>>+dontaudit updfstab_t devtty_t:chr_file { read write };
>>+allow updfstab_t self:fifo_file { getattr read write ioctl };
>>+can_exec(updfstab_t, { sbin_t bin_t ls_exec_t } )
>>+dontaudit updfstab_t home_root_t:dir { getattr search };
>>+dontaudit updfstab_t { home_dir_type home_type }:dir { search };
>>    
>>
>
>Why can_exec(ls_exec_t)?
>
>  
>
One of the scripts it execs execs ls.  Why does ls have it's own domain?

>>diff --exclude-from=exclude -N -u -r nsapolicy/macros/user_macros.te policy-1.17.17/macros/user_macros.te
>>--- nsapolicy/macros/user_macros.te	2004-09-14 09:18:11.000000000 -0400
>>+++ policy-1.17.17/macros/user_macros.te	2004-09-16 13:38:06.207431159 -0400
>>@@ -230,6 +230,12 @@
>> mount_domain($1, $1_mount, `, fs_domain')
>> role $1_r types $1_mount_t;
>> r_dir_file($1_t, mnt_t)
>>+allow $1_mount_t removable_device_t:blk_file { read };
>>+allow $1_mount_t iso9660_t:filesystem { relabelfrom };
>>+allow $1_mount_t removable_t:filesystem { mount relabelto };
>>+allow $1_mount_t removable_t:dir { mounton };
>>+allow $1_mount_t xdm_t:fd { use };
>>+allow $1_mount_t xdm_t:fifo_file { write };
>> ')
>>    
>>
>
>Shouldn't these rules need to be in other macros as well?
>Also, the xdm_t rules should be in a ifdef.
>
>  
>
Probably, just began experimenting with the new updatefstab patch that 
adds this, so we
should be seeing lots of complaints.

Dan


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
