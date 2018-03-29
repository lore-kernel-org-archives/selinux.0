MIME-Version: 1.0
In-Reply-To: <bb100d0a-57d7-22cd-502c-f586f7a2b51f@tycho.nsa.gov>
References: <20180329034003.2231-1-ykhodo@gmail.com>
 <20180329034003.2231-3-ykhodo@gmail.com>
 <bb100d0a-57d7-22cd-502c-f586f7a2b51f@tycho.nsa.gov>
From: Yuli Khodorkovskiy <ykhodo@gmail.com>
Date: Thu, 29 Mar 2018 11:48:18 -0400
Message-ID: <CAHnwOHAC6B2atYNQOdQrY-xooEcvXMKRTRfWP6jWv1tcxi2ZTw@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary="089e082f510084f3d005688f0dfa"
Subject: Re: [PATCH v2 2/2] libselinux: echo line number of bad
 label in selabel_fini()
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--089e082f510084f3d005688f0dfa
Content-Type: text/plain; charset="UTF-8"

On Thu, Mar 29, 2018 at 9:49 AM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 03/28/2018 11:40 PM, Yuli Khodorkovskiy wrote:
> > Keep track of line numbers for each file context in
> > selabel_handle. If an error occurs in selabel_fini(), the
> > line number of an invalid file context is echoed to the user.
> >
> > Signed-off-by: Yuli Khodorkovskiy <ykhodo@gmail.com>
> > ---
> >  libselinux/src/label.c          | 2 +-
> >  libselinux/src/label_file.h     | 1 +
> >  libselinux/src/label_internal.h | 1 +
> >  3 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/libselinux/src/label.c b/libselinux/src/label.c
> > index e642a97b..d9a58ce9 100644
> > --- a/libselinux/src/label.c
> > +++ b/libselinux/src/label.c
> > @@ -143,7 +143,7 @@ static int selabel_fini(struct selabel_handle *rec,
> >                           struct selabel_lookup_rec *lr,
> >                           int translating)
> >  {
> > -     if (compat_validate(rec, lr, rec->spec_file, 0))
> > +     if (compat_validate(rec, lr, rec->spec_file, lr->lineno))
> >               return -1;
> >
> >       if (translating && !lr->ctx_trans &&
> > diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h
> > index aa576d8e..4780ae48 100644
> > --- a/libselinux/src/label_file.h
> > +++ b/libselinux/src/label_file.h
> > @@ -472,6 +472,7 @@ static inline int process_line(struct selabel_handle
> *rec,
> >       spec_arr[nspec].mode = 0;
> >
> >       spec_arr[nspec].lr.ctx_raw = context;
> > +     spec_arr[nspec].lr.lineno = lineno;
> >
> >       /*
> >        * bump data->nspecs to cause closef() to cover it in its free
> > diff --git a/libselinux/src/label_internal.h b/libselinux/src/label_
> internal.h
> > index c55efb75..0e020557 100644
> > --- a/libselinux/src/label_internal.h
> > +++ b/libselinux/src/label_internal.h
> > @@ -73,6 +73,7 @@ struct selabel_lookup_rec {
> >       char * ctx_raw;
> >       char * ctx_trans;
> >       int validated;
> > +     unsigned lineno;
> >  };
> >
> >  struct selabel_handle {
> >
>
> I think this is ok, but wanted to double check: does this work correctly
> when file contexts are loaded from
> file_contexts.bin instead?  It looks to me as if the lineno will be left
> as 0 in that case and the
> code will handle that correctly.
>

Compiling a file_contexts.bin with sefcontext_compile will give you the
line number:

sefcontext_compile /etc/selinux/targeted/contexts/files/file_contexts -o
file_contexts.bin -p /etc/selinux/targeted/policy/policy.31
libsepol.sepol_context_from_string: malformed context "test"
libsepol.sepol_context_from_string: could not construct context from string
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert test to sid
/etc/selinux/targeted/contexts/files/file_contexts: line 6132 has invalid
context test
sefcontext_compile: process_file failed

Using file_contexts.bin for relabeling that I generated with no validation
will not report a line number:

restorecon: /etc/selinux/targeted/contexts/files/file_contexts: has invalid
context test

I'll see if I can associate the line number with each regex in
sefcontext_compile.



>
> The other question is whether we correctly report the file name when the
> entry comes from a file other
> than file_contexts itself, e.g. file_contexts.local, .homedirs, ...  Not
> your bug if we don't but wondered.
>

It is reporting the line number correctly, but the filename is incorrect.
I'll update this.

--089e082f510084f3d005688f0dfa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, Mar 29, 2018 at 9:49 AM, Stephen Smalley <span dir=3D"ltr">&lt;=
<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.gov</a=
>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><d=
iv class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">On 03/28/2018 11:40 PM, Y=
uli Khodorkovskiy wrote:<br>
&gt; Keep track of line numbers for each file context in<br>
&gt; selabel_handle. If an error occurs in selabel_fini(), the<br>
&gt; line number of an invalid file context is echoed to the user.<br>
&gt;<br>
&gt; Signed-off-by: Yuli Khodorkovskiy &lt;<a href=3D"mailto:ykhodo@gmail.c=
om">ykhodo@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 libselinux/src/label.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<=
br>
&gt;=C2=A0 libselinux/src/label_file.h=C2=A0 =C2=A0 =C2=A0| 1 +<br>
&gt;=C2=A0 libselinux/src/label_internal.<wbr>h | 1 +<br>
&gt;=C2=A0 3 files changed, 3 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/libselinux/src/label.c b/libselinux/src/label.c<br>
&gt; index e642a97b..d9a58ce9 100644<br>
&gt; --- a/libselinux/src/label.c<br>
&gt; +++ b/libselinux/src/label.c<br>
&gt; @@ -143,7 +143,7 @@ static int selabel_fini(struct selabel_handle *rec=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0struct selabel_lookup_rec *lr,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int translating)<br>
&gt;=C2=A0 {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0if (compat_validate(rec, lr, rec-&gt;spec_file, 0=
))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (compat_validate(rec, lr, rec-&gt;spec_file, l=
r-&gt;lineno))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (translating &amp;&amp; !lr-&gt;ctx_trans=
 &amp;&amp;<br>
&gt; diff --git a/libselinux/src/label_file.h b/libselinux/src/label_file.h=
<br>
&gt; index aa576d8e..4780ae48 100644<br>
&gt; --- a/libselinux/src/label_file.h<br>
&gt; +++ b/libselinux/src/label_file.h<br>
&gt; @@ -472,6 +472,7 @@ static inline int process_line(struct selabel_hand=
le *rec,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].mode =3D 0;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.ctx_raw =3D context;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0spec_arr[nspec].lr.lineno =3D lineno;<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * bump data-&gt;nspecs to cause closef() to=
 cover it in its free<br>
&gt; diff --git a/libselinux/src/label_<wbr>internal.h b/libselinux/src/lab=
el_<wbr>internal.h<br>
&gt; index c55efb75..0e020557 100644<br>
&gt; --- a/libselinux/src/label_<wbr>internal.h<br>
&gt; +++ b/libselinux/src/label_<wbr>internal.h<br>
&gt; @@ -73,6 +73,7 @@ struct selabel_lookup_rec {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char * ctx_raw;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char * ctx_trans;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int validated;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0unsigned lineno;<br>
&gt;=C2=A0 };<br>
&gt;<br>
&gt;=C2=A0 struct selabel_handle {<br>
&gt;<br>
<br>
</div></div>I think this is ok, but wanted to double check: does this work =
correctly when file contexts are loaded from<br>
file_contexts.bin instead?=C2=A0 It looks to me as if the lineno will be le=
ft as 0 in that case and the<br>
code will handle that correctly.<br></blockquote><div><br></div><div>Compil=
ing a file_contexts.bin with sefcontext_compile will give you the line numb=
er:</div><div><br></div><div><div>sefcontext_compile /etc/selinux/targeted/=
contexts/files/file_contexts -o file_contexts.bin -p /etc/selinux/targeted/=
policy/policy.31</div><div>libsepol.sepol_context_from_string: malformed co=
ntext &quot;test&quot;</div><div>libsepol.sepol_context_from_string: could =
not construct context from string</div><div>libsepol.context_from_string: c=
ould not create context structure</div><div>libsepol.sepol_context_to_sid: =
could not convert test to sid</div><div>/etc/selinux/targeted/contexts/file=
s/file_contexts: line 6132 has invalid context test</div><div>sefcontext_co=
mpile: process_file failed</div></div><div><br></div><div>Using file_contex=
ts.bin for relabeling that I generated with no validation will not report a=
 line number:</div><div><br></div><div>restorecon: /etc/selinux/targeted/co=
ntexts/files/file_contexts: has invalid context test<br></div><div><br></di=
v><div>I&#39;ll see if I can associate the line number with each regex in s=
efcontext_compile.</div><div><br></div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
<br>
The other question is whether we correctly report the file name when the en=
try comes from a file other<br>
than file_contexts itself, e.g. file_contexts.local, .homedirs, ...=C2=A0 N=
ot your bug if we don&#39;t but wondered.<br></blockquote><div><br></div><d=
iv>It is reporting the line number correctly, but the filename is incorrect=
. I&#39;ll update this.</div><div>=C2=A0</div></div><br></div></div>

--089e082f510084f3d005688f0dfa--
