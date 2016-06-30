Subject: Re: [PATCH V2 2/3] libselinux: Add setfiles support to
 selinux_restorecon(3)
To: Richard Haines <richard_c_haines@btinternet.com>, selinux@tycho.nsa.gov
References: <1466365100-8091-1-git-send-email-richard_c_haines@btinternet.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <5d811fe8-853c-54be-bba0-57d30d9d4f9f@tycho.nsa.gov>
Date: Thu, 30 Jun 2016 11:28:11 -0400
MIME-Version: 1.0
In-Reply-To: <1466365100-8091-1-git-send-email-richard_c_haines@btinternet.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/19/2016 03:38 PM, Richard Haines wrote:
> Add additional error handling, flags, xdev handling, alt_rootpath
> and add/remove non-seclabel fs's to support  setfiles(8)
> functionality.
> 
> Signed-off-by: Richard Haines <richard_c_haines@btinternet.com>
> ---
> V2 changes as per http://marc.info/?l=selinux&m=146470835908849&w=2
> plus selinux_restorecon_set_alt_rootpath() and
> selinux_restorecon_set_exclude_list now return errors (were void before).
> 
>  libselinux/include/selinux/restorecon.h            |  49 ++-
>  libselinux/man/man3/selinux_restorecon.3           |  73 +++-
>  .../man/man3/selinux_restorecon_set_alt_rootpath.3 |  35 ++
>  .../man/man3/selinux_restorecon_set_exclude_list.3 |  16 +-
>  .../man/man3/selinux_restorecon_set_sehandle.3     |   4 +-
>  libselinux/src/selinux_restorecon.c                | 453 +++++++++++++++++++--
>  libselinux/utils/selinux_restorecon.c              |  42 +-
>  7 files changed, 589 insertions(+), 83 deletions(-)
>  create mode 100644 libselinux/man/man3/selinux_restorecon_set_alt_rootpath.3
> 
>
> diff --git a/libselinux/src/selinux_restorecon.c b/libselinux/src/selinux_restorecon.c
> index 7a355e7..6924c89 100644
> --- a/libselinux/src/selinux_restorecon.c
> +++ b/libselinux/src/selinux_restorecon.c
> @@ -63,26 +92,213 @@ static void restorecon_init(void)
>  		sehandle = selinux_restorecon_default_handle();
>  		selinux_restorecon_set_sehandle(sehandle);
>  	}
> +
> +	efile_count = 0;
> +	if (!ignore_mounts)
> +		efile_count = exclude_non_seclabel_mounts(exclude_count);
>  }
>  
>  static pthread_once_t fc_once = PTHREAD_ONCE_INIT;
>  
> -
> -static int check_excluded(const char *file)
> +/*
> + * Manage excluded directories:
> + *  remove_exclude() - This removes any conflicting entries as there could be
> + *                     a case where a non-seclabel fs is mounted on /foo and
> + *                     then a seclabel fs is mounted on top of it.
> + *
> + *  add_exclude()    - Add a directory/fs to be excluded from labeling.
> + *
> + *  check_excluded() - Check if directory/fs is to be excluded when relabeling.
> + *                     The only case where an excluded directory is ignored, is
> + *                     if the caller specifically requests that a directory
> + *                     is to be relabeled by calling selinux_restorecon(3)
> + *                     with that directory as the pathname parameter.
> + *
> + *  file_system_count() - Calculates the the number of files to be processed.
> + *                        The count is only used if SELINUX_RESTORECON_PROGRESS
> + *                        is set and a mass relabel is requested.
> + *
> + *  exclude_non_seclabel_mounts() - Reads /proc/mounts to determine what
> + *                                  non-seclabel mounts to exclude from
> + *                                  relabeling. restorecon_init() will not
> + *                                  call this function if the
> + *                                  SELINUX_RESTORECON_IGNORE_MOUNTS
> + *                                  flag is set.
> + */
> +static void remove_exclude(const char *directory, int exclude_from_ctr)
>  {
>  	int i;
>  
> -	for (i = 0; fc_exclude_list[i]; i++) {
> -		if (strcmp(file, fc_exclude_list[i]) == 0)
> +	for (i = exclude_from_ctr; i < exclude_count; i++) {
> +		if (strcmp(directory, exclude_lst[i].directory) == 0) {
> +			free(exclude_lst[i].directory);

You aren't replacing the entry with another one, or decrementing the
exclude_count, unlike setfiles/restore.c?  What prevents this freed
pointer from being used later?

Also not sure what you are doing with exclude_from_ctr.  If I do a
restorecon -e /proc /, then /proc will get added twice, once by
exclude_non_seclabel_mounts() and once by the option, and I don't think
you'll deduplicate it here.  Or even just restorecon -e /proc -e /home
-e /proc -e /home?
