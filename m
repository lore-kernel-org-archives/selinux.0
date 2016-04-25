Subject: Re: [PATCH] selinux: Build policy on systems not supporting DCCP
 protocol
To: Richard Haines <richard_c_haines@btinternet.com>,
 Joshua Brindle <brindle@quarksecurity.com>
References: <571D182A.9000909@quarksecurity.com>
 <624404358.2761413.1461590359068.JavaMail.yahoo@mail.yahoo.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <571E62E8.5080808@tycho.nsa.gov>
Date: Mon, 25 Apr 2016 14:33:12 -0400
MIME-Version: 1.0
In-Reply-To: <624404358.2761413.1461590359068.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 04/25/2016 09:19 AM, Richard Haines wrote:
> 
> 
> 
> 
> 
>> On Sunday, 24 April 2016, 20:02, Joshua Brindle <brindle@quarksecurity.com> wrote:
>>> Richard Haines wrote:
>>>  Commit 3895fbbe0cf2ec52d6b6eda66084b6e9f8d88fb2 ("selinux: Add support
>>>  for portcon dccp protocol") added support for the (portcon dccp ..)
>>>  statement. This fix will allow policy to be built on platforms
>>>  (see [1]) that do not have DCCP support by defining the IANA
>>>  assigned IP Protocol Number 33 to IPPROTO_DCCP.
>>>
>>>  [1] https://android-review.googlesource.com/#/c/219568/
>>>
>>>  Signed-off-by: Richard Haines<richard_c_haines@btinternet.com>
>>>  ---
>>>    checkpolicy/checkpolicy.c     | 3 +++
>>>    checkpolicy/policy_define.c   | 3 +++
>>>    libsepol/cil/src/cil_binary.c | 3 +++
>>>    libsepol/src/module_to_cil.c  | 3 +++
>>>    libsepol/src/ports.c          | 3 +++
>>
> 
>> Seems like this should be in a private header.
> 
> I finally choose the way I did this to make it clear that netinet/in.h
> may not have dccp support.

Yes, doesn't seem worth defining a libsepol header that defines it and
then including that in each of these files.  It isn't as though the
definition will ever change...

>>
>>
>>>    5 files changed, 15 insertions(+)
>>>
>>>  diff --git a/checkpolicy/checkpolicy.c b/checkpolicy/checkpolicy.c
>>>  index ea9ee00..7947c20 100644
>>>  --- a/checkpolicy/checkpolicy.c
>>>  +++ b/checkpolicy/checkpolicy.c
>>>  @@ -64,6 +64,9 @@
>>>    #include<sys/stat.h>
>>>    #include<sys/socket.h>
>>>    #include<netinet/in.h>
>>>  +#ifndef IPPROTO_DCCP
>>>  +#define IPPROTO_DCCP 33
>>>  +#endif
>>>    #include<arpa/inet.h>
>>>    #include<fcntl.h>
>>>    #include<stdio.h>
>>>  diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
>>>  index 7a4d2f1..2068b71 100644
>>>  --- a/checkpolicy/policy_define.c
>>>  +++ b/checkpolicy/policy_define.c
>>>  @@ -36,6 +36,9 @@
>>>    #include<string.h>
>>>    #include<sys/socket.h>
>>>    #include<netinet/in.h>
>>>  +#ifndef IPPROTO_DCCP
>>>  +#define IPPROTO_DCCP 33
>>>  +#endif
>>>    #include<arpa/inet.h>
>>>    #include<stdlib.h>
>>>    #include<limits.h>
>>>  diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
>>>  index 8233dfd..b8437c9 100644
>>>  --- a/libsepol/cil/src/cil_binary.c
>>>  +++ b/libsepol/cil/src/cil_binary.c
>>>  @@ -31,6 +31,9 @@
>>>    #include<stdio.h>
>>>    #include<assert.h>
>>>    #include<netinet/in.h>
>>>  +#ifndef IPPROTO_DCCP
>>>  +#define IPPROTO_DCCP 33
>>>  +#endif
>>>
>>>    #include<sepol/policydb/policydb.h>
>>>    #include<sepol/policydb/polcaps.h>
>>>  diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
>>>  index b478d9f..38f0dc3 100644
>>>  --- a/libsepol/src/module_to_cil.c
>>>  +++ b/libsepol/src/module_to_cil.c
>>>  @@ -26,6 +26,9 @@
>>>    #include<getopt.h>
>>>    #include<libgen.h>
>>>    #include<netinet/in.h>
>>>  +#ifndef IPPROTO_DCCP
>>>  +#define IPPROTO_DCCP 33
>>>  +#endif
>>>    #include<signal.h>
>>>    #include<stdarg.h>
>>>    #include<stdio.h>
>>>  diff --git a/libsepol/src/ports.c b/libsepol/src/ports.c
>>>  index b1ee094..62ec602 100644
>>>  --- a/libsepol/src/ports.c
>>>  +++ b/libsepol/src/ports.c
>>>  @@ -1,4 +1,7 @@
>>>    #include<netinet/in.h>
>>>  +#ifndef IPPROTO_DCCP
>>>  +#define IPPROTO_DCCP 33
>>>  +#endif
>>>    #include<stdlib.h>
>>>
>>>    #include "debug.h"
>>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
