Subject: Re: [PATCH 1/2] policycoreutils: fixfiles should handle path
 arguments more robustly
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
References: <20170326143551.9407-1-alan.christopher.jenkins@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <562eabdd-e7b8-33f8-3a7e-a59a35435505@tycho.nsa.gov>
Date: Tue, 28 Mar 2017 15:55:48 -0400
MIME-Version: 1.0
In-Reply-To: <20170326143551.9407-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/26/2017 10:35 AM, Alan Jenkins wrote:
> E.g. `fixfiles restore -v /usr` - before:
>
> Warning: Skipping the following R/O filesystems:
> /sys/fs/cgroup
> Progress and Verbose mutually exclusive
> usage:  /sbin/restorecon [-iFnprRv0] [-e excludedir] pathname...
> usage:  /sbin/restorecon [-iFnprRv0] [-e excludedir] -f filename
> Warning: Skipping the following R/O filesystems:
> /sys/fs/cgroup
> 229k
>
> after:
>
> Warning: Skipping the following R/O filesystems:
> /sys/fs/cgroup
> /sbin/restorecon:  lstat(-v) failed:  No such file or directory
> Warning: Skipping the following R/O filesystems:
> /sys/fs/cgroup
> 229k
>
> This matches the usage shown in the manual page.  While we're in there,
> we should handle spaces as well e.g `fixfiles restore "a b"`.  Before:
>
> Warning: Skipping the following R/O filesystems:
> /sys/fs/cgroup
> /sbin/restorecon:  lstat(b) failed:  No such file or directory
>
> After:
>
> Warning: Skipping the following R/O filesystems:
> /sys/fs/cgroup
> /sbin/restorecon:  lstat(a b) failed:  No such file or directory
>
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>

Both of these have been applied.

Thanks,
Jim

> ---
>  policycoreutils/scripts/fixfiles | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 3896d19..d3a53ba 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -248,7 +248,7 @@ if [ ! -z "$RPMFILES" ]; then
>      exit $?
>  fi
>  if [ ! -z "$FILEPATH" ]; then
> -    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* $FILEPATH 2>&1 | cat >> $LOGFILE
> +    ${RESTORECON} $exclude_dirs ${FORCEFLAG} ${VERBOSE} -R $* -- "$FILEPATH" 2>&1 | cat >> $LOGFILE
>      return
>  fi
>  if [  -n "${FILESYSTEMSRW}" ]; then
> @@ -400,7 +400,7 @@ else
>  	process $command
>      else
>  	while [ -n "$1" ]; do
> -	    FILEPATH=$1
> +	    FILEPATH="$1"
>  	    process $command
>  	    shift
>  	done
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
