Message-ID: <1492703075.669.1.camel@tycho.nsa.gov>
Subject: Re: [PATCH] libsemanage: remove lock files
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Guido Trentalancia <guido@trentalancia.net>, selinux@tycho.nsa.gov
Date: Thu, 20 Apr 2017 11:44:35 -0400
In-Reply-To: <58517705.198270.1492699110308@pim.register.it>
References: <58517705.198270.1492699110308@pim.register.it>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Thu, 2017-04-20 at 16:38 +0200, Guido Trentalancia wrote:
> Remove semanage read and transaction lock files upon releasing
> them.

Why?

> 
> Signed-off-by: Guido Trentalancia <guido@trentalancia.net>
> ---
>  src/semanage_store.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff -pruN a/src/semanage_store.c b/src/semanage_store.c
> --- a/src/semanage_store.c	2016-10-14 17:31:26.000000000 +0200
> +++ b/src/semanage_store.c	2017-04-03 09:32:24.093627962 +0200
> @@ -1904,6 +1904,7 @@ void semanage_release_trans_lock(semanag
>  		close(sh->u.direct.translock_file_fd);
>  		sh->u.direct.translock_file_fd = -1;
>  	}
> +	unlink(semanage_files[SEMANAGE_TRANS_LOCK]);
>  	errno = errsv;
>  }
>  
> @@ -1917,6 +1918,7 @@ void semanage_release_active_lock(semana
>  		close(sh->u.direct.activelock_file_fd);
>  		sh->u.direct.activelock_file_fd = -1;
>  	}
> +	unlink(semanage_files[SEMANAGE_READ_LOCK]);
>  	errno = errsv;
>  }
