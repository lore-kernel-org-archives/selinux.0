Subject: Re: [PATCH] libsemanage: save homedir_template in the policy store
 for genhomedircon
To: Stephen Smalley <sds@tycho.nsa.gov>, SELinux List <selinux@tycho.nsa.gov>
References: <1441293481-13903-1-git-send-email-slawrence@tresys.com>
 <55E86698.1090900@tycho.nsa.gov>
From: Steve Lawrence <slawrence@tresys.com>
Message-ID: <55E87BFC.7070607@tresys.com>
Date: Thu, 3 Sep 2015 12:57:32 -0400
MIME-Version: 1.0
In-Reply-To: <55E86698.1090900@tycho.nsa.gov>
Content-Type: text/plain; charset="windows-1252"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/03/2015 11:26 AM, Stephen Smalley wrote:
> On 09/03/2015 11:18 AM, Steve Lawrence wrote:
>> We don't currently store homedir_template in the policy store, which
>> means genhomedircon only has a template file to use if the
>> homedir_template was generated from the file contexts in the same
>> transaction.  But homedir_template isn't always generated, as in the
>> case with setsebool -P. In this and other cases, genhomedircon will not
>> have a template file resulting in an empty file_contexts.homedir file.
>>
>> This commit changes this so that homedir_template is always stored in
>> the policy store so it can be used by genhomedircon regardless of how
>> policy was built. Also add the homedir_template file to the migration
>> script.
>>
>> Signed-off by: Steve Lawrence <slawrence@tresys.com>
> 
> Only question I have is whether either of the other two files that are
> being unlinked below need to be kept around for the same reason?  Or are
> they always generated, even upon setsebool -P?
> 

FC_TMPL is only in one place when splitting file contexts into
file_contexts and and homedir_template. So that's fine to not keep in
the store.

USERS_EXTRA does actually need to be kept around, since it appears to be
used to genhomedircon, which won't always occur before a policy rebuild.
I'll submit another patch shortly.

> Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>
> 
>> ---
>>  libsemanage/src/direct_api.c             | 1 -
>>  libsemanage/utils/semanage_migrate_store | 3 ++-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index 90a7b22..6e49cae 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -1415,7 +1415,6 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>  
>>  	/* remove files that are automatically generated and no longer needed */
>>  	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_FC_TMPL));
>> -	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_HOMEDIR_TMPL));
>>  	unlink(semanage_path(SEMANAGE_TMP, SEMANAGE_USERS_EXTRA));
>>  
>>  	if (sh->do_rebuild || modified || bools_modified || fcontexts_modified) {
>> diff --git a/libsemanage/utils/semanage_migrate_store b/libsemanage/utils/semanage_migrate_store
>> index 539f469..297c71b 100755
>> --- a/libsemanage/utils/semanage_migrate_store
>> +++ b/libsemanage/utils/semanage_migrate_store
>> @@ -251,7 +251,8 @@ if __name__ == "__main__":
>>  		"disable_dontaudit",
>>  		"preserve_tunables",
>>  		"policy.kern",
>> -		"file_contexts"]
>> +		"file_contexts",
>> +		"homedir_template"]
>>  
>>  
>>  	create_dir(newroot_path(), 0o755)
>>
> 
