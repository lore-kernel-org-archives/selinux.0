Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8TD1C7E003257
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 09:01:13 -0400
Received: by mail-qt0-f176.google.com with SMTP id 30so11041632qth.2
 for <selinux@tycho.nsa.gov>; Thu, 29 Sep 2016 06:01:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdofw9O3FriN3PqFdMy5LEqFC79PGR10ePcVeD3csZ10oQ@mail.gmail.com>
References: <1475149159-21757-1-git-send-email-jdanis@android.com>
 <1475149159-21757-2-git-send-email-jdanis@android.com>
 <CAFftDdofw9O3FriN3PqFdMy5LEqFC79PGR10ePcVeD3csZ10oQ@mail.gmail.com>
From: Janis Danisevskis <jdanis@android.com>
Date: Thu, 29 Sep 2016 14:01:05 +0100
Message-ID: <CA+xTVEuOY5qJXhw93LPBO_3aaK65Jni-9oof6eFXpen5dW9Z3Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] libselinux: android: fix lax service context lookup
To: William Roberts <bill.c.roberts@gmail.com>
Cc: "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 "seandroid-list@tycho.nsa.gov" <seandroid-list@tycho.nsa.gov>,
 Stephen Smalley <sds@tycho.nsa.gov>, James Carter <jwcart2@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=001a113bef4c1fd64c053da512bd
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113bef4c1fd64c053da512bd
Content-Type: text/plain; charset=UTF-8

William: Good thing you mention checkfc. I added you as a reviewer.

