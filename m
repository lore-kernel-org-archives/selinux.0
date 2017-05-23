Message-ID: <1495569616.8461.11.camel@tycho.nsa.gov>
Subject: Re: [PATCH 2/2] libsepol: use the number of elements in calloc
 first argument
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Tue, 23 May 2017 16:00:16 -0400
In-Reply-To: <20170520101141.6207-2-nicolas.iooss@m4x.org>
References: <20170520101141.6207-1-nicolas.iooss@m4x.org>
 <20170520101141.6207-2-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Sat, 2017-05-20 at 12:11 +0200, Nicolas Iooss wrote:
> When allocating an array with calloc(), the first argument usually is
> the number of items and the second one the size of an item. Doing so
> silences a warning reported by clang's static analyzer:
> 
>     kernel_to_cil.c:2050:14: warning: Call to 'calloc' has an
> allocation
>     size of 0 bytes.
>             cond_data = calloc(sizeof(struct cond_data), num);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Thanks, applied both.

> ---
>  libsepol/src/kernel_to_cil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/kernel_to_cil.c
> b/libsepol/src/kernel_to_cil.c
> index 3a1c0be76f45..498e2947f6cb 100644
> --- a/libsepol/src/kernel_to_cil.c
> +++ b/libsepol/src/kernel_to_cil.c
> @@ -2043,7 +2043,7 @@ static int write_cond_nodes_to_cil(FILE *out,
> struct policydb *pdb)
>  		num++;
>  	}
>  
> -	cond_data = calloc(sizeof(struct cond_data), num);
> +	cond_data = calloc(num, sizeof(struct cond_data));
>  	if (!cond_data) {
>  		rc = -1;
>  		goto exit;
