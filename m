Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id uB7769NG004664
 for <selinux@tycho.nsa.gov>; Wed, 7 Dec 2016 02:06:09 -0500
Received: by mail-wj0-f176.google.com with SMTP id tk12so55549941wjb.3
 for <selinux@tycho.nsa.gov>; Tue, 06 Dec 2016 23:06:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <476DC76E7D1DF2438D32BFADF679FC5622FF8988@ORSMSX103.amr.corp.intel.com>
References: <1481045078-15000-1-git-send-email-william.c.roberts@intel.com>
 <1481045078-15000-2-git-send-email-william.c.roberts@intel.com>
 <53b7636e-5abe-0712-1954-b8c77c80c10d@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5622FF892E@ORSMSX103.amr.corp.intel.com>
 <1720815e-90f4-1780-9aaa-1742b05a4efc@tycho.nsa.gov>
 <476DC76E7D1DF2438D32BFADF679FC5622FF8988@ORSMSX103.amr.corp.intel.com>
From: YongQin Liu <yongqin.liu@linaro.org>
Date: Wed, 7 Dec 2016 15:05:59 +0800
Message-ID: <CAMSo37WpUDFBy+jVrwLw=5KM=iEChn6+iv3F=Tb1jk58vycO5A@mail.gmail.com>
Subject: Re: [PATCH] quick selinux support for tracefs
To: "Roberts, William C" <william.c.roberts@intel.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "nnk@google.com" <nnk@google.com>,
 "selinux@tycho.nsa.gov" <selinux@tycho.nsa.gov>,
 Paul Moore <paul@paul-moore.com>
Content-Type: multipart/alternative; boundary=f403045ea0aa36612a05430c27a1
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--f403045ea0aa36612a05430c27a1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, Roberts

On 7 December 2016 at 02:05, Roberts, William C <william.c.roberts@intel.co=
m
> wrote:

>
>
> > -----Original Message-----
> > From: Stephen Smalley [mailto:sds@tycho.nsa.gov]
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

This change was submitted to http://android-review.googlesource.com/ via
gerrit instructions before,
and now seems that it is going to be submitted via the instructions for
kernel changes which I am not familiar.

If you like, please help to update the patch message and submit the patch.

Or you could share me the instructions on how to do that, and then I will
submit the changes with new message following your instructions.

Thanks,
Yongqin Liu

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


--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org <linaro-dev@lists.linaro.org>
http://lists.linaro.org/mailman/listinfo/linaro-android

