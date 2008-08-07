Received: from zombie2.ncsc.mil (zombie2.ncsc.mil [144.51.88.133])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m77ENXcp015799
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 10:23:33 -0400
Received: from exchange.columbia.tresys.com (jazzdrum.ncsc.mil [144.51.5.7])
	by zombie2.ncsc.mil (8.12.10/8.12.10) with SMTP id m77ENPjg022366
	for <selinux@tycho.nsa.gov>; Thu, 7 Aug 2008 14:23:25 GMT
Subject: Re: [patch 31/35] amanda policy update
From: "Christopher J. PeBenito" <cpebenito@tresys.com>
To: david@hardeman.nu
Cc: selinux@tycho.nsa.gov
In-Reply-To: <20080804123739.652566737@hardeman.nu>
References: <20080804123456.679565839@hardeman.nu>
	 <20080804123739.652566737@hardeman.nu>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 10:22:55 -0400
Message-Id: <1218118975.5345.31.camel@gorn.columbia.tresys.com>
Mime-Version: 1.0
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Mon, 2008-08-04 at 14:35 +0200, david@hardeman.nu wrote:
> plain text document attachment (policy_modules_admin_amanda.patch)
> RH policy updates to the amanda module, none of these look controversial

Merged.

> Index: refpolicy/policy/modules/admin/amanda.fc
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/amanda.fc	2008-07-19 19:15:44.000000000 +0200
> +++ refpolicy/policy/modules/admin/amanda.fc	2008-08-03 21:51:13.000000000 +0200
> @@ -3,6 +3,7 @@
>  /etc/amanda/.*/tapelist(/.*)?		gen_context(system_u:object_r:amanda_data_t,s0)
>  /etc/amandates				gen_context(system_u:object_r:amanda_amandates_t,s0)
>  /etc/dumpdates				gen_context(system_u:object_r:amanda_dumpdates_t,s0)
> +/etc/amanda/.*/index(/.*)?		gen_context(system_u:object_r:amanda_data_t,s0)
>  
>  /root/restore			-d	gen_context(system_u:object_r:amanda_recover_dir_t,s0)
>  
> Index: refpolicy/policy/modules/admin/amanda.te
> ===================================================================
> --- refpolicy.orig/policy/modules/admin/amanda.te	2008-08-03 16:47:00.000000000 +0200
> +++ refpolicy/policy/modules/admin/amanda.te	2008-08-03 21:51:13.000000000 +0200
> @@ -82,8 +82,9 @@
>  allow amanda_t amanda_config_t:file { getattr read };
>  
>  # access to amandas data structure
> -allow amanda_t amanda_data_t:dir { read search write };
> -allow amanda_t amanda_data_t:file manage_file_perms;
> +manage_dirs_pattern(amanda_t, amanda_data_t, amanda_data_t)
> +manage_files_pattern(amanda_t, amanda_data_t, amanda_data_t)
> +filetrans_pattern(amanda_t, amanda_config_t, amanda_data_t, { file dir })
>  
>  # access to amanda_dumpdates_t
>  allow amanda_t amanda_dumpdates_t:file { getattr lock read write };
> @@ -146,6 +147,8 @@
>  fs_list_all(amanda_t)
>  
>  storage_raw_read_fixed_disk(amanda_t)
> +storage_read_tape(amanda_t)
> +storage_write_tape(amanda_t)
>  
>  # Added for targeted policy
>  term_use_unallocated_ttys(amanda_t)
> @@ -220,6 +223,7 @@
>  auth_use_nsswitch(amanda_recover_t)
>  
>  fstools_domtrans(amanda_t)
> +fstools_signal(amanda_t)
>  
>  libs_use_ld_so(amanda_recover_t)
>  libs_use_shared_libs(amanda_recover_t)
> 
-- 
Chris PeBenito
Tresys Technology, LLC
(410) 290-1411 x150


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
