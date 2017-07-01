Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v61DeXmf009704
 for <selinux@tycho.nsa.gov>; Sat, 1 Jul 2017 09:40:33 -0400
Received: by mail-lf0-f65.google.com with SMTP id n136so11923643lfn.2
 for <selinux@tycho.nsa.gov>; Sat, 01 Jul 2017 06:40:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498833335-937-1-git-send-email-danielj@mellanox.com>
References: <1498833335-937-1-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Jul 2017 09:40:02 -0400
Message-ID: <CAHC9VhSqk1cS+8wpphZgmZt40iMZKLVmUPmnWcjpgf3vqj9zmw@mail.gmail.com>
Subject: Re: [PATCH] IB/core: Fix uninitialized variable use in
 check_qp_port_pkey_settings
To: Dan Jurgens <danielj@mellanox.com>, linux-rdma@vger.kernel.org
Cc: dan.carpenter@oracle.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 30, 2017 at 10:35 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> Check the return value from get_pkey_and_subnet_prefix to prevent using
> uninitialized variables.
>
> Fixes: d291f1a65232 ("IB/core: Enforce PKey security on QPs")
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/security.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)

Since the original patch went in via the SELinux tree, would the
IB/RDMA folks prefer this to go in via the SELinux tree as well?

-- 
paul moore
www.paul-moore.com
