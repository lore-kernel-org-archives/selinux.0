Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u811d5An003766
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 21:39:05 -0400
Received: by mail-oi0-f41.google.com with SMTP id p186so61418411oia.2
 for <selinux@tycho.nsa.gov>; Wed, 31 Aug 2016 18:39:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1469800416-125043-6-git-send-email-danielj@mellanox.com>
References: <1469800416-125043-1-git-send-email-danielj@mellanox.com>
 <1469800416-125043-6-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 31 Aug 2016 21:39:03 -0400
Message-ID: <CAHC9VhTF3erdxu+P3rZ3dn4dE+p4vgbyhKk1CmTwK333o-=-8g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] selinux: Create policydb version for Infiniband
 support
To: Dan Jurgens <danielj@mellanox.com>
Cc: chrisw@sous-sol.org, Stephen Smalley <sds@tycho.nsa.gov>,
 Eric Paris <eparis@parisplace.org>, dledford@redhat.com,
 sean.hefty@intel.com, hal.rosenstock@gmail.com, selinux@tycho.nsa.gov,
 linux-security-module@vger.kernel.org, linux-rdma@vger.kernel.org,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jul 29, 2016 at 9:53 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> Support for Infiniband requires the addition of two new object contexts,
> one for infiniband PKeys and another IB Ports. Added handlers to read
> and write the new ocontext types when reading or writing a binary policy
> representation.
>
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reviewed-by: Eli Cohen <eli@mellanox.com>
>
> ---
> v2:
> - Shorten ib_end_port to ib_port. Paul Moore
> - Added bounds checking to port number. Paul Moore
> - Eliminated {} in OCON_PKEY case statement.  Yuval Shaia

Nit picky, but you still have some curly braces in ocontext_read()
that aren't strictly necessary.

> v3:
> - ib_port -> ib_endport. Paul Moore
>
>  security/selinux/include/security.h |   3 +-
>  security/selinux/ss/policydb.c      | 130 +++++++++++++++++++++++++++++++-----
>  security/selinux/ss/policydb.h      |  27 +++++---
>  3 files changed, 136 insertions(+), 24 deletions(-)

-- 
paul moore
www.paul-moore.com
