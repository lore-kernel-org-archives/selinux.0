Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id t5EKXvgU003731
 for <selinux@tycho.nsa.gov>; Sun, 14 Jun 2015 16:33:57 -0400
Received: by oiha141 with SMTP id a141so47591415oih.0
 for <selinux@tycho.nsa.gov>; Sun, 14 Jun 2015 13:33:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1434206958-9234-1-git-send-email-nnk@google.com>
References: <1434206958-9234-1-git-send-email-nnk@google.com>
Date: Sun, 14 Jun 2015 13:33:53 -0700
Message-ID: <CABXk95CWgapfRtDC=17t_B_eaJTCrnu+Fy52ohHtm_wSbY1nQA@mail.gmail.com>
Subject: Re: [PATCH] policy_define.c: fix compiler warnings
From: Jeffrey Vander Stoep <jeffv@google.com>
To: Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset=UTF-8
Cc: SELinux <selinux@tycho.nsa.gov>
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

Acked-by: Jeff Vander Stoep <jeffv@google.com>

On Sat, Jun 13, 2015 at 7:49 AM, Nick Kralevich <nnk@google.com> wrote:
> Fixes compiler warnings all similar to the following:
>
> host C: checkpolicy <= external/selinux/checkpolicy/policy_define.c
> external/selinux/checkpolicy/policy_define.c:1572:2: warning: comparison of integers of different signs: 'int' and 'uint32_t' (aka 'unsigned int') [-Wsign-compare]
>         ebitmap_for_each_bit(&tclasses, node, i) {
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> external/selinux/checkpolicy/../libsepol/include/sepol/policydb/ebitmap.h:76:39: note: expanded from macro 'ebitmap_for_each_bit'
>         for (bit = ebitmap_start(e, &n); bit < ebitmap_length(e); bit = ebitmap_next(&n, bit)) \
>                                              ^ ~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Nick Kralevich <nnk@google.com>
> ---
>  checkpolicy/policy_define.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/checkpolicy/policy_define.c b/checkpolicy/policy_define.c
> index 093bded..27d8fe7 100644
> --- a/checkpolicy/policy_define.c
> +++ b/checkpolicy/policy_define.c
> @@ -1521,7 +1521,8 @@ int define_compute_type_helper(int which, avrule_t ** rule)
>         ebitmap_node_t *node;
>         avrule_t *avrule;
>         class_perm_node_t *perm;
> -       int i, add = 1;
> +       uint32_t i;
> +       int add = 1;
>
>         avrule = malloc(sizeof(avrule_t));
>         if (!avrule) {
> @@ -2745,7 +2746,7 @@ static int dominate_role_recheck(hashtab_key_t key __attribute__ ((unused)),
>         role_datum_t *rdp = (role_datum_t *) arg;
>         role_datum_t *rdatum = (role_datum_t *) datum;
>         ebitmap_node_t *node;
> -       int i;
> +       uint32_t i;
>
>         /* Don't bother to process against self role */
>         if (rdatum->s.value == rdp->s.value)
> --
> 2.2.0.rc0.207.ga3a616c
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
