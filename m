Subject: Re: [PATCH 1/2] libsepol: do not use handle when it is marked unused
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170531200615.9166-1-nicolas.iooss@m4x.org>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <779dce46-6ff0-4cee-be7d-752859f56d81@tycho.nsa.gov>
Date: Thu, 1 Jun 2017 13:00:51 -0400
MIME-Version: 1.0
In-Reply-To: <20170531200615.9166-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 05/31/2017 04:06 PM, Nicolas Iooss wrote:
> Assigning NULL to handle does not perform anything useful and clang
> complains about this:
> 
>      ibendports.c:122:2: error: 'handle' was marked unused but was used
>      [-Werror,-Wused-but-marked-unused]
>          handle = NULL;
>          ^
>      ibpkeys.c:115:2: error: 'handle' was marked unused but was used
>      [-Werror,-Wused-but-marked-unused]
>          handle = NULL;
>          ^
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,
Jim

> ---
>   libsepol/src/ibendports.c | 1 -
>   libsepol/src/ibpkeys.c    | 1 -
>   2 files changed, 2 deletions(-)
> 
> diff --git a/libsepol/src/ibendports.c b/libsepol/src/ibendports.c
> index 0438093e3053..6d56c9a1793f 100644
> --- a/libsepol/src/ibendports.c
> +++ b/libsepol/src/ibendports.c
> @@ -119,7 +119,6 @@ extern int sepol_ibendport_count(sepol_handle_t *handle __attribute__ ((unused))
>   
>   	*response = count;
>   
> -	handle = NULL;
>   	return STATUS_SUCCESS;
>   }
>   
> diff --git a/libsepol/src/ibpkeys.c b/libsepol/src/ibpkeys.c
> index ad6c07fe2c2d..682bf5db210c 100644
> --- a/libsepol/src/ibpkeys.c
> +++ b/libsepol/src/ibpkeys.c
> @@ -112,7 +112,6 @@ extern int sepol_ibpkey_count(sepol_handle_t *handle __attribute__ ((unused)),
>   
>   	*response = count;
>   
> -	handle = NULL;
>   	return STATUS_SUCCESS;
>   }
>   
> 


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
