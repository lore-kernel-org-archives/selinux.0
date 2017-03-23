Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NHYZfQ017955
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 13:34:35 -0400
Received: by mail-yw0-f182.google.com with SMTP id p77so151656226ywg.1
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 10:34:32 -0700 (PDT)
MIME-Version: 1.0
Sender: grundler@google.com
In-Reply-To: <CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
References: <20170316222652.125702-1-mka@chromium.org>
 <CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
 <CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
From: Grant Grundler <grundler@chromium.org>
Date: Thu, 23 Mar 2017 10:34:30 -0700
Message-ID: <CANEJEGu5L61TgJ0RUhG+DvLExj7X1FsfKbGOXWCMRRWykkLm2A@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove unnecessary check of array base in
 selinux_set_mapping()
To: Paul Moore <paul@paul-moore.com>
Cc: Grant Grundler <grundler@chromium.org>,
 Matthias Kaehlcke <mka@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>,
 James Morris <james.l.morris@oracle.com>,
 "Serge E . Hallyn" <serge@hallyn.com>, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Prarit Bhargava <prarit@redhat.com>,
 David Howells <dhowells@redhat.com>, Michael Davidson <md@google.com>,
 Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Mar 23, 2017 at 5:08 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Wed, Mar 22, 2017 at 8:28 PM, Grant Grundler <grundler@chromium.org> wrote:
>> Ping? Any feedback on this patch?
>
> It's on my list of patches to review, patience please.

No problem! Thank you!

just wanted confirmation it wasn't overlooked.

cheers,
grant

>
>> On Thu, Mar 16, 2017 at 3:26 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>>>
>>> 'perms' will never be NULL since it isn't a plain pointer but an array
>>> of u32 values.
>>>
>>> This fixes the following warning when building with clang:
>>>
>>> security/selinux/ss/services.c:158:16: error: address of array
>>> 'p_in->perms' will always evaluate to 'true'
>>> [-Werror,-Wpointer-bool-conversion]
>>>                 while (p_in->perms && p_in->perms[k]) {
>>>
>>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> ---
>>>  security/selinux/ss/services.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/selinux/ss/services.c
>>> b/security/selinux/ss/services.c
>>> index 082b20c78363..2f20b5f974f4 100644
>>> --- a/security/selinux/ss/services.c
>>> +++ b/security/selinux/ss/services.c
>>> @@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
>>>                 }
>>>
>>>                 k = 0;
>>> -               while (p_in->perms && p_in->perms[k]) {
>>> +               while (p_in->perms[k]) {
>>>                         /* An empty permission string skips ahead */
>>>                         if (!*p_in->perms[k]) {
>>>                                 k++;
>>> --
>>> 2.12.0.367.g23dc2f6d3c-goog
>>>
>>
>
>
>
> --
> paul moore
> www.paul-moore.com
