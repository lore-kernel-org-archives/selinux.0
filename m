Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7BAMGR011444
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 06:10:25 -0500
Received: by mail-wm0-f53.google.com with SMTP id f82so161122622wmf.1
 for <selinux@tycho.nsa.gov>; Wed, 07 Dec 2016 03:10:06 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5622FF9D57@ORSMSX103.amr.corp.intel.com>
References: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
 <1481045078-15000-2-git-send-email-william.c.roberts@intel.com>
 <53b7636e-5abe-0712-1954-b8c77c80c10d@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5622FF892E@ORSMSX103.amr.corp.intel.com>
 <1720815e-90f4-1780-9aaa-1742b05a4efc@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5622FF8988@ORSMSX103.amr.corp.intel.com>
 <CAMSo37WpUDFBy+jVrwLw=5KM=iEChn6+iv3F=Tb1jk58vycO5A@mail.gmail.com>
 <476DC76E7D1DF2438D32BFADF679FC5622FF9D57@ORSMSX103.amr.corp.intel.com>
From: YongQin Liu <yongqin.liu@linaro.org>
Date: Wed, 7 Dec 2016 19:10:05 +0800
Message-ID: <CAMSo37XWYSAJ5k7tSrSRZyzL_tiBa3Z-9UZ9MXyoYSsp5GQsTg@mail.gmail.com>
Subject: Re: [PATCH] quick selinux support for tracefs
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "nnk@google.com" <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=001a1142b63829e71605430f906a
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a1142b63829e71605430f906a
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7 December 2016 at 18:59, Roberts, William C <william.c.roberts@intel.co=
m
> wrote:

> Yes it was submitted to Android=E2=80=99s Gerrit Here by you:
>
> https://android-review.googlesource.com/#/c/220895/
>
>
>
> I already modified the commit message and got an Ack on V3 from Stephen:
>
> http://marc.info/?l=3Dselinux&m=3D148105682211911&w=3D2
>
>
>
Thanks, Roberts!


>
>
> *From:* YongQin Liu [mailto:yongqin.liu@linaro.org]
> *Sent:* Tuesday, December 6, 2016 11:06 PM
> *To:* Roberts, William C <william.c.roberts@intel.com>
> *Cc:* Stephen Smalley <sds@tycho.nsa.gov>; nnk@google.com;
> selinux@tycho.nsa.gov; Paul Moore <paul@paul-moore.com>
>
> *Subject:* Re: [PATCH] quick selinux support for tracefs
>
>
>
> Hi, Roberts
>
>
>
> On 7 December 2016 at 02:05, Roberts, William C <
> william.c.roberts@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
>
> > Sent: Tuesday, December 6, 2016 10:01 AM
> > To: Roberts, William C <william.c.roberts@intel.com>; nnk@google.com;
> > selinux@tycho.nsa.gov
> > Cc: Yongqin Liu <yongqin.liu@linaro.org>; Paul Moore <
> paul@paul-moore.com>
> > Subject: Re: [PATCH] quick selinux support for tracefs
> >
> > On 12/06/2016 12:50 PM, Roberts, William C wrote:
> > >
> > >
> > >> -----Original Message-----
> > >> From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
> > >> Sent: Tuesday, December 6, 2016 9:41 AM
> > >> To: Roberts, William C <william.c.roberts@intel.com>; nnk@google.com=
;
> > >> selinux@tycho.nsa.gov
> > >> Cc: Yongqin Liu <yongqin.liu@linaro.org>; Paul Moore
> > >> <paul@paul-moore.com>
> > >> Subject: Re: [PATCH] quick selinux support for tracefs
> > >>
> > >> On 12/06/2016 12:24 PM, william.c.roberts@intel.com wrote:
> > >>> From: Yongqin Liu <yongqin.liu@linaro.org>
> > >>>
> > >>> Here is just the quick fix for tracefs with selinux.
> > >>> just add tracefs to the list of whitelisted filesystem types in
> > >>> selinux_is_sblabel_mnt(), but the right fix would be to generalize
> > >>> this logic as described in the last item on the todo list,
> > >>> https://bitbucket.org/seandroid/wiki/wiki/ToDo
> > >>>
> > >>> Change-Id: I2aa803ccffbcd2802a7287514da7648e6b364157
> > >>
> > >> Please rewrite the subject line and patch description per the
> > >> kernel's submission guidelines, drop the Change-Id and the link to
> > >> the SEAndroid todo list, and don't say that this is a quick fix but
> > >
> > > Why would anyone do that for this patch when below you say it won=E2=
=80=99t be
> > > merged unless we fix issue #2?
> >
> > I didn't say it couldn't be merged; I said it isn't a good idea to say
> "this is a quick fix
> > but the right fix is X" in an upstream patch submission if you want it
> to be
> > merged, unless it is for a serious security or stability bug that needs
> to be fixed
> > right away.
>
> Oh sure, but I didn't right that patch message, Liu Yonggin is tha author=
,
> ill fix up the
> message and resubmit preserving him as the author.
>
>
>
> This change was submitted to http://android-review.googlesource.com/ via
> gerrit instructions before,
>
> and now seems that it is going to be submitted via the instructions for
> kernel changes which I am not familiar.
>
>
>
> If you like, please help to update the patch message and submit the patch=
.
>
>
>
> Or you could share me the instructions on how to do that, and then I will
> submit the changes with new message following your instructions.
>
>
>
> Thanks,
>
> Yongqin Liu
>
>
> >
> > >
> > > the right fix is something else if you want this to
> > >> actually be merged.  Because in that case, you ought to just
> > >> implement the right fix.  There is now an upstream kernel issue for
> the right
> > fix:
> > >> https://github.com/SELinuxProject/selinux-kernel/issues/2
> > >
> > > The other question here is tracefs safe to label in this fashion, I
> would assume
> > yes.
> > > Looking through I didn't see any eviction code.
> >
> > Yes, the inodes are pinned.
>
>
>
>
>
> --
>
> Best Regards,
>
> Yongqin Liu
>
> ---------------------------------------------------------------
>
> #mailing list
>
> linaro-android@lists.linaro.org <linaro-dev@lists.linaro.org>
>
> http://lists.linaro.org/mailman/listinfo/linaro-android
>



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org <linaro-dev@lists.linaro.org>
http://lists.linaro.org/mailman/listinfo/linaro-android

