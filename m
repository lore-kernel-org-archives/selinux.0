MIME-Version: 1.0
In-Reply-To: <1475149159-21757-2-git-send-email-jdanis@android.com>
References: <1475149159-21757-1-git-send-email-jdanis@android.com>
 <1475149159-21757-2-git-send-email-jdanis@android.com>
From: William Roberts <bill.c.roberts@gmail.com>
Date: Thu, 29 Sep 2016 07:57:54 -0400
Message-ID: <CAFftDdofw9O3FriN3PqFdMy5LEqFC79PGR10ePcVeD3csZ10oQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: android: fix lax service context lookup
To: Janis Danisevskis <jdanis@android.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>
Content-Type: text/plain; charset=UTF-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

do you have the corresponding changes to checkfc on AOSP?

On Thu, Sep 29, 2016 at 7:39 AM, Janis Danisevskis <jdanis@android.com> wrote:
> We use the same lookup function for service contexts
> that we use for property contexts. However, property
> contexts are namespace based and only compare the
> prefix. This may lead to service associations with
> a wrong label.
>
> This patch introduces a new back end for android
> services with a stricter lookup function. Now the
> service name must match the key of the service label
> exactly.
>
> Signed-off-by: Janis Danisevskis <jdanis@android.com>
> ---
>  libselinux/include/selinux/label.h      |  2 ++
>  libselinux/src/label.c                  |  1 +
>  libselinux/src/label_backends_android.c | 54 +++++++++++++++++++++++++++++++--
>  libselinux/src/label_internal.h         |  3 ++
>  libselinux/utils/selabel_digest.c       |  2 ++
>  libselinux/utils/selabel_lookup.c       |  2 ++
>  6 files changed, 62 insertions(+), 2 deletions(-)
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
> diff --git a/libselinux/src/label_backends_android.c b/libselinux/src/label_backends_android.c
> index 290b438..4d6ec86 100644
> --- a/libselinux/src/label_backends_android.c
> +++ b/libselinux/src/label_backends_android.c
> @@ -244,7 +244,7 @@ static void closef(struct selabel_handle *rec)
>         free(data);
>  }
>
> -static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> +static struct selabel_lookup_rec *property_lookup(struct selabel_handle *rec,
>                                          const char *key,
>                                          int __attribute__((unused)) type)
>  {
> @@ -279,6 +279,38 @@ finish:
>         return ret;
>  }
>
> +static struct selabel_lookup_rec *service_lookup(struct selabel_handle *rec,
> +               const char *key, int __attribute__((unused)) type)
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
> @@ -298,7 +330,25 @@ int selabel_property_init(struct selabel_handle *rec,
>         rec->data = data;
>         rec->func_close = &closef;
>         rec->func_stats = &stats;
> -       rec->func_lookup = &lookup;
> +       rec->func_lookup = &property_lookup;
> +
> +       return init(rec, opts, nopts);
> +}
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
>
>         return init(rec, opts, nopts);
>  }
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
> diff --git a/libselinux/utils/selabel_digest.c b/libselinux/utils/selabel_digest.c
> index 38162a5..e4d84a5 100644
> --- a/libselinux/utils/selabel_digest.c
> +++ b/libselinux/utils/selabel_digest.c
> @@ -92,6 +92,8 @@ int main(int argc, char **argv)
>                                 backend = SELABEL_CTX_DB;
>                         } else if (!strcmp(optarg, "prop")) {
>                                 backend = SELABEL_CTX_ANDROID_PROP;
> +                       } else if (!strcmp(optarg, "service")) {
> +                               backend = SELABEL_CTX_ANDROID_SERVICE;
>                         } else {
>                                 fprintf(stderr, "Unknown backend: %s\n",
>                                                                     optarg);
> diff --git a/libselinux/utils/selabel_lookup.c b/libselinux/utils/selabel_lookup.c
> index d0b1457..b678a89 100644
> --- a/libselinux/utils/selabel_lookup.c
> +++ b/libselinux/utils/selabel_lookup.c
> @@ -57,6 +57,8 @@ int main(int argc, char **argv)
>                                 backend = SELABEL_CTX_DB;
>                         } else if (!strcmp(optarg, "prop")) {
>                                 backend = SELABEL_CTX_ANDROID_PROP;
> +                       } else if (!strcmp(optarg, "service")) {
> +                               backend = SELABEL_CTX_ANDROID_SERVICE;
>                         } else {
>                                 fprintf(stderr, "Unknown backend: %s\n",
>                                                                     optarg);
> --
> 1.9.1
>
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.



-- 
Respectfully,

William C Roberts
