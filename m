Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v63N32BQ007327
 for <selinux@tycho.nsa.gov>; Mon, 3 Jul 2017 19:03:03 -0400
Received: by mail-lf0-f67.google.com with SMTP id t72so16270083lff.0
 for <selinux@tycho.nsa.gov>; Mon, 03 Jul 2017 16:03:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSqk1cS+8wpphZgmZt40iMZKLVmUPmnWcjpgf3vqj9zmw@mail.gmail.com>
References: <1498833335-937-1-git-send-email-danielj@mellanox.com>
 <CAHC9VhSqk1cS+8wpphZgmZt40iMZKLVmUPmnWcjpgf3vqj9zmw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jul 2017 19:02:59 -0400
Message-ID: <CAHC9VhTedbdnV4_G-o2raZfxOiXEvSkEXk_CV80=7oamJ1LPyw@mail.gmail.com>
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

On Sat, Jul 1, 2017 at 9:40 AM, Paul Moore <paul@paul-moore.com> wrote:
> On Fri, Jun 30, 2017 at 10:35 AM, Dan Jurgens <danielj@mellanox.com> wrote:
>> From: Daniel Jurgens <danielj@mellanox.com>
>>
>> Check the return value from get_pkey_and_subnet_prefix to prevent using
>> uninitialized variables.
>>
>> Fixes: d291f1a65232 ("IB/core: Enforce PKey security on QPs")
>> Signed-off-by: Daniel Jurgens <danielj@mellanox.com>
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> ---
>>  drivers/infiniband/core/security.c | 20 ++++++++++++--------
>>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> Since the original patch went in via the SELinux tree, would the
> IB/RDMA folks prefer this to go in via the SELinux tree as well?

I went ahead and merged this into the selinux/stable-4.13 tree and I'm
doing a sanity build now, assuming all goes well I'll send this up for
v4.13.

-- 
paul moore
www.paul-moore.com
