Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v91Fi6h6006196
 for <selinux@tycho.nsa.gov>; Sun, 1 Oct 2017 11:44:07 -0400
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
References: <20170927081645.32481-1-vmojzis@redhat.com>
 <20170927081645.32481-2-vmojzis@redhat.com>
 <CAFftDdr5xUm8GyrucqvdETeunPHFRKqECZiEiNkcJWcxzrZtrw@mail.gmail.com>
From: Vit Mojzis <vmojzis@redhat.com>
Message-ID: <47d1c544-0d6a-1160-277b-021123195178@redhat.com>
Date: Sun, 1 Oct 2017 17:43:33 +0200
MIME-Version: 1.0
In-Reply-To: <CAFftDdr5xUm8GyrucqvdETeunPHFRKqECZiEiNkcJWcxzrZtrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 1/2] libsemanage: Add support for listing
 fcontext.homedirs file
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



On 27.9.2017 19:04, William Roberts wrote:
> 2017-09-27 1:16 GMT-07:00 Vit Mojzis <vmojzis@redhat.com>:
>> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1409813
>> ---
>>   libsemanage/include/semanage/fcontexts_policy.h |  4 ++++
>>   libsemanage/src/direct_api.c                    |  6 ++++++
>>   libsemanage/src/fcontexts_policy.c              |  8 ++++++++
>>   libsemanage/src/handle.h                        | 19 +++++++++++++------
>>   4 files changed, 31 insertions(+), 6 deletions(-)
>>
>> diff --git a/libsemanage/include/semanage/fcontexts_policy.h b/libsemanage/include/semanage/fcontexts_policy.h
>> index a50db2b..199a1e1 100644
>> --- a/libsemanage/include/semanage/fcontexts_policy.h
>> +++ b/libsemanage/include/semanage/fcontexts_policy.h
>> @@ -26,4 +26,8 @@ extern int semanage_fcontext_list(semanage_handle_t * handle,
>>                                    semanage_fcontext_t *** records,
>>                                    unsigned int *count);
>>
>> +extern int semanage_fcontext_list_homedirs(semanage_handle_t * handle,
>> +                                 semanage_fcontext_t *** records,
>> +                                 unsigned int *count);
>> +
>>   #endif
>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>> index 65842df..886a228 100644
>> --- a/libsemanage/src/direct_api.c
>> +++ b/libsemanage/src/direct_api.c
>> @@ -210,6 +210,12 @@ int semanage_direct_connect(semanage_handle_t * sh)
>>                                       semanage_fcontext_dbase_local(sh)) < 0)
>>                  goto err;
>>
>> +       if (fcontext_file_dbase_init(sh,
>> +                                    selinux_file_context_homedir_path(),
>> +                                    selinux_file_context_homedir_path(),
>> +                                    semanage_fcontext_dbase_homedirs(sh)) < 0)
>> +               goto err;
>> +
>>          if (seuser_file_dbase_init(sh,
>>                                     semanage_path(SEMANAGE_ACTIVE,
>>                                                   SEMANAGE_SEUSERS_LOCAL),
>> diff --git a/libsemanage/src/fcontexts_policy.c b/libsemanage/src/fcontexts_policy.c
>> index 0b063b1..98490ab 100644
>> --- a/libsemanage/src/fcontexts_policy.c
>> +++ b/libsemanage/src/fcontexts_policy.c
>> @@ -51,3 +51,11 @@ int semanage_fcontext_list(semanage_handle_t * handle,
>>          dbase_config_t *dconfig = semanage_fcontext_dbase_policy(handle);
>>          return dbase_list(handle, dconfig, records, count);
>>   }
>> +
>> +int semanage_fcontext_list_homedirs(semanage_handle_t * handle,
>> +                          semanage_fcontext_t *** records, unsigned int *count)
>> +{
>> +
>> +       dbase_config_t *dconfig = semanage_fcontext_dbase_homedirs(handle);
>> +       return dbase_list(handle, dconfig, records, count);
>> +}
>> diff --git a/libsemanage/src/handle.h b/libsemanage/src/handle.h
>> index 889871d..1780ac8 100644
>> --- a/libsemanage/src/handle.h
>> +++ b/libsemanage/src/handle.h
>> @@ -79,7 +79,7 @@ struct semanage_handle {
>>          struct semanage_policy_table *funcs;
>>
>>          /* Object databases */
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
> Any particular reason to reassign all these defines instead
> of just setting DBASE_POLICY_FCONTEXTS_H to 22 and
> setting DBASE_ACTIVE_BOOLEANS to 23 other than just
> to have DBASE_POLICY_FCONTEXTS_H follow
> DBASE_POLICY_FCONTEXTS?
Nope, just to keep organized .
Should I set it to 22 instead?
>
> I'm also assuming, after looking at the code, that the database
> itself is built every time so versioning mismatches are not a worry.
>
>>          dbase_config_t dbase[DBASE_COUNT];
>>   };
>>
>> @@ -236,6 +237,12 @@ static inline
>>   }
>>
>>   static inline
>> +    dbase_config_t * semanage_fcontext_dbase_homedirs(semanage_handle_t * handle)
>> +{
>> +       return &handle->dbase[DBASE_POLICY_FCONTEXTS_H];
>> +}
>> +
>> +static inline
>>       dbase_config_t * semanage_seuser_dbase_policy(semanage_handle_t * handle)
>>   {
>>          return &handle->dbase[DBASE_POLICY_SEUSERS];
>> --
>> 2.9.4
>>
>>
>
>