--001a1142b63829e71605430f906a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On 7 December 2016 at 18:59, Roberts, William C <span dir=3D"ltr">&lt;<=
a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blank">william.c.r=
oberts@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">





<div lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"m_-7169845945826998707WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">Yes it was submitted to Android=E2=80=
=99s Gerrit Here by you:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><a href=3D"https://android-review.goo=
glesource.com/#/c/220895/" target=3D"_blank">https://android-review.<wbr>go=
oglesource.com/#/c/220895/</a><u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d">I already modified the commit message=
 and got an Ack on V3 from Stephen:<u></u><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><a href=3D"http://marc.info/?l=3Dseli=
nux&amp;m=3D148105682211911&amp;w=3D2" target=3D"_blank">http://marc.info/?=
l=3Dselinux&amp;m=3D<wbr>148105682211911&amp;w=3D2</a><u></u><u></u></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0</span></p></div></div><=
/blockquote><div>Thanks, Roberts!</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div class=
=3D"m_-7169845945826998707WordSection1"><p class=3D"MsoNormal"><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:#1f49=
7d"><u></u></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif;color:#1f497d"><u></u>=C2=A0<u></u></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #e1e1e1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><a name=3D"m_-7169845945826998707______replyseparato=
r"></a><b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quo=
t;Calibri&quot;,sans-serif"> YongQin Liu [mailto:<a href=3D"mailto:yongqin.=
liu@linaro.org" target=3D"_blank">yongqin.liu@linaro.org</a><wbr>]
<br>
<b>Sent:</b> Tuesday, December 6, 2016 11:06 PM<span class=3D""><br>
<b>To:</b> Roberts, William C &lt;<a href=3D"mailto:william.c.roberts@intel=
.com" target=3D"_blank">william.c.roberts@intel.com</a>&gt;<br>
</span><b>Cc:</b> Stephen Smalley &lt;<a href=3D"mailto:sds@tycho.nsa.gov" =
target=3D"_blank">sds@tycho.nsa.gov</a>&gt;; <a href=3D"mailto:nnk@google.c=
om" target=3D"_blank">nnk@google.com</a>; <a href=3D"mailto:selinux@tycho.n=
sa.gov" target=3D"_blank">selinux@tycho.nsa.gov</a>; Paul Moore &lt;<a href=
=3D"mailto:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&g=
t;</span></p><div><div class=3D"h5"><br>
<b>Subject:</b> Re: [PATCH] quick selinux support for tracefs<u></u><u></u>=
</div></div><p></p>
</div>
</div><div><div class=3D"h5">
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">Hi, Roberts<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
<div>
<p class=3D"MsoNormal">On 7 December 2016 at 02:05, Roberts, William C &lt;=
<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blank">william.c.=
roberts@intel.com</a>&gt; wrote:<u></u><u></u></p>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<p class=3D"MsoNormal"><br>
<br>
<span class=3D"m_-7169845945826998707gmail-">&gt; -----Original Message----=
-</span><br>
<span class=3D"m_-7169845945826998707gmail-">&gt; From: Stephen Smalley [ma=
ilto:<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_blank">sds@tycho.nsa.g=
ov</a>]</span><u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt">&gt; Sent: Tuesday, D=
ecember 6, 2016 10:01 AM<br>
&gt; To: Roberts, William C &lt;<a href=3D"mailto:william.c.roberts@intel.c=
om" target=3D"_blank">william.c.roberts@intel.com</a>&gt;;
<a href=3D"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a>;<br>
&gt; <a href=3D"mailto:selinux@tycho.nsa.gov" target=3D"_blank">selinux@tyc=
ho.nsa.gov</a><br>
&gt; Cc: Yongqin Liu &lt;<a href=3D"mailto:yongqin.liu@linaro.org" target=
=3D"_blank">yongqin.liu@linaro.org</a>&gt;; Paul Moore &lt;<a href=3D"mailt=
o:paul@paul-moore.com" target=3D"_blank">paul@paul-moore.com</a>&gt;<br>
&gt; Subject: Re: [PATCH] quick selinux support for tracefs<br>
&gt;<br>
&gt; On 12/06/2016 12:50 PM, Roberts, William C wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Stephen Smalley [mailto:<a href=3D"mailto:sds@tycho.nsa=
.gov" target=3D"_blank">sds@tycho.nsa.gov</a>]<br>
&gt; &gt;&gt; Sent: Tuesday, December 6, 2016 9:41 AM<br>
&gt; &gt;&gt; To: Roberts, William C &lt;<a href=3D"mailto:william.c.robert=
s@intel.com" target=3D"_blank">william.c.roberts@intel.com</a>&gt;;
<a href=3D"mailto:nnk@google.com" target=3D"_blank">nnk@google.com</a>;<br>
&gt; &gt;&gt; <a href=3D"mailto:selinux@tycho.nsa.gov" target=3D"_blank">se=
linux@tycho.nsa.gov</a><br>
&gt; &gt;&gt; Cc: Yongqin Liu &lt;<a href=3D"mailto:yongqin.liu@linaro.org"=
 target=3D"_blank">yongqin.liu@linaro.org</a>&gt;; Paul Moore<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:paul@paul-moore.com" target=3D"_blank">=
paul@paul-moore.com</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] quick selinux support for tracefs<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 12/06/2016 12:24 PM, <a href=3D"mailto:william.c.roberts@i=
ntel.com" target=3D"_blank">william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt;&gt;&gt; From: Yongqin Liu &lt;<a href=3D"mailto:yongqin.liu@linar=
o.org" target=3D"_blank">yongqin.liu@linaro.org</a>&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Here is just the quick fix for tracefs with selinux.<br>
&gt; &gt;&gt;&gt; just add tracefs to the list of whitelisted filesystem ty=
pes in<br>
&gt; &gt;&gt;&gt; selinux_is_sblabel_mnt(), but the right fix would be to g=
eneralize<br>
&gt; &gt;&gt;&gt; this logic as described in the last item on the todo list=
,<br>
&gt; &gt;&gt;&gt; <a href=3D"https://bitbucket.org/seandroid/wiki/wiki/ToDo=
" target=3D"_blank">https://bitbucket.org/<wbr>seandroid/wiki/wiki/ToDo</a>=
<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Change-Id: I2aa803ccffbcd2802a7287514da76<wbr>48e6b364157=
<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; Please rewrite the subject line and patch description per the=
<br>
&gt; &gt;&gt; kernel&#39;s submission guidelines, drop the Change-Id and th=
e link to<br>
&gt; &gt;&gt; the SEAndroid todo list, and don&#39;t say that this is a qui=
ck fix but<br>
&gt; &gt;<br>
&gt; &gt; Why would anyone do that for this patch when below you say it won=
=E2=80=99t be<br>
&gt; &gt; merged unless we fix issue #2?<br>
&gt;<br>
&gt; I didn&#39;t say it couldn&#39;t be merged; I said it isn&#39;t a good=
 idea to say &quot;this is a quick fix<br>