--f403045ea0aa36612a05430c27a1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, Roberts<br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On 7 December 2016 at 02:05, Roberts, William C <span dir=
=3D"ltr">&lt;<a href=3D"mailto:william.c.roberts@intel.com" target=3D"_blan=
k">william.c.roberts@intel.com</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span class=3D"gmail-"><br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Stephen Smalley [mailto:<a href=3D"mailto:sds@tycho.nsa.gov">sds=
@tycho.nsa.gov</a>]<br>
</span><div><div class=3D"gmail-h5">&gt; Sent: Tuesday, December 6, 2016 10=
:01 AM<br>
&gt; To: Roberts, William C &lt;<a href=3D"mailto:william.c.roberts@intel.c=
om">william.c.roberts@intel.com</a>&gt;; <a href=3D"mailto:nnk@google.com">=
nnk@google.com</a>;<br>
&gt; <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.gov</a><br>
&gt; Cc: Yongqin Liu &lt;<a href=3D"mailto:yongqin.liu@linaro.org">yongqin.=
liu@linaro.org</a>&gt;; Paul Moore &lt;<a href=3D"mailto:paul@paul-moore.co=
m">paul@paul-moore.com</a>&gt;<br>
&gt; Subject: Re: [PATCH] quick selinux support for tracefs<br>
&gt;<br>
&gt; On 12/06/2016 12:50 PM, Roberts, William C wrote:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt;&gt; -----Original Message-----<br>
&gt; &gt;&gt; From: Stephen Smalley [mailto:<a href=3D"mailto:sds@tycho.nsa=
.gov">sds@tycho.nsa.gov</a>]<br>
&gt; &gt;&gt; Sent: Tuesday, December 6, 2016 9:41 AM<br>
&gt; &gt;&gt; To: Roberts, William C &lt;<a href=3D"mailto:william.c.robert=
s@intel.com">william.c.roberts@intel.com</a>&gt;; <a href=3D"mailto:nnk@goo=
gle.com">nnk@google.com</a>;<br>
&gt; &gt;&gt; <a href=3D"mailto:selinux@tycho.nsa.gov">selinux@tycho.nsa.go=
v</a><br>
&gt; &gt;&gt; Cc: Yongqin Liu &lt;<a href=3D"mailto:yongqin.liu@linaro.org"=
>yongqin.liu@linaro.org</a>&gt;; Paul Moore<br>
&gt; &gt;&gt; &lt;<a href=3D"mailto:paul@paul-moore.com">paul@paul-moore.co=
m</a>&gt;<br>
&gt; &gt;&gt; Subject: Re: [PATCH] quick selinux support for tracefs<br>
&gt; &gt;&gt;<br>
&gt; &gt;&gt; On 12/06/2016 12:24 PM, <a href=3D"mailto:william.c.roberts@i=
ntel.com">william.c.roberts@intel.com</a> wrote:<br>
&gt; &gt;&gt;&gt; From: Yongqin Liu &lt;<a href=3D"mailto:yongqin.liu@linar=
o.org">yongqin.liu@linaro.org</a>&gt;<br>
&gt; &gt;&gt;&gt;<br>
&gt; &gt;&gt;&gt; Here is just the quick fix for tracefs with selinux.<br>
&gt; &gt;&gt;&gt; just add tracefs to the list of whitelisted filesystem ty=
pes in<br>
&gt; &gt;&gt;&gt; selinux_is_sblabel_mnt(), but the right fix would be to g=
eneralize<br>
&gt; &gt;&gt;&gt; this logic as described in the last item on the todo list=
,<br>
&gt; &gt;&gt;&gt; <a href=3D"https://bitbucket.org/seandroid/wiki/wiki/ToDo=
" rel=3D"noreferrer" target=3D"_blank">https://bitbucket.org/<wbr>seandroid=
/wiki/wiki/ToDo</a><br>
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
&gt; right away.<br>
<br>
</div></div>Oh sure, but I didn&#39;t right that patch message, Liu Yonggin=
 is tha author, ill fix up the<br>
message and resubmit preserving him as the author.<br></blockquote><div>=C2=
=A0</div><div>This change was submitted to <a href=3D"http://android-review=
.googlesource.com/">http://android-review.googlesource.com/</a>=C2=A0via ge=
rrit instructions before,<br></div><div>and now seems that it is going to b=
e submitted via the instructions for kernel changes which I am not familiar=
.</div><div><br></div><div><div>If you like, please help to update the patc=
h message and submit the patch.</div></div><div><br></div><div>Or you could=
 share me the instructions on how to do that, and then I will submit the ch=
anges with new message following your instructions.</div><div><br></div><di=
v>Thanks,</div><div>Yongqin Liu</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">
<div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5"><br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; the right fix is something else if you want this to<br>
&gt; &gt;&gt; actually be merged.=C2=A0 Because in that case, you ought to =
just<br>
&gt; &gt;&gt; implement the right fix.=C2=A0 There is now an upstream kerne=
l issue for the right<br>
&gt; fix:<br>
&gt; &gt;&gt; <a href=3D"https://github.com/SELinuxProject/selinux-kernel/i=
ssues/2" rel=3D"noreferrer" target=3D"_blank">https://github.com/<wbr>SELin=
uxProject/selinux-kernel/<wbr>issues/2</a><br>
&gt; &gt;<br>
&gt; &gt; The other question here is tracefs safe to label in this fashion,=
 I would assume<br>
&gt; yes.<br>
&gt; &gt; Looking through I didn&#39;t see any eviction code.<br>
&gt;<br>
&gt; Yes, the inodes are pinned.<br>
<br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div><span style=3D"color:r=
gb(80,0,80);font-family:arial,sans-serif;font-size:13px;background-color:rg=
b(255,255,255)">Best Regards,</span></div><div><span style=3D"color:rgb(80,=
0,80);font-family:arial,sans-serif;font-size:13px;background-color:rgb(255,=
255,255)">Yongqin Liu</span></div><div><span style=3D"color:rgb(80,0,80);fo=
nt-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255)=
">---------------------------------------------------------------</span></d=
iv><div><span style=3D"background-color:rgb(255,255,255);color:rgb(80,0,80)=
;font-family:arial,sans-serif;font-size:13px">#mailing list</span></div><a =
href=3D"mailto:linaro-dev@lists.linaro.org" style=3D"color:rgb(17,85,204);f=
ont-family:arial,sans-serif;font-size:13px;background-color:rgb(255,255,255=
)" target=3D"_blank">linaro-android@lists.linaro.org</a><div><div><a href=
=3D"http://lists.linaro.org/mailman/listinfo/linaro-android" target=3D"_bla=
nk">http://lists.linaro.org/mailman/listinfo/linaro-android</a></div></div>=
</div></div>
</div></div>

--f403045ea0aa36612a05430c27a1--
