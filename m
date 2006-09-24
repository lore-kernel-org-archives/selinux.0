Received: from jazzhorn.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id k8O12KEU031310
	for <selinux@tycho.nsa.gov>; Sat, 23 Sep 2006 21:02:20 -0400
Received: from exchange.columbia.tresys.com (jazzhorn.ncsc.mil [144.51.5.9])
	by jazzhorn.ncsc.mil (8.12.10/8.12.10) with SMTP id k8O11oFR010471
	for <selinux@tycho.nsa.gov>; Sun, 24 Sep 2006 01:01:50 GMT
Message-ID: <4515D90B.8020001@gentoo.org>
Date: Sat, 23 Sep 2006 21:02:03 -0400
From: Joshua Brindle <method@gentoo.org>
MIME-Version: 1.0
To: russell@coker.com.au
CC: SE-Linux <selinux@tycho.nsa.gov>, Daniel Walsh <dwalsh@redhat.com>
Subject: Re: FC5 policy
References: <200609240034.08217.russell@coker.com.au> <200609240813.56907.russell@coker.com.au> <4515CA12.3050107@gentoo.org> <200609241031.46481.russell@coker.com.au>
In-Reply-To: <200609241031.46481.russell@coker.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Russell Coker wrote:
> On Sunday 24 September 2006 09:58, Joshua Brindle <method@gentoo.org> wrote:
>   
>>>> um? in what way are the tools broken? It is quite easy to move a module
>>>> to base:
>>>>
>>>> semodule -r clamav -i base-with-clamav.pp
>>>>         
>>> The package installation process can't do it.
>>>       
>> sounds like a problem with the package manager rather than the selinux
>> tools.
>>     
>
> The only way of doing this with the package manager would be to look for 
> specific versions of packages and have code which says "if old version == X 
> and new version == y then use parameter `-r clamav`" which gets ugly fairly 
> quickly.
>
>   
Package managers can't quite cope with policy right anyway and this is 
another symptom of that. The old policy must be removed in the same 
transaction as the new policy is inserted which means the new package 
needs to obsolete the old package and both semodule commands need to be 
consolidated into a single semodule call.

This is the same reason that package managers can't handle modules with 
circular dependencies without packaging them together. Package managers 
need to be augmented to handle policies at a higher level than normal 
files and there has been quite a bit of resistance to that.

>>> Ideally we would have some way for semodule to automatically figure out
>>> that base-with-clamav.pp has the clamav module and do the right thing.
>>>       
>> doubtful. What if they have different rules? How about slightly
>> different type spaces? Is it ok if some types are invalided as long as
>> some aren't? This is certainly not something semodule should do.
>>     
>
> If the module name is the same then it should be fairly unambiguous.  Any 
> package upgrade may have slightly different type spaces etc so the difference 
> in module vs base is no difference than that between successive versions of 
> the base policy.
>   
Base doesn't have modules inside it, base is a standalone policy and it 
still isn't semodules job, if you have 2 modules with the same symbols 
your policy doesn't link, this isn't unlike how libraries or many other 
things that package managers handle work.
>>>> Who doesn't like removing access from processes? I think we are all on
>>>> the same side here..
>>>>         
>>> Then why do I keep sending this patch to the list and it doesn't get
>>> applied?
>>>
>>> Why hasn't the pre-fedora /boot sym-links thing been cleaned up?
>>>       
>> i didn't see you send any patch to the list. you sent a link to some
>> packages and some backhanded remarks about the policy, certainly not a
>> good way to get something merged..
>>     
>
> I've attached the patch to this message to save you the effort of visiting my 
> web site.
>
> You don't like my remarks, I don't like having to re-write patches multiple 
> times to get them accepted.  Particularly not simple and obvious patches.
>
>   

