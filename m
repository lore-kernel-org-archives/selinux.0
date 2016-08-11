Subject: Re: [PATCH V3 0/4] Update setfiles/restorecon to support
 selinux_restorecon
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1469522556-3022-1-git-send-email-richard_c_haines@btinternet.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <89dbfc4c-1a9e-b4d3-8dc4-cca788e331bf@tycho.nsa.gov>
Date: Thu, 11 Aug 2016 14:53:56 -0400
MIME-Version: 1.0
In-Reply-To: <1469522556-3022-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 07/26/2016 04:42 AM, Richard Haines wrote:
> These patches:
> 1) Add additional services to selinux_restorecon(3) so that setfiles(8)
> functionality can be supported.
> 2) Modify setfiles(8), restorecon(8) and restorecond(8) to make use of the
> new libselinux functions.
>
> I've supported all options except -q of the current restorecon(8) and
> setfiles(8) in selinux_restorecon_* services.
>
> The output from these commands should be much the same as before
> with some minor wording changes, the only exceptions being that the
> following options have been added (see man pages for details):
> 1) -I to ignore the digest on directories.
> 2) -m to ignore reading /proc/mounts.
>
> Changes for V2
> 1) All requested changes have been completed as per [1], [2] and [3].
> 2) As selinux_restorecon_set_alt_rootpath(3) and
> selinux_restorecon_set_exclude_list(3) now allocate memory etc. they return
> errors (they were void).
>
> Changes for V3
> 1) All requested changes have been completed as per [4], [5] and [6].
> 2) Reverted selinux_restorecon_set_exclude_list(3) to void as already released.
> 3) Included patch 4/4 for restorecond.
>
> Richard Haines (4):
>   libselinux: Evaluate inodes in selinux_restorecon(3)
>   libselinux: Add setfiles support to selinux_restorecon(3)
>   policycoreutils: setfiles - Modify to use selinux_restorecon
>   policycoreutils: restorecond - Modify to use selinux_restorecon
>
>  libselinux/include/selinux/restorecon.h            | 105 ++-
>  libselinux/man/man3/selinux_restorecon.3           |  85 ++-
>  .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  35 +
>  .../man/man3/selinux_restorecon_set_exclude_list.3 |   9 +-
>  .../man/man3/selinux_restorecon_set_sehandle.3     |   4 +-
>  libselinux/src/selinux_restorecon.c                | 738 ++++++++++++++++++---
>  libselinux/utils/selinux_restorecon.c              |  52 +-
>  policycoreutils/restorecond/restorecond.c          |  45 +-
>  policycoreutils/restorecond/restorecond.h          |   2 +
>  policycoreutils/restorecond/watch.c                |  25 +-
>  policycoreutils/setfiles/restore.c                 | 719 ++------------------
>  policycoreutils/setfiles/restore.h                 |  52 +-
>  policycoreutils/setfiles/restorecon.8              |  85 ++-
>  policycoreutils/setfiles/setfiles.8                |  86 ++-
>  policycoreutils/setfiles/setfiles.c                | 214 +++---
>  15 files changed, 1271 insertions(+), 985 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
>

Applied.

Thanks,

-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
