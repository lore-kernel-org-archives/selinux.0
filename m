Received: from jazzdrum.ncsc.mil (zombie.ncsc.mil [144.51.88.131])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k2NJZAZM025856
	for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2006 14:35:10 -0500
Received: from gotham.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by jazzdrum.ncsc.mil (8.12.10/8.12.10) with ESMTP id k2NJZ8on015159
	for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2006 19:35:09 GMT
Subject: Re: Latest Diffs.  This is a big one because we were frozen for so
	long.
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: Daniel J Walsh <dwalsh@redhat.com>
Cc: SE Linux <selinux@tycho.nsa.gov>
In-Reply-To: <441B1A9D.7090903@redhat.com>
References: <441B1A9D.7090903@redhat.com>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 14:35:19 -0500
Message-Id: <1143142519.3962.29.camel@sgc>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Merged most of it, with some reordering.  Some notes:

Moved fc regexes that changed from etc_t to bin_t to corecommands.

Why does apmd_t need to transition to xdm_xserver_t?

Dropped change that added rules to seutil_rw_file_contexts() that would
allow it to create and delete file contexts:

@@ -675,8 +675,8 @@
 
        files_search_etc($1)
        allow $1 selinux_config_t:dir search;
-       allow $1 file_context_t:dir r_dir_perms;
-       allow $1 file_context_t:file rw_file_perms;
+       allow $1 file_context_t:dir rw_dir_perms;
+       allow $1 file_context_t:file create_file_perms;
        allow $1 file_context_t:lnk_file { getattr read };
 ')

Dropped change that added rules to seutil_manage_module_store() that
allows it to create and delete create and delete selinux_config_t
directories:

@@ -853,7 +853,7 @@
        ')
 
        files_search_etc($1)
-       allow $1 selinux_config_t:dir rw_dir_perms;
+       allow $1 selinux_config_t:dir create_dir_perms;
        type_transition $1 selinux_config_t:dir semanage_store_t;
 
        allow $1 semanage_store_t:dir create_dir_perms;


Why is this needed? load policy isn't even linked against libsemanage:

@@ -192,6 +192,9 @@
 selinux_load_policy(load_policy_t)
 selinux_set_boolean(load_policy_t)
 
+seutil_get_semanage_trans_lock(load_policy_t)
+seutil_get_semanage_read_lock(load_policy_t)
+
 term_use_console(load_policy_t)
 term_list_ptys(load_policy_t)

On Fri, 2006-03-17 at 15:22 -0500, Daniel J Walsh wrote:
> Add Xen policy

moved xen_device_t to devices.

> Several commands search the /dev/ directory for fixed disk.  Need to 
> dontaudit avcs

trimmed this use back to chr_file and blk_file (interfaces already
exist) since device_node types only should have these classes.

> init needs to be able to unlink /.** files

The files_unlink_boot_flag interface you added is confusing, those are
supposed to be etc_runtime_t files, but you have root_t.

> Add support for hfsplus Named it NFS????

I've merged it for now and added a line for hfs, but perhaps we should
make a new type, maybe macosfs_t?

> Fix some kernel interfaces.  Add xen kernel interfaces

This addition to kernel_rw_vm_sysctls() doesn't make sense to me:

@@ -1044,6 +1044,7 @@
 
        allow $1 proc_t:dir search;
        allow $1 sysctl_t:dir r_dir_perms;
+       allow $1 sysctl_vm_t:dir rw_dir_perms;
        allow $1 sysctl_vm_t:file rw_file_perms;
 ')

why isn't it just r_dir_perms?  Same with this change to
kernel_rw_kernel_sysctls():

@@ -1328,7 +1329,7 @@

        allow $1 proc_t:dir search;
        allow $1 sysctl_t:dir r_dir_perms;
-       allow $1 sysctl_kernel_t:dir r_dir_perms;
+       allow $1 sysctl_kernel_t:dir rw_dir_perms;
        allow $1 sysctl_kernel_t:file rw_file_perms;
 ')

-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