&gt; but the right fix is X&quot; in an upstream patch submission if you wa=
nt it to be<br>
&gt; merged, unless it is for a serious security or stability bug that need=
s to be fixed<br>
&gt; right away.<u></u><u></u></p>
</div>
</div>
<p class=3D"MsoNormal">Oh sure, but I didn&#39;t right that patch message, =
Liu Yonggin is tha author, ill fix up the<br>
message and resubmit preserving him as the author.<u></u><u></u></p>
</blockquote>
<div>
<p class=3D"MsoNormal">=C2=A0<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">This change was submitted to <a href=3D"http://andro=
id-review.googlesource.com/" target=3D"_blank">
http://android-review.<wbr>googlesource.com/</a>=C2=A0via gerrit instructio=
ns before,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">and now seems that it is going to be submitted via t=
he instructions for kernel changes which I am not familiar.<u></u><u></u></=
p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<div>
<p class=3D"MsoNormal">If you like, please help to update the patch message=
 and submit the patch.<u></u><u></u></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Or you could share me the instructions on how to do =
that, and then I will submit the changes with new message following your in=
structions.<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Thanks,<u></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal">Yongqin Liu<u></u><u></u></p>
</div>
<blockquote style=3D"border:none;border-left:solid #cccccc 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-right:0in">
<div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; the right fix is something else if you want this to<br>
&gt; &gt;&gt; actually be merged.=C2=A0 Because in that case, you ought to =
just<br>
&gt; &gt;&gt; implement the right fix.=C2=A0 There is now an upstream kerne=
l issue for the right<br>
&gt; fix:<br>
&gt; &gt;&gt; <a href=3D"https://github.com/SELinuxProject/selinux-kernel/i=
ssues/2" target=3D"_blank">
https://github.com/<wbr>SELinuxProject/selinux-kernel/<wbr>issues/2</a><br>
&gt; &gt;<br>
&gt; &gt; The other question here is tracefs safe to label in this fashion,=
 I would assume<br>
