Subject: Re: [PATCH v2 2/3] libsepol/cil: add ioctl whitelist support
To: Steve Lawrence <slawrence@tresys.com>, SELinux List <selinux@tycho.nsa.gov>
References: <1441025637-18267-1-git-send-email-slawrence@tresys.com>
 <1441025637-18267-3-git-send-email-slawrence@tresys.com>
 <55E73FF1.5040601@tycho.nsa.gov> <55E74747.1030106@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55E74DD2.5000000@tycho.nsa.gov>
Date: Wed, 2 Sep 2015 15:28:18 -0400
MIME-Version: 1.0
In-Reply-To: <55E74747.1030106@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/02/2015 03:00 PM, Steve Lawrence wrote:
> On 09/02/2015 02:29 PM, James Carter wrote:
>> On 08/31/2015 08:53 AM, Steve Lawrence wrote:
>>> Add three new extended avrule statements with the following syntax:
>>>
>>>     (allowx source_type target_type permissionx)
>>>     (auditallowx source_type target_type permissionx)
>>>     (dontauditx source_type target_type permissionx)
>>>
>>> source_type - type, typeattribute, or typealias
>>> target_type - type, typeattribute, typealias, or "self" keyword
>>> permissionx - named or anonymous permissionx statement, which has the
>>> syntax:
>>>
>>>     (permissionx name (kind object expression))
>>>
>>
>> Right now the permissionx name will be fully qualified, but we haven't
>> been doing that for identifiers that don't show up in the kernel policy
>> (classpermsets, named contexts, named ranges, named ip addrs, etc). So
>> it seems like you should exclude walking the permx symtab in
>> cil_fqn.c:__cil_fqn_qualify_blocks() like we do for these other symtabs.
>>
>
> Yep, this should be excluded from being fully qualified. Will fix.
>
>> The other question I have (and I am willing to put this off for now
>> because I don't know how much work it would be and I don't want to delay
>> this any longer than I already have) is whether it would be possible to
>> factor out the common code from checkpolicy's policy_define.c and cil's
>> cil_binary.c into some common functions in libsepol.
>>
>
> Unfortunately, there really isn't much in common between checkpolicy and
> CIL for extended avrules. checkpolicy uses an av_ioctl_range_list to
> keep track of the extended permissions. But since CIL supports more
> complex expressions and because of expression code reuse, it was easier
> to just use an ebitmap for evaluating/storing the extended permissions.
> Additionally, checkpolicy adds extended avrules to the list of
> avrule_t's, whereas CIL writes directly to the avtab. So they take
> pretty different approaches to solving the same problem.
>
> Really, the only thing they have in common, which was copied directly
> from policy_define.c, is the xperm_setrangebits function. Now that that
> function is in CIL/libsepol, it wouldn't be much effort to have
> checkpolicy use that one and remove the one in policy_define, but I
> think that's about all the refactoring we could do without maybe
> rewriting policy_define.c to use ebitmaps, and I'm not even sure that
> would remove very much code.
>

OK. Don't worry about then.

Jim



-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
