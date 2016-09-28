Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u8SGZPcW008266
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 12:35:25 -0400
Received: by mail-qk0-f180.google.com with SMTP id j129so44597397qkd.1
 for <selinux@tycho.nsa.gov>; Wed, 28 Sep 2016 09:35:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1a53409d-1773-187b-e0cb-d49c8ac2d1a2@tycho.nsa.gov>
References: <1475078690-42486-1-git-send-email-jdanis@android.com>
 <1a53409d-1773-187b-e0cb-d49c8ac2d1a2@tycho.nsa.gov>
From: Janis Danisevskis <jdanis@android.com>
Date: Wed, 28 Sep 2016 17:35:17 +0100
Message-ID: <CA+xTVEuYb0oo6tDa-w4bU9pu+Rzb+7mrvXQqCkg_zy-9ns5aGQ@mail.gmail.com>
Subject: Re: [PATCH] libselinux: android: fix lax service context lookup
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov, seandroid-list@tycho.nsa.gov,
 James Carter <jwcart2@tycho.nsa.gov>, Janis Danisevskis <jdanis@google.com>
Content-Type: multipart/alternative; boundary=001a11479a2c4aef69053d93f2c3
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11479a2c4aef69053d93f2c3
Content-Type: text/plain; charset=UTF-8

On Wed, Sep 28, 2016 at 5:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 09/28/2016 12:04 PM, Janis Danisevskis wrote:
> > We use the same lookup function for service contexts
> > that we use for property contexts. However, property
> > contexts are namespace based and only compare the
> > prefix. This may lead to service associations with
> > a wrong label.
> >
> > This patch introduces a stricter lookup function for
> > services contexts. Now the service name must match
> > the key of the service label exactly.
> >
> > Signed-off-by: Janis Danisevskis <jdanis@android.com>
> > ---
> >  libselinux/include/selinux/label.h      |  2 ++
> >  libselinux/src/label.c                  |  1 +
> >  libselinux/src/label_android_property.c | 50
> +++++++++++++++++++++++++++++++++
> >  libselinux/src/label_internal.h         |  3 ++
> >  4 files changed, 56 insertions(+)
>
> Normally each backend would go into its own file, so service would get
> its own.  Alternatively, since we are unlikely to ever support one
> without the other, perhaps label_android_property.c should be renamed to
> label_android.c and contain all of the Android-unique backends.
>
> I was thinking along the same lines, was just eager to get home... I'll
send
a refactored patch by tomorrow.


> >
> > diff --git a/libselinux/include/selinux/label.h
> b/libselinux/include/selinux/label.h
> > index f0b1e10..277287e 100644
> > --- a/libselinux/include/selinux/label.h
> > +++ b/libselinux/include/selinux/label.h
> > @@ -34,6 +34,8 @@ struct selabel_handle;
> >  #define SELABEL_CTX_DB               3
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
> >       CONFIG_X_BACKEND(selabel_x_init),
> >       CONFIG_DB_BACKEND(selabel_db_init),
> >       &selabel_property_init,
> > +     &selabel_service_init,
>
> Wondering if we should support selective enablement of the property and
> service backends too, similar to what William introduced for media, x,
> and db so that he could disable them on Android (in our case, so we can
> disable property and service backends on Linux distributions).
>

Oh, that is what these wrappers are for :-) . Sure.


