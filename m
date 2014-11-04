Message-ID: <5459366B.3060106@tycho.nsa.gov>
Date: Tue, 04 Nov 2014 15:26:19 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Sven Vermeulen <sven.vermeulen@siphos.be>,
 Steve Lawrence <slawrence@tresys.com>
Subject: Re: SELinux Userspace Release: 20140826-rc5
References: <5451090B.2080107@tresys.com>
 <CAPzO=NyRKK=jJ151W6xk_cs7dHKJQCwCxoJc2jZmTLZ_DaXPUA@mail.gmail.com>
 <545784C2.30203@tresys.com>
 <CAPzO=Ny_xEYC6hgSb+nWJxqfgX6eYOBeUsf7wh+18h9j6nc0JA@mail.gmail.com>
In-Reply-To: <CAPzO=Ny_xEYC6hgSb+nWJxqfgX6eYOBeUsf7wh+18h9j6nc0JA@mail.gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/04/2014 01:08 PM, Sven Vermeulen wrote:
> On Mon, Nov 3, 2014 at 2:36 PM, Steve Lawrence <slawrence@tresys.com> wrote:
>> It looks like you are correct, that unconfined_t is the problem. The
>> unconfined_domain_noaudit interface has a gen_require on unconfined_t.
>> However, CIL does not have a concept of gen_require. It just tries to
>> resolve all statements inside an optional block, and if any of them fail
>> then the optional is disabled. So in refpolicy, this interface depends
>> on the unconfined_t type, even though it never uses it.
>>
>> One solution would create a tyepattribute that isn't used in any
>> statements (and so won't become part of the final kernel policy) but
>> that types that are gen_required are associated with. This should cause
>> a failure of the optional without affecting anything alse. Kindof a
>> hack, and it only works for types/roles since with have attributes for
>> those, but probably the only way to mimic gen_require in CIL.
>
> Or perhaps inside the optional_policy() block I can define a rule
> that, if unconfined was enabled, would be applicable anyway, like so:
>
> allow unconfined_t self:process signal;
>
> (assuming that that is a rule that is applied to unconfined_t - can't
> verify it at this moment).
>
> As the unconfined_t isn't defined (unconfined module is not loaded)
> then this part blocks as well.
>
> Of course, it's indeed a hack (similar to the typeattribute one).
> Having a simple comment above it to make clear that it is to work
> around this situation should make it clear.
>

Steve, how hard would it be to keep a list of the types that have been declared 
in the require block and check if they have been used directly? When you reached 
the end of the block any that have not been used could be placed in a rule like 
Sven suggests. Although, I would suggest "allow TYPE self: file getattr;" which 
I know that all domains allow.

>> Another option would be to change refpolicy so that the unconfined
>> attributes are defined in the unconfined module rather than in
>> kernel/domain/fs/etc, but maybe the way unconfined works would make the
>> difficult. It's also not backwards compatible, so we'd probably still
>> need the pp change anyway.
>
> This was actually what I was thinking about implementing on Gentoo to
> "fix" this, but might take some time.
>

We do not need to fix any policy sources. This is an artifact of generating CIL 
from the pp files and is due to the fact that the interfaces have already been 
expanded. In a CIL policy that has been generated from the policy source, if the 
unconfined module is not loaded then the interface unconfined_domain_noaudit() 
does not exist, optional blocks will be disabled as required, and everything works.

Speaking of require block issues. CIL generated from source policy has a problem 
that the CIL generated from pp files does not have. There are a handful of cases 
in the Fedora policy where require blocks in an interface are met because of an 
alias in another module. So these interfaces are expanded and appear in the 
policy even if the modules containing those interfaces are disabled. I currently 
have to manually add these interfaces.

By the way, there is now a fedora branch for the cilpolicy on bitbucket:
https://bitbucket.org/jwcarter/cilpolicy

> Do you have an idea how we could find similar cases? I think the
> unconfined ones are the only ones that use such a construction
> (gen_require without directly using it) but I rather be certain.
>

I seem to remember a few instances in the past were there where typos in the 
require block which caused the block to always be removed. But I don't see that 
in the current policy.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
