Subject: Re: [PATCH] libsemanage: genhomedircon: only set MLS level if MLS is
 enabled
To: Dominick Grift <dac.override@gmail.com>, selinux@tycho.nsa.gov
References: <1476466802-8500-1-git-send-email-sds@tycho.nsa.gov>
 <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <7b5816dd-cac1-64a2-692f-f2e29b7642e2@tycho.nsa.gov>
Date: Fri, 14 Oct 2016 14:59:59 -0400
MIME-Version: 1.0
In-Reply-To: <cdda0ea5-0753-05a4-69c4-b28ecf19e214@gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/14/2016 02:52 PM, Dominick Grift wrote:
> On 10/14/2016 07:40 PM, Stephen Smalley wrote:
>> When a non-MLS policy was used with genhomedircon
>> context_from_record() in sepol would report an error because an
>> MLS level was present when MLS is disabled.  Based on a patch by
>> Gary Tierney, amended to use sepol_policydb_mls_enabled rather
>> than semanage_mls_enabled because we are testing the temporary
>> working policy, not the active policy.
>> 
>> Reported-by: Jason Zaman <jason@perfinion.com> Signed-off-by:
>> Stephen Smalley <sds@tycho.nsa.gov> --- 
>> libsemanage/src/genhomedircon.c | 6 +++++- 1 file changed, 5
>> insertions(+), 1 deletion(-)
>> 
>> diff --git a/libsemanage/src/genhomedircon.c
>> b/libsemanage/src/genhomedircon.c index 6991fff..5e9d722 100644 
>> --- a/libsemanage/src/genhomedircon.c +++
>> b/libsemanage/src/genhomedircon.c @@ -638,7 +638,11 @@ static int
>> write_contexts(genhomedircon_settings_t *s, FILE *out, goto
>> fail; }
>> 
>> -		if (sepol_context_set_user(sepolh, context, user->sename) < 0
>> || +		if (sepol_context_set_user(sepolh, context, user->sename) <
>> 0) { +			goto fail; +		} + +		if
>> (sepol_policydb_mls_enabled(s->policydb) && 
>> sepol_context_set_mls(sepolh, context, user->level) < 0) { goto
>> fail; }
>> 
> 
> I could not get this to work:
> 
> libsemanage.validate_handler: seuser mapping [kcinimod ->
> (wheel.id, s0-s0:c0.c1023)] is invalid (No such file or
> directory). libsemanage.dbase_llist_iterate: could not iterate over
> records (No such file or directory) semodule: failed!

I don't see what that error has to do with the patch in question.
Is this a separate problem with using non-MLS policies?
