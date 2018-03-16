Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w2GIHPGv030558
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 14:17:25 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC13.oob.disa.mil (Postfix) with SMTP id 402twJ5gJRz25vbl
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 18:17:20 +0000 (UTC)
Received: from UPDC3CPA09_EEMSG_MP25.eemsg.mil (unknown [192.168.18.20])
 by UPDCF3IC13.oob.disa.mil (Postfix) with ESMTP id 402twJ4ZJLz25vbh
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 18:17:20 +0000 (UTC)
Received: by mail-qt0-f196.google.com with SMTP id n12so11816754qtl.5
 for <selinux@tycho.nsa.gov>; Fri, 16 Mar 2018 11:17:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180316181136.81215-1-trong@android.com>
References: <20180316181136.81215-1-trong@android.com>
From: Jeffrey Vander Stoep <jeffv@google.com>
Date: Fri, 16 Mar 2018 11:17:16 -0700
Message-ID: <CABXk95Dxz_v-TS0A_hAf2nEr3ywDvbn3tBmeXks2NGGfi1iGOg@mail.gmail.com>
To: Tri Vo <trong@android.com>
Cc: SELinux <selinux@tycho.nsa.gov>, Daniel Cashman <dcashman@google.com>,
 Sandeep Patil <sspatil@google.com>,
 William Roberts <bill.c.roberts@gmail.com>,
 James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v3] Resolve conflicts in expandattribute.
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Fri, Mar 16, 2018 at 11:11 AM, Tri Vo <trong@android.com> wrote:
> This commit resolves conflicts in values of expandattribute statements
> in policy language and expandtypeattribute in CIL.
>
> For example, these statements resolve to false in policy language:
>  expandattribute hal_audio true;
>  expandattribute hal_audio false;
>
> Similarly, in CIL these also resolve to false.
>  (expandtypeattribute (hal_audio) true)
>  (expandtypeattribute (hal_audio) false)
>
> A warning will be issued on this conflict.
>
> Motivation
> When Android combines multiple .cil files from system.img and vendor.img
> it's possible to have conflicting expandattribute statements.
>
> This change deals with this scenario by resolving the value of the
> corresponding expandtypeattribute to false. The rationale behind this
> override is that true is used for reduce run-time lookups, while
> false is used for tests which must pass.
>
> Signed-off-by: Tri Vo <trong@android.com>

Acked-by: Jeff Vander Stoep <jeffv@google.com>

> ---
>  checkpolicy/policy_define.c        | 10 ++++++----
>  libsepol/cil/src/cil_resolve_ast.c | 21 ++++++---------------
>  2 files changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 2c5db55d..40cc62b0 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1182,10 +1182,6 @@ int expand_attrib(void)
>                         goto exit;
>                 }
>
> -               if (attr->flags & TYPE_FLAGS_EXPAND_ATTR) {
> -                       yyerror2("%s already has the expandattribute option specified", id);
> -                       goto exit;
> -               }
>                 if (ebitmap_set_bit(&attrs, attr->s.value - 1, TRUE)) {
>                         yyerror("Out of memory!");
>                         goto exit;
> @@ -1213,6 +1209,12 @@ int expand_attrib(void)
>                 attr = hashtab_search(policydbp->p_types.table,
>                                 policydbp->sym_val_to_name[SYM_TYPES][i]);
>                 attr->flags |= flags;
> +               if ((attr->flags & TYPE_FLAGS_EXPAND_ATTR_TRUE) &&
> +                               (attr->flags & TYPE_FLAGS_EXPAND_ATTR_FALSE)) {
> +                       yywarn("Expandattribute option was set to both true and false. "
> +                               "Resolving to false.");
> +                       attr->flags &= ~TYPE_FLAGS_EXPAND_ATTR_TRUE;
> +               }
>         }
>
>         rc = 0;
> diff --git a/libsepol/cil/src/cil_resolve_ast.c b/libsepol/cil/src/cil_resolve_ast.c
> index d1a5ed87..02259241 100644
> --- a/libsepol/cil/src/cil_resolve_ast.c
> +++ b/libsepol/cil/src/cil_resolve_ast.c
> @@ -269,9 +269,8 @@ exit:
>         return rc;
>  }
>
> -int cil_type_used(struct cil_symtab_datum *datum, int used)
> +void cil_type_used(struct cil_symtab_datum *datum, int used)
>  {
> -       int rc = SEPOL_ERR;
>         struct cil_typeattribute *attr = NULL;
>
>         if (FLAVOR(datum) == CIL_TYPEATTRIBUTE) {
> @@ -279,16 +278,12 @@ int cil_type_used(struct cil_symtab_datum *datum, int used)
>                 attr->used |= used;
>                 if ((attr->used & CIL_ATTR_EXPAND_TRUE) &&
>                                 (attr->used & CIL_ATTR_EXPAND_FALSE)) {
> -                       cil_log(CIL_ERR, "Conflicting use of expandtypeattribute. "
> -                                       "Expandtypeattribute may be set to true or false "
> -                                       "but not both. \n");
> -                       goto exit;
> +                       cil_log(CIL_WARN, "Conflicting use of expandtypeattribute. "
> +                                       "Expandtypeattribute was set to both true or false for %s. "
> +                                       "Resolving to false. \n", attr->datum.name);
> +                       attr->used &= ~CIL_ATTR_EXPAND_TRUE;
>                 }
>         }
> -
> -       return SEPOL_OK;
> -exit:
> -       return rc;
>  }
>
>  int cil_resolve_permissionx(struct cil_tree_node *current, struct cil_permissionx *permx, void *extra_args)
> @@ -488,11 +483,7 @@ int cil_resolve_expandtypeattribute(struct cil_tree_node *current, void *extra_a
>                         goto exit;
>                 }
>                 used = expandattr->expand ? CIL_ATTR_EXPAND_TRUE : CIL_ATTR_EXPAND_FALSE;
> -               rc = cil_type_used(attr_datum, used);
> -               if (rc != SEPOL_OK) {
> -                       goto exit;
> -               }
> -
> +               cil_type_used(attr_datum, used);
>                 cil_list_append(expandattr->attr_datums, CIL_TYPE, attr_datum);
>         }
>
> --
> 2.16.2.804.g6dcf76e118-goog
>
