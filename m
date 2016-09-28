MIME-Version: 1.0
In-Reply-To: <1475078690-42486-1-git-send-email-jdanis@android.com>
References: <1475078690-42486-1-git-send-email-jdanis@android.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Wed, 28 Sep 2016 12:14:08 -0400
Message-ID: <CAFftDdrot=3V8dA-G+4KqpwJAcKN=NXuTZOyQYaWC6Bo23pByg@mail.gmail.com>
Subject: Re: [PATCH] libselinux: android: fix lax service context lookup
To: Janis Danisevskis <jdanis@android.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On Wed, Sep 28, 2016 at 12:04 PM, Janis Danisevskis <jdanis@android.com> wrote:
> We use the same lookup function for service contexts
> that we use for property contexts. However, property
> contexts are namespace based and only compare the
> prefix. This may lead to service associations with
> a wrong label.
>
> This patch introduces a stricter lookup function for
> services contexts. Now the service name must match
> the key of the service label exactly.
>
> Signed-off-by: Janis Danisevskis <jdanis@android.com>
> ---
>  libselinux/include/selinux/label.h      |  2 ++
>  libselinux/src/label.c                  |  1 +
>  libselinux/src/label_android_property.c | 50 +++++++++++++++++++++++++++++++++
>  libselinux/src/label_internal.h         |  3 ++
>  4 files changed, 56 insertions(+)
>
> diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
> index f0b1e10..277287e 100644
> --- a/libselinux/include/selinux/label.h
> +++ b/libselinux/include/selinux/label.h
> @@ -34,6 +34,8 @@ struct selabel_handle;
>  #define SELABEL_CTX_DB         3
>  /* Android property service contexts */
>  #define SELABEL_CTX_ANDROID_PROP 4
> +/* Android service contexts */
> +#define SELABEL_CTX_ANDROID_SERVICE 5
>
>  /*
>   * Available options
> diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> index 96a4ff1..eb0e766 100644
> --- a/libselinux/src/label.c
> +++ b/libselinux/src/label.c
> @@ -45,6 +45,7 @@ static selabel_initfunc initfuncs[] = {
>         CONFIG_X_BACKEND(selabel_x_init),
>         CONFIG_DB_BACKEND(selabel_db_init),
>         &selabel_property_init,
> +       &selabel_service_init,
>  };
>
>  static void selabel_subs_fini(struct selabel_sub *ptr)
> diff --git a/libselinux/src/label_android_property.c b/libselinux/src/label_android_property.c
> index 290b438..69d6afd 100644
> --- a/libselinux/src/label_android_property.c
> +++ b/libselinux/src/label_android_property.c
> @@ -279,6 +279,38 @@ finish:
>         return ret;
>  }
>
> +static struct selabel_lookup_rec *service_lookup(struct selabel_handle *rec,
> +               const char *key, int __attribute__((unused)) type)

Is their a way to set type where we could still share the
property_backend and choose on type if to be
a different match style? That's just a thought, and likely a dumb one,
i'm full of those.

It has been mildly confusing explaining to some that property_context
and service backends
have the same code underpinings and the naming isn't clear on that. I
would suggest, moving
the common stuff from each backend into android_backend_common.c and
.h and then just have
the deltas, which appear to be initialization and matching in the
respective label_android_property.c
and label_android_service.c files.

> +{
> +       struct saved_data *data = (struct saved_data *)rec->data;
> +       spec_t *spec_arr = data->spec_arr;
> +       unsigned int i;
> +       struct selabel_lookup_rec *ret = NULL;
> +
> +       if (!data->nspec) {
> +               errno = ENOENT;
> +               goto finish;
> +       }
> +
> +       for (i = 0; i < data->nspec; i++) {
> +               if (strcmp(spec_arr[i].property_key, key) == 0)
> +                       break;
> +               if (strcmp(spec_arr[i].property_key, "*") == 0)
> +                       break;
> +       }
> +
> +       if (i >= data->nspec) {
> +               /* No matching specification. */
> +               errno = ENOENT;
> +               goto finish;
> +       }
> +
> +       ret = &spec_arr[i].lr;
> +
> +finish:
> +       return ret;
> +}
> +
>  static void stats(struct selabel_handle __attribute__((unused)) *rec)
>  {
>         selinux_log(SELINUX_WARNING, "'stats' functionality not implemented.\n");
> @@ -302,3 +334,21 @@ int selabel_property_init(struct selabel_handle *rec,
>
>         return init(rec, opts, nopts);
>  }
> +
> +int selabel_service_init(struct selabel_handle *rec,
> +               const struct selinux_opt *opts, unsigned nopts)
> +{
> +       struct saved_data *data;
> +
> +       data = (struct saved_data *)malloc(sizeof(*data));
> +       if (!data)
> +               return -1;
> +       memset(data, 0, sizeof(*data));
> +
> +       rec->data = data;
> +       rec->func_close = &closef;
> +       rec->func_stats = &stats;
> +       rec->func_lookup = &service_lookup;
> +
> +       return init(rec, opts, nopts);
> +}
> diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_internal.h
> index 7c55531..6a9481a 100644
> --- a/libselinux/src/label_internal.h
> +++ b/libselinux/src/label_internal.h
> @@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,
>  int selabel_property_init(struct selabel_handle *rec,
>                             const struct selinux_opt *opts,
>                             unsigned nopts) hidden;
> +int selabel_service_init(struct selabel_handle *rec,
> +                           const struct selinux_opt *opts,
> +                           unsigned nopts) hidden;
>
>  /*
>   * Labeling internal structures
> --
> 2.8.0.rc3.226.g39d4020
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
