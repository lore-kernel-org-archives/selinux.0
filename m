Message-ID: <53C82955.90108@tresys.com>
Date: Thu, 17 Jul 2014 15:51:49 -0400
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
 <53C81FA0.1020109@tycho.nsa.gov>
In-Reply-To: <53C81FA0.1020109@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/17/2014 03:10 PM, Stephen Smalley wrote:
> On 07/17/2014 02:58 PM, Steve Lawrence wrote:
>> I think the only remaining issue is the one Dominick mentioned in his
>> first email regarding file_contexts.homedirs. I don't think this is an
>> actual bug, just the migration script migrating things that don't need
>> to be migrated. Still investigating it. We should have an update
>> sometime tomorrow.
> 
> So everything you reverted you restored in equivalent form?
> 

Yep. The only features reverted were enable/disable and
semanage_set_root (multiple commits added these features, which is why
there are 8 commits). Enable/disable as added back by the source policy
work, and setmanage_set_root was manually added back.

>>> What new functionality is included here that was not previously
>>> supported by the old policy toolchain?
>>
>> In terms a user would see, the most visible change is support for CIL
>> policies and HLLs, of which there's only one right now (pp2cil). There
>> are also some new semanage.conf options (target-platform, compiler-dir,
>> ignore-module-cache, store-root) but I imagine the vast majority of
>> people could just use the defaults. Similarly, we've added
>> --ignore-module-cache and --store-root to the semodule command. We've
>> also moved the store to /var/lib/selinux, but this is more behind the
>> scenes and should really only affect distributions.
> 
> What about new features/options of the user-facing commands?  I know
> some features were copied from earlier source/CIL releases into the main
> selinux userspace (e.g. enabled/disabled modules), but aren't some
> things like module priorities new?

Yes. The changes to semodule were:

New option -X, --priority to set the priority, defaults to 400.
New option -C, --ignore_module_cache to ignore cached CIL modules to
force recompilation.
Deprecated --base and --upgrade, which are both equivalent to --install.
Versions are no longer output in semodule --list (they don't exist in CIL).
The -l option can now accept a parameter (either "full" or "standard").
"standard" lists just active modules. This is the default if a parameter
is not provided. "full" lists all modules, priorities, and high level
language.

Changes to semanage:
- Add support for priorities with the module subcommand with the -X option
- Removes version references
- Modifies list to also output priority and hll
- Making a module permissive uses CIL instead of building a pp module



>> Though, there are two things we just realized have a different behavior.
>>
>> 1) verify_modules is now performed on the CIL modules, rather than pp
>> (or HLL) modules. So if someone is using verify_modules, things will
>> probably break. I'm not sure if anyone uses this feature or how
>> important it is that we maintain backwards compatibility.
>>
>> 2) verify_linked is no longer called, since there isn't any concept of a
>> linked base module with CIL
>>
>> Aside from that, I think all functionality should remain the same.
> 
> I'm not aware of anyone using anything other than verify kernel.
> 
>>> Any chance of getting a hll compiler for refpolicy source modules, i.e.
>>> in .if/.te/.fc form?
>>
>> That's in the plan. Jim has a tool that will compile .if/.te/.fc to CIL,
>> but the current HLL infrastructure may need some changes before that can
>> be supported. I think the main problem is that Jim's tool needs
>> knowledge of all modules to be able to convert them to CIL, but the
>> current HLL infrastructure compiles each module separately. We have
>> various ideas on how we can update the HLL infrastructure to support
>> this, but we've primarily been focused on getting the core CIL/HLL
>> functionality complete and upstreamed before focusing on the more
>> complicated HLL patterns.
> 
> Ok.  Ultimately audit2allow -M i.e. sepolgen module compiler should be
> re-tooled to generate source modules, and we'll essentially need a
> workflow that replaces the old make -f /usr/share/selinux/devel/Makefile
> mymodule.pp; semodule -i mymodule.pp.
