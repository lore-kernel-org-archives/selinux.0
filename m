Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id sB3DYAuw016075
 for <selinux@tycho.nsa.gov>; Wed, 3 Dec 2014 08:34:12 -0500
Message-ID: <547F1141.2030101@tresys.com>
Date: Wed, 3 Dec 2014 08:33:53 -0500
From: Steve Lawrence <slawrence@tresys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
To: "Christopher J. PeBenito" <cpebenito@tresys.com>, Refpolicy List
 <refpolicy@oss1.tresys.com>
Subject: Re: [refpolicy] [PATCH] Update policy for selinux userspace moving
 the policy store to /var/lib/selinux
References: <1417537964-16125-1-git-send-email-slawrence@tresys.com>
 <547F0C35.6060906@tresys.com>
In-Reply-To: <547F0C35.6060906@tresys.com>
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 12/03/2014 08:12 AM, Christopher J. PeBenito wrote:
> On 12/2/2014 11:32 AM, Steve Lawrence wrote:
>> This keeps /var/lib/selinux labeled as semanage_var_lib_t, but all
>> directories inside it are now labeled semanage_store_t, except for lock
>> files.
> 
> Is there anything other than module stores in /var/lib/selinux?  I don't
> see anything else on my systems.  If so, we should drop
> semanage_var_lib_t (make it an alias of semanage_store_t for compat) and
> make everything under /var/lib/selinux semanage_store_t (except the
> locks of course).
> 

The current selinux userspace only uses it as a temporary location to
build permissive modules for the 'semanage permissive' command. However,
the next userspace release changes that so that only the module store
lives in /var/lib/selinux. Permissive modules are handled differently.
I'll send an updated patch with your recommendations.

>> Signed-off-by: Steve Lawrence <slawrence@tresys.com>
>> ---
>>  policy/modules/system/selinuxutil.fc | 6 +++++-
>>  policy/modules/system/selinuxutil.if | 3 ++-
>>  policy/modules/system/selinuxutil.te | 1 +
>>  3 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/policy/modules/system/selinuxutil.fc b/policy/modules/system/selinuxutil.fc
>> index ec19d63..8f1eb3c 100644
>> --- a/policy/modules/system/selinuxutil.fc
>> +++ b/policy/modules/system/selinuxutil.fc
>> @@ -41,11 +41,15 @@
>>  /usr/sbin/setsebool		--	gen_context(system_u:object_r:semanage_exec_t,s0)
>>  /usr/sbin/semanage		--	gen_context(system_u:object_r:semanage_exec_t,s0)
>>  /usr/sbin/semodule		--	gen_context(system_u:object_r:semanage_exec_t,s0)
>> +/usr/libexec/selinux/semanage_migrate_store		--	gen_context(system_u:object_r:semanage_exec_t,s0)
>>  
>>  #
>>  # /var/lib
>>  #
>> -/var/lib/selinux(/.*)?			gen_context(system_u:object_r:semanage_var_lib_t,s0)
>> +/var/lib/selinux		-d	gen_context(system_u:object_r:semanage_var_lib_t,s0)
>> +/var/lib/selinux/.*			gen_context(system_u:object_r:semanage_store_t,s0)
>> +/var/lib/selinux/[^/]+/semanage\.read\.LOCK -- gen_context(system_u:object_r:semanage_read_lock_t,s0)
>> +/var/lib/selinux/[^/]+/semanage\.trans\.LOCK -- gen_context(system_u:object_r:semanage_trans_lock_t,s0)
>>  
>>  #
>>  # /var/run
>> diff --git a/policy/modules/system/selinuxutil.if b/policy/modules/system/selinuxutil.if
>> index bee06f4..ae280bd 100644
>> --- a/policy/modules/system/selinuxutil.if
>> +++ b/policy/modules/system/selinuxutil.if
>> @@ -1037,11 +1037,12 @@ interface(`seutil_run_semanage',`
>>  #
>>  interface(`seutil_manage_module_store',`
>>  	gen_require(`
>> -		type selinux_config_t, semanage_store_t;
>> +		type selinux_config_t, semanage_store_t, semanage_var_lib_t;
>>  	')
>>  
>>  	files_search_etc($1)
>>  	manage_dirs_pattern($1, selinux_config_t, semanage_store_t)
>> +	manage_dirs_pattern($1, semanage_var_lib_t, semanage_store_t)
>>  	manage_files_pattern($1, semanage_store_t, semanage_store_t)
>>  	manage_lnk_files_pattern($1, semanage_store_t, semanage_store_t)
>>  ')
>> diff --git a/policy/modules/system/selinuxutil.te b/policy/modules/system/selinuxutil.te
>> index c322a6f..a73874c 100644
>> --- a/policy/modules/system/selinuxutil.te
>> +++ b/policy/modules/system/selinuxutil.te
>> @@ -454,6 +454,7 @@ allow semanage_t semanage_tmp_t:dir manage_dir_perms;
>>  allow semanage_t semanage_tmp_t:file manage_file_perms;
>>  files_tmp_filetrans(semanage_t, semanage_tmp_t, { file dir })
>>  
>> +filetrans_pattern(semanage_t, semanage_var_lib_t, semanage_store_t, dir)
>>  manage_dirs_pattern(semanage_t, semanage_var_lib_t, semanage_var_lib_t)
>>  manage_files_pattern(semanage_t, semanage_var_lib_t, semanage_var_lib_t)
>>  
>>
> 
> 
