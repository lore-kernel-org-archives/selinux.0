Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id v9MLufQq029266
 for <selinux@tycho.nsa.gov>; Sun, 22 Oct 2017 17:56:41 -0400
Received: by mail-yw0-f182.google.com with SMTP id u142so7011000ywg.4
 for <selinux@tycho.nsa.gov>; Sun, 22 Oct 2017 14:56:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdp9jSrU9Q4EcXNAEgXr43gBq3+4i3+WVJbkgpQ6GbNrGQ@mail.gmail.com>
References: <20171019234915.21820-1-jaekyun@google.com>
 <CABXk95D88yx3PV4XRkKTtr_u3SscQGsEVde=a5miX0KoAag4Ww@mail.gmail.com>
 <CAFftDdp9jSrU9Q4EcXNAEgXr43gBq3+4i3+WVJbkgpQ6GbNrGQ@mail.gmail.com>
From: Jaekyun Seok <jaekyun@google.com>
Date: Mon, 23 Oct 2017 06:56:36 +0900
Message-ID: <CANFkKyn++ZMcHAuBcZ1sGqr8OKTHYfowq=SUONNAMCkwtNf=0Q@mail.gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: Jeffrey Vander Stoep <jeffv@google.com>, SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="001a114bdabab90dbc055c29c72a"
Subject: Re: [PATCH] libselinux: android: support exact match for a
 property key
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a114bdabab90dbc055c29c72a
Content-Type: text/plain; charset="UTF-8"

Please see my inline comments.

Thanks,

On Sat, Oct 21, 2017 at 1:02 AM, William Roberts <bill.c.roberts@gmail.com>
wrote:

> On Fri, Oct 20, 2017 at 7:54 AM, Jeffrey Vander Stoep via Selinux
> <selinux@tycho.nsa.gov> wrote:
> > Please hold off on submission. We're discussing if this is really
> necessary.
>
> Yeah I'd like to hear about what issues the current longest match
> logic was causing
> in the commit message.
>

I am working to whitelist properties which should be restricted from being
accessed by some components.

To do that, exact match should be supported.


>
> >
> > On Thu, Oct 19, 2017 at 4:49 PM, Jaekyun Seok via Selinux
> > <selinux@tycho.nsa.gov> wrote:
> >> Performs exact match if a property key of property contexts ends with
> '$'
> >> instead of prefix match.
>
> This seems like an overly verbose way to accomplish exact match. The
> property_contexts
> file has things like:
>
> *                  <-- match everything
> foo.bar.       <- match prefix foo.bar. properties
> foo.bar.baz <-- currently matches foo.bar.baz, foo.bar.bazbaz, etc. No
> trailing .
>                         could be changed to mean exact match.
>
> Really what you would want is that if it doesn't end with a dot, don't
> do a prefix
> match. No need to add the $ semantic AFAICT.
>

Sounds good to me. I will discuss this way internally.


