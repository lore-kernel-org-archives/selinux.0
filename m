Received: from goalie.tycho.ncsc.mil (goalie.infosec.tycho.ncsc.mil
 [144.51.242.250])
 by tarius.infosec.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w5PMf2gm016594
 for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2018 18:41:02 -0400
Received: by mail-oi0-f65.google.com with SMTP id c6-v6so14130205oiy.0
 for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2018 15:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180625163425.216965-1-jannh@google.com>
 <CAHC9VhTipjBx9CF4FdTbc2a8bSqKqWiHfi9Krv=Lu74Yvquyrg@mail.gmail.com>
In-Reply-To: <CAHC9VhTipjBx9CF4FdTbc2a8bSqKqWiHfi9Krv=Lu74Yvquyrg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 26 Jun 2018 00:40:46 +0200
Message-ID: <CAG48ez1v3J_VYnrP1RRCf936pvakphGQzvZZWw6tojiHA-BAxw@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, Eric Paris <eparis@parisplace.org>,
 selinux@tycho.nsa.gov, security@kernel.org,
 kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] selinux: move user accesses in selinuxfs out of
 locked regions
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Jun 26, 2018 at 12:36 AM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Jun 25, 2018 at 12:34 PM Jann Horn <jannh@google.com> wrote:
> > If a user is accessing a file in selinuxfs with a pointer to a userspace
> > buffer that is backed by e.g. a userfaultfd, the userspace access can
> > stall indefinitely, which can block fsi->mutex if it is held.
> >
> > For sel_read_policy(), remove the locking, since this method doesn't seem
> > to access anything that requires locking.
>
> Forgive me, I'm thinking about this quickly so I could be very wrong
> here, but isn't the mutex needed to prevent problems in multi-threaded
> apps hitting the same fd at the same time?

sel_read_policy() operates on a read-only copy of the policy, accessed
via ->private_data, allocated using vmalloc in sel_open_policy() via
security_read_policy(). As far as I can tell, nothing can write to
that read-only copy of the policy. None of the handlers in
sel_policy_ops write - they just mmap as readonly (in which case
you're already reading without locks, by the way) or read.
