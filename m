Date: Mon, 29 Nov 2010 08:15:38 +1100 (EST)
From: James Morris <jmorris@namei.org>
To: Eric Paris <eparis@redhat.com>
cc: selinux@tycho.nsa.gov, sds@tycho.nsa.gov, paul.moore@hp.com
Subject: Re: [PATCH 1/4] flex_array: fix flex_array_put_ptr macro to be valid
 C
In-Reply-To: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
Message-ID: <alpine.LRH.2.00.1011290815020.15604@tundra.namei.org>
References: <20101123165227.4489.29282.stgit@paris.rdu.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

On Tue, 23 Nov 2010, Eric Paris wrote:

> Using flex_array_put_ptr() results in a compile error "error: lvalue
> required as unary ?&? operand"  fix the casting order to fix this.
> 
> Signed-off-by: Eric Paris <eparis@redhat.com>

These all look good to me.  Consider cc'ing the LSM list with 
SELinux kernel changes.

> ---
> 
>  include/linux/flex_array.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/flex_array.h b/include/linux/flex_array.h
> index 631b77f..70e4efa 100644
> --- a/include/linux/flex_array.h
> +++ b/include/linux/flex_array.h
> @@ -71,7 +71,7 @@ void *flex_array_get(struct flex_array *fa, unsigned int element_nr);
>  int flex_array_shrink(struct flex_array *fa);
>  
>  #define flex_array_put_ptr(fa, nr, src, gfp) \
> -	flex_array_put(fa, nr, &(void *)(src), gfp)
> +	flex_array_put(fa, nr, (void *)&(src), gfp)
>  
>  void *flex_array_get_ptr(struct flex_array *fa, unsigned int element_nr);
>  
> 

-- 
James Morris
<jmorris@namei.org>

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