On Thu, Sep 29, 2016 at 12:57 PM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> do you have the corresponding changes to checkfc on AOSP?
>
> On Thu, Sep 29, 2016 at 7:39 AM, Janis Danisevskis <jdanis@android.com>
> wrote:
> > We use the same lookup function for service contexts
> > that we use for property contexts. However, property
> > contexts are namespace based and only compare the
> > prefix. This may lead to service associations with
> > a wrong label.
> >
> > This patch introduces a new back end for android
> > services with a stricter lookup function. Now the
> > service name must match the key of the service label
> > exactly.
> >
> > Signed-off-by: Janis Danisevskis <jdanis@android.com>
> > ---
> >  libselinux/include/selinux/label.h      |  2 ++
> >  libselinux/src/label.c                  |  1 +
> >  libselinux/src/label_backends_android.c | 54
> +++++++++++++++++++++++++++++++--
> >  libselinux/src/label_internal.h         |  3 ++
> >  libselinux/utils/selabel_digest.c       |  2 ++
> >  libselinux/utils/selabel_lookup.c       |  2 ++
> >  6 files changed, 62 insertions(+), 2 deletions(-)
> >
> > diff --git a/libselinux/include/selinux/label.h
> b/libselinux/include/selinux/label.h
> > index f0b1e10..277287e 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -34,6 +34,8 @@ struct selabel_handle;
> >  #define SELABEL_CTX_DB         3
> >  /* Android property service contexts */
> >  #define SELABEL_CTX_ANDROID_PROP 4
> > +/* Android service contexts */
> > +#define SELABEL_CTX_ANDROID_SERVICE 5
> >
> >  /*
> >   * Available options
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index 96a4ff1..eb0e766 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -45,6 +45,7 @@ static selabel_initfunc initfuncs[] = {
> >         CONFIG_X_BACKEND(selabel_x_init),
> >         CONFIG_DB_BACKEND(selabel_db_init),
> >         &selabel_property_init,
> > +       &selabel_service_init,
> >  };
> >
> >  static void selabel_subs_fini(struct selabel_sub *ptr)
> > diff --git a/libselinux/src/label_backends_android.c
> b/libselinux/src/label_backends_android.c
> > index 290b438..4d6ec86 100644
> > --- a/libselinux/src/label_backends_android.c
> > +++ b/libselinux/src/label_backends_android.c
> > @@ -244,7 +244,7 @@ static void closef(struct selabel_handle *rec)
> >         free(data);
> >  }
> >
> > -static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,
> > +static struct selabel_lookup_rec *property_lookup(struct selabel_handle
> *rec,
> >                                          const char *key,
> >                                          int __attribute__((unused))
> type)
> >  {
> > @@ -279,6 +279,38 @@ finish:
> >         return ret;
> >  }
> >
> > +static struct selabel_lookup_rec *service_lookup(struct selabel_handle
> *rec,
> > +               const char *key, int __attribute__((unused)) type)
> > +{
> > +       struct saved_data *data = (struct saved_data *)rec->data;
> > +       spec_t *spec_arr = data->spec_arr;
> > +       unsigned int i;
> > +       struct selabel_lookup_rec *ret = NULL;
> > +
> > +       if (!data->nspec) {
> > +               errno = ENOENT;
> > +               goto finish;
> > +       }
> > +
> > +       for (i = 0; i < data->nspec; i++) {
> > +               if (strcmp(spec_arr[i].property_key, key) == 0)
> > +                       break;
> > +               if (strcmp(spec_arr[i].property_key, "*") == 0)
> > +                       break;
> > +       }
> > +
> > +       if (i >= data->nspec) {
> > +               /* No matching specification. */
> > +               errno = ENOENT;
> > +               goto finish;
> > +       }
> > +
> > +       ret = &spec_arr[i].lr;
> > +
> > +finish:
> > +       return ret;
> > +}
> > +
> >  static void stats(struct selabel_handle __attribute__((unused)) *rec)
> >  {
> >         selinux_log(SELINUX_WARNING, "'stats' functionality not
> implemented.\n");
> > @@ -298,7 +330,25 @@ int selabel_property_init(struct selabel_handle
> *rec,
> >         rec->data = data;
> >         rec->func_close = &closef;
> >         rec->func_stats = &stats;
> > -       rec->func_lookup = &lookup;
> > +       rec->func_lookup = &property_lookup;
> > +
> > +       return init(rec, opts, nopts);
> > +}
> > +
> > +int selabel_service_init(struct selabel_handle *rec,
> > +               const struct selinux_opt *opts, unsigned nopts)
> > +{
> > +       struct saved_data *data;
> > +
> > +       data = (struct saved_data *)malloc(sizeof(*data));
> > +       if (!data)
> > +               return -1;
> > +       memset(data, 0, sizeof(*data));
> > +
> > +       rec->data = data;
> > +       rec->func_close = &closef;
> > +       rec->func_stats = &stats;
> > +       rec->func_lookup = &service_lookup;
> >
> >         return init(rec, opts, nopts);
> >  }
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_
> internal.h
> > index 7c55531..6a9481a 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,
> >  int selabel_property_init(struct selabel_handle *rec,
> >                             const struct selinux_opt *opts,
> >                             unsigned nopts) hidden;
> > +int selabel_service_init(struct selabel_handle *rec,
> > +                           const struct selinux_opt *opts,
> > +                           unsigned nopts) hidden;
> >
> >  /*
> >   * Labeling internal structures
> > diff --git a/libselinux/utils/selabel_digest.c
> b/libselinux/utils/selabel_digest.c
> > index 38162a5..e4d84a5 100644
> > --- a/libselinux/utils/selabel_digest.c
> > +++ b/libselinux/utils/selabel_digest.c
> > @@ -92,6 +92,8 @@ int main(int argc, char **argv)
> >                                 backend = SELABEL_CTX_DB;
> >                         } else if (!strcmp(optarg, "prop")) {
> >                                 backend = SELABEL_CTX_ANDROID_PROP;
> > +                       } else if (!strcmp(optarg, "service")) {
> > +                               backend = SELABEL_CTX_ANDROID_SERVICE;
> >                         } else {
> >                                 fprintf(stderr, "Unknown backend: %s\n",
> >
>  optarg);
> > diff --git a/libselinux/utils/selabel_lookup.c
> b/libselinux/utils/selabel_lookup.c
> > index d0b1457..b678a89 100644
> > --- a/libselinux/utils/selabel_lookup.c
> > +++ b/libselinux/utils/selabel_lookup.c
> > @@ -57,6 +57,8 @@ int main(int argc, char **argv)
> >                                 backend = SELABEL_CTX_DB;
> >                         } else if (!strcmp(optarg, "prop")) {
> >                                 backend = SELABEL_CTX_ANDROID_PROP;
> > +                       } else if (!strcmp(optarg, "service")) {
> > +                               backend = SELABEL_CTX_ANDROID_SERVICE;
> >                         } else {
> >                                 fprintf(stderr, "Unknown backend: %s\n",
> >
>  optarg);
> > --
> > 1.9.1
> >
> > _______________________________________________
> > Selinux mailing list
> > Selinux@tycho.nsa.gov
> > To unsubscribe, send email to Selinux-leave@tycho.nsa.gov.
> > To get help, send an email containing "help" to
> Selinux-request@tycho.nsa.gov.
>
>
>
> --
> Respectfully,
>
> William C Roberts
>

--001a113bef4c1fd64c053da512bd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">William: Good thing you mention checkfc. I added you as a =
reviewer.</div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Sep 29, 2016 at 12:57 PM, William Roberts <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gma=
il.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">do you have =
the corresponding changes to checkfc on AOSP?<br>
<div><div class=3D"h5"><br>
On Thu, Sep 29, 2016 at 7:39 AM, Janis Danisevskis &lt;<a href=3D"mailto:jd=
anis@android.com">jdanis@android.com</a>&gt; wrote:<br>
&gt; We use the same lookup function for service contexts<br>
&gt; that we use for property contexts. However, property<br>
&gt; contexts are namespace based and only compare the<br>
&gt; prefix. This may lead to service associations with<br>
&gt; a wrong label.<br>
&gt;<br>
&gt; This patch introduces a new back end for android<br>
&gt; services with a stricter lookup function. Now the<br>
&gt; service name must match the key of the service label<br>
&gt; exactly.<br>
&gt;<br>
&gt; Signed-off-by: Janis Danisevskis &lt;<a href=3D"mailto:jdanis@android.=
com">jdanis@android.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 libselinux/include/selinux/<wbr>label.h=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 ++<br>
&gt;=C2=A0 libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 libselinux/src/label_backends_<wbr>android.c | 54 ++++++++++++++=
++++++++++++++++<wbr>+--<br>
&gt;=C2=A0 libselinux/src/label_internal.<wbr>h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 ++<br>
&gt;=C2=A0 libselinux/utils/selabel_<wbr>digest.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 libselinux/utils/selabel_<wbr>lookup.c=C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 2 ++<br>
&gt;=C2=A0 6 files changed, 62 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/libselinux/include/selinux/<wbr>label.h b/libselinux/incl=
ude/selinux/<wbr>label.h<br>
&gt; index f0b1e10..277287e 100644<br>
&gt; --- a/libselinux/include/selinux/<wbr>label.h<br>
&gt; +++ b/libselinux/include/selinux/<wbr>label.h<br>
&gt; @@ -34,6 +34,8 @@ struct selabel_handle;<br>
&gt;=C2=A0 #define SELABEL_CTX_DB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
&gt;=C2=A0 /* Android property service contexts */<br>
&gt;=C2=A0 #define SELABEL_CTX_ANDROID_PROP 4<br>
&gt; +/* Android service contexts */<br>
&gt; +#define SELABEL_CTX_ANDROID_SERVICE 5<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Available options<br>
&gt; diff --git a/libselinux/src/label.c b/libselinux/src/label.c<br>
&gt; index 96a4ff1..eb0e766 100644<br>
&gt; --- a/libselinux/src/label.c<br>
&gt; +++ b/libselinux/src/label.c<br>
&gt; @@ -45,6 +45,7 @@ static selabel_initfunc initfuncs[] =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_X_BACKEND(selabel_x_<wbr>init)=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_DB_BACKEND(selabel_db_<wbr>ini=
t),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;selabel_property_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;selabel_service_init,<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static void selabel_subs_fini(struct selabel_sub *ptr)<br>
&gt; diff --git a/libselinux/src/label_<wbr>backends_android.c b/libselinux=
/src/label_<wbr>backends_android.c<br>
&gt; index 290b438..4d6ec86 100644<br>
&gt; --- a/libselinux/src/label_<wbr>backends_android.c<br>
&gt; +++ b/libselinux/src/label_<wbr>backends_android.c<br>
&gt; @@ -244,7 +244,7 @@ static void closef(struct selabel_handle *rec)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free(data);<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; -static struct selabel_lookup_rec *lookup(struct selabel_handle *rec,<=
br>
&gt; +static struct selabel_lookup_rec *property_lookup(struct selabel_hand=
le *rec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 const char *key,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 int __attribute__((unused)) type)<br>
&gt;=C2=A0 {<br>
&gt; @@ -279,6 +279,38 @@ finish:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static struct selabel_lookup_rec *service_lookup(struct selabel_handl=
e *rec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *ke=
y, int __attribute__((unused)) type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (struct saved_=
data *)rec-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_t *spec_arr =3D data-&gt;spec_arr;<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selabel_lookup_rec *ret =3D NULL;<b=
r>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data-&gt;nspec) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOE=
NT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto finish;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; data-&gt;nspec; i++) =
{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(spe=
c_arr[i].property_<wbr>key, key) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(spe=
c_arr[i].property_<wbr>key, &quot;*&quot;) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (i &gt;=3D data-&gt;nspec) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* No matching=
 specification. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOE=
NT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto finish;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D &amp;spec_arr[i].lr;<br>
&gt; +<br>
&gt; +finish:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void stats(struct selabel_handle __attribute__((unused)) =
*rec)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_log(SELINUX_WARNING, &quot;&#=
39;stats&#39; functionality not implemented.\n&quot;);<br>
&gt; @@ -298,7 +330,25 @@ int selabel_property_init(struct selabel_handle *=
rec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;data =3D data;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_close =3D &amp;closef;<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_stats =3D &amp;stats;<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_lookup =3D &amp;lookup;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_lookup =3D &amp;property_look=
up;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0return init(rec, opts, nopts);<br>
&gt; +}<br>
&gt; +<br>
&gt; +int selabel_service_init(struct selabel_handle *rec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct s=
elinux_opt *opts, unsigned nopts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0struct saved_data *data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0data =3D (struct saved_data *)malloc(sizeo=
f(*data));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(data, 0, sizeof(*data));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;data =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_close =3D &amp;closef;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_stats =3D &amp;stats;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0rec-&gt;func_lookup =3D &amp;service_looku=
p;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return init(rec, opts, nopts);<br>
&gt;=C2=A0 }<br>
&gt; diff --git a/libselinux/src/label_<wbr>internal.h b/libselinux/src/lab=
el_<wbr>internal.h<br>
&gt; index 7c55531..6a9481a 100644<br>
&gt; --- a/libselinux/src/label_<wbr>internal.h<br>
&gt; +++ b/libselinux/src/label_<wbr>internal.h<br>
&gt; @@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,<br>
&gt;=C2=A0 int selabel_property_init(struct selabel_handle *rec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct selinux_opt *opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned nopts) hidden;<br>
&gt; +int selabel_service_init(struct selabel_handle *rec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct selinux_opt *opts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned nopts) hidden;<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Labeling internal structures<br>
&gt; diff --git a/libselinux/utils/selabel_<wbr>digest.c b/libselinux/utils=
/selabel_<wbr>digest.c<br>
&gt; index 38162a5..e4d84a5 100644<br>
&gt; --- a/libselinux/utils/selabel_<wbr>digest.c<br>
&gt; +++ b/libselinux/utils/selabel_<wbr>digest.c<br>
&gt; @@ -92,6 +92,8 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D SELABEL_CTX_DB;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else if (!strcmp(optarg, &quot;prop&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D SELABEL_CTX_AND=
ROID_PROP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0} else if (!strcmp(optarg, &quot;service&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D SELABEL_CTX_ANDROID_S=
ERVICE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Unkno=
wn backend: %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0optarg);<br>
&gt; diff --git a/libselinux/utils/selabel_<wbr>lookup.c b/libselinux/utils=
/selabel_<wbr>lookup.c<br>
&gt; index d0b1457..b678a89 100644<br>
&gt; --- a/libselinux/utils/selabel_<wbr>lookup.c<br>
&gt; +++ b/libselinux/utils/selabel_<wbr>lookup.c<br>
&gt; @@ -57,6 +57,8 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D SELABEL_CTX_DB;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else if (!strcmp(optarg, &quot;prop&quot;)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D SELABEL_CTX_AND=
ROID_PROP;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0} else if (!strcmp(optarg, &quot;service&quot;)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backend =3D SELABEL_CTX_ANDROID_S=
ERVICE;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;Unkno=
wn backend: %s\n&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0optarg);<br>
&gt; --<br>
&gt; 1.9.1<br>
&gt;<br>
</div></div>&gt; ______________________________<wbr>_________________<br>
&gt; Selinux mailing list<br>
&gt; <a href=3D"mailto:Selinux@tycho.nsa.gov">Selinux@tycho.nsa.gov</a><br>
&gt; To unsubscribe, send email to <a href=3D"mailto:Selinux-leave@tycho.ns=
a.gov">Selinux-leave@tycho.nsa.gov</a>.<br>
&gt; To get help, send an email containing &quot;help&quot; to <a href=3D"m=
ailto:Selinux-request@tycho.nsa.gov">Selinux-request@tycho.nsa.gov</a>.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</font></span></blockquote></div><br></div>

--001a113bef4c1fd64c053da512bd--
