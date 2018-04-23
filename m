Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w3NGLh7T012529
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 12:21:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
 by UPDCF3IC16.oob.disa.mil (Postfix) with SMTP id 40VBYD2Y7Nz2Vp9J
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 16:21:36 +0000 (UTC)
Received: from UPBD19PA14.eemsg.mil (unknown [192.168.18.14])
 by UPDCF3IC16.oob.disa.mil (Postfix) with ESMTP id 40VBYC57q6z2Vp8t
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 16:21:35 +0000 (UTC)
Received: by mail-pg0-f49.google.com with SMTP id b9so8737157pgf.6
 for <selinux@tycho.nsa.gov>; Mon, 23 Apr 2018 09:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ8tuXqjVAwfHo7usVTGKaKbhUFhUd0uZML4T3h=B=0fhmJKVg@mail.gmail.com>
 <bc31b468-299d-b0d6-af68-3f96d0655252@tycho.nsa.gov>
In-Reply-To: <bc31b468-299d-b0d6-af68-3f96d0655252@tycho.nsa.gov>
From: Joe Kirwin <jpk@cmd.com>
Date: Mon, 23 Apr 2018 16:21:22 +0000
Message-ID: <CAJ8tuXoUc0Eru04KMBzKOZ18qYb20CUvd1LPQZb9nBpqNge9xA@mail.gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, Petr Lautrbach <plautrba@redhat.com>,
 Daniel J Walsh <dwalsh@redhat.com>
Cc: selinux@tycho.nsa.gov, Travis Szucs <ts@cmd.com>
Content-Type: multipart/alternative; boundary="94eb2c14e7f052a7c8056a866e30"
Subject: Re: Alias path subbing results in unexpected policy
 labelling
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c14e7f052a7c8056a866e30
Content-Type: text/plain; charset="UTF-8"

Petr, Daniel,

Have you had time to verify this issue yet?
Any comments to add?

Thanks,
Joe

