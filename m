To: Yuli Khodorkovskiy <ykhodo@gmail.com>
Cc: Petr Lautrbach <plautrba@redhat.com>, SELinux <selinux@tycho.nsa.gov>
References: <27be33f6-67d1-38bf-0351-4ea5af2fb1e1@tycho.nsa.gov>
 <20180420123135.GA2126@workstation>
 <1ec7a74e-c05e-48ef-c2d1-b97d5c8ef58f@tycho.nsa.gov>
 <20180420133104.GB2126@workstation>
 <b812c22d-5bd8-cab2-467b-998d9fd4d1f0@tycho.nsa.gov>
 <CAHnwOHDgZE-JL4ktAAivDQWLW22WCRnNT25zdDnF-t+uVbk9pg@mail.gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <097b7f8c-dffc-9c7f-4821-eda250024016@tycho.nsa.gov>
Date: Wed, 25 Apr 2018 10:32:35 -0400
MIME-Version: 1.0
In-Reply-To: <CAHnwOHDgZE-JL4ktAAivDQWLW22WCRnNT25zdDnF-t+uVbk9pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: ANN: SELinux userspace 2.8-rc1 release candidate
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/25/2018 10:11 AM, Yuli Khodorkovskiy wrote:
> On Fri, Apr 20, 2018 at 10:09 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 04/20/2018 09:31 AM, Petr Lautrbach wrote:
>>> On Fri, Apr 20, 2018 at 08:49:41AM -0400, Stephen Smalley wrote:
>>>> On 04/20/2018 08:31 AM, Petr Lautrbach wrote:
>>>>> On Thu, Apr 19, 2018 at 11:07:39AM -0400, Stephen Smalley wrote:
>>>>>> A 2.8-rc1 release candidate for the SELinux userspace is now available at:
>>>>>> https://github.com/SELinuxProject/selinux/wiki/Releases
>>>>>>
>>>>>> Please give it a test and let us know if there are any issues.
>>>>>
>>>>>
>>>>> I've built in my Fedora COPR repo [1] and I'm running Fedora CI [2] tests on it.
>>>>>
>>>>> So far there's one problem found by libselinux/selabel-function [3] test. It
>>>>> looks like commit 814631d3aebaa changed the behavior of selabel_open() when
>>>>> SELABEL_OPT_VALIDATE is null - a context should not be validated, but it is.
>>>>
>>>> So, is this a bug in the test or a bug in libselinux?  As noted in that commit description,
>>>> failing to verify contexts at all before use can lead to applying an invalid label (if the system is permissive).
>>>
>>> selabel_open(3) states that "an invalid context may not be treated as  an
>>> error unless it is actually encountered during a lookup operation ". So at
>>> least, it's some disproportion between the code and the documentation.
>>>
>>> I read the commit message as that a context should be validated before it's
>>> applied. But now it's validated during lookup.
>>
>> I guess it would be an API change given the way SELABEL_OPT_VALIDATE is documented in the man page,
>> although that description doesn't quite match the current code either.
>>
>> I was thinking that {SELABEL_OPT_VALIDATE,1} was intended to mean "validate all contexts during selabel_open() and fail the open on any errors".  Which is good for setfiles (particularly when invoked by libsemanage to check file_contexts against the policy) but was considered problematic for restorecon, as it meant that a single typo in file_contexts could prevent your system from booting (e.g. restorecon -R /dev or similar during boot may fail even if the error has nothing to do with /dev entries).  I thought {SELABEL_OPT_VALIDATE,0} was intended to mean "don't validate during selabel_open(); instead, lazily validate just before returning from selabel_lookup()".  That makes more sense to me.
>>
>> However, if it is an API change, I guess we have to revert it.  In which case maybe we should just change restorecon itself
>> to validate the context it gets from selabel_lookup (which might have been Yuli's original approach; I don't remember -
>> I think I sent him down this path instead).
> 
> Iirc, my original patch did not do lazy validation, which is why we
> went down this path. Is the right approach to change restorecon or to
> update the API and maintain compatibility?

I reverted the change because technically it breaks the documented semantics of SELABEL_OPT_VALIDATE and thus could
break existing external users, particularly ones that do not specify SELABEL_OPT_VALIDATE at all or specify it as 0.  Use case example is for labeling filesystem images where the file contexts aren't defined in the host policy.

If we want to address the problem with restorecon potentially setting an invalid context when run in permissive mode,
then we would likely need to introduce yet another SELABEL_OPT_* value, e.g. SELABEL_OPT_VALIDATE_LAZILY, and have restorecon explicitly specify that as part of its selabel_open() call, in order to cause the lazy validation to occur
before returning from selabel_lookup().  This would avoid any compatibility breakage with existing callers of selabel_open().  restorecon (and setfiles) would still need an option to disable such validation for use cases where it isn't desirable.
