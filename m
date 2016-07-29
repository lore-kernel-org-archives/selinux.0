Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6TE70XT005311
 for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2016 10:07:05 -0400
Received: by mail-oi0-f42.google.com with SMTP id w18so107530200oiw.3
 for <selinux@tycho.nsa.gov>; Fri, 29 Jul 2016 07:05:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7a9c9bda-b7e0-274e-2634-8850cc292a0a@tycho.nsa.gov>
References: <1469717017-19818-1-git-send-email-sds@tycho.nsa.gov>
 <CAHC9VhTQfcMR8_RCo_hxEjOMsDi_cTrgCO2udPWQAqrVnU6pVg@mail.gmail.com>
 <7a9c9bda-b7e0-274e-2634-8850cc292a0a@tycho.nsa.gov>
From: Paul Moore <pmoore@redhat.com>
Date: Fri, 29 Jul 2016 10:05:13 -0400
Message-ID: <CAGH-KgupZpTL60HGNSe_AfiNM8WzkXEpiWTyMia8mJrqNfxmmQ@mail.gmail.com>
Subject: Re: [PATCH] selinux-testsuite: Add test for execstack on thread
 stacks.
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <paul@paul-moore.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 29, 2016 at 9:45 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 07/29/2016 09:39 AM, Paul Moore wrote:
>> On Thu, Jul 28, 2016 at 10:43 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
>>> Test execstack permission checking for thread stacks.
>>> The test is conditional on Linux >= 4.7.
>>>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>> Revised to make it conditional on the kernel version in which
>>> the corresponding change was merged, so it passes on old and new kernels.
>>>
>>>  tests/mmap/Makefile                |  2 ++
>>>  tests/mmap/mprotect_stack_thread.c | 58 ++++++++++++++++++++++++++++++++++++++
>>>  tests/mmap/test                    |  8 +++++-
>>>  3 files changed, 67 insertions(+), 1 deletion(-)
>>>  create mode 100644 tests/mmap/mprotect_stack_thread.c
>>
>> With v4.7 released, and the newly added conditionals, I see no reason
>> not to merge this patch (as well as the userns cap test) into the
>> master branch.  Can you think of any reason why not?
>
> No, that's why I re-spun these patches.  Should be good to go.  I
> force-pushed the updated patches to the branches, so they should be
> available to merge or cherry-pick there.

Okay, great.  Just a reminder, you've got write access to that repo,
and since you seem like a trustworthy guy I would say just go ahead a
do the merge yourself ;)

-- 
paul moore
security @ redhat
