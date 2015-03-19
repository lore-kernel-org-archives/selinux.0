Message-ID: <550B192A.7030008@tycho.nsa.gov>
Date: Thu, 19 Mar 2015 14:44:58 -0400
From: Stephen Smalley <sds@tycho.nsa.gov>
MIME-Version: 1.0
To: Thomas Hurd <thurd@tresys.com>, selinux@tycho.nsa.gov
Subject: Re: [PATCH] libsepol: bool_copy_callback set state on creation
References: <1426784629-24048-1-git-send-email-thurd@tresys.com>
In-Reply-To: <1426784629-24048-1-git-send-email-thurd@tresys.com>
Content-Type: text/plain; charset=windows-1252
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 03/19/2015 01:03 PM, Thomas Hurd wrote:
> Boolean states are only written on a declaration.
> If a module is turned off which includes a tunable declaration that
> is required in another module, the state is never set. This patch
> sets the state when the booldatum is created so that an uninitialized
> memory read does not occur in cond_write_bool and write garbage to
> the link binary.  This can cause a failure in cond_read_bool when
> running semodule_expand.
> 
> Signed-off-by: Thomas Hurd <thurd@tresys.com>
> ---
>  libsepol/src/link.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/libsepol/src/link.c b/libsepol/src/link.c
> index f98a8d2..f211164 100644
> --- a/libsepol/src/link.c
> +++ b/libsepol/src/link.c
> @@ -630,6 +630,7 @@ static int bool_copy_callback(hashtab_key_t key, hashtab_datum_t datum,
>  		state->base->p_bools.nprim++;
>  		base_bool = new_bool;
>  		base_bool->flags = booldatum->flags;
> +		base_bool->state = booldatum->state;
>  	} else if ((booldatum->flags & COND_BOOL_FLAGS_TUNABLE) !=
>  		   (base_bool->flags & COND_BOOL_FLAGS_TUNABLE)) {
>  			/* A mismatch between boolean/tunable declaration
> 

Hmm...commit 3df79fc5ebf08a35aaa095b2ee3fd24b3ece6ae5 (libsepol: fix
boolean state smashing) removed the setting of the state here, replacing
it with conditional setting iff it is a decl further down.
