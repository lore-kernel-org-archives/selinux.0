Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u6MGUMuB021482
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 12:30:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id c199so10843929oig.1
 for <selinux@tycho.nsa.gov>; Fri, 22 Jul 2016 09:29:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1468537011-20407-6-git-send-email-danielj@mellanox.com>
References: <1468537011-20407-1-git-send-email-danielj@mellanox.com>
 <1468537011-20407-6-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 22 Jul 2016 12:29:25 -0400
Message-ID: <CAHC9VhTRQ_jvdOPn-eszzHkb1+HL7ySaM5qK2pgX=9GFdjOcpg@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] selinux: Create policydb version for Infiniband
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

On Thu, Jul 14, 2016 at 6:56 PM, Dan Jurgens <danielj@mellanox.com> wrote:
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

We had a discussion about this in the last patchset and I think things
may have gotten confused.  From what I remember, according to the IB
developers the proper term is "end port"; if that is true, we probably
should use "end port", but I would prefer if we drop the underscore in
most of the places, e.g. "ib_endport" instead of "ib_end_port".

Sorry for the continuing nit pickiness.

> - Added bounds checking to port number. Paul Moore
> - Eliminated {} in OCON_PKEY case statement.  Yuval Shaia
> ---
>  security/selinux/include/security.h |    3 +-
>  security/selinux/ss/policydb.c      |  130 +++++++++++++++++++++++++++++++----
>  security/selinux/ss/policydb.h      |   27 +++++--
>  3 files changed, 136 insertions(+), 24 deletions(-)

-- 
paul moore
www.paul-moore.com
