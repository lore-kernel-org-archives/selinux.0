Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id u2R0dYDi011566
 for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2016 20:39:34 -0400
Received: by mail-qg0-f46.google.com with SMTP id c67so51151907qgc.1
 for <selinux@tycho.nsa.gov>; Sat, 26 Mar 2016 17:39:32 -0700 (PDT)
MIME-Version: 1.0
From: Amir Eaman <amir.imen@gmail.com>
Date: Sat, 26 Mar 2016 20:39:13 -0400
Message-ID: <CA+D4ZVpm660vuxgQSYQH_QU5re=mvczEK=8L3L+DAbtcNAHh9g@mail.gmail.com>
Subject: Fedora 23 error when using policy generator
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c13a6498ae97052efd0774
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--001a11c13a6498ae97052efd0774
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,
When I press apply button in the last step for policy generator on Fedora
23 the following error is issued. What should I do?
=E2=80=8B

> Failed to retrieve rpm info for selinux-policy
> Traceback (most recent call last):
>   File "/usr/lib/python-exec/python2.7/sepolicy", line 643, in <module>
>     args.func(args)
>   File "/usr/lib/python-exec/python2.7/sepolicy", line 517, in generate
>     print mypolicy.generate(args.path)
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 13=
70, in generate
>     out +=3D "%s # %s\n" % (self.write_spec(out_dir), _("Spec file"))
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 12=
19, in write_spec
>     fd.write(self.generate_spec())
>   File "/usr/lib64/python2.7/site-packages/sepolicy/generate.py", line 11=
81, in generate_spec
>     selinux_policyver =3D get_rpm_nvr_list("selinux-policy")[1]
> TypeError: 'NoneType' object has no attribute '__getitem__'

=E2=80=8B

--

--001a11c13a6498ae97052efd0774
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi,=
<br></div><div class=3D"gmail_default" style=3D"font-size:small">When I pre=
ss apply button in the last step for policy generator on Fedora 23 the foll=
owing error is issued. What should I do?<br clear=3D"all"></div><div class=
=3D"gmail_default" style=3D"font-size:small">=E2=80=8B<pre>&gt; Failed to r=
etrieve rpm info for selinux-policy
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
&#39;</pre>=E2=80=8B</div><br>-- <br><div class=3D"gmail_signature"><div di=
r=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><div dir=3D"ltr"=
><div><div dir=3D"ltr"><div><div dir=3D"ltr"><div><img src=3D"https://docs.=
google.com/uc?export=3Ddownload&amp;id=3D0B7YVMWSp9Xl-TE04Wk9ubUV4NU0&amp;r=
evid=3D0B7YVMWSp9Xl-NFhsWmxQeWVTOWwzY1A4V05NNUEraXdCS0UwPQ" width=3D"143" h=
eight=3D"67"><br></div></div></div></div></div></div></div></div></div></di=
v></div></div></div>
</div>

--001a11c13a6498ae97052efd0774--
