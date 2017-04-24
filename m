Message-ID: <1493042781.13274.12.camel@tycho.nsa.gov>
Subject: Re: [RFC PATCH 0/1] libselinux: Add support for
 selinux_check_access_flags
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
Date: Mon, 24 Apr 2017 10:06:21 -0400
In-Reply-To: <20170424130919.5286-1-richard_c_haines@btinternet.com>
References: <20170424130919.5286-1-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-04-24 at 14:09 +0100, Richard Haines wrote:
> Only wanted the avd flags to check whether the domain was permissive
> or not using an selinux_check_access() type call.

Why?  What's the intended user?

> 
> As a consequence of implementing selinux_check_access_flags,
> additional
> calls have been added to avc.c: avc_has_perm_flags() and
> avc_has_perm_noaudit_flags(). Added man page entries for them but not
> sure
> if they should be hidden.
> 
> Richard Haines (1):
>   libselinux: Add support for selinux_check_access_flags
> 
>  libselinux/include/selinux/avc.h                 |  68 +++++++
>  libselinux/include/selinux/selinux.h             |  32 +++
>  libselinux/man/man3/avc_has_perm.3               |  37 +++-
>  libselinux/man/man3/security_compute_av.3        |  21 +-
>  libselinux/man/man3/selinux_check_access_flags.3 |   1 +
>  libselinux/src/avc.c                             |  44 ++++-
>  libselinux/src/avc_internal.h                    |   1 +
>  libselinux/src/checkAccess.c                     |  63 +++---
>  libselinux/utils/.gitignore                      |   2 +
>  libselinux/utils/avc_has_perm.c                  | 235
> +++++++++++++++++++++++
>  libselinux/utils/selinux_check_access.c          | 189
> ++++++++++++++++++
>  11 files changed, 660 insertions(+), 33 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_check_access_flags.3
>  create mode 100644 libselinux/utils/avc_has_perm.c
>  create mode 100644 libselinux/utils/selinux_check_access.c
> 