>
> >  };
> >
> >  static void selabel_subs_fini(struct selabel_sub *ptr)
> > diff --git a/libselinux/src/label_android_property.c
> b/libselinux/src/label_android_property.c
> > index 290b438..69d6afd 100644
> > --- a/libselinux/src/label_android_property.c
> > +++ b/libselinux/src/label_android_property.c
> > @@ -279,6 +279,38 @@ finish:
> >       return ret;
> >  }
> >
> > +static struct selabel_lookup_rec *service_lookup(struct selabel_handle
> *rec,
> > +             const char *key, int __attribute__((unused)) type)
> > +{
> > +     struct saved_data *data = (struct saved_data *)rec->data;
> > +     spec_t *spec_arr = data->spec_arr;
> > +     unsigned int i;
> > +     struct selabel_lookup_rec *ret = NULL;
> > +
> > +     if (!data->nspec) {
> > +             errno = ENOENT;
> > +             goto finish;
> > +     }
> > +
> > +     for (i = 0; i < data->nspec; i++) {
> > +             if (strcmp(spec_arr[i].property_key, key) == 0)
> > +                     break;
> > +             if (strcmp(spec_arr[i].property_key, "*") == 0)
> > +                     break;
> > +     }
> > +
> > +     if (i >= data->nspec) {
> > +             /* No matching specification. */
> > +             errno = ENOENT;
> > +             goto finish;
> > +     }
> > +
> > +     ret = &spec_arr[i].lr;
> > +
> > +finish:
> > +     return ret;
> > +}
> > +
> >  static void stats(struct selabel_handle __attribute__((unused)) *rec)
> >  {
> >       selinux_log(SELINUX_WARNING, "'stats' functionality not
> implemented.\n");
> > @@ -302,3 +334,21 @@ int selabel_property_init(struct selabel_handle
> *rec,
> >
> >       return init(rec, opts, nopts);
> >  }
> > +
> > +int selabel_service_init(struct selabel_handle *rec,
> > +             const struct selinux_opt *opts, unsigned nopts)
> > +{
> > +     struct saved_data *data;
> > +
> > +     data = (struct saved_data *)malloc(sizeof(*data));
> > +     if (!data)
> > +             return -1;
> > +     memset(data, 0, sizeof(*data));
> > +
> > +     rec->data = data;
> > +     rec->func_close = &closef;
> > +     rec->func_stats = &stats;
> > +     rec->func_lookup = &service_lookup;
> > +
> > +     return init(rec, opts, nopts);
> > +}
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_
> internal.h
> > index 7c55531..6a9481a 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,
> >  int selabel_property_init(struct selabel_handle *rec,
> >                           const struct selinux_opt *opts,
> >                           unsigned nopts) hidden;
> > +int selabel_service_init(struct selabel_handle *rec,
> > +                         const struct selinux_opt *opts,
> > +                         unsigned nopts) hidden;
> >
> >  /*
> >   * Labeling internal structures
> >
>
>

--001a11479a2c4aef69053d93f2c3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Wed, Sep 28, 2016 at 5:17 PM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 0=
9/28/2016 12:04 PM, Janis Danisevskis wrote:<br>
&gt; We use the same lookup function for service contexts<br>
&gt; that we use for property contexts. However, property<br>
&gt; contexts are namespace based and only compare the<br>
&gt; prefix. This may lead to service associations with<br>
&gt; a wrong label.<br>
&gt;<br>
&gt; This patch introduces a stricter lookup function for<br>
&gt; services contexts. Now the service name must match<br>
&gt; the key of the service label exactly.<br>
&gt;<br>
&gt; Signed-off-by: Janis Danisevskis &lt;<a href=3D"mailto:jdanis@android.=
com">jdanis@android.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 libselinux/include/selinux/<wbr>label.h=C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 ++<br>
&gt;=C2=A0 libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 1 +<br>
&gt;=C2=A0 libselinux/src/label_android_<wbr>property.c | 50 ++++++++++++++=
++++++++++++++++<wbr>+++<br>
&gt;=C2=A0 libselinux/src/label_internal.<wbr>h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 3 ++<br>
&gt;=C2=A0 4 files changed, 56 insertions(+)<br>
<br>
</span>Normally each backend would go into its own file, so service would g=
et<br>
its own.=C2=A0 Alternatively, since we are unlikely to ever support one<br>
without the other, perhaps label_android_property.c should be renamed to<br=
>
label_android.c and contain all of the Android-unique backends.<br>
<span class=3D""><br></span></blockquote><div>I was thinking along the same=
 lines, was just eager to get home... I&#39;ll send</div><div>a refactored =
patch by tomorrow.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><sp=
an class=3D"">
&gt;<br>
&gt; diff --git a/libselinux/include/selinux/<wbr>label.h b/libselinux/incl=
ude/selinux/<wbr>label.h<br>
&gt; index f0b1e10..277287e 100644<br>
&gt; --- a/libselinux/include/selinux/<wbr>label.h<br>
&gt; +++ b/libselinux/include/selinux/<wbr>label.h<br>
&gt; @@ -34,6 +34,8 @@ struct selabel_handle;<br>
&gt;=C2=A0 #define SELABEL_CTX_DB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A03<br>
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
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_X_BACKEND(selabel_x_<wbr>init),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CONFIG_DB_BACKEND(selabel_db_<wbr>init),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;selabel_property_init,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0&amp;selabel_service_init,<br>
<br>
</span>Wondering if we should support selective enablement of the property =
and<br>
service backends too, similar to what William introduced for media, x,<br>
and db so that he could disable them on Android (in our case, so we can<br>
disable property and service backends on Linux distributions).<br></blockqu=
ote><div><br></div><div>Oh, that is what these wrappers are for :-) . Sure.=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 =
0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 static void selabel_subs_fini(struct selabel_sub *ptr)<br>
&gt; diff --git a/libselinux/src/label_<wbr>android_property.c b/libselinux=
/src/label_<wbr>android_property.c<br>
&gt; index 290b438..69d6afd 100644<br>
&gt; --- a/libselinux/src/label_<wbr>android_property.c<br>
&gt; +++ b/libselinux/src/label_<wbr>android_property.c<br>
&gt; @@ -279,6 +279,38 @@ finish:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt;=C2=A0 }<br>
&gt;<br>
&gt; +static struct selabel_lookup_rec *service_lookup(struct selabel_handl=
e *rec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *key, int =
__attribute__((unused)) type)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct saved_data *data =3D (struct saved_data *)=
rec-&gt;data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spec_t *spec_arr =3D data-&gt;spec_arr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct selabel_lookup_rec *ret =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!data-&gt;nspec) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOENT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto finish;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; data-&gt;nspec; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(spec_arr[i=
].property_<wbr>key, key) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strcmp(spec_arr[i=
].property_<wbr>key, &quot;*&quot;) =3D=3D 0)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (i &gt;=3D data-&gt;nspec) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* No matching specif=
ication. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0errno =3D ENOENT;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto finish;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0ret =3D &amp;spec_arr[i].lr;<br>
&gt; +<br>
&gt; +finish:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 static void stats(struct selabel_handle __attribute__((unused)) =
*rec)<br>
&gt;=C2=A0 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0selinux_log(SELINUX_WARNING, &quot;&#39;stat=
s&#39; functionality not implemented.\n&quot;);<br>
&gt; @@ -302,3 +334,21 @@ int selabel_property_init(struct selabel_handle *=
rec,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return init(rec, opts, nopts);<br>
&gt;=C2=A0 }<br>
&gt; +<br>
&gt; +int selabel_service_init(struct selabel_handle *rec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const struct selinux_=
opt *opts, unsigned nopts)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0struct saved_data *data;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0data =3D (struct saved_data *)malloc(sizeof(*data=
));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (!data)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0memset(data, 0, sizeof(*data));<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rec-&gt;data =3D data;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rec-&gt;func_close =3D &amp;closef;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rec-&gt;func_stats =3D &amp;stats;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rec-&gt;func_lookup =3D &amp;service_lookup;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0return init(rec, opts, nopts);<br>
&gt; +}<br>
&gt; diff --git a/libselinux/src/label_<wbr>internal.h b/libselinux/src/lab=
el_<wbr>internal.h<br>
&gt; index 7c55531..6a9481a 100644<br>
&gt; --- a/libselinux/src/label_<wbr>internal.h<br>
&gt; +++ b/libselinux/src/label_<wbr>internal.h<br>
&gt; @@ -39,6 +39,9 @@ int selabel_db_init(struct selabel_handle *rec,<br>
&gt;=C2=A0 int selabel_property_init(struct selabel_handle *rec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct selinux_opt *opts,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned nopts) hidden;<br>
&gt; +int selabel_service_init(struct selabel_handle *rec,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0const struct selinux_opt *opts,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0unsigned nopts) hidden;<br>
&gt;<br>
&gt;=C2=A0 /*<br>
&gt;=C2=A0 =C2=A0* Labeling internal structures<br>
&gt;<br>
<br>
</div></div></blockquote></div><br></div></div>

--001a11479a2c4aef69053d93f2c3--
