Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA8KulnC000826
 for <selinux@tycho.nsa.gov>; Tue, 8 Nov 2016 15:56:48 -0500
Received: by mail-ua0-f182.google.com with SMTP id 20so157685216uak.0
 for <selinux@tycho.nsa.gov>; Tue, 08 Nov 2016 12:56:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC561CD2178D@ORSMSX103.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC561CD2178D@ORSMSX103.amr.corp.intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 8 Nov 2016 15:56:33 -0500
Message-ID: <CAHC9VhS5Fg1qegytKsG5Tz6MvO=pLxn3qmzDsvkcVhC5jx7d3g@mail.gmail.com>
Subject: Re: GPF in sidtab_context_to_sid
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Nov 8, 2016 at 1:26 PM, Roberts, William C
<william.c.roberts@intel.com> wrote:
> I found a very similar oops online:
>
> http://oops.kernel.org/oops/general-protection-fault-in-sidtab_context_to_sid/
>
> Has anyone encountered this bug?
>
> I had something reported to me very similar where the faulting instruction
> was:
>
> 0xffffffff8133c81e <+174>:   mov    0x14(%r12),%eax
>
> Addr2line on vmlinux produced:
>
> $ addr2line -f -e ./vmlinux ffffffff8133c81e
> context_cmp
> kernel/cht/security/selinux/ss/context.h:152

I'm guessing you don't have a reproducer?

It looks like both these kernels are older (3.x), have you seen this
on anything recent?

-- 
paul moore
www.paul-moore.com
