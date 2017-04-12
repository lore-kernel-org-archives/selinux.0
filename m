Message-ID: <1492023047.3881.24.camel@tycho.nsa.gov>
Subject: Re: [PATCH 6/6] policycoreutils: newrole: always initialize pw fields
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
Date: Wed, 12 Apr 2017 14:50:47 -0400
In-Reply-To: <20170411214603.28040-6-nicolas.iooss@m4x.org>
References: <20170411214603.28040-1-nicolas.iooss@m4x.org>
 <20170411214603.28040-6-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, 2017-04-11 at 23:46 +0200, Nicolas Iooss wrote:
> In extract_pw_data(), if "getpwuid(uid)" fails, the function returns
> an
> error value without initializing main's pw.pw_name. This leads main()
> to
> call "free(pw.pw_name)" on an uninitialized value.
> 
> Use memset() to initialize structure pw in main().
> 
> This issue has been found using clang's static analyzer.

Thanks, applied patches 2 through 6.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  policycoreutils/newrole/newrole.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/policycoreutils/newrole/newrole.c
> b/policycoreutils/newrole/newrole.c
> index bed92e4e7494..077496d3b64d 100644
> --- a/policycoreutils/newrole/newrole.c
> +++ b/policycoreutils/newrole/newrole.c
> @@ -1113,6 +1113,7 @@ int main(int argc, char *argv[])
>  	 * malicious software), not to authorize the operation
> (which is covered
>  	 * by policy).  Trusted path mechanism would be preferred.
>  	 */
> +	memset(&pw, 0, sizeof(pw));
>  	if (extract_pw_data(&pw))
>  		goto err_free;
>  
