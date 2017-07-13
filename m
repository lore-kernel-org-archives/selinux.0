Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v6DLuW1S001323
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 17:56:32 -0400
Received: by mail-lf0-f68.google.com with SMTP id z78so6683903lff.2
 for <selinux@tycho.nsa.gov>; Thu, 13 Jul 2017 13:59:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1499967307.624.12.camel@tycho.nsa.gov>
References: <1499944132-6721-1-git-send-email-mmalik@redhat.com>
 <1499964819.624.8.camel@tycho.nsa.gov> <1499967307.624.12.camel@tycho.nsa.gov>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jul 2017 16:59:53 -0400
Message-ID: <CAHC9VhT84tFE8Y-At=Awd67mh_O6CwcK7Pc3=kunpo7Pdub6Vw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Milos Malik <mmalik@redhat.com>, selinux@tycho.nsa.gov
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH] Additional tests for long-time supported netlink classes
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, Jul 13, 2017 at 1:35 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> Also, I wanted to mention that this still doesn't address testing of
> the finer-grained permissions for netlink sockets, e.g.
> nlmsg_read/write/..., as noted in the open issue:
> https://github.com/SELinuxProject/selinux-testsuite/issues/17
>
> That isn't an obstacle to taking this one, but wanted to note that we
> still want to address that at some point.

Agreed.  I still think that Milos' patch is an improvement and worth
merging once the RHEL-7 are answered/resolved (your previous email).

> Also, on the kernel side, we might want to consider defining those
> permissions for more of the netlink socket classes, particularly the
> newer ones, if/where it makes sense to do so.  Or, alternatively, to
> implement support analogous to the ioctl whitelisting support for
> netlink messages so that we can do fine-grained restrictions there.

Yes, definitely.  Long term I think doing something similar to what
was done for the individual ioctls is the best solution, but I'd be
happy to accept netlink permission mapping updates in the meantime.

-- 
paul moore
www.paul-moore.com
