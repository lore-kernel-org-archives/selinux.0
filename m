Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w18LwQ9S024275
 for <selinux@tycho.nsa.gov>; Thu, 8 Feb 2018 16:58:26 -0500
Received: by mail-lf0-f68.google.com with SMTP id h78so1342293lfg.6
 for <selinux@tycho.nsa.gov>; Thu, 08 Feb 2018 13:58:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFftDdq3CoeuV=iz6PXYhbh6TaafrtOEoS0khytj6Sv376vsiQ@mail.gmail.com>
References: <1518047169-9046-1-git-send-email-william.c.roberts@intel.com>
 <CAHC9VhQ-XkmCx0qWb7bfvgfwzYJDZvspJE7DUHnb3pmnhwo9uw@mail.gmail.com>
 <CAFftDdq3CoeuV=iz6PXYhbh6TaafrtOEoS0khytj6Sv376vsiQ@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 8 Feb 2018 16:58:22 -0500
Message-ID: <CAHC9VhQ2KfQSH8orN-ru8L_APBTLS1DPY6QsaE9YKoocszhkvA@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: William Roberts <william.c.roberts@intel.com>,
 Stephen Smalley <sds@tycho.nsa.gov>, selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] [RFC] sidtab: use memset vs loop for init
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Feb 8, 2018 at 11:31 AM, William Roberts
<bill.c.roberts@gmail.com> wrote:
> On Thu, Feb 8, 2018 at 7:20 AM, Paul Moore <paul@paul-moore.com> wrote:
>> On Wed, Feb 7, 2018 at 6:46 PM,  <william.c.roberts@intel.com> wrote:

...

>>> I sent this as an RFC for 2 reasons:
>>> 1. NOT TESTED
>>
>> So yes, this is a pretty trivial patch, and it is an RFC, but if you
>> want me to merge this at some point you need to at least build and
>> boot a patched kernel successfully.
>
> Well yes, I would never send a patch that I intended for merge
> without thorough testing. This is why it is clearly marked and such.

You did mark it clearly, no worries, I just wanted to make sure
everyone reading along at home was clear on things :)

-- 
paul moore
www.paul-moore.com
