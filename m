Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u34Mr14B016254
 for <selinux@tycho.nsa.gov>; Mon, 4 Apr 2016 18:53:01 -0400
Received: by mail-io0-f178.google.com with SMTP id g185so167989987ioa.2
 for <selinux@tycho.nsa.gov>; Mon, 04 Apr 2016 15:52:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1459806504-16135-2-git-send-email-danielj@mellanox.com>
References: <1459806504-16135-1-git-send-email-danielj@mellanox.com>
 <1459806504-16135-2-git-send-email-danielj@mellanox.com>
Date: Tue, 5 Apr 2016 01:52:58 +0300
Message-ID: <CAJ3xEMjFfcju=wCsSqsw=RDeXz=TfTg9XLaA95vMYxGJv5mP7w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] security: Add LSM hooks for Infiniband security
From: Or Gerlitz <gerlitz.or@gmail.com>
To: Dan Jurgens <danielj@mellanox.com>
Cc: selinux@tycho.nsa.gov, linux-security-module@vger.kernel.org,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Yevgeny Petrilin <yevgenyp@mellanox.com>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, Apr 5, 2016 at 12:48 AM, Dan Jurgens <danielj@mellanox.com> wrote:

> --- a/include/linux/lsm_hooks.h
> +++ b/include/linux/lsm_hooks.h
> @@ -8,6 +8,7 @@
>   * Copyright (C) 2001 Silicon Graphics, Inc. (Trust Technology Group)
>   * Copyright (C) 2015 Intel Corporation.
>   * Copyright (C) 2015 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright (C) 2016 Mellanox Techonologies. <danielj@mellanox.com>

Hi Dan,

I don't see the point to use personal copyright credits in our
upstream development. AFAIK, we don't do that for the NIC side
patches, if you don't mind, lets avoid that.

Or.
