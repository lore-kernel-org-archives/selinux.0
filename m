Message-ID: <437A8394.9030507@redhat.com>
Date: Tue, 15 Nov 2005 19:55:48 -0500
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: "Christopher J. PeBenito" <cpebenito@tresys.com>
CC: Stephen Smalley <sds@tycho.nsa.gov>, Ivan Gyurdiev <ivg2@cornell.edu>,
   SELinux-dev@tresys.com, selinux@tycho.nsa.gov
Subject: Re: Policy mods in last nights refpolicy
References: <437907D7.8090002@cornell.edu>	 <1132054159.5415.282.camel@moss-spartans.epoch.ncsc.mil>	 <1132055891.5415.305.camel@moss-spartans.epoch.ncsc.mil>	 <4379E4D1.2010900@redhat.com>	 <1132063930.5415.364.camel@moss-spartans.epoch.ncsc.mil>	 <4379EFBE.8070202@redhat.com> <1132069967.24234.159.camel@sgc>
In-Reply-To: <1132069967.24234.159.camel@sgc>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Christopher J. PeBenito wrote:
> On Tue, 2005-11-15 at 09:25 -0500, Daniel J Walsh wrote:
>   
>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/files.fc serefpolicy-2.0.1/policy/modules/system/files.fc
>> --- nsaserefpolicy/policy/modules/system/files.fc	2005-11-14 18:24:06.000000000 -0500
>> +++ serefpolicy-2.0.1/policy/modules/system/files.fc	2005-11-15 09:19:21.000000000 -0500
>> @@ -214,3 +214,4 @@
>>  /var/tmp/lost\+found	-d	gen_context(system_u:object_r:lost_found_t,s0)
>>  /var/tmp/lost\+found/.*		<<none>>
>>  /var/tmp/vi\.recover	-d	gen_context(system_u:object_r:tmp_t,s0)
>> +/var/lib/abl(/.*)?		gen_context(system_u:object_r:var_auth_t,s0)
>> diff --exclude-from=exclude -N -u -r nsaserefpolicy/policy/modules/system/files.te serefpolicy-2.0.1/policy/modules/system/files.te
>> --- nsaserefpolicy/policy/modules/system/files.te	2005-11-14 18:24:06.000000000 -0500
>> +++ serefpolicy-2.0.1/policy/modules/system/files.te	2005-11-15 09:19:21.000000000 -0500
>> @@ -167,3 +167,12 @@
>>  #
>>  type var_spool_t;
>>  files_tmp_file(var_spool_t)
>> +
>> +#
>> +# var_auth_t is the type of /var/lib/auth, usually
>> +# used for auth data in pam_able
>> +#
>> +type var_auth_t, file_type;
>> +fs_associate(var_auth_t)
>> +fs_associate_noxattr(var_auth_t)
>>     
>
> A couple notes.  It seems more logical for var_auth_t to be in authlogin
> along with the rest of the pam types.  Also, if its not moved, then
> encapsulation is broken since an interface in authlogin refers to types
> not in that module.
>
>   
Ok fine
> I'll move var_auth_t to authlogin, but I'm not clear on the rules you
> added to auth_use_nsswitch():
>
>   
>> --- nsaserefpolicy/policy/modules/system/authlogin.if	2005-11-14 18:24:06.000000000 -0500
>> +++ serefpolicy-2.0.1/policy/modules/system/authlogin.if	2005-11-15 09:19:21.000000000 -0500
>> @@ -931,6 +931,9 @@
>>  	optional_policy(`samba.te',`
>>  		samba_connect_winbind($1)
>>  	')
>> +	allow $1 var_auth_t:dir r_dir_perms;
>> +	allow $1 var_auth_t:file create_file_perms;
>> +
>>  ')
>>  
>>  ########################################
>>     
>
> Is this really supposed to be create_file_perms?  It seems like it
> should just be r_file_perms since the dir access is r_dir_perms.  The
> interface also needs a gen_require() since it not explicitly refers to
> types.
>   
No apps need to be able to create and delete files in this directory.  
This pam applet keeps track
of failed logins or something like that.
> Also, now that people are going to be using refpolicy, we're going to
> have to start bumping the module versions in the policy_module()
> statements when changes are made, so that modules can be upgraded
> correctly.  Currently the modules are set to 1.0.  After a little
> thought, it seems like it would be better if we go to x.y.z for
> versioning: bump z for each changed module when committing to
> sourceforge; bump y for each changed module when releasing; bump x for
> major design changes to the module.  Does this seem like a reasonable
> versioning scheme?
>
>   
Yes.  Why not start out at 2.0.1 though since this is a major step 
forward in policy.

-- 



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
