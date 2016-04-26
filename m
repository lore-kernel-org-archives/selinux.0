Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u3QKvAlE032507
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 16:57:10 -0400
Received: by mail-oi0-f53.google.com with SMTP id x201so28648710oif.3
 for <selinux@tycho.nsa.gov>; Tue, 26 Apr 2016 13:57:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <46d242c8-ca4c-dfea-a93f-73bdc57db1cd@tycho.nsa.gov>
References: <1460137920-17190-1-git-send-email-sds@tycho.nsa.gov>
 <1976950.a3EgWPGDNc@sifl>
 <46d242c8-ca4c-dfea-a93f-73bdc57db1cd@tycho.nsa.gov>
Date: Tue, 26 Apr 2016 16:57:08 -0400
Message-ID: <CAHC9VhTBTEm6rP0_9+h1oPH6Rqugq+tuWhQV4ekA=ee7YHUeFQ@mail.gmail.com>
Subject: Re: [PATCH] selinux: distinguish non-init user namespace capability
 checks
From: Paul Moore <paul@paul-moore.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, Dan Walsh <dwalsh@redhat.com>,
 "Christopher J. PeBenito" <cpebenito@tresys.com>,
 Miroslav Grepl <mgrepl@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 26, 2016 at 4:06 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On 04/26/2016 03:51 PM, Paul Moore wrote:
>> On Friday, April 08, 2016 01:52:00 PM Stephen Smalley wrote:
>>> Distinguish capability checks against a target associated
>>> with the init user namespace versus capability checks against
>>> a target associated with a non-init user namespace by defining
>>> and using separate security classes for the latter.
>>>
>>> This is needed to support e.g. Chrome usage of user namespaces
>>> for the Chrome sandbox without needing to allow Chrome to also
>>> exercise capabilities on targets in the init user namespace.
>>>
>>> Suggested-by: Dan Walsh <dwalsh@redhat.com>
>>> Signed-off-by: Stephen Smalley <sds@tycho.nsa.gov>
>>> ---
>>>  security/selinux/hooks.c            | 14 +++++++-------
>>>  security/selinux/include/classmap.h | 28 ++++++++++++++++++----------
>>>  2 files changed, 25 insertions(+), 17 deletions(-)
>>
>> Applied, thanks.
>
> I pushed the test for these new checks to a branch of selinux-testsuite
> (#userns) because the test can't be used without a corresponding update
> to policy to define the new classes, so I will wait to merge to master
> until rawhide gets the new class definitions.  Also, I'll need to make
> the test code conditional on kernel version so that it won't fail on
> kernels that predate the support.  Will this change be in 4.7?

I merged the code into the selinux#next branch so barring any
linux-next blowups, yes, I'll submit this with the 4.7 patches.

-- 
paul moore
www.paul-moore.com
