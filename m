Subject: Re: [PATCH] libsepol/cil: Fix uninitialized false positive in
 cil_binary
To: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>, selinux@tycho.nsa.gov
References: <1441911675-50003-1-git-send-email-ykhodorkovskiy@tresys.com>
From: James Carter <jwcart2@tycho.nsa.gov>
Message-ID: <55F2EF97.1040202@tycho.nsa.gov>
Date: Fri, 11 Sep 2015 11:13:27 -0400
MIME-Version: 1.0
In-Reply-To: <1441911675-50003-1-git-send-email-ykhodorkovskiy@tresys.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/10/2015 03:01 PM, Yuli Khodorkovskiy wrote:
> On older versions of gcc, an error is incorrectly given about
> uninitialized variables. This will initialize the culprits.
>
> Signed-off-by: Yuli Khodorkovskiy <ykhodorkovskiy@tresys.com>

Applied.

Thanks,
Jim

> ---
>   libsepol/cil/src/cil_binary.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/libsepol/cil/src/cil_binary.c b/libsepol/cil/src/cil_binary.c
> index 52ce067..b359232 100644
> --- a/libsepol/cil/src/cil_binary.c
> +++ b/libsepol/cil/src/cil_binary.c
> @@ -1497,7 +1497,7 @@ int __cil_avrulex_ioctl_to_policydb(hashtab_key_t k, hashtab_datum_t datum, void
>   	ebitmap_t *xperms;
>   	ebitmap_node_t *node;
>   	unsigned int i;
> -	uint16_t low, high;
> +	uint16_t low = 0, high = 0;
>   	struct avtab_extended_perms *partial = NULL;
>   	struct avtab_extended_perms *complete = NULL;
>   	int start_new_range;
>


-- 
James Carter <jwcart2@tycho.nsa.gov>
National Security Agency
