Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uBKJ1e2U030887
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 14:01:41 -0500
Received: by mail-vk0-f68.google.com with SMTP id x186so15385052vkd.2
 for <selinux@tycho.nsa.gov>; Tue, 20 Dec 2016 11:01:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1482256710.28169.35.camel@tycho.nsa.gov>
References: <148225595449.30954.6812336959299313160.stgit@sifl>
 <1482256710.28169.35.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Dec 2016 14:01:35 -0500
Message-ID: <CAHC9VhRqwq9gJMUsHUcYYU_KHDeJaz9CTB6N=dDD_DNXKW1Agw@mail.gmail.com>
Subject: Re: [PATCH] selinux: use the kernel headers when building
 scripts/selinux/genheaders
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Paul Moore <pmoore@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Dec 20, 2016 at 12:58 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Tue, 2016-12-20 at 12:45 -0500, Paul Moore wrote:
>> From: Paul Moore <paul@paul-moore.com>
>>
>> Commit 3322d0d64f4e ("selinux: keep SELinux in sync with new
>> capability
>> definitions") added a check on the defined capabilities without
>> explicitly including the capability header file which caused problems
>> when building genheaders for users of clang/llvm.  Resolve this by
>> using the kernel headers when building genheaders, which is arguably
>> the right thing to do regardless, and explicitly including the
>> kernel's capability.h header file in classmap.h.
>>
>> Reported-by: Nicolas Iooss <nicolas.iooss@m4x.org>
>> Signed-off-by: Paul Moore <paul@paul-moore.com>
>> ---
>>  scripts/selinux/genheaders/Makefile     |    4 +++-
>>  scripts/selinux/genheaders/genheaders.c |    4 ++++
>>  security/selinux/include/classmap.h     |    2 ++
>>  3 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/selinux/genheaders/Makefile
>> b/scripts/selinux/genheaders/Makefile
>> index 1d1ac51359e3..6fc2b8789a0b 100644
>> --- a/scripts/selinux/genheaders/Makefile
>> +++ b/scripts/selinux/genheaders/Makefile
>> @@ -1,4 +1,6 @@
>>  hostprogs-y  := genheaders
>> -HOST_EXTRACFLAGS += -Isecurity/selinux/include
>> +HOST_EXTRACFLAGS += \
>> +     -I$(srctree)/include/uapi -I$(srctree)/include \
>> +     -I$(srctree)/security/selinux/include
>>
>>  always               := $(hostprogs-y)
>> diff --git a/scripts/selinux/genheaders/genheaders.c
>> b/scripts/selinux/genheaders/genheaders.c
>> index 539855ff31f9..f4dd41f900d5 100644
>> --- a/scripts/selinux/genheaders/genheaders.c
>> +++ b/scripts/selinux/genheaders/genheaders.c
>> @@ -1,3 +1,7 @@
>> +
>> +/* NOTE: we really do want to use the kernel headers here */
>> +#define __EXPORTED_HEADERS__
>> +
>>  #include <stdio.h>
>>  #include <stdlib.h>
>>  #include <unistd.h>
>> diff --git a/security/selinux/include/classmap.h
>> b/security/selinux/include/classmap.h
>> index e2d4ad3a4b4c..13ae49b0baa0 100644
>> --- a/security/selinux/include/classmap.h
>> +++ b/security/selinux/include/classmap.h
>> @@ -1,3 +1,5 @@
>> +#include <linux/capability.h>
>
> I think we only need uapi/linux/capability.h, not the kernel-private
> definitions.

Pulling in only uapi/linux/capability.h resulted in numerous conflicts
between the system and kernel-private includes.  Some of these
conflicts can be resolved by pre-defining a number of preprocessor
macros, but the patch was starting to look very hackish and it wasn't
clear to me that it would be possible to resolve all of the conflicts.

I am open to other suggestions so long as they solve the problem
Nicolas reported.

-- 
paul moore
www.paul-moore.com
