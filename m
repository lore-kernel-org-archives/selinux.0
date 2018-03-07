To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20180305225820.23610-1-nicolas.iooss@m4x.org>
From: jwcart2 <jwcart2@tycho.nsa.gov>
Message-ID: <3414b49c-fd30-3636-d1ae-ce60fe546d2b@tycho.nsa.gov>
Date: Wed, 7 Mar 2018 09:57:06 -0500
MIME-Version: 1.0
In-Reply-To: <20180305225820.23610-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 1/3] libsepol: initialize tmp_key->ibdev_name if its
 allocation failed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/05/2018 05:58 PM, Nicolas Iooss wrote:
> In sepol_ibendport_key_create(), if sepol_ibendport_alloc_ibdev_name()
> fails to allocate tmp_key->ibdev_name, sepol_ibendport_key_free() is
> called to free the memory associated with tmp_key, which results in
> free() being called on uninitialized tmp_key->ibdev_name.
> 
> This issue is reported by clang's static analyzer with the following
> message:
> 
>      ibendport_record.c:115:2: warning: 1st function call argument is an
>      uninitialized value
>              free(key->ibdev_name);
>              ^~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>   libsepol/src/ibendport_record.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/libsepol/src/ibendport_record.c b/libsepol/src/ibendport_record.c
> index 912aeb536fd9..8285a9d6ffcf 100644
> --- a/libsepol/src/ibendport_record.c
> +++ b/libsepol/src/ibendport_record.c
> @@ -62,8 +62,10 @@ int sepol_ibendport_key_create(sepol_handle_t *handle,
>   		goto omem;
>   	}
>   
> -	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0)
> +	if (sepol_ibendport_alloc_ibdev_name(handle, &tmp_key->ibdev_name) < 0) {
> +		tmp_key->ibdev_name = NULL;
>   		goto err;
> +	}
>   
>   	strncpy(tmp_key->ibdev_name, ibdev_name, IB_DEVICE_NAME_MAX);
>   	tmp_key->port = port;
> 

It seems to be that a better way to fix this is to modify 
sepol_ibendport_alloc_ibdev_name(), so that the result of the calloc is assigned 
to *ibdev_name. That way if the calloc fails, tmp_key->ibdev_name will be set to 
NULL automatically.


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
