Message-ID: <534D78B6.9070208@tycho.nsa.gov>
Date: Tue, 15 Apr 2014 14:21:42 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov,
 Eric Paris <eparis@redhat.com>, Daniel J Walsh <dwalsh@redhat.com>
Subject: Re: [PATCH] libsepol: Skip duplicate filename_trans rules in
 state->out policy.
References: <1397579252-1378-1-git-send-email-richard_c_haines@btinternet.com>
 <534D6117.4020506@tycho.nsa.gov>
In-Reply-To: <534D6117.4020506@tycho.nsa.gov>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/15/2014 12:40 PM, Stephen Smalley wrote:
> On 04/15/2014 12:27 PM, Richard Haines wrote:
>> The current detection of duplicate rules does not cover the state->out
>> policy and therefore will duplicate filename transition rules if already
>> present.
>>
>> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
>> ---
>>  libsepol/src/expand.c | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/libsepol/src/expand.c b/libsepol/src/expand.c
>> index acb6906..e908fdb 100644
>> --- a/libsepol/src/expand.c
>> +++ b/libsepol/src/expand.c
>> @@ -1534,6 +1534,20 @@ static int expand_filename_trans(expand_state_t *state, filename_trans_rule_t *r
>>  				if (cur_trans)
>>  					continue;
>>  
>> +				/* Now check if duplicate rule in state->out policy */
>> +				cur_trans = state->out->filename_trans;
>> +
>> +				while (cur_trans) {
>> +					if (cur_trans->stype == (i + 1) &&
>> +					    cur_trans->ttype == (j + 1) &&
>> +					    cur_trans->tclass == cur_rule->tclass &&
>> +					    !strcmp(cur_trans->name, cur_rule->name))
>> +						break;
>> +					cur_trans = cur_trans->next;
>> +				}
>> +				if (cur_trans)
>> +					continue;
>> +
>>  				new_trans = malloc(sizeof(*new_trans));
>>  				if (!new_trans) {
>>  					ERR(state->handle, "Out of memory!");
> 
> Isn't this effectively a revert of:
> 
> commit a29f6820c52b60b9028298cde9962dd140bbf9ea
> Author: Adam Tkac <atkac@redhat.com>
> Date:   Fri May 25 17:55:08 2012 +0200
> 
>     libsepol: filename_trans: use some better sorting to compare and merge
> 
> The kernel switched to using a hashtab for filename_trans rules in
> commit 2463c26d50adc282d19317013ba0ff473823ca47
> Author: Eric Paris <eparis@redhat.com>
> Date:   Thu Apr 28 15:11:21 2011 -0400
> 
>     SELinux: put name based create rules in a hashtable
> 
> Is there a reason we don't do this in libsepol too?

So if I am reading a29f68 correctly, it is completely wrong and should
just be reverted.  That will fix the duplicate filename transition rules
if I am not mistaken.  Then separately, we can look at bringing over the
switch to using a hashtab that was already done in the kernel and use
that to speed up this checking?  Comments?
