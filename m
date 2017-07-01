Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v61DgWtr010217
 for <selinux@tycho.nsa.gov>; Sat, 1 Jul 2017 09:42:32 -0400
Received: by mail-lf0-f47.google.com with SMTP id b207so82978796lfg.2
 for <selinux@tycho.nsa.gov>; Sat, 01 Jul 2017 06:42:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
References: <1498835756-7610-1-git-send-email-danielj@mellanox.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 1 Jul 2017 09:42:26 -0400
Message-ID: <CAHC9VhQC4VO2W6TCOWxKdfsra=fG12ZYXaJdKQJVXtLz92XtoA@mail.gmail.com>
Subject: Re: [PATCH] IB/core: Fix static analysis warning in
 ib_policy_change_task
To: Dan Jurgens <danielj@mellanox.com>, linux-rdma@vger.kernel.org
Cc: dan.carpenter@oracle.com, dledford@redhat.com, selinux@tycho.nsa.gov,
 yevgenyp@mellanox.com
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Jun 30, 2017 at 11:15 AM, Dan Jurgens <danielj@mellanox.com> wrote:
> From: Daniel Jurgens <danielj@mellanox.com>
>
> ib_get_cached_subnet_prefix can technically fail, but the only way it
> could is not possible based on the loop conditions. Check the return
> value before using the variable sp to resolve a static analysis warning.
>
> Fixes: 8f408ab64be6 ("selinux lsm IB/core: Implement LSM notification
> system")
> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/infiniband/core/device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Similar question as with the other fix: SELinux tree or IB/RDMA tree?

-- 
paul moore
www.paul-moore.com
