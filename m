Message-ID: <545B8372.3000604@tycho.nsa.gov>
Date: Thu, 06 Nov 2014 09:19:30 -0500
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Sven Vermeulen <sven.vermeulen@siphos.be>
Subject: Re: SELinux Userspace Release: 20140826-rc5
References: <5451090B.2080107@tresys.com>
 <CAPzO=NyRKK=jJ151W6xk_cs7dHKJQCwCxoJc2jZmTLZ_DaXPUA@mail.gmail.com>
 <545784C2.30203@tresys.com>
 <CAPzO=Ny_xEYC6hgSb+nWJxqfgX6eYOBeUsf7wh+18h9j6nc0JA@mail.gmail.com>
 <5459366B.3060106@tycho.nsa.gov> <545B81E6.60908@tresys.com>
In-Reply-To: <545B81E6.60908@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/06/2014 09:12 AM, Steve Lawrence wrote:
> On 11/04/2014 03:26 PM, James Carter wrote:
>> On 11/04/2014 01:08 PM, Sven Vermeulen wrote:
>>> On Mon, Nov 3, 2014 at 2:36 PM, Steve Lawrence <slawrence@tresys.com>
>>> wrote:
>>>> It looks like you are correct, that unconfined_t is the problem. The
>>>> unconfined_domain_noaudit interface has a gen_require on unconfined_t.
>>>> However, CIL does not have a concept of gen_require. It just tries to
>>>> resolve all statements inside an optional block, and if any of them fail
>>>> then the optional is disabled. So in refpolicy, this interface depends
>>>> on the unconfined_t type, even though it never uses it.
>>>>
>>>> One solution would create a tyepattribute that isn't used in any
>>>> statements (and so won't become part of the final kernel policy) but
>>>> that types that are gen_required are associated with. This should cause
>>>> a failure of the optional without affecting anything alse. Kindof a
>>>> hack, and it only works for types/roles since with have attributes for
>>>> those, but probably the only way to mimic gen_require in CIL.
>>>
>>> Or perhaps inside the optional_policy() block I can define a rule
>>> that, if unconfined was enabled, would be applicable anyway, like so:
>>>
>>> allow unconfined_t self:process signal;
>>>
>>> (assuming that that is a rule that is applied to unconfined_t - can't
>>> verify it at this moment).
>>>
>>> As the unconfined_t isn't defined (unconfined module is not loaded)
>>> then this part blocks as well.
>>>
>>> Of course, it's indeed a hack (similar to the typeattribute one).
>>> Having a simple comment above it to make clear that it is to work
>>> around this situation should make it clear.
>>>
>>
>> Steve, how hard would it be to keep a list of the types that have been
>> declared in the require block and check if they have been used directly?
>> When you reached the end of the block any that have not been used could
>> be placed in a rule like Sven suggests.
>
> It probably wouldn't be too difficult to only add statements for types
> that aren't used in the optional block. I just finished writing out
> gen_requires for everything, regardless of if they are used or not, and
> got some interesting numbers. With all the extra gen_require
> typeattribute statements (~46000 of them), compiling CIL generated from
> refpolicy pp's was actually faster (25 seconds vs 18 seconds). However,
> it used about 13MB extra memory (129MB vs 142MB). Not really sure why
> there was such a relatively dramatic decrease in compile time though.
>
> I'll look into only adding symbols that are used in the optional and see
> if there are noticeable differences, but I suspect performance would be
> similar to how it before this change.
>
>> Although, I would suggest "allow
>>> TYPE self: file getattr;" which I know that all domains allow
>
> A typeattribute statement would prevent us from having to worry about
> this kind of stuff. I was thinking something like this:
>
> In the base module, we would also define this:
>
>    (typeattribute cil_gen_require)
>
> And then in optionals, we could have something like thi:
>
>    (option optional_foo
>      (typeattributeset cil_gen_require unconfined_t)
>    )
>
> This doesn't change the policy at all (since cil_gen_require isn't used
> in any statements, it won't be added to the binary), and a similar idea
> can be used for roles as well, though I don't think there are any cases
> were roles need to be 'cil_gen_required' in the converted CIL.
>

You're right. That is the better way of handling this.

Jim



-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
