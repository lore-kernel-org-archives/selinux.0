Received: from goalie.tycho.ncsc.mil (goalie [144.51.242.250])
 by tarius.tycho.ncsc.mil (8.14.4/8.14.4) with ESMTP id w1F50IpS011438
 for <selinux@tycho.nsa.gov>; Thu, 15 Feb 2018 00:00:19 -0500
Received: by mail-it0-f53.google.com with SMTP id 193so14966388iti.1
 for <selinux@tycho.nsa.gov>; Wed, 14 Feb 2018 21:00:11 -0800 (PST)
MIME-Version: 1.0
From: Aman Sharma <amansh.sharma5@gmail.com>
Date: Thu, 15 Feb 2018 10:30:10 +0530
Message-ID: <CAPMH7-_9hM6Kp4DjzLZaAxyxatkrAPqxGV+jBrWdeftkE4xmFw@mail.gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary="94eb2c06030637efe80565391ad8"
Subject: Facing problem while running the audit2allow command
List-Id: "Security-Enhanced Linux \(SELinux\) mailing list"
 <selinux.tycho.nsa.gov>
List-Post: <mailto:selinux@tycho.nsa.gov>
List-Help: <mailto:selinux-request@tycho.nsa.gov?subject=help>

--94eb2c06030637efe80565391ad8
Content-Type: text/plain; charset="UTF-8"

Hi All,

I am getting one issue while running the command *audit2allow *and below is
the
logs for the same :

After switching back to lower version, running "audit2allow -a" command
show below errors repeteadly and the command does not return:
libsepol.context_from_record: invalid security context:
"sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023"
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert
sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023 to sid
libsepol.context_from_record: invalid security context:
"sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023"
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure
libsepol.sepol_context_to_sid: could not convert
sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023 to sid
libsepol.context_from_record: invalid security context:
"sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023"
libsepol.context_from_record: could not create context structure
libsepol.context_from_string: could not create context structure

And also Unconfined is disabled in my System and I am suspecting that after
disabling , I am getting the above errors. Can anybody help me on this.

Please let me know if any comments are there.

-- 

Thanks
Aman
Cell: +91 9990296404 |  Email ID : amansh.sharma5@gmail.com

--94eb2c06030637efe80565391ad8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<div><br></div><div>I am getting one issue while ru=
nning the command <b>audit2allow </b>and below is the=C2=A0<br clear=3D"all=
"><div>logs for the same :</div><div><br></div><div>

<span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:1=
4px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial;flo=
at:none;display:inline">After switching back to lower version, running &quo=
t;audit2allow -a&quot; command show below errors repeteadly and the command=
 does not return:<span>=C2=A0</span></span><br style=3D"color:rgb(51,51,51)=
