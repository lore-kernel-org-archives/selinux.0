Message-ID: <52F24625.5000005@tycho.nsa.gov>
Date: Wed, 05 Feb 2014 09:09:41 -0500
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Eric Paris <eparis@parisplace.org>,
 Casey Schaufler <casey@schaufler-ca.com>
Subject: Re: SELinux question..
References: <CA+55aFyaBZsF7u+Ka=0PRXQyF-vPyejgysoLsPAZdyf6Qn1KdA@mail.gmail.com>	<52F17412.3010105@schaufler-ca.com>
 <CACLa4pvZXRBSOXGnvcfnMWc-ZxcFwZQDjy7gfSDKWCeXiNCJxQ@mail.gmail.com>
In-Reply-To: <CACLa4pvZXRBSOXGnvcfnMWc-ZxcFwZQDjy7gfSDKWCeXiNCJxQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: LSM List <linux-security-module@vger.kernel.org>,
 SELinux <selinux@tycho.nsa.gov>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 James Morris <james.l.morris@oracle.com>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/05/2014 07:52 AM, Eric Paris wrote:
> So Casey's comments don't actually make any sense to me at all.  The
> AVC is just a cache of previous results of policy lookups.  The policy
> is fscking huge and looking up a permission takes forever.  that's a
> given, not much we can do about that part.  Now how well SELinux
> caches those results can certainly possibly be looked at....
> 
> I certainly have no objection to using a u64 for ssid and tsid.
> 
> Paul more and I sorta talked and debated about pushing tclass into the
> same u64.  tclass can easily fit in 8 bits (we could fit in 7, but
> that doesn't really do anything).  So
> 
> struct ssid_tsid_tclass {
>       u64 ssid:28, tsid:28, tclass:8;
> );
> 
> It's clearly doable, and we won't *cough* have any trouble today.
> Sids are created sequentially.  You get one sid per unique context.
> It's 'possible' to already overrid the u32 (and you'll start getting
> ENOMEM to all sorts of things if you do)  Paul is particularly worried
> that when/if we run up on the new 268M unique sids (2^28) someday,
> years down the line, you/users/people are going to scream and scream
> when we want those couple of bits back.  We'd need to remove tclass
> from the u64.  Personally I'm ok with that.  I'd rather not pay a
> performance penalty today for what we think will be a problem someday
> down the road...
> 
> Maybe I can try to prototype something.  What patch did you use?  What
> type of performance gains were you able to note?  How did you get your
> perf data?

(cc selinux list)

The greatest use of unique security contexts (and thus SIDs) will be in
setups making extensive use of the SELinux MLS/MCS category sets, as we
typically define 1024 categories in policy (and more are possible) and
they are sets, not just a single value.  So users with MLS policies,
users making extensive use of svirt, openshift, or any other user of MCS
under targeted policy, etc.

If you shrink tclass in the AVC, don't do it in the security server, as
the security policy may include userspace security classes checked via
/sys/fs/selinux/access but the kernel AVC will only ever hold kernel
class indices.

> 
> -Eric
> 
> On Tue, Feb 4, 2014 at 6:13 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>> On 2/4/2014 2:37 PM, Linus Torvalds wrote:
>>> I'm looking at profiles once more, and (once more) being annoying by
>>> SELinux overheads..
>>>
>>> One thing strikes me: does the ssid/tsid space need to be a full 32
>>> bit? Right now the indexing is done by <ssid,tsid,tclass>, and that's
>>> a <u32,u32,u16> tuple..
>>>
>>> I actually improved code generation on x86-64 noticeably by encoding
>>> the ssid+tsid in one 64-bit register, which lowers register pressure
>>> (no frame accesses in avc_has_perm_noaudit()) and makes the avc lookup
>>> more efficient. But it would be even better if the whole tuple could
>>> be encoded that way, ie the 'struct avc_entry' could have just one
>>> 64-bit field that contains <ssid,tsid,tclass>.
>>>
>>> It could easily be a structure with basically arbitrary bit boundaries, so
>>>
>>>    struct ssid_tsid_tclass {
>>>       u64 ssid:24, tsid:24, tclass:16;
>>>    );
>>>
>>> would work fine. Or 25/25/14. Or whatever. The high bits of ssid/tsid
>>> don't *seem* to be used in normal setups, but I don't actually know
>>> what the rules are for these things. Do they need to be the full 32
>>> bits? Does tclass need to be 16 bits? Is there some 64-bit packing
>>> that could work?
>>>
>>> (Ok, so the big cost is actually all the cache misses in avc_lookup(),
>>> and it would be a really big deal if there was some way to perhaps
>>> short-circuit that entirely for the case of "user does directory
>>> lookup permission check for a directory inode". If somebody has a way
>>> to do *that* with SELinux, that would be lovely)
>>
>> There is no reason that SELinux couldn't use security blob
>> pointers for filesystem objects and tasks instead of avc lookups.
>> The only places that really need secids are in networking code
>> where security has been begrudgenly granted 32 bits and admonished
>> never to come asking for more. If a pointer were available instead
>> (and Paul Moore has proposed more than one way to do that, at least
>> one of which provided superior cache performance over the existing
>> code) the avc could go away altogether.
>>
>> There are reasons that some developers like the avc mechanism.
>> I will leave the arguments in its favor to them.
>>
>>> .
>>>
>>>                  Linus
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
