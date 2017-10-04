Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v94F9MZC005077
 for <selinux@tycho.nsa.gov>; Wed, 4 Oct 2017 11:09:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A3684C04AC74
 for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2017 14:54:59 +0000 (UTC)
Received: from [10.40.205.103] (unknown [10.40.205.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2F595D9CD
 for <selinux@tycho.nsa.gov>; Wed,  4 Oct 2017 14:54:58 +0000 (UTC)
To: selinux@tycho.nsa.gov
References: <1506971246.23398.11.camel@tycho.nsa.gov>
 <20171003095737.9027-1-vmojzis@redhat.com>
 <1507126077.1491.2.camel@tycho.ncsc.mil>
From: Vit Mojzis <vmojzis@redhat.com>
Message-ID: <1dcea489-7584-e7a3-aa50-99a974440734@redhat.com>
Date: Wed, 4 Oct 2017 16:54:57 +0200
MIME-Version: 1.0
In-Reply-To: <1507126077.1491.2.camel@tycho.ncsc.mil>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH] libsemanage: Add support for listing
 fcontext.homedirs file
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 4.10.2017 16:07, Stephen Smalley wrote:
> On Tue, 2017-10-03 at 11:57 +0200, Vit Mojzis wrote:
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813
> These all look good to me now.  Could you please re-post them all with
> Signed-off-by: lines, and then we'll merge them in a couple of days
> barring any other concerns?

Sure. Thank you, I appreciate your help.

>
>> ---
>>   libsemanage/include/semanage/fcontexts_policy.h |  4 ++++
>>   libsemanage/src/direct_api.c                    |  7 +++++++
>>   libsemanage/src/fcontexts_policy.c              |  8 ++++++++
>>   libsemanage/src/handle.h                        | 19 +++++++++++++
>> ------
>>   4 files changed, 32 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsemanage/include/semanage/fcontexts_policy.h
>> b/libsemanage/include/semanage/fcontexts_policy.h
>> index a50db2b..199a1e1 100644
>> --- a/libsemanage/include/semanage/fcontexts_policy.h
>> +++ b/libsemanage/include/semanage/fcontexts_policy.h
>> @@ -26,4 +26,8 @@ extern int semanage_fcontext_list(semanage_handle_t
>> * handle,
>>   				  semanage_fcontext_t *** records,
>>   				  unsigned int *count);
>>   
>> +extern int semanage_fcontext_list_homedirs(semanage_handle_t *
>> handle,
>> +				  semanage_fcontext_t *** records,
>> +				  unsigned int *count);
>> +
>>   #endif
>> diff --git a/libsemanage/src/direct_api.c
>> b/libsemanage/src/direct_api.c
>> index 971a08f..00ad820 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -210,6 +210,12 @@ int semanage_direct_connect(semanage_handle_t *
>> sh)
>>   				     semanage_fcontext_dbase_local(s
>> h)) < 0)
>>   		goto err;
>>   
>> +	if (fcontext_file_dbase_init(sh,
>> +				     semanage_path(SEMANAGE_ACTIVE,
>> SEMANAGE_STORE_FC_HOMEDIRS),
>> +				     semanage_path(SEMANAGE_TMP,
>> SEMANAGE_STORE_FC_HOMEDIRS),
>> +				     semanage_fcontext_dbase_homedir
>> s(sh)) < 0)
>> +		goto err;
>> +
>>   	if (seuser_file_dbase_init(sh,
>>   				   semanage_path(SEMANAGE_ACTIVE,
>>   						 SEMANAGE_SEUSERS_LO
>> CAL),
>> @@ -349,6 +355,7 @@ static int
>> semanage_direct_disconnect(semanage_handle_t * sh)
>>   	iface_file_dbase_release(semanage_iface_dbase_local(sh));
>>   	bool_file_dbase_release(semanage_bool_dbase_local(sh));
>>   	fcontext_file_dbase_release(semanage_fcontext_dbase_local(sh
>> ));
>> +	fcontext_file_dbase_release(semanage_fcontext_dbase_homedirs
>> (sh));
>>   	seuser_file_dbase_release(semanage_seuser_dbase_local(sh));
>>   	node_file_dbase_release(semanage_node_dbase_local(sh));
>>   
>> diff --git a/libsemanage/src/fcontexts_policy.c
>> b/libsemanage/src/fcontexts_policy.c
>> index 0b063b1..98490ab 100644
>> --- a/libsemanage/src/fcontexts_policy.c
>> +++ b/libsemanage/src/fcontexts_policy.c
>> @@ -51,3 +51,11 @@ int semanage_fcontext_list(semanage_handle_t *
>> handle,
>>   	dbase_config_t *dconfig =
>> semanage_fcontext_dbase_policy(handle);
>>   	return dbase_list(handle, dconfig, records, count);
>>   }
>> +
>> +int semanage_fcontext_list_homedirs(semanage_handle_t * handle,
>> +			   semanage_fcontext_t *** records, unsigned
>> int *count)
>> +{
>> +
>> +	dbase_config_t *dconfig =
>> semanage_fcontext_dbase_homedirs(handle);
>> +	return dbase_list(handle, dconfig, records, count);
>> +}
>> diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
>> index 889871d..1780ac8 100644
>> --- a/libsemanage/src/handle.h
>> +++ b/libsemanage/src/handle.h
>> @@ -79,7 +79,7 @@ struct semanage_handle {
>>   	struct semanage_policy_table *funcs;
>>   
>>   	/* Object databases */
>> -#define DBASE_COUNT      23
>> +#define DBASE_COUNT      24
>>   
>>   /* Local modifications */
>>   #define DBASE_LOCAL_USERS_BASE  0
>> @@ -102,13 +102,14 @@ struct semanage_handle {
>>   #define DBASE_POLICY_INTERFACES  15
>>   #define DBASE_POLICY_BOOLEANS    16
>>   #define DBASE_POLICY_FCONTEXTS   17
>> -#define DBASE_POLICY_SEUSERS     18
>> -#define DBASE_POLICY_NODES       19
>> -#define DBASE_POLICY_IBPKEYS     20
>> -#define DBASE_POLICY_IBENDPORTS  21
>> +#define DBASE_POLICY_FCONTEXTS_H 18
>> +#define DBASE_POLICY_SEUSERS     19
>> +#define DBASE_POLICY_NODES       20
>> +#define DBASE_POLICY_IBPKEYS     21
>> +#define DBASE_POLICY_IBENDPORTS  22
>>   
>>   /* Active kernel policy */
>> -#define DBASE_ACTIVE_BOOLEANS    22
>> +#define DBASE_ACTIVE_BOOLEANS    23
>>   	dbase_config_t dbase[DBASE_COUNT];
>>   };
>>   
>> @@ -236,6 +237,12 @@ static inline
>>   }
>>   
>>   static inline
>> +    dbase_config_t *
>> semanage_fcontext_dbase_homedirs(semanage_handle_t * handle)
>> +{
>> +	return &handle->dbase[DBASE_POLICY_FCONTEXTS_H];
>> +}
>> +
>> +static inline
>>       dbase_config_t * semanage_seuser_dbase_policy(semanage_handle_t
>> * handle)
>>   {
>>   	return &handle->dbase[DBASE_POLICY_SEUSERS];
