Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v2TMxsH7011080
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 18:59:56 -0400
Received: by mail-vk0-f48.google.com with SMTP id s68so35615089vke.3
 for <selinux@tycho.nsa.gov>; Wed, 29 Mar 2017 15:59:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANEJEGu5L61TgJ0RUhG+DvLExj7X1FsfKbGOXWCMRRWykkLm2A@mail.gmail.com>
References: <20170316222652.125702-1-mka@chromium.org>
 <CANEJEGtObzAs4ZT70A_y_bLNujaNLxzOSPjrWRoY3wAR9211jw@mail.gmail.com>
 <CAHC9VhSVqYuuBvyjWmAqgfn9WvFW=VokcLLqsvmKedee3Gjgfw@mail.gmail.com>
 <CANEJEGu5L61TgJ0RUhG+DvLExj7X1FsfKbGOXWCMRRWykkLm2A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 29 Mar 2017 18:59:48 -0400
Message-ID: <CAHC9VhTWA=OVDFymUAhvpoEYHgfsxSKKSm316Q0Ox4-9t23NOQ@mail.gmail.com>
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

On Thu, Mar 23, 2017 at 1:34 PM, Grant Grundler <grundler@chromium.org> wrote:
> On Thu, Mar 23, 2017 at 5:08 AM, Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Mar 22, 2017 at 8:28 PM, Grant Grundler <grundler@chromium.org> wrote:
>>> Ping? Any feedback on this patch?
>>
>> It's on my list of patches to review, patience please.
>
> No problem! Thank you!
>
> just wanted confirmation it wasn't overlooked.

Merged, thanks for your patience.

-- 
paul moore
www.paul-moore.com
