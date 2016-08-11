Subject: Re: [PATCH] selinux-testsuite: Add test for execstack on thread
 stacks.
To: Paul Moore <pmoore@redhat.com>
References: <1469717017-19818-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhTQfcMR8_RCo_hxEjOMsDi_cTrgCO2udPWQAqrVnU6pVg@mail.gmail.com>
 <7a9c9bda-b7e0-274e-2634-8850cc292a0a@tycho.nsa.gov>
 <CAGH-KgupZpTL60HGNSe_AfiNM8WzkXEpiWTyMia8mJrqNfxmmQ@mail.gmail.com>
Cc: selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <755f448a-7fd7-c676-90d4-517a4fcda226@tycho.nsa.gov>
Date: Thu, 11 Aug 2016 13:32:59 -0400
MIME-Version: 1.0
In-Reply-To: <CAGH-KgupZpTL60HGNSe_AfiNM8WzkXEpiWTyMia8mJrqNfxmmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/29/2016 10:05 AM, Paul Moore wrote:
> On Fri, Jul 29, 2016 at 9:45 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>> On 07/29/2016 09:39 AM, Paul Moore wrote:
>>> On Thu, Jul 28, 2016 at 10:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>>> Test execstack permission checking for thread stacks.
>>>> The test is conditional on Linux >= 4.7.
>>>>
>>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>>> ---
>>>> Revised to make it conditional on the kernel version in which
>>>> the corresponding change was merged, so it passes on old and new kernels.
>>>>
>>>>  tests/mmap/Makefile                |  2 ++
>>>>  tests/mmap/mprotect_stack_thread.c | 58 ++++++++++++++++++++++++++++++++++++++
>>>>  tests/mmap/test                    |  8 +++++-
>>>>  3 files changed, 67 insertions(+), 1 deletion(-)
>>>>  create mode 100644 tests/mmap/mprotect_stack_thread.c
>>>
>>> With v4.7 released, and the newly added conditionals, I see no reason
>>> not to merge this patch (as well as the userns cap test) into the
>>> master branch.  Can you think of any reason why not?
>>
>> No, that's why I re-spun these patches.  Should be good to go.  I
>> force-pushed the updated patches to the branches, so they should be
>> available to merge or cherry-pick there.
> 
> Okay, great.  Just a reminder, you've got write access to that repo,
> and since you seem like a trustworthy guy I would say just go ahead a
> do the merge yourself ;)

Applied them both.
