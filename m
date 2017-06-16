Message-ID: <1497631982.7898.3.camel@tycho.nsa.gov>
Subject: Re: [PATCH] policycoreutils/fixfiles: do not dereference link files
 in tmp
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Vit Mojzis <vmojzis@redhat.com>, selinux@tycho.nsa.gov
Date: Fri, 16 Jun 2017 12:53:02 -0400
In-Reply-To: <20170616082959.20461-1-vmojzis@redhat.com>
References: <20170616082959.20461-1-vmojzis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, 2017-06-16 at 10:29 +0200, Vit Mojzis wrote:
> Files in /tmp, /var/tmp, /var/run and /var/lib/debug labeled as
> unlabeled_t or undefined_t are relabeled to match corresponding
> directory label. Stop dereferencing link files in these folders
> in order not to accidentally change label of other files in the
> system.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1458831
> 
> Signed-off-by: Vit Mojzis <vmojzis@redhat.com>

Thanks, applied.

> ---
>  policycoreutils/scripts/fixfiles | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles
> b/policycoreutils/scripts/fixfiles
> index 0eeeea4..1aa330f 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -255,10 +255,10 @@ case "$RESTORE_MODE" in
>  	UNDEFINED=`get_undefined_type` || exit $?
>  	UNLABELED=`get_unlabeled_type` || exit $?
>  	find /tmp \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) \( -type s -o -type p \) -delete
> -	find /tmp \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --reference /tmp {} \;
> -	find /var/tmp \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --reference /var/tmp {} \;
> -	find /var/run \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --reference /var/run {} \;
> -	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context
> "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --
> reference /lib {} \;
> +	find /tmp \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference /tmp {}
> \;
> +	find /var/tmp \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference
> /var/tmp {} \;
> +	find /var/run \( -context "*:${UNLABELED}*" -o -context
> "*:${UNDEFINED}*" \) -exec chcon --no-dereference --reference
> /var/run {} \;
> +	[ ! -e /var/lib/debug ] || find /var/lib/debug \( -context
> "*:${UNLABELED}*" -o -context "*:${UNDEFINED}*" \) -exec chcon --no-
> dereference --reference /lib {} \;
>      ;;
>  esac
>  }
