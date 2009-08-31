Received: from msux-gh1-uea01.nsa.gov (msux-gh1-uea01.nsa.gov [63.239.67.1])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id n7VE2WX8015546
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 10:02:32 -0400
Received: from mx1.redhat.com (localhost [127.0.0.1])
	by msux-gh1-uea01.nsa.gov (8.12.10/8.12.10) with ESMTP id n7VE1tXG003492
	for <selinux@tycho.nsa.gov>; Mon, 31 Aug 2009 14:01:55 GMT
Message-ID: <4A9BD7F3.8090709@redhat.com>
Date: Mon, 31 Aug 2009 10:02:27 -0400
From: Daniel J Walsh <dwalsh@redhat.com>
MIME-Version: 1.0
To: Shintaro Fujiwara <shintaro.fujiwara@gmail.com>
CC: Chad Sellers <csellers@tresys.com>, method@manicmethod.com,
        selinux <selinux@tycho.nsa.gov>
Subject: Re: [PATCH] Fix semanage_direct_commit() to notice disable_dontaudit
References: <1250792957-20920-1-git-send-email-csellers@tresys.com>	 <f71a82820908310522o779d0caaq2798a99e5f5543e5@mail.gmail.com>	 <4A9BC252.7020803@redhat.com> <f71a82820908310602u35fdedb3n88de450de4894b02@mail.gmail.com>
In-Reply-To: <f71a82820908310602u35fdedb3n88de450de4894b02@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On 08/31/2009 09:02 AM, Shintaro Fujiwara wrote:
> Well, in F11 I typed,
> 
> seinfo --permissive but got an error...
> 
> I basically understand that I should take care of permissive module, though.
> 
>
Yes this is in Rawhide/F12
 
> 
> 2009/8/31 Daniel J Walsh <dwalsh@redhat.com>:
>> On 08/31/2009 08:22 AM, Shintaro Fujiwara wrote:
>>> Thanks digging in topic that I pinted some time ago.
>>>
>>> Why don't you fix semodule to notice which module has permissive.
>>>
>>> I notice administrators in my program, i.e. segatex, when listing
>>> modules, list permissive modules.
>>>
>>> We tend to forget after we set some module permissive and it's quite
>>> convenient to set permissive when we get certain denied messages, but
>>> it's sad when we forgot we set certain module permissive.
>>>
>>> So, I think it's better to let administrators know which module has
>>> permissive module now when he typed "semodule -l ".
>>>
>>> Can anybody fix semodule to echo permissive module at the top and
>>> still echo list ?
>>>
>>>
>>> 2009/8/21 Chad Sellers <csellers@tresys.com>:
>>>> Add code to semanage_direct_commit() to notice that the disable_dontaudit
>>>> flag has been changed and rebuild the policy if so.
>>>>
>>>> Currently, libsemanage doesn't notice that the disable_dontaudit flag is
>>>> set so it does not rebuild the policy. semodule got around this by calling
>>>> semanage_set_rebuild() explicitly, but libsemanage should really notice
>>>> that this has changed and rebuild appropriately.
>>>> ---
>>>>  libsemanage/src/direct_api.c |    7 ++++++-
>>>>  1 files changed, 6 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
>>>> index d563841..0eab399 100644
>>>> --- a/libsemanage/src/direct_api.c
>>>> +++ b/libsemanage/src/direct_api.c
>>>> @@ -675,7 +675,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>>>
>>>>        /* Declare some variables */
>>>>        int modified = 0, fcontexts_modified, ports_modified,
>>>> -           seusers_modified, users_extra_modified;
>>>> +           seusers_modified, users_extra_modified, dontaudit_modified;
>>>>        dbase_config_t *users = semanage_user_dbase_local(sh);
>>>>        dbase_config_t *users_base = semanage_user_base_dbase_local(sh);
>>>>        dbase_config_t *pusers_base = semanage_user_base_dbase_policy(sh);
>>>> @@ -694,6 +694,10 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>>>
>>>>        /* Create or remove the disable_dontaudit flag file. */
>>>>        path = semanage_path(SEMANAGE_TMP, SEMANAGE_DISABLE_DONTAUDIT);
>>>> +       if (access(path, F_OK) == 0)
>>>> +               dontaudit_modified = !(sepol_get_disable_dontaudit(sh->sepolh) == 1);
>>>> +       else
>>>> +               dontaudit_modified = (sepol_get_disable_dontaudit(sh->sepolh) == 1);
>>>>        if (sepol_get_disable_dontaudit(sh->sepolh) == 1) {
>>>>                FILE *touch;
>>>>                touch = fopen(path, "w");
>>>> @@ -734,6 +738,7 @@ static int semanage_direct_commit(semanage_handle_t * sh)
>>>>        modified |= bools->dtable->is_modified(bools->dbase);
>>>>        modified |= ifaces->dtable->is_modified(ifaces->dbase);
>>>>        modified |= nodes->dtable->is_modified(nodes->dbase);
>>>> +       modified |= dontaudit_modified;
>>>>
>>>>        /* If there were policy changes, or explicitly requested, rebuild the policy */
>>>>        if (sh->do_rebuild || modified) {
>>>> --
>>>> 1.6.2.5
>>>>
>>>>
>>>> --
>>>> This message was distributed to subscribers of the selinux mailing list.
>>>> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
>>>> the words "unsubscribe selinux" without quotes as the message.
>>>>
>>>
>>>
>>>
>> seinfo --permissive
>>
>> Will do this.
>>
> 
> 
> 


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
