To: Alan Jenkins <alan.christopher.jenkins@gmail.com>, selinux@tycho.nsa.gov
References: <20180512124309.26362-1-alan.christopher.jenkins@gmail.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <f87605aa-3345-3f8c-9647-dbdd5f3801f5@tycho.nsa.gov>
Date: Tue, 15 May 2018 13:52:14 -0400
MIME-Version: 1.0
In-Reply-To: <20180512124309.26362-1-alan.christopher.jenkins@gmail.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH] policycoreutils: fixfiles: failure to create
 /.autorelabel is fatal
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/12/2018 08:43 AM, Alan Jenkins wrote:
> Fix the following ambiguous output (from booting with init=/bin/sh):
> 
>     # /usr/sbin/fixfiles onboot
>     /usr/sbin/fixfiles: line 313: /.autorelabel: Read-only file system
>     /usr/sbin/fixfiles: line 317: /.autorelabel: Read-only file system
>     System will relabel on next boot
> 
> System will not relabel on next boot if we couldn't create ./autorelabel
> 
> (In case anyone reading this description is still confused: To run
> `fixfiles onboot` after booting with init=/bin/sh, you must first run
> `mount / -oremount,rw`).

Thanks, applied.

> ---
>  policycoreutils/scripts/fixfiles | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/policycoreutils/scripts/fixfiles b/policycoreutils/scripts/fixfiles
> index 0eeeea46..69bd8488 100755
> --- a/policycoreutils/scripts/fixfiles
> +++ b/policycoreutils/scripts/fixfiles
> @@ -309,7 +309,7 @@ case "$1" in
>  	    usage
>  	    exit 1
>  	fi
> -	> /.autorelabel
> +	> /.autorelabel || exit $?
>  	[ -z "$FORCEFLAG" ] || echo -n "$FORCEFLAG " >> /.autorelabel
>  	[ -z "$BOOTTIME" ] || echo -N $BOOTTIME >> /.autorelabel
>  	# Force full relabel if / does not have a label on it
> 
