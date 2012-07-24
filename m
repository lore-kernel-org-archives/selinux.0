MIME-Version: 1.0
Date: Tue, 24 Jul 2012 15:25:38 -0700
Message-ID: <CAO-4OdF58aU5s=t5qeQiMOafGHjJTEQL7NpqnW0dAXjzmAOrgQ@mail.gmail.com>
Subject: What is the reason for the denial?
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
        William Roberts <bill.c.roberts@gmail.com>
Content-Type: multipart/alternative; boundary=bcaec554d844876ce104c59ad71e
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec554d844876ce104c59ad71e
Content-Type: text/plain; charset=ISO-8859-1

*Hi, all*
*
*
*I have the following denial. It's very strange since there is one policy
in app.te: "*allow appdomain app_data_file:notdevfile_class_set
create_file_perms;*"*
Therefore, this denial should not be existed. Do you have any ideas?
Thanks.
*

#============= browser_app ==============
allow browser_app app_data_file:file open;

<5>[12332.713684] type=1400 audit(1342643713.703:2221): avc:  denied  {
open } for  pid=25996 comm="WebViewCoreThre" name="jsfileaccess.html"
dev=mmcblk0p12 ino=578608 scontext=u:r:browser_app:s0:c3
tcontext=u:object_r:app_data_file:s0:c37 tclass=file
<5>[12332.933044] type=1400 audit(1342643713.921:2222): avc:  denied  {
open } for  pid=25996 comm="WebViewCoreThre" name="target.txt"
dev=mmcblk0p12 ino=578521 scontext=u:r:browser_app:s0:c3
tcontext=u:object_r:app_data_file:s0:c37 tclass=file*

-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--bcaec554d844876ce104c59ad71e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

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
nks. </span></font></div><b id=3D"internal-source-marker_0.4585704817436635=
5" style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;font-wei=
ght:normal"><span style=3D"font-size:15px;font-family:Arial;vertical-align:=
baseline;white-space:pre-wrap"><div>
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

--bcaec554d844876ce104c59ad71e--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
