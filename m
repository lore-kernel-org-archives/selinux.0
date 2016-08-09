Subject: Re: [PATCH] policycoreutils: 'fixfiles check' should not change
 anything
To: Petr Lautrbach <plautrba@redhat.com>, selinux@tycho.nsa.gov
References: <1470749055-22365-1-git-send-email-plautrba@redhat.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <81e52662-d82b-d339-9024-e019b539cf0d@tycho.nsa.gov>
Date: Tue, 9 Aug 2016 16:24:01 -0400
MIME-Version: 1.0
In-Reply-To: <1470749055-22365-1-git-send-email-plautrba@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 08/09/2016 09:24 AM, Petr Lautrbach wrote:
> -n was not being passed down to restorecon properly in the code path
> for -C and -N
>
> Patch-by: Dan Callaghan <dcallagh@redhat.com>
> Signed-off-by: Petr Lautrbach <plautrba@redhat.com>

Applied.

Thanks,
Jim

> ---
>  policycoreutils/scripts/fixfiles | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 5c29eb9..fa43a53 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -150,8 +150,9 @@ fi
>  #
>  newer() {
>      DATE=$1
> +    shift
>      for m in `echo $FILESYSTEMSRW`; do
> -	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} -i -0 -f -
> +	find $m -mount -newermt $DATE -print0 2>/dev/null | ${RESTORECON} ${FORCEFLAG} ${VERBOSE} $* -i -0 -f -
>      done;
>
>  }
> @@ -190,7 +191,7 @@ if [ -f ${PREFC} -a -x /usr/bin/diff ]; then
>  		  esac; \
>  	       fi; \
>  	    done | \
> -	${RESTORECON} ${VERBOSE} -i -f - -R `exclude_dirs`; \
> +	${RESTORECON} ${VERBOSE} -i -f - -R $* `exclude_dirs`; \
>  	rm -f ${TEMPFILE} ${PREFCTEMPFILE}
>  fi
>  }
> @@ -222,7 +223,7 @@ if [ ! -z "$PREFC" ]; then
>      exit $?
>  fi
>  if [ ! -z "$BOOTTIME" ]; then
> -    newer $BOOTTIME
> +    newer $BOOTTIME $*
>      exit $?
>  fi
>  [ -x /usr/sbin/genhomedircon ] && /usr/sbin/genhomedircon
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
