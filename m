Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5NGHqi5024451
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 12:17:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id v22-v6so3046256ljg.13
 for <selinux@tycho.nsa.gov>; Sat, 23 Jun 2018 09:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <152970230022.7734.15824980755229329454.stgit@chester>
 <20180623.211618.698435338116789998.davem@davemloft.net>
In-Reply-To: <20180623.211618.698435338116789998.davem@davemloft.net>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 23 Jun 2018 12:15:22 -0400
Message-ID: <CAHC9VhTrWh6D8-B-15eqGv=0WhqMyeeRnY8Km7VEkNQyowZjvA@mail.gmail.com>
To: davem@davemloft.net
Cc: Paul Moore <pmoore@redhat.com>, netdev@vger.kernel.org,
 selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] ipv6: avoid copy_from_user() via ipv6_renew_options_kern()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, Jun 23, 2018 at 8:16 AM David Miller <davem@davemloft.net> wrote:
>
> From: Paul Moore <pmoore@redhat.com>
> Date: Fri, 22 Jun 2018 17:18:20 -0400
>
> > From: Paul Moore <paul@paul-moore.com>
> >
> > The ipv6_renew_options_kern() function eventually called into
> > copy_from_user(), despite it not using any userspace buffers, which
> > was problematic as that ended up calling access_ok() which emited
> > a warning on x86 (and likely other arches as well).
> >
> >   ipv6_renew_options_kern()
> >     ipv6_renew_options()
> >       ipv6_renew_option()
> >         copy_from_user()
> >           _copy_from_user()
> >             access_ok()
> >
> > The access_ok() check inside _copy_from_user() is obviously the right
> > thing to do which means that calling copy_from_user() via
> > ipv6_renew_options_kern() is obviously the wrong thing to do.
>
> Ok, I re-read the code around here.
>
> access_ok() is not warning because we are calling copy_from_user()
> with a kernel pointer.  The set_ds(KERNEL_DS) adjusts the
> user_addr_max() setting, and thus that check passes.
>
> The problem is that we are invoking this from an interrupt, and this
> triggers the WARN_ON_IN_IRQ() in access_ok().
>
> Although I think that WARN_ON_IN_IRQ() is completely unnecessary when
> KERNEL_DS is set, the situation that really causes this problem is not
> at all clear from your commit message.
>
> I guess that for now your fix is fine, but I want you to please adjust
> the commit message.
>
> Provide the _full_ annotated kernel backtrace from the warning that
> triggers, because this will show the reader that we are in an
> interrupt.  And explain that being in the interrupt is strictly what
> causes this to warn, not that we are using kernel pointers.  The
> latter is %100 valid when set_fs(KERNEL_DS) is performed.
>
> Thank you.

Okay, so it's the right fix for all the wrong reasons :)

Thanks for the correction; I'll fixup the commit subject/description
and resend when I'm in front of the system with the patch (later this
weekend, early next week).

-- 
paul moore
www.paul-moore.com
