MIME-Version: 1.0
Date: Mon, 30 Jul 2012 13:11:07 -0700
Message-ID: <CAO-4OdF4Kyt7Cg8-9zkb4zY4HdcK=Vg-M-mXm4nNgA03mVrKcA@mail.gmail.com>
Subject: Questions about the following denials
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d0401236f816e5104c611a930
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0401236f816e5104c611a930
Content-Type: text/plain; charset=ISO-8859-1

*Hi, Stephen,*
*
*
*Could you give me some suggestions for the understanding the denials as
shown below?*
*

#============= release_app ==============
allow release_app zygote:netlink_selinux_socket getattr;*
*
<5>[13011.539764] type=1400 audit(1343515886.695:592): avc:  denied  {
getattr } for  pid=10278 comm="ationTestRunner" path="socket:[1516]"
dev=sockfs ino=1516 scontext=u:r:release_app:s0 tcontext=u:r:zygote:s0
tclass=netlink_selinux_socket




#============= untrusted_app ==============
allow untrusted_app self:netlink_route_socket create;*
*
<5>[13900.251708] type=1400 audit(1343516775.406:801): avc:  denied  {
create } for  pid=15089 comm="WebViewCoreThre"
scontext=u:r:untrusted_app:s0:c39 tcontext=u:r:untrusted_app:s0:c39
tclass=netlink_route_socket*

-- 
-----------------------------------
Haiqing Jiang, PH.D student

Computer Science Department, North Carolina State University

--f46d0401236f816e5104c611a930
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><b style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;fon=
t-weight:normal"><span style=3D"font-size:15px;font-family:Arial;vertical-a=
lign:baseline;white-space:pre-wrap">Hi, Stephen,</span></b></div><div><b st=
yle=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;font-weight:n=
ormal"><span style=3D"font-size:15px;font-family:Arial;vertical-align:basel=
ine;white-space:pre-wrap"><br>
</span></b></div><div><b style=3D"font-family:&#39;Times New Roman&#39;;fon=
t-size:medium;font-weight:normal"><span style=3D"font-size:15px;font-family=
:Arial;vertical-align:baseline;white-space:pre-wrap">Could you give me some=
 suggestions for the understanding the denials as shown below?</span></b></=
div>
<b id=3D"internal-source-marker_0.5502668635454029" style=3D"font-family:&#=
39;Times New Roman&#39;;font-size:medium;font-weight:normal"><span style=3D=
"font-size:15px;font-family:Arial;vertical-align:baseline;white-space:pre-w=
rap"><div>
<b style=3D"font-family:&#39;Times New Roman&#39;;font-size:medium;font-wei=
ght:normal"><span style=3D"font-size:15px;font-family:Arial;vertical-align:=
baseline;white-space:pre-wrap"><br></span></b></div>#=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D release_app =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<b=
r class=3D"kix-line-break">
allow release_app zygote:netlink_selinux_socket getattr;</span></b><div><b =
style=3D"font-weight:normal"><font face=3D"Arial"><span style=3D"font-size:=
15px;white-space:pre-wrap"><br></span></font><span style=3D"font-family:Ari=
al;font-size:15px;vertical-align:baseline;white-space:pre-wrap">&lt;5&gt;[1=
3011.539764] type=3D1400 audit(1343515886.695:592): avc: =A0denied =A0{ get=
attr } for =A0pid=3D10278 comm=3D&quot;ationTestRunner&quot; path=3D&quot;s=
ocket:[1516]&quot; dev=3Dsockfs ino=3D1516 scontext=3Du:r:release_app:s0 tc=
ontext=3Du:r:zygote:s0 tclass=3Dnetlink_selinux_socket</span><br>
<span style=3D"font-family:Arial;font-size:15px;vertical-align:baseline;whi=
te-space:pre-wrap"><br class=3D"kix-line-break"></span><br><br><br><span st=
yle=3D"font-family:Arial;font-size:15px;vertical-align:baseline;white-space=
:pre-wrap">#=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D untrusted_app =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br class=3D"kix-line-break">
allow untrusted_app self:netlink_route_socket create;</span></b></div><div>=
<b style=3D"font-weight:normal"><font face=3D"Arial"><span style=3D"font-si=
ze:15px;white-space:pre-wrap"><br></span></font><span style=3D"font-family:=
Arial;font-size:15px;vertical-align:baseline;white-space:pre-wrap">&lt;5&gt=
;[13900.251708] type=3D1400 audit(1343516775.406:801): avc: =A0denied =A0{ =
create } for =A0pid=3D15089 comm=3D&quot;WebViewCoreThre&quot; scontext=3Du=
:r:untrusted_app:s0:c39 tcontext=3Du:r:untrusted_app:s0:c39 tclass=3Dnetlin=
k_route_socket</span></b><br clear=3D"all">
<div><br></div>-- <br><div>-----------------------------------</div>Haiqing=
 Jiang, PH.D student<div><br></div><div>Computer Science Department, North =
Carolina State University<br><div><br></div></div><br>
</div>

--f46d0401236f816e5104c611a930--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