;font-family:Arial,sans-serif;font-size:14px;font-style:normal;font-variant=
-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:n=
ormal;text-align:left;text-indent:0px;text-transform:none;white-space:norma=
l;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:=
initial;text-decoration-color:initial"><span style=3D"color:rgb(51,51,51);f=
ont-family:Arial,sans-serif;font-size:14px;font-style:normal;font-variant-l=
igatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:nor=
mal;text-align:left;text-indent:0px;text-transform:none;white-space:normal;=
word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:in=
itial;text-decoration-color:initial;float:none;display:inline">libsepol.con=
text_from_record: invalid security context: &quot;sysadm_u:system_r:unconfi=
ned_java_t:s0-s0:c0.c1023&quot;<span>=C2=A0</span></span><br style=3D"color=
:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:norma=
l;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;le=
tter-spacing:normal;text-align:left;text-indent:0px;text-transform:none;whi=
te-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-dec=
oration-style:initial;text-decoration-color:initial"><span style=3D"color:r=
gb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:normal;=
font-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lett=
er-spacing:normal;text-align:left;text-indent:0px;text-transform:none;white=
-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decor=
ation-style:initial;text-decoration-color:initial;float:none;display:inline=
">libsepol.context_from_record: could not create context structure<span>=C2=
=A0</span></span><br style=3D"color:rgb(51,51,51);font-family:Arial,sans-se=
rif;font-size:14px;font-style:normal;font-variant-ligatures:normal;font-var=
iant-caps:normal;font-weight:400;letter-spacing:normal;text-align:left;text=
-indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgro=
und-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-co=
lor:initial"><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-seri=
f;font-size:14px;font-style:normal;font-variant-ligatures:normal;font-varia=
nt-caps:normal;font-weight:400;letter-spacing:normal;text-align:left;text-i=
ndent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgroun=
d-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-colo=
r:initial;float:none;display:inline">libsepol.context_from_string: could no=
t create context structure<span>=C2=A0</span></span><br style=3D"color:rgb(=
51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:left;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(51=
,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:normal;font-=
variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-sp=
acing:normal;text-align:left;text-indent:0px;text-transform:none;white-spac=
e:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decoration=
-style:initial;text-decoration-color:initial;float:none;display:inline">lib=
sepol.sepol_context_to_sid: could not convert sysadm_u:system_r:unconfined_=
java_t:s0-s0:c0.c1023 to sid<span>=C2=A0</span></span><br style=3D"color:rg=
b(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:normal;f=
ont-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;lette=
r-spacing:normal;text-align:left;text-indent:0px;text-transform:none;white-=
space:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decora=
tion-style:initial;text-decoration-color:initial"><span style=3D"color:rgb(=
51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:normal;fon=
t-variant-ligatures:normal;font-variant-caps:normal;font-weight:400;letter-=
spacing:normal;text-align:left;text-indent:0px;text-transform:none;white-sp=
ace:normal;word-spacing:0px;background-color:rgb(255,255,255);text-decorati=
on-style:initial;text-decoration-color:initial;float:none;display:inline">l=
ibsepol.context_from_record: invalid security context: &quot;sysadm_u:syste=
m_r:unconfined_java_t:s0-s0:c0.c1023&quot;<span>=C2=A0</span></span><br sty=
le=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-=
style:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-we=
ight:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transfo=
rm:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,25=
5);text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;float:none;dis=
play:inline">libsepol.context_from_record: could not create context structu=
re<span>=C2=A0</span></span><br style=3D"color:rgb(51,51,51);font-family:Ar=
ial,sans-serif;font-size:14px;font-style:normal;font-variant-ligatures:norm=
al;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-alig=
n:left;text-indent:0px;text-transform:none;white-space:normal;word-spacing:=
0px;background-color:rgb(255,255,255);text-decoration-style:initial;text-de=
coration-color:initial"><span style=3D"color:rgb(51,51,51);font-family:Aria=
l,sans-serif;font-size:14px;font-style:normal;font-variant-ligatures:normal=
;font-variant-caps:normal;font-weight:400;letter-spacing:normal;text-align:=
left;text-indent:0px;text-transform:none;white-space:normal;word-spacing:0p=
x;background-color:rgb(255,255,255);text-decoration-style:initial;text-deco=
ration-color:initial;float:none;display:inline">libsepol.context_from_strin=
g: could not create context structure<span>=C2=A0</span></span><br style=3D=
"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style=
:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:=
400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform:no=
ne;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);te=
xt-decoration-style:initial;text-decoration-color:initial"><span style=3D"c=
olor:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-style:n=
ormal;font-variant-ligatures:normal;font-variant-caps:normal;font-weight:40=
0;letter-spacing:normal;text-align:left;text-indent:0px;text-transform:none=
;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255);text=
-decoration-style:initial;text-decoration-color:initial;float:none;display:=
inline">libsepol.sepol_context_to_sid: could not convert sysadm_u:system_r:=
unconfined_java_t:s0-s0:c0.c1023 to sid<span>=C2=A0</span></span><br style=
=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial"><span style=
=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:14px;font-st=
yle:normal;font-variant-ligatures:normal;font-variant-caps:normal;font-weig=
ht:400;letter-spacing:normal;text-align:left;text-indent:0px;text-transform=
:none;white-space:normal;word-spacing:0px;background-color:rgb(255,255,255)=
;text-decoration-style:initial;text-decoration-color:initial;float:none;dis=
play:inline">libsepol.context_from_record: invalid security context: &quot;=
sysadm_u:system_r:unconfined_java_t:s0-s0:c0.c1023&quot;<span>=C2=A0</span>=
</span><br style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-s=
ize:14px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:=
normal;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0p=
x;text-transform:none;white-space:normal;word-spacing:0px;background-color:=
rgb(255,255,255);text-decoration-style:initial;text-decoration-color:initia=
l"><span style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-siz=
e:14px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:no=
rmal;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;=
text-transform:none;white-space:normal;word-spacing:0px;background-color:rg=
b(255,255,255);text-decoration-style:initial;text-decoration-color:initial;=
float:none;display:inline">libsepol.context_from_record: could not create c=
ontext structure<span>=C2=A0</span></span><br style=3D"color:rgb(51,51,51);=
font-family:Arial,sans-serif;font-size:14px;font-style:normal;font-variant-=
ligatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:no=
rmal;text-align:left;text-indent:0px;text-transform:none;white-space:normal=
;word-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:i=
nitial;text-decoration-color:initial"><span style=3D"color:rgb(51,51,51);fo=
nt-family:Arial,sans-serif;font-size:14px;font-style:normal;font-variant-li=
gatures:normal;font-variant-caps:normal;font-weight:400;letter-spacing:norm=
al;text-align:left;text-indent:0px;text-transform:none;white-space:normal;w=
ord-spacing:0px;background-color:rgb(255,255,255);text-decoration-style:ini=
tial;text-decoration-color:initial;float:none;display:inline">libsepol.cont=
ext_from_string: could not create context structure<span>=C2=A0</span></spa=
n><br style=3D"color:rgb(51,51,51);font-family:Arial,sans-serif;font-size:1=
4px;font-style:normal;font-variant-ligatures:normal;font-variant-caps:norma=
l;font-weight:400;letter-spacing:normal;text-align:left;text-indent:0px;tex=
t-transform:none;white-space:normal;word-spacing:0px;background-color:rgb(2=
55,255,255);text-decoration-style:initial;text-decoration-color:initial"><b=
r><font color=3D"#333333" face=3D"Arial, sans-serif"><span style=3D"font-si=
ze:14px">And also Unconfined is disabled in my System and I am suspecting t=
hat after disabling , I am getting the above errors. Can anybody help me on=
 this.</span></font></div><div><br></div><div>Please let me know if any com=
ments are there.<br style=3D"color:rgb(51,51,51);font-family:Arial,sans-ser=
if;font-size:14px;font-style:normal;font-variant-ligatures:normal;font-vari=
ant-caps:normal;font-weight:400;letter-spacing:normal;text-align:left;text-=
indent:0px;text-transform:none;white-space:normal;word-spacing:0px;backgrou=
nd-color:rgb(255,255,255);text-decoration-style:initial;text-decoration-col=
or:initial">

<br></div>-- <br><div class=3D"gmail_signature" data-smartmail=3D"gmail_sig=
nature"><div dir=3D"ltr"><div><br></div><div>Thanks</div><div>Aman</div><di=
v>Cell: +91 9990296404 | =C2=A0Email ID : <a href=3D"mailto:amansh.sharma5@=
gmail.com" target=3D"_blank">amansh.sharma5@gmail.com</a></div></div></div>
</div></div>

--94eb2c06030637efe80565391ad8--
