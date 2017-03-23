Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2NC87xX008441
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 08:08:08 -0400
Received: by mail-vk0-f67.google.com with SMTP id y16so13732526vky.1
 for <selinux@tycho.nsa.gov>; Thu, 23 Mar 2017 05:08:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
References: <20170316222652.125702-1-mka@chromium.org>
 <CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Mar 2017 08:08:05 -0400
Message-ID: <CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
Subject: Re: [PATCH] selinux: Remove unnecessary check of array base in
 selinux_set_mapping()
To: Grant Grundler <grundler@chromium.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Stephen Smalley <sds@tycho.nsa.gov>,
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

On Wed, Mar 22, 2017 at 8:28 PM, Grant Grundler <grundler@chromium.org> wrote:
> Ping? Any feedback on this patch?

It's on my list of patches to review, patience please.

> On Thu, Mar 16, 2017 at 3:26 PM, Matthias Kaehlcke <mka@chromium.org> wrote:
>>
>> 'perms' will never be NULL since it isn't a plain pointer but an array
>> of u32 values.
>>
>> This fixes the following warning when building with clang:
>>
>> security/selinux/ss/services.c:158:16: error: address of array
>> 'p_in->perms' will always evaluate to 'true'
>> [-Werror,-Wpointer-bool-conversion]
>>                 while (p_in->perms && p_in->perms[k]) {
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> ---
>>  security/selinux/ss/services.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/security/selinux/ss/services.c
>> b/security/selinux/ss/services.c
>> index 082b20c78363..2f20b5f974f4 100644
>> --- a/security/selinux/ss/services.c
>> +++ b/security/selinux/ss/services.c
>> @@ -155,7 +155,7 @@ static int selinux_set_mapping(struct policydb *pol,
>>                 }
>>
>>                 k = 0;
>> -               while (p_in->perms && p_in->perms[k]) {
>> +               while (p_in->perms[k]) {
>>                         /* An empty permission string skips ahead */
>>                         if (!*p_in->perms[k]) {
>>                                 k++;
>> --
>> 2.12.0.367.g23dc2f6d3c-goog
>>
>



-- 
paul moore
www.paul-moore.com
