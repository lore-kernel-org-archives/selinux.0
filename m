MIME-Version: 1.0
In-Reply-To: <CAO-4OdF58aU5s=t5qeQiMOafGHjJTEQL7NpqnW0dAXjzmAOrgQ@mail.gmail.com>
References: <CAO-4OdF58aU5s=t5qeQiMOafGHjJTEQL7NpqnW0dAXjzmAOrgQ@mail.gmail.com>
Date: Tue, 24 Jul 2012 15:42:54 -0700
Message-ID: <CAFftDdrTYViyQWBVf=1qvs9rCJgYhTEGd3PqHM17Us4e=dkyRQ@mail.gmail.com>
Subject: Re: What is the reason for the denial?
From: William Roberts <bill.c.roberts@gmail.com>
To: Haiqing Jiang <hqjiang1988@gmail.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b33d5be42a8a304c59b1522
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b33d5be42a8a304c59b1522
Content-Type: text/plain; charset=ISO-8859-1

Is it MLS notice the MLS level change
On Jul 24, 2012 3:25 PM, "Haiqing Jiang" <hqjiang1988@gmail.com> wrote:

> *Hi, all*
> *
> *
> *I have the following denial. It's very strange since there is one policy
> in app.te: "*allow appdomain app_data_file:notdevfile_class_set
> create_file_perms;*"*
> Therefore, this denial should not be existed. Do you have any ideas?
> Thanks.
> *
>
> #============= browser_app ==============
> allow browser_app app_data_file:file open;
>
> <5>[12332.713684] type=1400 audit(1342643713.703:2221): avc:  denied  {
> open } for  pid=25996 comm="WebViewCoreThre" name="jsfileaccess.html"
> dev=mmcblk0p12 ino=578608 scontext=u:r:browser_app:s0:c3
> tcontext=u:object_r:app_data_file:s0:c37 tclass=file
> <5>[12332.933044] type=1400 audit(1342643713.921:2222): avc:  denied  {
> open } for  pid=25996 comm="WebViewCoreThre" name="target.txt"
> dev=mmcblk0p12 ino=578521 scontext=u:r:browser_app:s0:c3
> tcontext=u:object_r:app_data_file:s0:c37 tclass=file*
>
> --
> -----------------------------------
> Haiqing Jiang, PH.D student
>
> Computer Science Department, North Carolina State University
>
>
>

--047d7b33d5be42a8a304c59b1522
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Is it MLS notice the MLS level change</p>
<div class=3D"gmail_quote">On Jul 24, 2012 3:25 PM, &quot;Haiqing Jiang&quo=
t; &lt;<a href=3D"mailto:hqjiang1988@gmail.com">hqjiang1988@gmail.com</a>&g=
t; wrote:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div><b style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;fon=
t-weight:normal"><span style=3D"font-size:15px;font-family:Arial;vertical-a=
lign:baseline;white-space:pre-wrap">Hi, all</span></b></div><div><b style=
=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;font-weight:norm=
al"><span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline=
;white-space:pre-wrap"><br>

</span></b></div><div><b style=3D"font-family:&#39;Times New Roman&#39;;fon=
t-size:medium;font-weight:normal"><span style=3D"font-size:15px;font-family=
:Arial;vertical-align:baseline;white-space:pre-wrap">I have the following d=
enial. It&#39;s very strange since there is one policy in app.te: &quot;</s=
pan></b><font face=3D"Arial"><span style=3D"font-size:15px;white-space:pre-=
wrap">allow appdomain app_data_file:notdevfile_class_set create_file_perms;=
</span></font><b style=3D"font-family:&#39;Times New Roman&#39;;font-size:m=
edium;font-weight:normal"><span style=3D"font-size:15px;font-family:Arial;v=
ertical-align:baseline;white-space:pre-wrap">&quot;</span></b></div>

<div><font face=3D"Arial"><span style=3D"font-size:15px;white-space:pre-wra=
p">Therefore, this denial should not be existed. Do you have any ideas? Tha=
nks. </span></font></div><b style=3D"font-family:&#39;Times New Roman&#39;;=
font-size:medium;font-weight:normal"><span style=3D"font-size:15px;font-fam=
ily:Arial;vertical-align:baseline;white-space:pre-wrap"><div>

<b style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;font-wei=
ght:normal"><span style=3D"font-size:15px;font-family:Arial;vertical-align:=
baseline;white-space:pre-wrap"><br></span></b></div>#=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D browser_app =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</=
span><br>

<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">allow browser_app app_data_file:file open;</span><br><sp=
an style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;white-=
space:pre-wrap"></span><br>

<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[12332.713684] type=3D1400 audit(1342643713.703=
:2221): avc: =A0denied =A0{ open } for =A0pid=3D25996 comm=3D&quot;WebViewC=
oreThre&quot; name=3D&quot;jsfileaccess.html&quot; dev=3Dmmcblk0p12 ino=3D5=
78608 scontext=3Du:r:browser_app:s0:c3 tcontext=3Du:object_r:app_data_file:=
s0:c37 tclass=3Dfile</span><br>

<span style=3D"font-size:15px;font-family:Arial;vertical-align:baseline;whi=
te-space:pre-wrap">&lt;5&gt;[12332.933044] type=3D1400 audit(1342643713.921=
:2222): avc: =A0denied =A0{ open } for =A0pid=3D25996 comm=3D&quot;WebViewC=
oreThre&quot; name=3D&quot;target.txt&quot; dev=3Dmmcblk0p12 ino=3D578521 s=
context=3Du:r:browser_app:s0:c3 tcontext=3Du:object_r:app_data_file:s0:c37 =
tclass=3Dfile</span></b><br clear=3D"all">

<div><br></div>-- <br><div>-----------------------------------</div>Haiqing=
 Jiang, PH.D student<div><br></div><div>Computer Science Department, North =
Carolina State University<br><div><br></div></div><br>
</blockquote></div>

--047d7b33d5be42a8a304c59b1522--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
