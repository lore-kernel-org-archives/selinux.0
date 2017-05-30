MIME-Version: 1.0
In-Reply-To: <20170530191304.29886-1-jwcart2@tycho.nsa.gov>
References: <20170530191304.29886-1-jwcart2@tycho.nsa.gov>
From: Nicolas Iooss <nicolas.iooss@m4x.org>
Date: Tue, 30 May 2017 23:37:01 +0200
Message-ID: <CAJfZ7=nA6d0H=DG2pnbubofxwdRLtD8DO+Vm_qTVYtxep_MW6g@mail.gmail.com>
Subject: Re: [PATCH 1/2] libsepol: Clean up scope handling
To: James Carter <jwcart2@tycho.nsa.gov>
Cc: selinux <selinux@tycho.nsa.gov>
Content-Type: text/plain; charset="UTF-8"
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Tue, May 30, 2017 at 9:13 PM, James Carter <jwcart2@tycho.nsa.gov> wrote:
> Currently, when checking if an identifier is enabled, each scope in
> the decl_ids list is checked. This means that if any block that
> requires the identifier is enabled, then the identifier will be treated
> as being declared.
>
> Now, declarations will be kept at the end of the decl_ids list and
> when checking if an identifier is enabled, only the last scope will
> be checked (Except for roles and users which allow multiple declarations,
> they will have to keep the old behavior.)
>
> Signed-off-by: James Carter <jwcart2@tycho.nsa.gov>
> ---
>  libsepol/src/avrule_block.c | 24 ++++++++++++++++++++----
>  libsepol/src/policydb.c     | 13 +++++++++++++
>  2 files changed, 33 insertions(+), 4 deletions(-)
>
> diff --git a/libsepol/src/avrule_block.c b/libsepol/src/avrule_block.c
> index 224e999..e1f460e 100644
> --- a/libsepol/src/avrule_block.c
> +++ b/libsepol/src/avrule_block.c
> @@ -156,20 +156,36 @@ int is_id_enabled(char *id, policydb_t * p, int symbol_table)
>  {
>         scope_datum_t *scope =
>             (scope_datum_t *) hashtab_search(p->scope[symbol_table].table, id);
> -       uint32_t i;
> +       avrule_decl_t *decl;
> +       uint32_t len = scope->decl_ids_len;
> +
>         if (scope == NULL) {
>                 return 0;
>         }
>         if (scope->scope != SCOPE_DECL) {
>                 return 0;
>         }
> -       for (i = 0; i < scope->decl_ids_len; i++) {
> -               avrule_decl_t *decl =
> -                   p->decl_val_to_struct[scope->decl_ids[i] - 1];
> +
> +       if (len < 1) {
> +               return 0;
> +       }
> +
> +       if (symbol_table == SYM_ROLES || symbol_table == SYM_USERS) {
> +               uint32_t i;
> +               for (i = 0; i < len; i++) {
> +                       avrule_decl_t *decl =
> +                               p->decl_val_to_struct[scope->decl_ids[i] - 1];

Hello,
This statement creates a local variable which shadows the previous
"decl" variable that is introduced in this commit too (this gets
reported as a -Wshadow warning). You may want to rename one of these
two variables.

Cheers,
Nicolas
