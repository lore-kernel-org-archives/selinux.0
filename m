From: Victor Porton <porton@narod.ru>
To: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <52F24625.5000005@tycho.nsa.gov>
References: <CA+55aFyaBZsF7u+Ka=0PRXQyF-vPyejgysoLsPAZdyf6Qn1KdA@mail.gmail.com>	<52F17412.3010105@schaufler-ca.com>
 <CACLa4pvZXRBSOXGnvcfnMWc-ZxcFwZQDjy7gfSDKWCeXiNCJxQ@mail.gmail.com>
 <52F24625.5000005@tycho.nsa.gov>
Subject: Re: SELinux question..
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Message-Id: <10921391611264@web22m.yandex.ru>
Date: Wed, 05 Feb 2014 16:41:04 +0200
Cc: LSM List <linux-security-module@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 James Morris <james.l.morris@oracle.com>, SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

MCS also has a use in sandboxing:

http://portonsoft.wordpress.com/2014/01/11/toward-robust-linux-sandbox/

By the way, it would help if you allow more than 1024 categories.

It is a good idea to build a category from the process ID of the calling program.

It can nevertheless be done with the current kernel assigning SEVERAL categories to MCS, having the list of categories determined by the process ID. But calculating several categories from one process ID is silly.

If I'd take the decision, I would allow any (possibly 64 bit) number as a category in MCS. Thus we would just pass process ID to SELinux when programming the sandbox.

P.S. Debian yet does not work well with enforcing SELinux. For this reason I have lied aside my project related with sandboxing for an indefinite time (until SELinux will work with my Debian).

05.02.2014, 16:19, "Stephen Smalley" <sds@tycho.nsa.gov>:
> On 02/05/2014 07:52 AM, Eric Paris wrote:
>
>> šSo Casey's comments don't actually make any sense to me at all. šThe
>> šAVC is just a cache of previous results of policy lookups. šThe policy
>> šis fscking huge and looking up a permission takes forever. šthat's a
>> šgiven, not much we can do about that part. šNow how well SELinux
>> šcaches those results can certainly possibly be looked at....
>>
>> šI certainly have no objection to using a u64 for ssid and tsid.
>>
>> šPaul more and I sorta talked and debated about pushing tclass into the
>> šsame u64. štclass can easily fit in 8 bits (we could fit in 7, but
>> šthat doesn't really do anything). šSo
>>
>> šstruct ssid_tsid_tclass {
>> šššššššu64 ssid:28, tsid:28, tclass:8;
>> š);
>>
>> šIt's clearly doable, and we won't *cough* have any trouble today.
>> šSids are created sequentially. šYou get one sid per unique context.
>> šIt's 'possible' to already overrid the u32 (and you'll start getting
>> šENOMEM to all sorts of things if you do) šPaul is particularly worried
>> šthat when/if we run up on the new 268M unique sids (2^28) someday,
>> šyears down the line, you/users/people are going to scream and scream
>> šwhen we want those couple of bits back. šWe'd need to remove tclass
>> šfrom the u64. šPersonally I'm ok with that. šI'd rather not pay a
>> šperformance penalty today for what we think will be a problem someday
>> šdown the road...
>>
>> šMaybe I can try to prototype something. šWhat patch did you use? šWhat
>> štype of performance gains were you able to note? šHow did you get your
>> šperf data?
>
> (cc selinux list)
>
> The greatest use of unique security contexts (and thus SIDs) will be in
> setups making extensive use of the SELinux MLS/MCS category sets, as we
> typically define 1024 categories in policy (and more are possible) and
> they are sets, not just a single value. šSo users with MLS policies,
> users making extensive use of svirt, openshift, or any other user of MCS
> under targeted policy, etc.
>
> If you shrink tclass in the AVC, don't do it in the security server, as
> the security policy may include userspace security classes checked via
> /sys/fs/selinux/access but the kernel AVC will only ever hold kernel
> class indices.
>
>> š-Eric
>>
>> šOn Tue, Feb 4, 2014 at 6:13 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> šOn 2/4/2014 2:37 PM, Linus Torvalds wrote:
>>>> šI'm looking at profiles once more, and (once more) being annoying by
>>>> šSELinux overheads..
>>>>
>>>> šOne thing strikes me: does the ssid/tsid space need to be a full 32
>>>> šbit? Right now the indexing is done by <ssid,tsid,tclass>, and that's
>>>> ša <u32,u32,u16> tuple..
>>>>
>>>> šI actually improved code generation on x86-64 noticeably by encoding
>>>> šthe ssid+tsid in one 64-bit register, which lowers register pressure
>>>> š(no frame accesses in avc_has_perm_noaudit()) and makes the avc lookup
>>>> šmore efficient. But it would be even better if the whole tuple could
>>>> šbe encoded that way, ie the 'struct avc_entry' could have just one
>>>> š64-bit field that contains <ssid,tsid,tclass>.
>>>>
>>>> šIt could easily be a structure with basically arbitrary bit boundaries, so
>>>>
>>>> ššššstruct ssid_tsid_tclass {
>>>> šššššššu64 ssid:24, tsid:24, tclass:16;
>>>> šššš);
>>>>
>>>> šwould work fine. Or 25/25/14. Or whatever. The high bits of ssid/tsid
>>>> šdon't *seem* to be used in normal setups, but I don't actually know
>>>> šwhat the rules are for these things. Do they need to be the full 32
>>>> šbits? Does tclass need to be 16 bits? Is there some 64-bit packing
>>>> šthat could work?
>>>>
>>>> š(Ok, so the big cost is actually all the cache misses in avc_lookup(),
>>>> šand it would be a really big deal if there was some way to perhaps
>>>> šshort-circuit that entirely for the case of "user does directory
>>>> šlookup permission check for a directory inode". If somebody has a way
>>>> što do *that* with SELinux, that would be lovely)
>>> šThere is no reason that SELinux couldn't use security blob
>>> špointers for filesystem objects and tasks instead of avc lookups.
>>> šThe only places that really need secids are in networking code
>>> šwhere security has been begrudgenly granted 32 bits and admonished
>>> šnever to come asking for more. If a pointer were available instead
>>> š(and Paul Moore has proposed more than one way to do that, at least
>>> šone of which provided superior cache performance over the existing
>>> šcode) the avc could go away altogether.
>>>
>>> šThere are reasons that some developers like the avc mechanism.
>>> šI will leave the arguments in its favor to them.
>>>> š.
>>>>
>>>> ššššššššššššššššššLinus
>>>> š--
>>>> šTo unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>>>> šthe body of a message to majordomo@vger.kernel.org
>>>> šMore majordomo info at šhttp://vger.kernel.org/majordomo-info.html
>> š--
>> šTo unsubscribe from this list: send the line "unsubscribe linux-security-module" in
>> šthe body of a message to majordomo@vger.kernel.org
>> šMore majordomo info at šhttp://vger.kernel.org/majordomo-info.html
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.

Victor Porton - http://portonvictor.org
