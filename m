To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20180603162541.28136-1-nicolas.iooss@m4x.org>
 <20180603162541.28136-4-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <145542e0-95d4-8336-64d3-8ed87cc29941@tycho.nsa.gov>
Date: Wed, 6 Jun 2018 16:03:43 -0400
MIME-Version: 1.0
In-Reply-To: <20180603162541.28136-4-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCH 4/4] policycoreutils/hll/pp: remove unused variable
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 06/03/2018 12:25 PM, Nicolas Iooss wrote:
> pp's main() never set outfd to anything else than -1 so there is no
> point in closing it.

Thanks, applied all four patches.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  policycoreutils/hll/pp/pp.c | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/policycoreutils/hll/pp/pp.c b/policycoreutils/hll/pp/pp.c
> index b97a9b34816a..98969eb2f5f3 100644
> --- a/policycoreutils/hll/pp/pp.c
> +++ b/policycoreutils/hll/pp/pp.c
> @@ -73,7 +73,6 @@ int main(int argc, char **argv)
>  	const char *ofile = NULL;
>  	FILE *in = NULL;
>  	FILE *out = NULL;
> -	int outfd = -1;
>  
>  	// ignore sigpipe so we can check the return code of write, and potentially
>  	// return a more helpful error message
> @@ -159,12 +158,6 @@ exit:
>  	if (out != NULL) {
>  		fclose(out);
>  	}
> -	if (outfd != -1) {
> -		close(outfd);
> -		if (rc != 0) {
> -			unlink(argv[2]);
> -		}
> -	}
>  	sepol_module_package_free(mod_pkg);
>  
>  	return rc;
> 
