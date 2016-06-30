Subject: Re: [PATCH V2 0/3] Update setfiles/restorecon to support
 selinux_restorecon
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1466364986-7989-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <ae348289-9168-8ee9-debe-834cc9d7ac96@tycho.nsa.gov>
Date: Thu, 30 Jun 2016 10:43:47 -0400
MIME-Version: 1.0
In-Reply-To: <1466364986-7989-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2016 03:36 PM, Richard Haines wrote:
> These patches:
> 1) Add additional services to selinux_restorecon(3) so that setfiles(8)
> functionality can be supported.
> 2) Modify setfiles(8) and restorecon(8) to make use of the new libselinux
> functions.
> 
> I've supported all options except -q of the current restorecon(8) and
> setfiles(8) in selinux_restorecon_* services.
> 
> There is a new option of -I to ignore the digest as explained in the updated
> man pages.
> 
> The output from these commands should be much the same as before (some minor
> wording changes).
> 
> Changes for V2
> 1) All requested changes have been completed as per [1], [2] and [3].
> 2) As selinux_restorecon_set_alt_rootpath(3) and
> selinux_restorecon_set_exclude_list(3) now allocate memory etc. they return
> errors (they were void).

Unfortunately, we can't do that if they were included in a prior release
(e.g. 2.5).  That would be an ABI incompatibility.  Options:
1) Use symbol versioning.  This would require adding a linker version
script / map file to libselinux like we already have for libsepol and
libsemanage, and defining an old and new version of the symbol so that
existing binaries can keep using the void interface and programs
compiled against the new library can use the int interface.
2) Just leave it void and abort or something on memory allocation failure.
3) Leave the functions unchanged, i.e. don't allocate memory (but I
think this will be problematic in the future).

> 
> [1] http://marc.info/?l=selinux&m=146470027405908&w=2
> [2] http://marc.info/?l=selinux&m=146470835908849&w=2
> [3] http://marc.info/?l=selinux&m=146470720008392&w=2
> 
> Richard Haines (3):
>   libselinux: Evaluate inodes in selinux_restorecon(3)
>   libselinux: Add setfiles support to selinux_restorecon(3)
>   policycoreutils: setfiles - Modify to use selinux_restorecon
> 
>  libselinux/include/selinux/restorecon.h            | 109 +++-
>  libselinux/man/man3/selinux_restorecon.3           |  80 ++-
>  .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  35 +
>  .../man/man3/selinux_restorecon_set_exclude_list.3 |  16 +-
>  .../man/man3/selinux_restorecon_set_sehandle.3     |   4 +-
>  libselinux/src/selinux_restorecon.c                | 710 ++++++++++++++++++--
>  libselinux/utils/selinux_restorecon.c              |  52 +-
>  policycoreutils/setfiles/restore.c                 | 718 ++-------------------
>  policycoreutils/setfiles/restore.h                 |  51 +-
>  policycoreutils/setfiles/restorecon.8              |  74 ++-
>  policycoreutils/setfiles/setfiles.8                |  75 ++-
>  policycoreutils/setfiles/setfiles.c                | 198 +++---
>  12 files changed, 1201 insertions(+), 921 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
> 
