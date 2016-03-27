Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2R3Tb16015988
 for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2016 23:29:37 -0400
Received: by mail-qg0-f41.google.com with SMTP id j35so86502684qge.0
 for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2016 20:29:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+D4ZVpm660vuxgQSYQH_QU5re=mvczEK=8L3L+DAbtcNAHh9g@mail.gmail.com>
References: <CA+D4ZVpm660vuxgQSYQH_QU5re=mvczEK=8L3L+DAbtcNAHh9g@mail.gmail.com>
From: Amir Eaman <amir.imen@gmail.com>
Date: Sat, 26 Mar 2016 23:29:15 -0400
Message-ID: <CA+D4ZVpHWM_hS_Ld8n00yJ_A_aO517WJp1mDrW+kXJvdeJo=mw@mail.gmail.com>
Subject: Re: Fedora 23 error when using policy generator
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a113540d8baca9d052eff6769
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a113540d8baca9d052eff6769
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The exact error is: in Fedora 23

root@localhost selinux-master]# *selinux-polgengui*

Failed to retrieve rpm info for selinux-policy
> Traceback (most recent call last):
>   File "/bin/selinux-polgengui", line 360, in forward
>     self.generate_policy()
>   File "/bin/selinux-polgengui", line 506, in generate_policy
>     self.info(my_policy.generate(outputdir))
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line
> 1382, in generate
>     out +=3D "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line
> 1228, in write_spec
>     fd.write(self.generate_spec())
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line
> 1190, in generate_spec
>     selinux_policyver =3D get_rpm_nvr_list("selinux-policy")[1]
> TypeError: 'NoneType' object has no attribute '__getitem__'
>

On Sat, Mar 26, 2016 at 8:39 PM, Amir Eaman <amir.imen@gmail.com> wrote:

> Hi,
> When I press apply button in the last step for policy generator on Fedora
> 23 the following error is issued. What should I do?
> =E2=80=8B
>
> > Failed to retrieve rpm info for selinux-policy
> > Traceback (most recent call last):
> >   File "/usr/lib/python-exec/python2.7/sepolicy", line 643, in <module>
> >     args.func(args)
> >   File "/usr/lib/python-exec/python2.7/sepolicy", line 517, in generate
> >     print mypolicy.generate(args.path)
> >   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line =
1370, in generate
> >     out +=3D "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
> >   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line =
1219, in write_spec
> >     fd.write(self.generate_spec())
> >   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line =
1181, in generate_spec
> >     selinux_policyver =3D get_rpm_nvr_list("selinux-policy")[1]
> > TypeError: 'NoneType' object has no attribute '__getitem__'
>
> =E2=80=8B
>
> --
>
>


--

--001a113540d8baca9d052eff6769
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">The=
 exact error is: in Fedora 23<br><br><span class=3D"" style=3D"font-size:11=
