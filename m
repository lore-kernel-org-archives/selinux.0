Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u7J05ata000926
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 20:05:37 -0400
Received: by mail-oi0-f65.google.com with SMTP id b22so5002585oii.3
 for <selinux@tycho.nsa.gov>; Thu, 18 Aug 2016 17:05:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471290132-26336-1-git-send-email-william.c.roberts@intel.com>
References: <1471290132-26336-1-git-send-email-william.c.roberts@intel.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 18 Aug 2016 20:05:29 -0400
Message-ID: <CAHC9VhR9A6cZT5OxXTf1wyD+z+Er8EXX1Bzz4G5PA6s-=HZ1ag@mail.gmail.com>
Subject: Re: [PATCH] selinux: drop SECURITY_SELINUX_POLICYDB_VERSION_MAX
To: william.c.roberts@intel.com
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
 seandroid-list@tycho.nsa.gov
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, Aug 15, 2016 at 3:42 PM,  <william.c.roberts@intel.com> wrote:
> From: William Roberts <william.c.roberts@intel.com>
>
> Remove the SECURITY_SELINUX_POLICYDB_VERSION_MAX Kconfig option
>
> Per: https://github.com/SELinuxProject/selinux/wiki/Kernel-Todo
>
> This was only needed on Fedora 3 and 4 and just causes issues now,
> so drop it.
>
> The MAX and MIN should just be whatever the kernel can support.
>
> Signed-off-by: William Roberts <william.c.roberts@intel.com>
> ---
>  security/selinux/Kconfig            | 38 -------------------------------------
>  security/selinux/include/security.h |  4 ----
>  2 files changed, 42 deletions(-)

Merged, thanks for the help!

-- 
paul moore
www.paul-moore.com
