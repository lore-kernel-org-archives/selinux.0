Message-ID: <53C91A48.7040704@tresys.com>
Date: Fri, 18 Jul 2014 08:59:52 -0400
From: Steve Lawrence <slawrence@tresys.com>
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>, Dominick Grift
 <dominick.grift@gmail.com>
Subject: Re: [RFC] Source Policy, CIL, and High Level Languages
References: <53BD9646.6030303@tresys.com>
 <1404975079.31209.11.camel@x220.localdomain> <53C01CDD.80407@tresys.com>
 <53C409C3.3010602@tycho.nsa.gov> <53C40B13.9030907@tycho.nsa.gov>
 <53C40E8D.8070006@tycho.nsa.gov> <53C40F73.3030204@tresys.com>
 <53C41818.5000906@tycho.nsa.gov> <53C5875E.3050600@tresys.com>
 <53C68950.3050805@tycho.nsa.gov> <53C68A6D.80500@tycho.nsa.gov>
 <53C68BAE.4000303@tycho.nsa.gov> <53C68D40.8020700@tycho.nsa.gov>
 <53C69616.3040808@tresys.com> <1405526012.12577.9.camel@x220.localdomain>
 <53C6CBD8.2050509@tycho.nsa.gov> <53C7D452.3030206@tresys.com>
 <53C80FA5.3050705@tycho.nsa.gov> <53C81CDC.8080803@tresys.com>
 <53C81FA0.1020109@tycho.nsa.gov> <53C828A7.60909@tycho.nsa.gov>
 <53C82C6B.4090004@tresys.com> <53C8341D.4080300@tycho.nsa.gov>
In-Reply-To: <53C8341D.4080300@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/17/2014 04:37 PM, Stephen Smalley wrote:
> On 07/17/2014 04:04 PM, Steve Lawrence wrote:
>> On 07/17/2014 03:48 PM, Stephen Smalley wrote:
>>> On 07/17/2014 03:10 PM, Stephen Smalley wrote:
>>>> On 07/17/2014 02:58 PM, Steve Lawrence wrote:
>>>>> I think the only remaining issue is the one Dominick mentioned in his
>>>>> first email regarding file_contexts.homedirs. I don't think this is an
>>>>> actual bug, just the migration script migrating things that don't need
>>>>> to be migrated. Still investigating it. We should have an update
>>>>> sometime tomorrow.
>>>>
>>>> So everything you reverted you restored in equivalent form?
>>>>
>>>>>> What new functionality is included here that was not previously
>>>>>> supported by the old policy toolchain?
>>>>>
>>>>> In terms a user would see, the most visible change is support for CIL
>>>>> policies and HLLs, of which there's only one right now (pp2cil). There
>>>>> are also some new semanage.conf options (target-platform, compiler-dir,
>>>>> ignore-module-cache, store-root) but I imagine the vast majority of
>>>>> people could just use the defaults. Similarly, we've added
>>>>> --ignore-module-cache and --store-root to the semodule command. We've
>>>>> also moved the store to /var/lib/selinux, but this is more behind the
>>>>> scenes and should really only affect distributions.
>>>>
>>>> What about new features/options of the user-facing commands?  I know
>>>> some features were copied from earlier source/CIL releases into the main
>>>> selinux userspace (e.g. enabled/disabled modules), but aren't some
>>>> things like module priorities new?
>>>>
>>>>> Though, there are two things we just realized have a different behavior.
>>>>>
>>>>> 1) verify_modules is now performed on the CIL modules, rather than pp
>>>>> (or HLL) modules. So if someone is using verify_modules, things will
>>>>> probably break. I'm not sure if anyone uses this feature or how
>>>>> important it is that we maintain backwards compatibility.
>>>>>
>>>>> 2) verify_linked is no longer called, since there isn't any concept of a
>>>>> linked base module with CIL
>>>>>
>>>>> Aside from that, I think all functionality should remain the same.
>>>>
>>>> I'm not aware of anyone using anything other than verify kernel.
>>>>
>>>>>> Any chance of getting a hll compiler for refpolicy source modules, i.e.
>>>>>> in .if/.te/.fc form?
>>>>>
>>>>> That's in the plan. Jim has a tool that will compile .if/.te/.fc to CIL,
>>>>> but the current HLL infrastructure may need some changes before that can
>>>>> be supported. I think the main problem is that Jim's tool needs
>>>>> knowledge of all modules to be able to convert them to CIL, but the
>>>>> current HLL infrastructure compiles each module separately. We have
>>>>> various ideas on how we can update the HLL infrastructure to support
>>>>> this, but we've primarily been focused on getting the core CIL/HLL
>>>>> functionality complete and upstreamed before focusing on the more
>>>>> complicated HLL patterns.
>>>>
>>>> Ok.  Ultimately audit2allow -M i.e. sepolgen module compiler should be
>>>> re-tooled to generate source modules, and we'll essentially need a
>>>> workflow that replaces the old make -f /usr/share/selinux/devel/Makefile
>>>> mymodule.pp; semodule -i mymodule.pp.
>>>
>>> I guess one other possible concern might be storage:
>>>
>>> $ du -sh /etc/selinux/targeted/modules /var/lib/selinux/
>>> 5.4M	/etc/selinux/targeted/modules
>>> 11M	/var/lib/selinux/
>>>
>>> I'm guessing that is just the cost of storing each module in both binary
>>> and cil form?
>>
>> Yep, we store both HLL and CIL. They are both compressed and CIL
>> compresses decently since it's just text, but it's still a lot of text.
>>
>>> Is there an option to discard the .pp files altogether and only retain
>>> the cil files?
>>
>> Not at the moment, but it wouldn't be hard to accomplish. Just need to
>> delete all the hll files and change the contents of lang_ext to 'cil'.
>> Something we could add if storage is an issue.
> 
> That worked, albeit I had to learn that lang_ext must not include a
> newline or libsemanage won't accept it.  Took it down to 5.8M.  I
> suspect we could also stop retaining a copy of certain generated files
> like file_contexts although that is no different than the current code.

I think the new policy store infrastructure actually doesn't store a
copy of generated files, like file_contexts. It just doesn't appear that
way because the migration script copies things from the old store that
it doesn't need to. But they are never actually used. Once I verify this
is correct, I'll have a patch that should fix the migration script.

> Not sure what benefit there is in retaining the pp files, since they
> carry no additional information AFAIK and they aren't human viewable or
> editable.  Is there even an option for exporting modules from the policy
> store currently that would allow extracting them except via direct file
> access to the policy store?

There isn't currently a way to extract policy from the store, but that
has been a use case that has been discussed in the past. Something like
the following could be useful:

semodule --priority 400 --extract foo # outputs to foo.<hll>
edit foo.<hll>
semodule --priority 500 --install foo.<hll>

So there could be cases in the future where it could be convenient to
keep the HLL files around.

Another option to reduce disk usage could be to disable caching of the
CIL files (right now, we only have an option to ignore the cached
files). This way, the user could still do the above and edit hll files
without having to rely on them being accessible from somewhere else.
Though, this would incur a penalty of having to recompile HLL files for
every change (which in my tests, about doubles compilation time).

> More generally, if the user knows that the hll module is going to be
> saved elsewhere, then there is no reason to retain a copy in the policy
> store, so having the option of dropping the hll version, either for all
> modules or for specific modules, seems useful.

Do you see this feature as necessary for this patchset to be upstreamed,
or is this something we could add as a later update?
