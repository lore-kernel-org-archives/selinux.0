Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBLK3FWf014565
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 15:03:18 -0500
Received: by mail-oi0-f45.google.com with SMTP id 3so38559669oih.1
 for <selinux@tycho.nsa.gov>; Wed, 21 Dec 2016 12:03:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2ef38284-be9c-306f-979f-2507106af09b@m4x.org>
References: <148233685348.23556.6766505841733321185.stgit@sifl>
 <2ef38284-be9c-306f-979f-2507106af09b@m4x.org>
From: Paul Moore <pmoore@redhat.com>
Date: Wed, 21 Dec 2016 15:03:11 -0500
Message-ID: <CAGH-KgvrWojZTDaHTOK9M4hks9pJUKQpamYxUJSxp=buoOPm1w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: use the kernel headers when building
 scripts/selinux
To: Nicolas Iooss <nicolas.iooss@m4x.org>
Cc: selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Dec 21, 2016 at 1:06 PM, Nicolas Iooss <nicolas.iooss@m4x.org> wrote:
> On 21/12/16 17:14, Paul Moore wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> Commit 3322d0d64f4e ("selinux: keep SELinux in sync with new capability
>> definitions") added a check on the defined capabilities without
>> explicitly including the capability header file which caused problems
>> when building genheaders for users of clang/llvm.  Resolve this by
>> using the kernel headers when building genheaders, which is arguably
>> the right thing to do regardless, and explicitly including the
>> kernel's capability.h header file in classmap.h.  We also update the
>> mdp build, even though it wasn't causing an error we really should
>> be using the headers from the kernel we are building.
>
> I tested this patch and it works fine on my configuration (no compiler
> warning and the kernel headers are included as expected). Thanks!

Great, thanks for the verification.  I'll send this patch up for v4.10
later today.

-- 
paul moore
security @ redhat
