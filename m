Message-ID: <1485283025.8139.20.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils: let output of `fixfiles` be redirected
 (as normal)
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
Date: Tue, 24 Jan 2017 13:37:05 -0500
In-Reply-To: <20170123121550.6818-1-alan.christopher.jenkins@gmail.com>
References: <20170123121550.6818-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Mon, 2017-01-23 at 12:15 +0000, Alan Jenkins wrote:
> fixfiles was redirecting log output to `tty`.  This overrides user
> intent
> e.g. when shell redirection is used.
> 
> Redirect it to stdout, using /proc.  `tty` equally depended on /proc.
> We do not depend on /dev/stdout: it might not be present, if a rescue
> system is booted with devtmpfs (no udev daemon).
> 
> By default, log messages were redirected into the void when not run
> from a
> tty.  We consider this a bug, which is now fixed.
> 
> 1. If calling scripts happen to require the old behaviour, they can
> easily
>    write the same code themselves.
> 
> 2. When fixfiles is run from Fedora's selinux-autorelabel.service,
>    the calling script is specifically run from a tty.
> 
>    Also Fedora's calling script chooses to redirect stdout and stderr
> to
>    /dev/null.  This redirection will now suceed, improving the
> transparency
>    of the code.  The previous behaviour may be obtained by choosing
> not
>    to redirect the progress messages of this long-running process to
>    /dev/null.  A patch has been submitted to Fedora to suggest this
> novel
>    approach:  https://bugzilla.redhat.com/show_bug.cgi?id=1415674
> 
> 
> Complete disclosure:
> 
> * Remove unused variable LOGGER.
> * Fix logfiles containing spaces.
> 
> 
> Disclaimer:
> 
> 1. "Log" output may contain escape sequences (backspace?) e.g. in
>    `fixfiles -l log.txt restore`.  This is not the usual
> understanding
>    of a log file.
> 
> 2.  For some reason, not all informative messages are sent to `-l`
> e.g.
>    the list of filesystems, and "cleaning up labels on /tmp".
> 
> 3. `function logit` is retained, but the logfile is also written to
>    outside this function.  Implementing support for the system log
>    would require another function which accepts piped input.
>    Also see point 1.

Thanks, applied.

> 
> Signed-off-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> ---
>  policycoreutils/scripts/fixfiles | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles
> b/policycoreutils/scripts/fixfiles
> index fa43a53..df6f766 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -119,11 +119,7 @@ VERBOSE="-p"
>  FORCEFLAG=""
>  DIRS=""
>  RPMILES=""
> -LOGFILE=`tty`
> -if [ $? != 0 ]; then
> -    LOGFILE="/dev/null"
> -fi
> -LOGGER=/usr/sbin/logger
> +LOGFILE=/proc/self/fd/1
>  SETFILES=/sbin/setfiles
>  RESTORECON=/sbin/restorecon
>  FILESYSTEMSRW=`get_rw_labeled_mounts`
> @@ -138,11 +134,11 @@ else
>  fi
>  
>  #
> -# Log to either syslog or a LOGFILE
> +# Write to LOGFILE
>  #
>  logit () {
>  if [ -n $LOGFILE ]; then
> -    echo $1 >> $LOGFILE
> +    echo $1 >> "$LOGFILE"
>  fi
>  }
>  #