&gt; yes.<br>
&gt; &gt; Looking through I didn&#39;t see any eviction code.<br>
&gt;<br>
&gt; Yes, the inodes are pinned.<u></u><u></u></p>
</div>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal"><br>
<br clear=3D"all">
<u></u><u></u></p>
<div>
<p class=3D"MsoNormal"><u></u>=C2=A0<u></u></p>
</div>
<p class=3D"MsoNormal">-- <u></u><u></u></p>
<div>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#500050;background:white">Best Regards,</span><u=
></u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#500050;background:white">Yongqin Liu</span><u><=
/u><u></u></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#500050;background:white">----------------------=
--------<wbr>------------------------------<wbr>---</span><u></u><u></u></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#500050;background:white">#mailing list</span><u=
></u><u></u></p>
</div>
<p class=3D"MsoNormal"><a href=3D"mailto:linaro-dev@lists.linaro.org" targe=
t=3D"_blank"><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,=
sans-serif;color:#1155cc;background:white">linaro-android@lists.linaro.<wbr=
>org</span></a><u></u><u></u></p>
<div>
<div>
<p class=3D"MsoNormal"><a href=3D"http://lists.linaro.org/mailman/listinfo/=
linaro-android" target=3D"_blank">http://lists.linaro.org/<wbr>mailman/list=
info/linaro-<wbr>android</a><u></u><u></u></p>
</div>
</div>
</div>
</div>
</div>
</div>
</div></div></div>
</div>
</div>

</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div class=
=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><d=
iv><span style=3D"color:rgb(80,0,80);font-family:arial,sans-serif;font-size=
:13px;background-color:rgb(255,255,255)">Best Regards,</span></div><div><sp=
an style=3D"color:rgb(80,0,80);font-family:arial,sans-serif;font-size:13px;=
background-color:rgb(255,255,255)">Yongqin Liu</span></div><div><span style=
=3D"color:rgb(80,0,80);font-family:arial,sans-serif;font-size:13px;backgrou=
nd-color:rgb(255,255,255)">------------------------------------------------=
---------------</span></div><div><span style=3D"background-color:rgb(255,25=
5,255);color:rgb(80,0,80);font-family:arial,sans-serif;font-size:13px">#mai=
ling list</span></div><a href=3D"mailto:linaro-dev@lists.linaro.org" style=
=3D"color:rgb(17,85,204);font-family:arial,sans-serif;font-size:13px;backgr=
ound-color:rgb(255,255,255)" target=3D"_blank">linaro-android@lists.linaro.=
org</a><div><div><a href=3D"http://lists.linaro.org/mailman/listinfo/linaro=
-android" target=3D"_blank">http://lists.linaro.org/mailman/listinfo/linaro=
-android</a></div></div></div></div>
</div></div>

--001a1142b63829e71605430f906a--
