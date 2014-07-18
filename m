Message-ID: <53C94404.3030104@tresys.com>
Date: Fri, 18 Jul 2014 11:57:56 -0400
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
 <53C91A48.7040704@tresys.com> <53C92F92.6070607@tycho.nsa.gov>
In-Reply-To: <53C92F92.6070607@tycho.nsa.gov>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: SELinux List <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/18/2014 10:30 AM, Stephen Smalley wrote:
> On 07/18/2014 08:59 AM, Steve Lawrence wrote:
>> There isn't currently a way to extract policy from the store, but that
>> has been a use case that has been discussed in the past. Something like
>> the following could be useful:
>>
>> semodule --priority 400 --extract foo # outputs to foo.<hll>
>> edit foo.<hll>
>> semodule --priority 500 --install foo.<hll>
>>
>> So there could be cases in the future where it could be convenient to
>> keep the HLL files around.
> 
> Sure, for source modules.  For pp files, though?
> 

Yeah, not useful for pp files. But I'd like to see pp files eventually
go away, with the source policies (which are likely much smaller) to be
the primary HLL.

Though, as Chris pointed out, extracting policies from the store could
potentially be useful for analysis.

>> Another option to reduce disk usage could be to disable caching of the
>> CIL files (right now, we only have an option to ignore the cached
>> files). This way, the user could still do the above and edit hll files
>> without having to rely on them being accessible from somewhere else.
>> Though, this would incur a penalty of having to recompile HLL files for
>> every change (which in my tests, about doubles compilation time).
> 
> Seems less useful than being able to disable storage of the HLL files.
> No penalty incurred, you just have to know that you won't need them
> again or that they will remain available externally.

Agreed, just throwing it out as another option.

>>> More generally, if the user knows that the hll module is going to be
>>> saved elsewhere, then there is no reason to retain a copy in the policy
>>> store, so having the option of dropping the hll version, either for all
>>> modules or for specific modules, seems useful.
>>
>> Do you see this feature as necessary for this patchset to be upstreamed,
>> or is this something we could add as a later update?
> 
> Not absolutely required, just wondering if we might encounter issues
> with migration on some systems due to insufficient space.  We'll
> actually have 3 copies of each module, 2 pp files (one still in
> /etc/selinux/targeted/modules, not deleted by the migration script) and
> 1 cil file.  Plus all of the copying that occurs during the transaction
> and installation of the files (-> /var/lib/selinux/targeted/tmp, ->
> /var/lib/selinux/tmp/targeted?, -> /etc/selinux/targeted).  Any idea
> what the max storage requirement for successful migration relative to
> the original size of the policy store?

We could delete the old store post migration but pre-rebuild. So we'd
only ever have two copies of the modules. We held off on doing this in
case something went wrong. Maybe after the migration script is run
through its paces we could be more confident and not require a backup.
Or we could delete the old store after a successful migration, so you
only take the extra storage hit on migration.

As far as max storage requirement, the current policy store is about
5MB. The CIL versions also required about 5MB total. So /var/lib/selinux
needs about 10MB to store all the policies (CIL + pp), and grows to
about 25MB during building. Makes sense since it makes a copy of the
active store (doubling from 10MB to 20MB), then builds into the sandbox
(~5MB). Then it deletes the sandbox and the old module store.

So you need about 5x the current policy to successfully migrate.

So we could probably save about 5MB if we deleted the old store after
migration, and save another 10MB during the build process if pp modules
were deleted after converted to CIL.
