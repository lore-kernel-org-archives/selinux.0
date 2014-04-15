Message-ID: <534D7E9C.2020207@tycho.nsa.gov>
Date: Tue, 15 Apr 2014 14:46:52 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] libsepol: Skip duplicate filename_trans rules in
 state->out policy.
References: <1397579252-1378-1-git-send-email-richard_c_haines@btinternet.com>		
 <534D6117.4020506@tycho.nsa.gov> <534D78B6.9070208@tycho.nsa.gov>	
 <1397586465.2471.2.camel@flatline.rdu.redhat.com>	
 <534D7BA4.2040705@tycho.nsa.gov>
 <1397587423.2471.4.camel@flatline.rdu.redhat.com>
In-Reply-To: <1397587423.2471.4.camel@flatline.rdu.redhat.com>
Content-Type: text/plain; charset=UTF-8
Cc: selinux@tycho.nsa.gov
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/15/2014 02:43 PM, Eric Paris wrote:
> On Tue, 2014-04-15 at 14:34 -0400, Stephen Smalley wrote:
>> On 04/15/2014 02:27 PM, Eric Paris wrote:
>>> On Tue, 2014-04-15 at 14:21 -0400, Stephen Smalley wrote:
>>>> On 04/15/2014 12:40 PM, Stephen Smalley wrote:
>>>>> On 04/15/2014 12:27 PM, Richard Haines wrote:
>>>>>> The current detection of duplicate rules does not cover the state->out
>>>>>> policy and therefore will duplicate filename transition rules if already
>>>>>> present.
>>>>>>
>>>>>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>>>>>> ---
>>>>>>  libsepol/src/expand.c | 14 ++++++++++++++
>>>>>>  1 file changed, 14 insertions(+)
>>>>>>
>>>>>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>>>>>> index acb6906..e908fdb 100644
>>>>>> --- a/libsepol/src/expand.c
>>>>>> +++ b/libsepol/src/expand.c
>>>>>> @@ -1534,6 +1534,20 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
>>>>>>  				if (cur_trans)
>>>>>>  					continue;
>>>>>>  
>>>>>> +				/* Now check if duplicate rule in state->out policy */
>>>>>> +				cur_trans = state->out->filename_trans;
>>>>>> +
>>>>>> +				while (cur_trans) {
>>>>>> +					if (cur_trans->stype == (i + 1) &&
>>>>>> +					    cur_trans->ttype == (j + 1) &&
>>>>>> +					    cur_trans->tclass == cur_rule->tclass &&
>>>>>> +					    !strcmp(cur_trans->name, cur_rule->name))
>>>>>> +						break;
>>>>>> +					cur_trans = cur_trans->next;
>>>>>> +				}
>>>>>> +				if (cur_trans)
>>>>>> +					continue;
>>>>>> +
>>>>>>  				new_trans = malloc(sizeof(*new_trans));
>>>>>>  				if (!new_trans) {
>>>>>>  					ERR(state->handle, "Out of memory!");
>>>>>
>>>>> Isn't this effectively a revert of:
>>>>>
>>>>> commit a29f6820c52b60b9028298cde9962dd140bbf9ea
>>>>> Author: Adam Tkac <atkac@redhat.com>
>>>>> Date:   Fri May 25 17:55:08 2012 +0200
>>>>>
>>>>>     libsepol: filename_trans: use some better sorting to compare and merge
>>>>>
>>>>> The kernel switched to using a hashtab for filename_trans rules in
>>>>> commit 2463c26d50adc282d19317013ba0ff473823ca47
>>>>> Author: Eric Paris <eparis@redhat.com>
>>>>> Date:   Thu Apr 28 15:11:21 2011 -0400
>>>>>
>>>>>     SELinux: put name based create rules in a hashtable
>>>>>
>>>>> Is there a reason we don't do this in libsepol too?
>>>>
>>>> So if I am reading a29f68 correctly, it is completely wrong and should
>>>> just be reverted.  That will fix the duplicate filename transition rules
>>>> if I am not mistaken.  Then separately, we can look at bringing over the
>>>> switch to using a hashtab that was already done in the kernel and use
>>>> that to speed up this checking?  Comments?
>>>
>>> I think that's a good idea.  The kernel hashtab and this 'fix' were done
>>> about the same time.  I intended to bring the kernel hashtab over and
>>> got distracted and then forgot about it...
>>>
>>> Shouldn't be a hard thing, and I believe should get us back to having
>>> bitwise the same policy in /sys/fs/selinux/policy as we have on disk...
>>
>> Looks like we have some other areas of divergence, e.g. range_tr hashtab
>> conversion, ebitmap optimizations, possibly others.  The latter would
>> require a policy binary format change (new version) to make it fully
>> identical.
>>
>> Not sure how well even the hashtab is doing at this point as Fedora has
>>> 150,000 file name transition rules in its policy per sedispol output?
>>  That seems a bit excessive.
> 
> My understanding is that MANY of these are because of the expansion of
> attributes in the source and the parent object.  If we could leave these
> as attributes it would shrink things and incredible amount...

I have to question how many of those rules are truly needed.  But with
regard to enabling attribute usage in file name transition rules, I'd
think we'd first need to introduce an avc_transition_sid() interface and
cache security_transition_sid() results in the AVC since
security_transition_sid() will become more costly.  We already do that
in the userspace AVC, see avc_compute_create().