>
> >>
> >> This will enable to define an exact rule which can avoid unexpected
> >> context assignment.
> >>
> >> Signed-off-by: Jaekyun Seok <jaekyun@google.com>
> >> ---
> >>  libselinux/src/label_backends_android.c | 9 +++++++--
> >>  1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/libselinux/src/label_backends_android.c
> b/libselinux/src/label_backends_android.c
> >> index cb8aae26..4611d396 100644
> >> --- a/libselinux/src/label_backends_android.c
> >> +++ b/libselinux/src/label_backends_android.c
> >> @@ -258,8 +258,13 @@ static struct selabel_lookup_rec
> *property_lookup(struct selabel_handle *rec,
> >>         }
> >>
> >>         for (i = 0; i < data->nspec; i++) {
> >> -               if (strncmp(spec_arr[i].property_key, key,
> >> -                           strlen(spec_arr[i].property_key)) == 0) {
> >> +               size_t property_key_len = strlen(spec_arr[i].property_
> key);
> >> +               if (spec_arr[i].property_key[property_key_len - 1] ==
> '$' &&
> >> +                   strlen(key) == property_key_len - 1 &&
> >> +                   strncmp(spec_arr[i].property_key, key,
> property_key_len - 1) == 0) {
> >> +                       break;
> >> +               }
> >> +               if (strncmp(spec_arr[i].property_key, key,
> property_key_len) == 0) {
> >>                         break;
> >>                 }
> >>                 if (strncmp(spec_arr[i].property_key, "*", 1) == 0)
> >> --
> >> 2.15.0.rc0.271.g36b669edcc-goog
> >>
> >>
> >
>
>
>
> --
> Respectfully,
>
> William C Roberts
>



-- 
Jaekyun Seok | Software Engineer | jaekyun@google.com | +82 2 531 9235

--001a114bdabab90dbc055c29c72a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Please see my inline comments.</div><div><br></div>Th=
anks,<div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat,=
 Oct 21, 2017 at 1:02 AM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"=
mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com=
</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">O=
n Fri, Oct 20, 2017 at 7:54 AM, Jeffrey Vander Stoep via Selinux<br>
&lt;<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>&gt; =
wrote:<br>
&gt; Please hold off on submission. We&#39;re discussing if this is really =
necessary.<br>
<br>
</span>Yeah I&#39;d like to hear about what issues the current longest matc=
h<br>
logic was causing<br>
in the commit message.<br></blockquote><div><br></div><div>I am working to =
whitelist properties which should be restricted from being accessed by some=
 components.</div><div><br></div><div>To do that, exact match should be sup=
ported.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D""><br>
&gt;<br>
&gt; On Thu, Oct 19, 2017 at 4:49 PM, Jaekyun Seok via Selinux<br>
&gt; &lt;<a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a>=
&gt; wrote:<br>
&gt;&gt; Performs exact match if a property key of property contexts ends w=
ith &#39;$&#39;<br>
&gt;&gt; instead of prefix match.<br>
<br>
</span>This seems like an overly verbose way to accomplish exact match. The=
<br>
property_contexts<br>
file has things like:<br>
<br>
*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;-- matc=
h everything<br>
foo.bar.=C2=A0 =C2=A0 =C2=A0 =C2=A0&lt;- match prefix foo.bar. properties<b=
r>
foo.bar.baz &lt;-- currently matches foo.bar.baz, foo.bar.bazbaz, etc. No<b=
r>
trailing .<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 could be changed to mean exact match.<br>
<br>
Really what you would want is that if it doesn&#39;t end with a dot, don&#3=
9;t<br>
do a prefix<br>
match. No need to add the $ semantic AFAICT.<br></blockquote><div><br></div=
><div>Sounds good to me. I will discuss this way internally.</div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;&gt;<br>
&gt;&gt; This will enable to define an exact rule which can avoid unexpecte=
d<br>
&gt;&gt; context assignment.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Jaekyun Seok &lt;<a href=3D"mailto:jaekyun@google.c=
om">jaekyun@google.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 libselinux/src/label_backends_<wbr>android.c | 9 +++++++--<b=
r>
&gt;&gt;=C2=A0 1 file changed, 7 insertions(+), 2 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/libselinux/src/label_<wbr>backends_android.c b/libsel=
inux/src/label_<wbr>backends_android.c<br>
&gt;&gt; index cb8aae26..4611d396 100644<br>
&gt;&gt; --- a/libselinux/src/label_<wbr>backends_android.c<br>
&gt;&gt; +++ b/libselinux/src/label_<wbr>backends_android.c<br>
&gt;&gt; @@ -258,8 +258,13 @@ static struct selabel_lookup_rec *property_lo=
okup(struct selabel_handle *rec,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; data-&gt;nsp=
ec; i++) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncm=
p(spec_arr[i].property_<wbr>key, key,<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0strlen(spec_arr[i].property_<wbr>key)) =
=3D=3D 0) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t pro=
perty_key_len =3D strlen(spec_arr[i].property_<wbr>key);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (spec_a=
rr[i].property_key[<wbr>property_key_len - 1] =3D=3D &#39;$&#39; &amp;&amp;=
<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0strlen(key) =3D=3D property_key_len - 1 &amp;&amp;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0strncmp(spec_arr[i].property_<wbr>key, key, property_key_len - 1) =3D=
=3D 0) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (strncm=
p(spec_arr[i].property_<wbr>key, key, property_key_len) =3D=3D 0) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s=
trncmp(spec_arr[i].property_<wbr>key, &quot;*&quot;, 1) =3D=3D 0)<br>
&gt;&gt; --<br>
&gt;&gt; 2.15.0.rc0.271.g36b669edcc-<wbr>goog<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;<br>
<br>
<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">--<br>
Respectfully,<br>
<br>
William C Roberts<br>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r><div class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div di=
r=3D"ltr"><div><span style=3D"font-family:&#39;Times New Roman&#39;;font-si=
ze:medium"><div style=3D"line-height:1.5em;padding-top:10px;margin-top:10px=
;color:rgb(85,85,85);font-family:sans-serif;font-size:small"><span style=3D=
"border-top-width:2px;border-right-width:0px;border-bottom-width:0px;border=
-left-width:0px;border-top-style:solid;border-right-style:solid;border-bott=
om-style:solid;border-left-style:solid;border-top-color:rgb(213,15,37);bord=
er-right-color:rgb(213,15,37);border-bottom-color:rgb(213,15,37);border-lef=
t-color:rgb(213,15,37);padding-top:2px;margin-top:2px">Jaekyun Seok=C2=A0|<=
/span><span style=3D"border-top-width:2px;border-right-width:0px;border-bot=
tom-width:0px;border-left-width:0px;border-top-style:solid;border-right-sty=
le:solid;border-bottom-style:solid;border-left-style:solid;border-top-color=
:rgb(51,105,232);border-right-color:rgb(51,105,232);border-bottom-color:rgb=
(51,105,232);border-left-color:rgb(51,105,232);padding-top:2px;margin-top:2=
px">=C2=A0Software Engineer=C2=A0|</span><span style=3D"border-top-width:2p=
x;border-right-width:0px;border-bottom-width:0px;border-left-width:0px;bord=
er-top-style:solid;border-right-style:solid;border-bottom-style:solid;borde=
r-left-style:solid;border-top-color:rgb(0,153,57);border-right-color:rgb(0,=
153,57);border-bottom-color:rgb(0,153,57);border-left-color:rgb(0,153,57);p=
adding-top:2px;margin-top:2px">=C2=A0<a href=3D"mailto:jaekyun@google.com" =
target=3D"_blank">jaekyun@google.com</a>=C2=A0|</span><span style=3D"border=
-top-width:2px;border-right-width:0px;border-bottom-width:0px;border-left-w=
idth:0px;border-top-style:solid;border-right-style:solid;border-bottom-styl=
e:solid;border-left-style:solid;border-top-color:rgb(238,178,17);border-rig=
ht-color:rgb(238,178,17);border-bottom-color:rgb(238,178,17);border-left-co=
lor:rgb(238,178,17);padding-top:2px;margin-top:2px">=C2=A0+82 2 531 9235</s=
pan></div></span></div></div></div>
</div></div></div>

--001a114bdabab90dbc055c29c72a--
