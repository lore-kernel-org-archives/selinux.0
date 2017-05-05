Subject: Re: [PATCH 1/6] Revert "policycoreutils: let output of `fixfiles` be
 redirected (as normal)"
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
References: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <3ce2580b-19e7-ecb9-1483-aa30e4c51049@tycho.nsa.gov>
Date: Fri, 5 May 2017 13:31:30 -0400
MIME-Version: 1.0
In-Reply-To: <20170504170122.26882-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/04/2017 01:01 PM, Alan Jenkins wrote:
> This reverts commit ac7899fc3ad6221e195dd13cdf14b346897314ae,
> which is not yet part of an officially tagged release
> (or release candidate).
> 
> `LOGFILE=/proc/self/fd/1` was wrong.
> 
> `LOGFILE=$(tty)` was being relied on in one case (exclude_dirs),
> to log messages from a function run specifically with stdout redirected
> (captured into a variable).
> 
> Having `logit "message"` break inside redirected functions
> is a nasty leaky abstraction.
> 
> This caused e.g. `fixfiles restore` to terminate early with the error
> 
>      skipping: No such file or directory
> 
> if the user had configured any excluded paths in
> /etc/selinux/fixfiles_exclude_dirs

These six patches have been applied.

Thanks,
Jim

> ---
>   policycoreutils/scripts/fixfiles | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index bc74d69..75d7762 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -119,7 +119,11 @@ VERBOSE="-p"
>   FORCEFLAG=""
>   DIRS=""
>   RPMILES=""
> -LOGFILE=/proc/self/fd/1
> +LOGFILE=`tty`
> +if [ $? != 0 ]; then
> +    LOGFILE="/dev/null"
> +fi
> +LOGGER=/usr/sbin/logger
>   SETFILES=/sbin/setfiles
>   RESTORECON=/sbin/restorecon
>   FILESYSTEMSRW=`get_rw_labeled_mounts`
> @@ -134,11 +138,11 @@ else
>   fi
>   
>   #
> -# Write to LOGFILE
> +# Log to either syslog or a LOGFILE
>   #
>   logit () {
>   if [ -n $LOGFILE ]; then
> -    echo $1 >> "$LOGFILE"
> +    echo $1 >> $LOGFILE
>   fi
>   }
>   #
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
