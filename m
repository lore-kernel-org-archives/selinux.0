Subject: Re: [PATCH 1/6] semodule_package: do not leak memory when using -u or
 -s
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170227203935.23674-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <03cce8c9-4384-caa8-8384-fae41752017d@tycho.nsa.gov>
Date: Wed, 1 Mar 2017 11:35:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170227203935.23674-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 02/27/2017 03:39 PM, Nicolas Iooss wrote:
> When using -u and -s options, semodule_package's main() allocates
> user_extra and seusers to hold the argument values. These allocated
> memory blocks are not freed when main() exits, which leads gcc's Address
> Sanitizer to report a memory leak. This occurs for example when building
> refpolicy base.pp module.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

I applied all six of these patches.

Thanks,
Jim

> ---
>  semodule-utils/semodule_package/semodule_package.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/semodule-utils/semodule_package/semodule_package.c b/semodule-utils/semodule_package/semodule_package.c
> index e472054826a3..a25daf59f9e7 100644
> --- a/semodule-utils/semodule_package/semodule_package.c
> +++ b/semodule-utils/semodule_package/semodule_package.c
> @@ -257,5 +257,7 @@ int main(int argc, char **argv)
>  	free(file_contexts);
>  	free(outfile);
>  	free(module);
> +	free(seusers);
> +	free(user_extra);
>  	exit(0);
>  }
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
