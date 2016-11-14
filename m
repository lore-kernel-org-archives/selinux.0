Subject: Re: [PATCH 1/1] libsemanage: semanage_seuser_key_create: copy name
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20161112120503.2162-1-nicolas.iooss@m4x.org>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <b4dffcc8-37ab-e592-0a73-1e057f19e147@tycho.nsa.gov>
Date: Mon, 14 Nov 2016 13:16:09 -0500
MIME-Version: 1.0
In-Reply-To: <20161112120503.2162-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 11/12/2016 07:05 AM, Nicolas Iooss wrote:
> When removing a login using semanage with Python 3 the following error
> occurs:
> 
>     # semanage login -l | grep my_user
>     my_user                   user_u
> 
>     # semanage login --delete my_user
>     ValueError: Login mapping for my_user is not defined
> 
> This is due to a use-after-free in the swig-generated code for python3
> bindings.
> 
> Copy the user name in semanage_seuser_key_create() and free it in
> semanage_seuser_key_free(), like commit eac6f1f1b512 ("libsepol:
> sepol_{bool|iface|user}_key_create: copy name") did.

Thanks, applied.

> 
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>
> ---
>  libsemanage/src/seuser_record.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/libsemanage/src/seuser_record.c b/libsemanage/src/seuser_record.c
> index 8823b1ed1c7b..1ed459486228 100644
> --- a/libsemanage/src/seuser_record.c
> +++ b/libsemanage/src/seuser_record.c
> @@ -33,7 +33,7 @@ struct semanage_seuser {
>  
>  struct semanage_seuser_key {
>  	/* This user's name */
> -	const char *name;
> +	char *name;
>  };
>  
>  int semanage_seuser_key_create(semanage_handle_t * handle,
> @@ -48,7 +48,12 @@ int semanage_seuser_key_create(semanage_handle_t * handle,
>  		ERR(handle, "out of memory, could not create seuser key");
>  		return STATUS_ERR;
>  	}
> -	tmp_key->name = name;
> +	tmp_key->name = strdup(name);
> +	if (!tmp_key->name) {
> +		ERR(handle, "out of memory, could not create seuser key");
> +		free(tmp_key);
> +		return STATUS_ERR;
> +	}
>  
>  	*key_ptr = tmp_key;
>  	return STATUS_SUCCESS;
> @@ -75,7 +80,7 @@ hidden_def(semanage_seuser_key_extract)
>  
>  void semanage_seuser_key_free(semanage_seuser_key_t * key)
>  {
> -
> +	free(key->name);
>  	free(key);
>  }
>  
> 