On Tue, Mar 20, 2018 at 8:14 AM Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On 03/19/2018 10:29 PM, Joe Kirwin wrote:
> > *_Empirical Observations _*
> > *
> > *
> > If I was to create an SELinux policy containing the following
> file_contexts (fruits.fc)
> > ```
> > /apple/orange/.*                  --
> gen_context(system_u:object_r:atype_t,s0)
> > /banana/.*                           --
> gen_context(system_u:object_r:btype_t,s0)
> > ```
> >
> > If I then take the file
> > /etc/selinux/default/contexts/files/file_contexts.subs_dist and append
> to it the alias
> > ```
> > /apple /banana
> > ```
> >
> > The resulting behavior is that when running:
> > ```
> > $ ./libselinux/utils/selabel_lookup_best_match -p /apple/orange/foo
> > Best match context: system_u:object_r:btype_t:s0
> >
> > But the expected behavior is to match `atype_t` as that is a
> "more-specific" match pattern
>
> I don't think this is a bug based on the documented behavior for
> file_contexts.subs.  That said,
> that support was added by Red Hat so I'll let them speak to it.
>
> >
> > *_Looking into why_*
> >
> > From the method in `libselinux/src/label_file.c` :
> >                       lookup_common(struct selabel_handle *rec, const
> char *key, int type, bool partial)
> >
> > we encounter a call to :
> >                      selabel_sub_key(struct saved_data *data, const char
> *key)
> >
> > In the example above the candidate path we're trying to match (referred
> to as the key in the code) is "canonicalized" to the /banana alias but the
> regex being evaluated is not
> >
> > *_A proposed fix_*
> > *
> > *
> > /Also attached (label_file.patch), if the patch formatting is off on
> this thread, apologies./
> > *
> > *
> > diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c
> > index 560d8c3..98a8d1b 100644
> > --- a/libselinux/src/label_file.c
> > +++ b/libselinux/src/label_file.c
> > @@ -848,7 +848,7 @@ static struct spec *lookup_common(struct
> selabel_handle *rec,
> >  {
> >     struct saved_data *data = (struct saved_data *)rec->data;
> >     struct spec *spec_arr = data->spec_arr;
> > -   int i, rc, file_stem;
> > +   int i, rc, file_stem, orig_file_stem;
> >     mode_t mode = (mode_t)type;
> >     const char *buf;
> >     struct spec *ret = NULL;
> > @@ -879,8 +879,12 @@ static struct spec *lookup_common(struct
> selabel_handle *rec,
> >     }
> >
> >     sub = selabel_sub_key(data, key);
> > -   if (sub)
> > +   orig_file_stem = -1;
> > +   if (sub) {
> > +      orig_file_stem = find_stem_from_file(data, &key);
> >         key = sub;
> > +   }
> >
> >     buf = key;
> >     file_stem = find_stem_from_file(data, &buf);
> > @@ -896,7 +900,8 @@ static struct spec *lookup_common(struct
> selabel_handle *rec,
> >          * stem as the file AND if the spec in question has no mode
> >          * specified or if the mode matches the file mode then we do
> >          * a regex check        */
> > -       if ((spec->stem_id == -1 || spec->stem_id == file_stem) &&
> > +       if ((spec->stem_id == -1 || spec->stem_id == file_stem ||
> > +            spec->stem_id == orig_file_stem) &&
> >             (!mode || !spec->mode || mode == spec->mode)) {
> >             if (compile_regex(data, spec, NULL) < 0)
> >                 goto finish;
> >
> >
> >
> > I think there is still some simplification that could be done with
> aliases, in that they really shouldn't have a direction (e.g. alias ->
> original) instead they should go both ways and if there is a tie it should
> go by the ordering of the specs.
> > Reason for this is that a developer of an SELinux policy, may not know
> the contents or directionality of file_contexts.subs_dist ahead of time or
> when it might change.
> >
> > Thanks,
> > Joe Kirwin and Travis Szucs
> >
>
> --
-- 
*Joe Kirwin*  |  *Senior Security Developer_*
*E:* jpk@cmd.com <bam@cmd.com>   *M:* 1.604.365.2823

<https://app.salesforceiq.com/r?target=5a6243eae4b0af727465cb94&t=AFwhZf1CQsv7FDLhSeW59giQrg545clQ2ksOeCxqTY5CK4AoaKjZJqLqF4FBhplxxtKw68VNNcp3ThHgNAMyfYlitWTAFUx2WymfWC2lJKWbtcBVzXz7rzKynmKi0AIVRaiN70T6bDHU>

--94eb2c14e7f052a7c8056a866e30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Petr, Daniel,<div><br></div><div>Have you had time to veri=
fy this issue yet?=C2=A0</div><div>Any comments to add?</div><div><br></div=
><div>Thanks,</div><div>Joe<br><br><div class=3D"gmail_quote"><div dir=3D"l=
tr">On Tue, Mar 20, 2018 at 8:14 AM Stephen Smalley &lt;<a href=3D"mailto:s=
ds@tycho.nsa.gov">sds@tycho.nsa.gov</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pa=
dding-left:1ex">On 03/19/2018 10:29 PM, Joe Kirwin wrote:<br>
&gt; *_Empirical Observations=C2=A0_*<br>
&gt; *<br>
&gt; *<br>
&gt; If I was to create an SELinux policy containing the following file_con=
texts (fruits.fc)<br>
&gt; ```<br>
&gt; /apple/orange/.*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 --=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_context(s=
ystem_u:object_r:atype_t,s0)<br>
&gt; /banana/.*=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 gen_context(system_u:object_r:btype_t,s0)<br>
&gt; ```<br>
&gt; <br>
&gt; If I then take the file=C2=A0<br>
&gt; /etc/selinux/default/contexts/files/file_contexts.subs_dist and append=
 to it the alias=C2=A0<br>
&gt; ```<br>
&gt; /apple /banana<br>
&gt; ```<br>
&gt; <br>
&gt; The resulting behavior is that when running:<br>
&gt; ```<br>
&gt; $ ./libselinux/utils/selabel_lookup_best_match -p /apple/orange/foo<br=
>
&gt; Best match context: system_u:object_r:btype_t:s0<br>
&gt; <br>
&gt; But the expected behavior is to match `atype_t` as that is a &quot;mor=
e-specific&quot; match pattern<br>
<br>
I don&#39;t think this is a bug based on the documented behavior for file_c=
ontexts.subs.=C2=A0 That said,<br>
that support was added by Red Hat so I&#39;ll let them speak to it.<br>
<br>
&gt; <br>
&gt; *_Looking into why_*<br>
&gt; <br>
&gt; From the method in `libselinux/src/label_file.c` :<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 lookup_common(struct selabel_handle *rec, const char *key, int type,=
 bool partial)=C2=A0<br>
