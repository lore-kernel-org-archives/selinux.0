MIME-Version: 1.0
Sender: phhusson@gmail.com
In-Reply-To: <20180322230435.21048-2-phh@phh.me>
References: <20180322230435.21048-1-phh@phh.me>
 <20180322230435.21048-2-phh@phh.me>
From: Pierre-Hugues Husson <phh@phh.me>
Date: Thu, 29 Mar 2018 20:04:41 +0200
Message-ID: <CAJ-oXjSq9W71xkNtFdszMGz8iJrnyrW7wrfQuBQxd9jYwL1BfA@mail.gmail.com>
To: selinux@tycho.nsa.gov
Cc: phh <phh@phh.me>, Tri Vo <trong@android.com>, jwcart2@tycho.nsa.gov,
 Pierre-Hugues Husson <phhusson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [PATCH v2 1/1] Detect identical genfscon
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

2018-03-23 0:04 GMT+01:00 Pierre-Hugues Husson <phh@phh.me>:
> From: Pierre-Hugues Husson <phhusson@gmail.com>
>
> Currently secilc doesn't deal with duplicate genfscon rules
>
> This commit fixes this, and implements multiple_decls behaviour.
>
> To reduce the code changes, the compare function returns in its LSB
> whether the rules are only a matching rule match, or a full match.
> ---
>  libsepol/cil/src/cil_post.c | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/libsepol/cil/src/cil_post.c b/libsepol/cil/src/cil_post.c
> index a2122454..c054e9ce 100644
> --- a/libsepol/cil/src/cil_post.c
> +++ b/libsepol/cil/src/cil_post.c
> @@ -53,6 +53,26 @@
>  static int __cil_expr_to_bitmap(struct cil_list *expr, ebitmap_t *out, int max, struct cil_db *db);
>  static int __cil_expr_list_to_bitmap(struct cil_list *expr_list, ebitmap_t *out, int max, struct cil_db *db);
>
> +/* compare function returns whether a,b have the same context in the LSB */
> +static int compact(void* array, uint32_t *count, int len, int (*compare)(const void *, const void *), int multiple_decls) {
> +       char *a = (char*)array;
> +       uint32_t i, j = 0;
> +       int c;
> +       for(i=1; i<*count; i++) {
> +               c = compare(a+i*len, a+j*len);
> +               /* If LSB is set, it means the rules match except for the context
> +                * We never want this */
> +               if(c&1) return SEPOL_ERR;
> +
> +               if(!multiple_decls && c == 0) return SEPOL_ERR;
> +
> +               if(c) j++;
> +               if(i != j) memcpy(a+j*len, a+i*len, len);
> +       }
> +       *count = j;
I've just realized this should actually be j+1