I'm sure Chris PeBenito will look at the patch on Monday but I can see 
at least one error, you are breaking encapsulation by using the proc_t 
type in the amavis policy.
> ------------------------------------------------------------------------
>
> diff -ru serefpolicy-2.3.7.orig/policy/modules/kernel/kernel.if serefpolicy-2.3.7/policy/modules/kernel/kernel.if
> --- serefpolicy-2.3.7.orig/policy/modules/kernel/kernel.if	2006-09-23 22:43:33.000000000 +1000
> +++ serefpolicy-2.3.7/policy/modules/kernel/kernel.if	2006-09-23 22:44:06.000000000 +1000
> @@ -1978,6 +1978,24 @@
>  
>  ########################################
>  ## <summary>
> +##	Allow caller to stat unlabeled processes.
> +## </summary>
> +## <param name="domain">
> +##	<summary>
> +##	Domain allowed access.
> +##	</summary>
> +## </param>
> +#
> +interface(`kernel_getattr_unlabeled_procs',`
> +	gen_require(`
> +		type unlabeled_t;
> +	')
> +
> +	allow $1 unlabeled_t:process getattr;
> +')
> +
> +########################################
> +## <summary>
>  ##	Allow caller to relabel unlabeled files.
>  ## </summary>
>  ## <param name="domain">
> diff -ru serefpolicy-2.3.7.orig/policy/modules/services/amavis.fc serefpolicy-2.3.7/policy/modules/services/amavis.fc
> --- serefpolicy-2.3.7.orig/policy/modules/services/amavis.fc	2006-08-12 20:57:28.000000000 +1000
> +++ serefpolicy-2.3.7/policy/modules/services/amavis.fc	2006-09-23 22:44:06.000000000 +1000
> @@ -7,6 +7,6 @@
>  /var/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
>  /var/lib/amavis(/.*)?			gen_context(system_u:object_r:amavis_var_lib_t,s0)
>  /var/log/amavisd\.log		--	gen_context(system_u:object_r:amavis_var_log_t,s0)
> -/var/run/amavis(d)?(/.*)?		gen_context(system_u:object_r:amavis_var_run_t,s0)
> +/var/run/amavis(d)?/.+			gen_context(system_u:object_r:amavis_var_run_t,s0)
>  /var/spool/amavisd(/.*)?		gen_context(system_u:object_r:amavis_spool_t,s0)
>  /var/virusmails(/.*)?			gen_context(system_u:object_r:amavis_quarantine_t,s0)
> diff -ru serefpolicy-2.3.7.orig/policy/modules/services/amavis.te serefpolicy-2.3.7/policy/modules/services/amavis.te
> --- serefpolicy-2.3.7.orig/policy/modules/services/amavis.te	2006-09-23 22:43:33.000000000 +1000
> +++ serefpolicy-2.3.7/policy/modules/services/amavis.te	2006-09-23 22:44:06.000000000 +1000
> @@ -50,6 +50,7 @@
>  allow amavis_t self:unix_stream_socket create_stream_socket_perms;
>  allow amavis_t self:unix_dgram_socket create_socket_perms;
>  allow amavis_t self:tcp_socket { listen accept };
> +allow amavis_t proc_t:lnk_file read;
>  
>  # configuration files
>  allow amavis_t amavis_etc_t:dir r_dir_perms;
> @@ -66,7 +67,6 @@
>  allow amavis_t amavis_spool_t:dir manage_dir_perms;
>  allow amavis_t amavis_spool_t:file manage_file_perms;
>  allow amavis_t amavis_spool_t:sock_file manage_file_perms;
> -files_spool_filetrans(amavis_t,amavis_spool_t,{ dir file })
>  type_transition amavis_t amavis_spool_t:sock_file amavis_var_run_t;
>  
>  # tmp files
> @@ -78,8 +78,6 @@
>  allow amavis_t amavis_var_lib_t:file create_file_perms;
>  allow amavis_t amavis_var_lib_t:sock_file create_file_perms;
>  allow amavis_t amavis_var_lib_t:dir create_dir_perms;
> -files_var_filetrans(amavis_t,amavis_var_lib_t,{ file dir sock_file })
> -files_var_lib_filetrans(amavis_t,amavis_var_lib_t,file)
>  
>  # log files
>  allow amavis_t amavis_var_log_t:file create_file_perms;
> diff -ru serefpolicy-2.3.7.orig/policy/modules/services/samba.te serefpolicy-2.3.7/policy/modules/services/samba.te
> --- serefpolicy-2.3.7.orig/policy/modules/services/samba.te	2006-09-23 22:43:33.000000000 +1000
> +++ serefpolicy-2.3.7/policy/modules/services/samba.te	2006-09-23 22:44:06.000000000 +1000
> @@ -521,10 +521,6 @@
>  userdom_use_sysadm_ttys(smbmount_t)
>  
>  optional_policy(`
> -	cups_read_rw_config(smbd_t)
> -')
> -
> -optional_policy(`
>  	nis_use_ypbind(smbmount_t)
>  ')
>  
> diff -ru serefpolicy-2.3.7.orig/policy/modules/system/unconfined.if serefpolicy-2.3.7/policy/modules/system/unconfined.if
> --- serefpolicy-2.3.7.orig/policy/modules/system/unconfined.if	2006-09-23 22:43:33.000000000 +1000
> +++ serefpolicy-2.3.7/policy/modules/system/unconfined.if	2006-09-23 22:44:06.000000000 +1000
> @@ -89,6 +89,11 @@
>  	optional_policy(`
>  		storage_unconfined($1)
>  	')
> +
> +	optional_policy(`
> +		kernel_getattr_unlabeled_procs($1)
> +		kernel_kill_unlabeled($1)
> +	')
>  ')
>  
>  ########################################
>   


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
