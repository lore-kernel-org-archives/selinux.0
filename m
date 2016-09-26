Subject: Re: [PATCH 0/2] selinux: Add features to find
 security.restorecon_last entries
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1474903749-4941-1-git-send-email-richard_c_haines@btinternet.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <2c13a8be-de16-2ee2-6c87-aa403b70ded1@tycho.nsa.gov>
Date: Mon, 26 Sep 2016 14:14:38 -0400
MIME-Version: 1.0
In-Reply-To: <1474903749-4941-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/26/2016 11:29 AM, Richard Haines wrote:
> This patch adds a new selinux_restorecon_xattr(3) function and a
> supporting utility restorecon_xattr(8) to find and/or remove
> security.restorecon_last entries added by setfiles(8) or
> restorecon(8).
>
> Richard Haines (2):
>   libselinux: Add function to find security.restorecon_last entries
>   policycoreutils: setfiles - Utility to find security.restorecon_last
>     entries
>
>  libselinux/include/selinux/restorecon.h            |  48 +++++
>  libselinux/man/man3/selinux_restorecon.3           |   2 +
>  .../man/man3/selinux_restorecon_default_handle.3   |   6 +-
>  .../man/man3/selinux_restorecon_set_alt_rootpath.3 |   4 +-
>  .../man/man3/selinux_restorecon_set_exclude_list.3 |   4 +-
>  .../man/man3/selinux_restorecon_set_sehandle.3     |   9 +-
>  libselinux/man/man3/selinux_restorecon_xattr.3     | 170 ++++++++++++++++
>  libselinux/src/selinux_restorecon.c                | 207 +++++++++++++++++++
>  policycoreutils/setfiles/Makefile                  |  10 +-
>  policycoreutils/setfiles/restore.h                 |   1 +
>  policycoreutils/setfiles/restorecon_xattr.8        | 119 +++++++++++
>  policycoreutils/setfiles/restorecon_xattr.c        | 221 +++++++++++++++++++++
>  12 files changed, 789 insertions(+), 12 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_xattr.3
>  create mode 100644 policycoreutils/setfiles/restorecon_xattr.8
>  create mode 100644 policycoreutils/setfiles/restorecon_xattr.c
>

Applied both patches.

Thanks,
Jim

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
