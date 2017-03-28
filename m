Subject: Re: [PATCH 1/1] libsepol/cil: do not dereference a NULL pointer when
 calloc() fails
To: Nicolas Iooss <nicolas.iooss@m4x.org>, selinux@tycho.nsa.gov
References: <20170325134842.1414-1-nicolas.iooss@m4x.org>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <15731dc5-ea50-3092-6e1e-ee24546d9d5d@tycho.nsa.gov>
Date: Tue, 28 Mar 2017 15:55:10 -0400
MIME-Version: 1.0
In-Reply-To: <20170325134842.1414-1-nicolas.iooss@m4x.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/25/2017 09:48 AM, Nicolas Iooss wrote:
> When list_init() fails to allocate a list with calloc(), it calls
> list_destroy(&l) with l = NULL. This functions starts by dereferencing
> its argument ("(*list)->head"), which does not work well when it is
> NULL.
>
> This bug can be fixed by returning directly in list_init() when calloc()
> fails. Doing so allows making list_init() implementation shorter by
> removing label "exit" and local variable "rc".
>
> This issue has been found using clang's static analyzer.
>
> Signed-off-by: Nicolas Iooss <nicolas.iooss@m4x.org>

Applied.

Thanks,
Jim

> ---
>  libsepol/src/module_to_cil.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/libsepol/src/module_to_cil.c b/libsepol/src/module_to_cil.c
> index 6c33b94da9d9..308ada4f1381 100644
> --- a/libsepol/src/module_to_cil.c
> +++ b/libsepol/src/module_to_cil.c
> @@ -250,19 +250,13 @@ static void attr_list_destroy(struct list **attr_list)
>
>  static int list_init(struct list **list)
>  {
> -	int rc = -1;
>  	struct list *l = calloc(1, sizeof(*l));
>  	if (l == NULL) {
> -		goto exit;
> +		return -1;
>  	}
>
>  	*list = l;
> -
>  	return 0;
> -
> -exit:
> -	list_destroy(&l);
> -	return rc;
>  }
>
>  static int list_prepend(struct list *list, void *data)
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
