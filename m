Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v8CM10he015547
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 18:01:00 -0400
Received: by mail-lf0-f42.google.com with SMTP id q132so29726108lfe.5
 for <selinux@tycho.nsa.gov>; Tue, 12 Sep 2017 15:00:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFyoctVqwQgOczJ32aOm5xRv0gWyDY9XmUoEBa0XoJ2BJA@mail.gmail.com>
References: <CAHC9VhQr8R-=Sgqb7biFkz3G_dAAQG-PRMGe+Lp7SvoHKM=v+w@mail.gmail.com>
 <CA+55aFyoctVqwQgOczJ32aOm5xRv0gWyDY9XmUoEBa0XoJ2BJA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 12 Sep 2017 18:00:29 -0400
Message-ID: <CAHC9VhQL6CL9bk_HNfUr+4RyNvmTC=Qn3NkPV8xk+rbjFOhNgA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: James Morris <jmorris@namei.org>, selinux@tycho.nsa.gov,
 LSM List <linux-security-module@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [GIT PULL] SELinux patches for v4.14
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Sep 12, 2017 at 4:24 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Sep 12, 2017 at 10:33 AM, Paul Moore <paul@paul-moore.com> wrote:
>> As discussed on the linux-security pull request thread, this is the
>> direct SELinux pull request; the content/tag is the same as what I
>> sent to James/linux-security earlier:
>
> The contents may be the same, but the base is different.
>
> In particular, you based it on the security tree that already had a
> few other patches, so now that branch contains not just selinux work,
> but also a couple of tomoyo patches that came in that way.
>
> Anyway, I pulled this simply because it was easier to review and
> didn't have anything I disliked per se, but if we're going to actually
> keep the different securlty layers separate, they need to also have
> clean bases for the work in the future.
>
> Anyway, I'm at the airport on my way back home, and hopefully I'll be
> back to normal tomorrow after a good night's sleep, and I can take a
> look at the rest.

Oof, sorry about the base mixup; I'll change the SELinux tree base
moving forward so this shouldn't happen again.

-- 
paul moore
www.paul-moore.com