pt;font-family:Calibri,sans-serif;line-height:20px"><span style=3D"backgrou=
nd-color:inherit" class=3D"">root@localhost selinux-master]# <b>selinux-pol=
gengui</b></span></span><span style=3D"font-size:11pt;line-height:20px;font=
-family:Calibri,sans-serif" class=3D""><b><span class=3D""> </span></b><br>=
<br class=3D""></span><blockquote style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex" class=3D"gmail_quote"><sp=
an class=3D"" style=3D"font-size:11pt;font-family:Calibri,sans-serif;line-h=
eight:20px"><span style=3D"background-color:inherit" class=3D"">Failed to r=
etrieve rpm info for selinux-policy</span></span><span style=3D"font-size:1=
1pt;line-height:20px;font-family:Calibri,sans-serif" class=3D""><span class=
=3D"">=C2=A0</span></span><br class=3D""><span style=3D"font-size:11pt;line=
-height:20px;font-family:Calibri,sans-serif" class=3D""></span><span class=
=3D"" style=3D"font-size:11pt;font-family:Calibri,sans-serif;line-height:20=
px"><span style=3D"background-color:inherit" class=3D"">Traceback (most rec=
ent call last):</span></span><span style=3D"font-size:11pt;line-height:20px=
;font-family:Calibri,sans-serif" class=3D""><span class=3D"">=C2=A0</span><=
/span><br class=3D""><span style=3D"font-size:11pt;line-height:20px;font-fa=
mily:Calibri,sans-serif" class=3D""></span><span class=3D"" style=3D"font-s=
ize:11pt;font-family:Calibri,sans-serif;line-height:20px"><span style=3D"ba=
ckground-color:inherit" class=3D"">=C2=A0 File &quot;/bin/selinux-polgengui=
&quot;, line 360, in forward</span></span><span style=3D"font-size:11pt;lin=
e-height:20px;font-family:Calibri,sans-serif" class=3D""><span class=3D"">=
=C2=A0</span></span><br class=3D""><span style=3D"font-size:11pt;line-heigh=
t:20px;font-family:Calibri,sans-serif" class=3D""></span><span class=3D"" s=
tyle=3D"font-size:11pt;font-family:Calibri,sans-serif;line-height:20px"><sp=
an style=3D"background-color:inherit" class=3D"">=C2=A0=C2=A0=C2=A0 self.ge=
nerate_policy()</span></span><span style=3D"font-size:11pt;line-height:20px=
;font-family:Calibri,sans-serif" class=3D""><span class=3D"">=C2=A0</span><=
/span><br class=3D""><span style=3D"font-size:11pt;line-height:20px;font-fa=
mily:Calibri,sans-serif" class=3D""></span><span class=3D"" style=3D"font-s=
ize:11pt;font-family:Calibri,sans-serif;line-height:20px"><span style=3D"ba=
ckground-color:inherit" class=3D"">=C2=A0 File &quot;/bin/selinux-polgengui=
&quot;, line 506, in generate_policy</span></span><span style=3D"font-size:=
11pt;line-height:20px;font-family:Calibri,sans-serif" class=3D""><span clas=
s=3D"">=C2=A0</span></span><br class=3D""><span style=3D"font-size:11pt;lin=
e-height:20px;font-family:Calibri,sans-serif" class=3D""></span><span class=
=3D"" style=3D"font-size:11pt;font-family:Calibri,sans-serif;line-height:20=
px"><span style=3D"background-color:inherit" class=3D"">=C2=A0=C2=A0=C2=A0 =
<a href=3D"http://self.info">self.info</a>(my_policy.generate(</span></span=
><span class=3D"" style=3D"font-size:11pt;font-family:Calibri,sans-serif;li=
ne-height:20px"><span style=3D"background-color:inherit" class=3D"">outputd=
ir</span></span><span class=3D"" style=3D"font-size:11pt;font-family:Calibr=
i,sans-serif;line-height:20px"><span style=3D"background-color:inherit" cla=
ss=3D"">))</span></span><span style=3D"font-size:11pt;line-height:20px;font=
-family:Calibri,sans-serif" class=3D""><span class=3D"">=C2=A0</span></span=
><br class=3D""><span style=3D"font-size:11pt;line-height:20px;font-family:=
Calibri,sans-serif" class=3D""></span><span class=3D"" style=3D"font-size:1=
1pt;font-family:Calibri,sans-serif;line-height:20px"><span style=3D"backgro=
und-color:inherit" class=3D"">=C2=A0 File &quot;/usr/lib64/python2.7/site-p=
ackages/sepolicy/generate.py&quot;, line 1382, in generate</span></span><sp=
an style=3D"font-size:11pt;line-height:20px;font-family:Calibri,sans-serif"=
 class=3D""><span class=3D"">=C2=A0</span></span><br class=3D""><span style=
=3D"font-size:11pt;line-height:20px;font-family:Calibri,sans-serif" class=
=3D""></span><span class=3D"" style=3D"font-size:11pt;font-family:Calibri,s=
ans-serif;line-height:20px"><span style=3D"background-color:inherit" class=
=3D"">=C2=A0=C2=A0=C2=A0 out +=3D &quot;%s # %s\n&quot; % (self.write_spec(=
out_dir), _(&quot;Spec file&quot;))</span></span><span style=3D"font-size:1=
1pt;line-height:20px;font-family:Calibri,sans-serif" class=3D""><span class=
=3D"">=C2=A0</span></span><br class=3D""><span style=3D"font-size:11pt;line=
-height:20px;font-family:Calibri,sans-serif" class=3D""></span><span class=
=3D"" style=3D"font-size:11pt;font-family:Calibri,sans-serif;line-height:20=
px"><span style=3D"background-color:inherit" class=3D"">=C2=A0 File &quot;/=
usr/lib64/python2.7/site-packages/sepolicy/generate.py&quot;, line 1228, in=
 write_spec</span></span><span style=3D"font-size:11pt;line-height:20px;fon=
t-family:Calibri,sans-serif" class=3D""><span class=3D"">=C2=A0</span></spa=
n><br class=3D""><span style=3D"font-size:11pt;line-height:20px;font-family=
:Calibri,sans-serif" class=3D""></span><span class=3D"" style=3D"font-size:=
11pt;font-family:Calibri,sans-serif;line-height:20px"><span style=3D"backgr=
ound-color:inherit" class=3D"">=C2=A0=C2=A0=C2=A0 fd.write(self.generate_sp=
ec())</span></span><span style=3D"font-size:11pt;line-height:20px;font-fami=
ly:Calibri,sans-serif" class=3D""><span class=3D"">=C2=A0</span></span><br =
class=3D""><span style=3D"font-size:11pt;line-height:20px;font-family:Calib=
ri,sans-serif" class=3D""></span><span class=3D"" style=3D"font-size:11pt;f=
ont-family:Calibri,sans-serif;line-height:20px"><span style=3D"background-c=
olor:inherit" class=3D"">=C2=A0 File &quot;/usr/lib64/python2.7/site-packag=
es/sepolicy/generate.py&quot;, line 1190, in generate_spec</span></span><sp=
an style=3D"font-size:11pt;line-height:20px;font-family:Calibri,sans-serif"=
 class=3D""><span class=3D"">=C2=A0</span></span><br class=3D""><span style=
