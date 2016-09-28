Subject: Re: [PATCH] libselinux: android: fix lax service context lookup
To: Janis Danisevskis <jdanis@android.com>
References: <1475078690-42486-1-git-send-email-jdanis@android.com>
 <1a53409d-1773-187b-e0cb-d49c8ac2d1a2@tycho.nsa.gov>
 <CA+xTVEuYb0oo6tDa-w4bU9pu+Rzb+7mrvXQqCkg_zy-9ns5aGQ@mail.gmail.com>
Cc: seandroid-list@tycho.nsa.gov, selinux@tycho.nsa.gov
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <638717f3-e434-938c-4edb-683784a4d94f@tycho.nsa.gov>
Date: Wed, 28 Sep 2016 12:54:21 -0400
MIME-Version: 1.0
In-Reply-To: <CA+xTVEuYb0oo6tDa-w4bU9pu+Rzb+7mrvXQqCkg_zy-9ns5aGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

On 09/28/2016 12:35 PM, Janis Danisevskis wrote:
> 
> 
> On Wed, Sep 28, 2016 at 5:17 PM, Stephen Smalley <sds@tycho.nsa.gov
> <mailto:sds@tycho.nsa.gov>> wrote:
> 
>     On 09/28/2016 12:04 PM, Janis Danisevskis wrote:
>     > We use the same lookup function for service contexts
>     > that we use for property contexts. However, property
>     > contexts are namespace based and only compare the
>     > prefix. This may lead to service associations with
>     > a wrong label.
>     >
>     > This patch introduces a stricter lookup function for
>     > services contexts. Now the service name must match
>     > the key of the service label exactly.
>     >
>     > Signed-off-by: Janis Danisevskis <jdanis@android.com <mailto:jdanis@android.com>>
>     > ---
>     >  libselinux/include/selinux/label.h      |  2 ++
>     >  libselinux/src/label.c                  |  1 +
>     >  libselinux/src/label_android_property.c | 50 +++++++++++++++++++++++++++++++++
>     >  libselinux/src/label_internal.h         |  3 ++
>     >  4 files changed, 56 insertions(+)
> 
>     Normally each backend would go into its own file, so service would get
>     its own.  Alternatively, since we are unlikely to ever support one
>     without the other, perhaps label_android_property.c should be renamed to
>     label_android.c and contain all of the Android-unique backends.
> 
> I was thinking along the same lines, was just eager to get home... I'll send
> a refactored patch by tomorrow.

Also, please update libselinux/utils/selabel_lookup.c and
selabel_digest.c to know about your new backend.
>  
> 
>     >
>     > diff --git a/libselinux/include/selinux/label.h b/libselinux/include/selinux/label.h
>     > index f0b1e10..277287e 100644
>     > --- a/libselinux/include/selinux/label.h
>     > +++ b/libselinux/include/selinux/label.h
>     > @@ -34,6 +34,8 @@ struct selabel_handle;
>     >  #define SELABEL_CTX_DB               3
>     >  /* Android property service contexts */
>     >  #define SELABEL_CTX_ANDROID_PROP 4
>     > +/* Android service contexts */
>     > +#define SELABEL_CTX_ANDROID_SERVICE 5
>     >
>     >  /*
>     >   * Available options
>     > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
>     > index 96a4ff1..eb0e766 100644
>     > --- a/libselinux/src/label.c
>     > +++ b/libselinux/src/label.c
>     > @@ -45,6 +45,7 @@ static selabel_initfunc initfuncs[] = {
>     >       CONFIG_X_BACKEND(selabel_x_init),
>     >       CONFIG_DB_BACKEND(selabel_db_init),
>     >       &selabel_property_init,
>     > +     &selabel_service_init,
> 
>     Wondering if we should support selective enablement of the property and
>     service backends too, similar to what William introduced for media, x,
>     and db so that he could disable them on Android (in our case, so we can
>     disable property and service backends on Linux distributions).
> 
> 
> Oh, that is what these wrappers are for :-) . Sure.
>  
> 
> 
>     >  };
>     >
>     >  static void selabel_subs_fini(struct selabel_sub *ptr)
>     > diff --git a/libselinux/src/label_android_property.c
>     b/libselinux/src/label_android_property.c
>     > index 290b438..69d6afd 100644
>     > --- a/libselinux/src/label_android_property.c
>     > +++ b/libselinux/src/label_android_property.c
>     > @@ -279,6 +279,38 @@ finish:
>     >       return ret;
>     >  }
>     >
>     > +static struct selabel_lookup_rec *service_lookup(struct
>     selabel_handle *rec,
>     > +             const char *key, int __attribute__((unused)) type)
>     > +{
>     > +     struct saved_data *data = (struct saved_data *)rec->data;
>     > +     spec_t *spec_arr = data->spec_arr;
>     > +     unsigned int i;
>     > +     struct selabel_lookup_rec *ret = NULL;
>     > +
>     > +     if (!data->nspec) {
>     > +             errno = ENOENT;
>     > +             goto finish;
>     > +     }
>     > +
>     > +     for (i = 0; i < data->nspec; i++) {
>     > +             if (strcmp(spec_arr[i].property_key, key) == 0)
>     > +                     break;
>     > +             if (strcmp(spec_arr[i].property_key, "*") == 0)
>     > +                     break;
>     > +     }
>     > +
>     > +     if (i >= data->nspec) {
>     > +             /* No matching specification. */
>     > +             errno = ENOENT;
>     > +             goto finish;
>     > +     }
>     > +
>     > +     ret = &spec_arr[i].lr;
>     > +
>     > +finish:
>     > +     return ret;
>     > +}
>     > +
>     >  static void stats(struct selabel_handle __attribute__((unused)) *rec)
>     >  {
>     >       selinux_log(SELINUX_WARNING, "'stats' functionality not
>     implemented.\n");
>     > @@ -302,3 +334,21 @@ int selabel_property_init(struct
>     selabel_handle *rec,
>     >
>     >       return init(rec, opts, nopts);
>     >  }
>     > +
>     > +int selabel_service_init(struct selabel_handle *rec,
>     > +             const struct selinux_opt *opts, unsigned nopts)
>     > +{
>     > +     struct saved_data *data;
>     > +
>     > +     data = (struct saved_data *)malloc(sizeof(*data));
>     > +     if (!data)
>     > +             return -1;
>     > +     memset(data, 0, sizeof(*data));
>     > +
>     > +     rec->data = data;
>     > +     rec->func_close = &closef;
>     > +     rec->func_stats = &stats;
>     > +     rec->func_lookup = &service_lookup;
>     > +
>     > +     return init(rec, opts, nopts);
>     > +}
>     > diff --git a/libselinux/src/label_internal.h
>     b/libselinux/src/label_internal.h
>     > index 7c55531..6a9481a 100644
>     > --- a/libselinux/src/label_internal.h
>     > +++ b/libselinux/src/label_internal.h
>     > @@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,
>     >  int selabel_property_init(struct selabel_handle *rec,
>     >                           const struct selinux_opt *opts,
>     >                           unsigned nopts) hidden;
>     > +int selabel_service_init(struct selabel_handle *rec,
>     > +                         const struct selinux_opt *opts,
>     > +                         unsigned nopts) hidden;
>     >
>     >  /*
>     >   * Labeling internal structures
>     >
> 
> 
> 
> 
> _______________________________________________
> Selinux mailing list
> Selinux@tycho.nsa.gov
> To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> To get help, send an email containing "help" to Selinux-request@tycho.nsa.gov.
> 
