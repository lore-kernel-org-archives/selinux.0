Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uA8LdXAO005930
 for <selinux@tycho.nsa.gov>; Tue, 8 Nov 2016 16:39:33 -0500
From: "Roberts, William C" <william.c.roberts@intel.com>
To: Paul Moore <paul@paul-moore.com>
CC: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>
Subject: RE: GPF in sidtab_context_to_sid
Date: Tue, 8 Nov 2016 21:39:30 +0000
Message-ID: <476DC76E7D1DF2438D32BFADF679FC561CD21E34@ORSMSX103.amr.corp.intel.com>
References: <476DC76E7D1DF2438D32BFADF679FC561CD2178D@ORSMSX103.amr.corp.intel.com>
 <CAHC9VhS5Fg1qegytKsG5Tz6MvO=pLxn3qmzDsvkcVhC5jx7d3g@mail.gmail.com>
In-Reply-To: <CAHC9VhS5Fg1qegytKsG5Tz6MvO=pLxn3qmzDsvkcVhC5jx7d3g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>



> -----Original Message-----
> From: Paul Moore [mailto:paul@paul-moore.com]
> Sent: Tuesday, November 8, 2016 12:57 PM
> To: Roberts, William C <william.c.roberts@intel.com>
> Cc: selinux@tycho.nsa.gov
> Subject: Re: GPF in sidtab_context_to_sid
> 
> On Tue, Nov 8, 2016 at 1:26 PM, Roberts, William C <william.c.roberts@intel.com>
> wrote:
> > I found a very similar oops online:
> >
> > http://oops.kernel.org/oops/general-protection-fault-in-sidtab_context
> > _to_sid/
> >
> > Has anyone encountered this bug?
> >
> > I had something reported to me very similar where the faulting
> > instruction
> > was:
> >
> > 0xffffffff8133c81e <+174>:   mov    0x14(%r12),%eax
> >
> > Addr2line on vmlinux produced:
> >
> > $ addr2line -f -e ./vmlinux ffffffff8133c81e context_cmp
> > kernel/cht/security/selinux/ss/context.h:152
> 
> I'm guessing you don't have a reproducer?

Supposedly, I am digging that slowly out of the reporters. If I can use it to
reproduce, I'll let you know.

> 
> It looks like both these kernels are older (3.x), have you seen this on anything
> recent?

No.

> 
> --
> paul moore
> www.paul-moore.com