=3D"font-size:11pt;line-height:20px;font-family:Calibri,sans-serif" class=
=3D""></span><span class=3D"" style=3D"font-size:11pt;font-family:Calibri,s=
ans-serif;line-height:20px"><span style=3D"background-color:inherit" class=
=3D"">=C2=A0=C2=A0=C2=A0 selinux_policyver =3D get_rpm_nvr_list(&quot;selin=
ux-policy&quot;)[1]</span></span><span style=3D"font-size:11pt;line-height:=
20px;font-family:Calibri,sans-serif" class=3D""><span class=3D"">=C2=A0</sp=
an></span><br class=3D""><span style=3D"font-size:11pt;line-height:20px;fon=
t-family:Calibri,sans-serif" class=3D""></span><span class=3D"" style=3D"fo=
nt-size:11pt;font-family:Calibri,sans-serif;line-height:20px"><span style=
=3D"background-color:inherit" class=3D"">TypeError: &#39;NoneType&#39; obje=
ct has no attribute &#39;__getitem__&#39;</span></span><br></blockquote></d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Sat, =
Mar 26, 2016 at 8:39 PM, Amir Eaman <span dir=3D"ltr">&lt;<a href=3D"mailto=
:amir.imen@gmail.com" target=3D"_blank">amir.imen@gmail.com</a>&gt;</span> =
wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div class=3D"gma=
il_default" style=3D"font-size:small">Hi,<br></div><div class=3D"gmail_defa=
ult" style=3D"font-size:small">When I press apply button in the last step f=
or policy generator on Fedora 23 the following error is issued. What should=
 I do?<br clear=3D"all"></div><div class=3D"gmail_default" style=3D"font-si=
ze:small">=E2=80=8B<pre>&gt; Failed to retrieve rpm info for selinux-policy
&gt; Traceback (most recent call last):
&gt;   File &quot;/usr/lib/python-exec/python2.7/sepolicy&quot;, line 643, =
in &lt;module&gt;
&gt;     args.func(args)
&gt;   File &quot;/usr/lib/python-exec/python2.7/sepolicy&quot;, line 517, =
in generate
&gt;     print mypolicy.generate(args.path)
&gt;   File &quot;/usr/lib64/python2.7/site-packages/sepolicy/generate.py&q=
uot;, line 1370, in generate
&gt;     out +=3D &quot;%s # %s\n&quot; % (self.write_spec(out_dir), _(&quo=
t;Spec file&quot;))
&gt;   File &quot;/usr/lib64/python2.7/site-packages/sepolicy/generate.py&q=
uot;, line 1219, in write_spec
&gt;     fd.write(self.generate_spec())
&gt;   File &quot;/usr/lib64/python2.7/site-packages/sepolicy/generate.py&q=
uot;, line 1181, in generate_spec
&gt;     selinux_policyver =3D get_rpm_nvr_list(&quot;selinux-policy&quot;)=
[1]
&gt; TypeError: &#39;NoneType&#39; object has no attribute &#39;__getitem__=
&#39;</pre>=E2=80=8B</div><span class=3D"HOEnZb"><font color=3D"#888888"><b=
r>-- <br><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr">=
<div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><img=
 src=3D"https://docs.google.com/uc?export=3Ddownload&amp;id=3D0B7YVMWSp9Xl-=
TE04Wk9ubUV4NU0&amp;revid=3D0B7YVMWSp9Xl-NFhsWmxQeWVTOWwzY1A4V05NNUEraXdCS0=
UwPQ" width=3D"143" height=3D"67"><br></div></div></div></div></div></div><=
/div></div></div></div></div></div></div>
</font></span></div>
</blockquote></div><br><br clear=3D"all"><br>-- <br><div class=3D"gmail_sig=
nature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><=
div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><img src=
=3D"https://docs.google.com/uc?export=3Ddownload&amp;id=3D0B7YVMWSp9Xl-TE04=
Wk9ubUV4NU0&amp;revid=3D0B7YVMWSp9Xl-NFhsWmxQeWVTOWwzY1A4V05NNUEraXdCS0UwPQ=
" width=3D"143" height=3D"67"><br></div></div></div></div></div></div></div=
></div></div></div></div></div></div>
</div>

--001a113540d8baca9d052eff6769--
