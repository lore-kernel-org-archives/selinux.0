Subject: Re: [PATCH] libsemanage: Do not always print a module name warning
To: Miroslav Grepl <mgrepl@redhat.com>, selinux@tycho.nsa.gov
References: <20160927155113.19322-1-mgrepl@redhat.com>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <a4f4bf3e-1e40-8e5a-a3a5-ca25722f521f@tycho.nsa.gov>
Date: Tue, 27 Sep 2016 12:15:59 -0400
MIME-Version: 1.0
In-Reply-To: <20160927155113.19322-1-mgrepl@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/27/2016 11:51 AM, Miroslav Grepl wrote:
> From: Miroslav Grep <mgrepl@redhat.com>
> 
> 7a728e46 commit supposed to add a warning when a module name is
> different than a filename, but this warning is printed always. This
> commit fixes it.
> 
> Fixes:
> $ semodule -X 400 -i testmod.pp
> Warning: SELinux userspace will refer to the module from testmod.pp as
> testmod rather than testmod

Thanks, applied.

> 
> Signed-off-by: Miroslav Grepl <mgrepl@redhat.com>
> ---
>  libsemanage/src/direct_api.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/libsemanage/src/direct_api.c b/libsemanage/src/direct_api.c
> index 4320f43..3719cb1 100644
> --- a/libsemanage/src/direct_api.c
> +++ b/libsemanage/src/direct_api.c
> @@ -1619,7 +1619,9 @@ static int semanage_direct_install_file(semanage_handle_t * sh,
>  		if ((retval = parse_module_headers(sh, data, data_len, &module_name, &version)) != 0)
>  			goto cleanup;
>  
> -		fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
> +		if (strcmp(module_name, filename) != 0)
> +			fprintf(stderr, "Warning: SELinux userspace will refer to the module from %s as %s rather than %s\n", install_filename, module_name, filename);
> +
>  		free(version);
>  	}
>  	retval = semanage_direct_install(sh, data, data_len, module_name, lang_ext);
> 