&gt; <br>
&gt; we encounter a call to :<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0selabel_sub_key(struct saved_data *data, const char *key)<br>
&gt; <br>
&gt; In the example above the candidate path we&#39;re trying to match (ref=
erred to as the key in the code) is &quot;canonicalized&quot; to the /banan=
a alias but the regex being evaluated is not=C2=A0<br>
&gt; <br>
&gt; *_A proposed fix_*<br>
&gt; *<br>
&gt; *<br>
&gt; /Also attached (label_file.patch), if the patch formatting is off on t=
his thread, apologies./<br>
&gt; *<br>
&gt; *<br>
&gt; diff --git a/libselinux/src/label_file.c b/libselinux/src/label_file.c=
<br>
&gt; index 560d8c3..98a8d1b 100644<br>
&gt; --- a/libselinux/src/label_file.c<br>
&gt; +++ b/libselinux/src/label_file.c<br>
&gt; @@ -848,7 +848,7 @@ static struct spec *lookup_common(struct selabel_h=
andle *rec,<br>
&gt; =C2=A0{<br>
&gt; =C2=A0 =C2=A0 struct saved_data *data =3D (struct saved_data *)rec-&gt=
;data;<br>
&gt; =C2=A0 =C2=A0 struct spec *spec_arr =3D data-&gt;spec_arr;<br>
&gt; -=C2=A0 =C2=A0int i, rc, file_stem;<br>
&gt; +=C2=A0 =C2=A0int i, rc, file_stem, orig_file_stem;<br>
&gt; =C2=A0 =C2=A0 mode_t mode =3D (mode_t)type;<br>
&gt; =C2=A0 =C2=A0 const char *buf;<br>
&gt; =C2=A0 =C2=A0 struct spec *ret =3D NULL;<br>
&gt; @@ -879,8 +879,12 @@ static struct spec *lookup_common(struct selabel_=
handle *rec,<br>
&gt; =C2=A0 =C2=A0 }=C2=A0 =C2=A0<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 sub =3D selabel_sub_key(data, key);<br>
&gt; -=C2=A0 =C2=A0if (sub)<br>
&gt; +=C2=A0 =C2=A0orig_file_stem =3D -1;=C2=A0<br>
&gt; +=C2=A0 =C2=A0if (sub) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 orig_file_stem =3D find_stem_from_file(data, &am=
p;key);<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D sub;<br>
&gt; +=C2=A0 =C2=A0}=C2=A0 =C2=A0<br>
&gt; =C2=A0<br>
&gt; =C2=A0 =C2=A0 buf =3D key;<br>
&gt; =C2=A0 =C2=A0 file_stem =3D find_stem_from_file(data, &amp;buf);<br>
&gt; @@ -896,7 +900,8 @@ static struct spec *lookup_common(struct selabel_h=
andle *rec,<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* stem as the file AND if the spec i=
n question has no mode<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* specified or if the mode matches t=
he file mode then we do<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a regex check=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 */=C2=A0=C2=A0<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((spec-&gt;stem_id =3D=3D -1 || spec-&g=
t;stem_id =3D=3D file_stem) &amp;&amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((spec-&gt;stem_id =3D=3D -1 || spec-&g=
t;stem_id =3D=3D file_stem ||=C2=A0=C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 spec-&gt;stem_id =3D=3D ori=
g_file_stem) &amp;&amp;<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (!mode || !spec-&gt;mode || =
mode =3D=3D spec-&gt;mode)) {<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (compile_regex(data, spec=
, NULL) &lt; 0)<br>
&gt; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto finish;<b=
r>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; I think there is still some simplification that could be done with ali=
ases, in that they really shouldn&#39;t have a direction (e.g. alias -&gt; =
original) instead they should go both ways and if there is a tie it should =
go by the ordering of the specs.<br>
&gt; Reason for this is that a developer of an SELinux policy, may not know=
 the contents or directionality of file_contexts.subs_dist ahead of time or=
 when it might change.<br>
&gt; <br>
&gt; Thanks,<br>
&gt; Joe Kirwin and Travis Szucs<br>
&gt; <br>
<br>
</blockquote></div></div></div>-- <br><div dir=3D"ltr" class=3D"gmail_signa=
ture" data-smartmail=3D"gmail_signature"><div dir=3D"ltr">-- <br><div class=
=3D"inbox-inbox-inbox-inbox-inbox-inbox-inbox-inbox-inbox-inbox-inbox-inbox=
-inbox-inbox-inbox-inbox-m_6294346792908566087gmail_signature"><div dir=3D"=
ltr"><span style=3D"font-size:12.8px"><div style=3D"color:rgb(33,33,33)"><f=
ont face=3D"arial, helvetica, sans-serif" color=3D"#351c75"><b>Joe Kirwin</=
b>=C2=A0 |=C2=A0 <b>Senior Security Developer_</b></font></div></span><div =
style=3D"font-size:12.8px;color:rgb(33,33,33)"><font face=3D"arial, helveti=
ca, sans-serif"><b><font color=3D"#674ea7">E:</font></b> <a href=3D"mailto:=
bam@cmd.com" style=3D"color:rgb(17,85,204)" target=3D"_blank">jpk@cmd.com</=
a>=C2=A0 =C2=A0</font><b style=3D"font-family:arial,helvetica,sans-serif"><=
font color=3D"#674ea7">M:</font></b><span style=3D"font-family:arial,helvet=
ica,sans-serif">=C2=A01.604</span>.365.2823</div><div style=3D"font-size:12=
.8px;color:rgb(33,33,33)"><font face=3D"arial, helvetica, sans-serif"><br><=
/font></div><font style=3D"font-size:12.8px;color:rgb(33,33,33)" face=3D"ar=
ial, helvetica, sans-serif"><a href=3D"https://app.salesforceiq.com/r?targe=
t=3D5a6243eae4b0af727465cb94&amp;t=3DAFwhZf1CQsv7FDLhSeW59giQrg545clQ2ksOeC=
xqTY5CK4AoaKjZJqLqF4FBhplxxtKw68VNNcp3ThHgNAMyfYlitWTAFUx2WymfWC2lJKWbtcBVz=
Xz7rzKynmKi0AIVRaiN70T6bDHU" style=3D"color:rgb(17,85,204)" title=3D"http:/=
/cmd.com/" target=3D"_blank"><img src=3D"https://docs.google.com/uc?export=
=3Ddownload&amp;id=3D0B_kbwmLAcdqqNDdsXzN5bzB6UUU&amp;revid=3D0B_kbwmLAcdqq=
dldWRGZtenE2OExhRXN0VzZiaThvaXdYRXpBPQ" height=3D"28" width=3D"96"></a></fo=
nt></div></div></div></div>

--94eb2c14e7f052a7c8056a866e30--
