Message-ID: <542D6A5F.5090708@tycho.nsa.gov>
Date: Thu, 02 Oct 2014 11:08:15 -0400
From: James Carter <jwcart2@tycho.nsa.gov>
MIME-Version: 1.0
To: Steve Lawrence <slawrence@tresys.com>,
 Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>,
 SELinux List <selinux@tycho.nsa.gov>
Subject: Re: [PATCH 0/3] pp2cil fixes based on feedback
References: <1412255410-15537-1-git-send-email-ykhodorkovskiy@tresys.com>
 <542D64CF.809@tycho.nsa.gov> <542D6821.2000609@tresys.com>
In-Reply-To: <542D6821.2000609@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/02/2014 10:58 AM, Steve Lawrence wrote:
> On 10/02/2014 10:44 AM, James Carter wrote:
>> On 10/02/2014 09:10 AM, Yuli Khodorkovskiy wrote:
>>> This patchset provides fixes to the pp2cil tool based on feedback for
>>> 2014-08-26-rc1.
>>>
>>> An issue was encountered in 2014-08-26-rc1 with missing roles [1].
>>> Role declarations will now be printed in base and modules, where
>>> before only module role declarations were printed. Also, roletype
>>> statements will only be created when a role or a type are in the
>>> correct scope. As a result of these changes, policies that declare
>>> roles mulitple times in different modules will result in pp2cil
>>> generating duplicate roles. Since CIL does not allow identical role
>>> delcarations in different modules, current policies must be rebuilt
>>> with a refpolicy patch that removes duplicate role declarations [2].
>>>
>>
>> What about current policies? How does this effect backwards compatibility?
>>
>
> Unfortunately, this solution is not very backwards compatible. In order
> to update to the latest userspace, it would require distributions to
> update to the latest refpolicy or to pull in the refpolicy patch
> referenced below. However, we have already found issues in distribution
> policies that caused breakage that require distributions to update their
> policies (e.g. bad filecon statements in fedora), so this isn't a
> particularly new. It does potentially affect all policies though, and
> not just a single distros version of policy, so it's a bit bigger.
>
> I wouldn't expect this would affect custom policy modules that aren't
> part of refpolicy, since most of those either don't contain role
> declarations, or if they do, I'd guess they are custom roles that
> wouldn't be duplicated eleswhere.  So if the distro updated their
> policy, then custom user modules shouldn't have any problems. This is
> just an assumption though. It may be wrong.
>
> We could provide a backwards compatibility mode in CIL that allows
> duplicate roles, and eventually work to phase it out. Though, I'd really
> like to avoid that.
>

I really don't want that.

But we know which roles are declared in the base module. So can't we just not 
write those role declarations if they occur in a module? It is a horrible and 
ugly hack, but it should work.

>>> A bug in creating filecon statements was also fixed where a missing
>>> trailing newline in .fc files would cause parsing issues.
>>>
>>> Finally, generated typeattribute/sets will now be printed immediately
>>> unless they are in avrule conditionals/blocks. The special case will
>>> have generated typeattributes/sets to be printed after the
>>> conditionals/blocks are printed.
>>>
>>> [1] http://marc.info/?l=selinux&m=140983712508791&w=2
>>> [2]
>>> https://github.com/TresysTechnology/refpolicy/commit/330b0fc3331d3b836691464734c96f3da3044490
>>>
>>>
>>>
>>> Yuli Khodorkovskiy (3):
>>>     policycoreutils/hll/pp: Fix role/roletype scoping
>>>     policycoreutils/hll/pp: fix '\n' parsing in filecon statements
>>>     policycoreutils/hll/pp: change printing behavior of typeattribute/sets
>>>
>>>    policycoreutils/hll/pp/pp.c | 763
>>> ++++++++++++++++++++++++++++++--------------
>>>    1 file changed, 529 insertions(+), 234 deletions(-)
>>>
>>
>>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
