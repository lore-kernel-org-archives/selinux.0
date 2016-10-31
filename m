Subject: Re: [PATCH 1/1] policycoreutils: semodule_package: do not fail with
 an empty fc file
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161030212722.24743-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <9985da16-14f1-4d72-b60d-6dfeb20ae73a@tycho.nsa.gov>
Date: Mon, 31 Oct 2016 12:52:31 -0400
MIME-Version: 1.0
In-Reply-To: <20161030212722.24743-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 10/30/2016 05:27 PM, Nicolas Iooss wrote:
> When running sepolgen tests on a Linux 4.7 kernel, one test fails with
> the following message:
> 
>     /usr/bin/semodule_package:  Failed to mmap
>     tmp/module_compile_test.mod.fc:  Invalid argument
> 
> The .fc file is empty, which is why it cannot be used with mmap().
> Anyway the current code supports empty files (with if() conditions in
> main()) so do not try to mmap an empty file in file_to_data().

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
> 
> While at it, it seems that neither seusersdata nor user_extradata are
> unmapped at the end of main(). As this does not cause a test to fail
> I will not send a patch to fix this.
> 
>  policycoreutils/semodule_package/semodule_package.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/policycoreutils/semodule_package/semodule_package.c b/policycoreutils/semodule_package/semodule_package.c
> index d2a5fd07bd71..e472054826a3 100644
> --- a/policycoreutils/semodule_package/semodule_package.c
> +++ b/policycoreutils/semodule_package/semodule_package.c
> @@ -72,6 +72,10 @@ static int file_to_data(const char *path, char **data, size_t * len)
>  			path, strerror(errno));
>  		goto err;
>  	}
> +	if (!sb.st_size) {
> +		*len = 0;
> +		return 0;
> +	}
>  
>  	*data = mmap(NULL, sb.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
>  	if (*data == MAP_FAILED) {
> 
