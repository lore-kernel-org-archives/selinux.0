Message-ID: <4783E1A2.6020101@manicmethod.com>
Date: Tue, 08 Jan 2008 15:48:34 -0500
From: Joshua Brindle <method@manicmethod.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: SE Linux <selinux@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: Re: role dominance
References: <47824819.9040006@manicmethod.com> <1199728427.2944.167.camel@moss-spartans.epoch.ncsc.mil> <47826F37.9030003@manicmethod.com>
In-Reply-To: <47826F37.9030003@manicmethod.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Joshua Brindle wrote:
> Stephen Smalley wrote:
>> On Mon, 2008-01-07 at 10:41 -0500, Joshua Brindle wrote:
>>  
>>> While working on policyrep we've found that role dominance is pretty 
>>> difficult to implement correctly, and apparently there is some 
>>> ambiguity about how it works. The main problem we are running into 
>>> now is that converting the role bitmaps of an old module 
>>> (compatibility) back to a role dominance statement is very difficult.
>>>     
>>
>> And likely unnecessary.  It isn't required that a conversion yield the
>> same source representation, but only that it yield the same end result
>> when you ultimately generate a kernel binary policy.  Or are you saying
>> that you can't even do the latter?
>>
>>   
>
> The latter is possible.
>
>>> Also it seems like noone has really used role dominance. During 
>>> conversations about it here Chris PeBenito suggests that he wants 
>>> something like it for refpolicy but a role attribute kind of system 
>>> may be much simpler and easier to implement/understand.
>>>
>>> Thoughts?
>>>     
>>
>> Any language feature that isn't actually being used should probably be
>> deprecated.
>>   
>
> I vote for deprecation in the current compiler and no implementation 
> in policyrep. If we want to add role attribute that would be fine too. 
> Chris wants some way to group roles and I never really thought role 
> dominance was the right way to do it.
>

Patch below to deprecate role dominance. I think we should throw a 
warning in policyrep if we see anything in the dominates field of the 
role datum and continue without support. Chris suggests that he'd like 
role attributes so we can put that on the todo list to implement.

Index: checkpolicy/policy_parse.y
===================================================================
--- checkpolicy/policy_parse.y  (revision 2725)
+++ checkpolicy/policy_parse.y  (working copy)
@@ -2563,6 +2563,8 @@
                return (role_datum_t *) 1;      /* any non-NULL value */
        }
 
+       yywarn("Role dominance has been deprecated");
+
        role_id = queue_remove(id_queue);
        if (!is_id_in_scope(SYM_ROLES, role_id)) {
                yyerror2("role %s is not within scope", role_id);



--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
