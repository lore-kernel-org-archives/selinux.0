Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id rA1Jgshe025203
	for <selinux@tycho.nsa.gov>; Fri, 1 Nov 2013 15:42:54 -0400
Received: by mail-qc0-f194.google.com with SMTP id n4so1170114qcx.5
        for <selinux@tycho.nsa.gov>; Fri, 01 Nov 2013 12:42:53 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 1 Nov 2013 20:42:52 +0100
Message-ID: <CALQuvJCYEZky6kT6DkSpDB9pj_07yHe7cP4cUdZPd5mpwuawEw@mail.gmail.com>
Subject: Android emulator
From: Gabriele Scotti <gabriele.sct@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=001a11c3218aac115704ea22c504
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--001a11c3218aac115704ea22c504
Content-Type: text/plain; charset=ISO-8859-1

Dear Sirs,

I am writing to enquire about the android emulator behavior: I'm using the AOSP
master branch with the SE for Android modifications and I'm trying to place
restrictions on what application can use the bind channel.
I have two custom application in the untrusted domain that can communicate
each other and I want to block this communication, so I modified the file
app.te by removing the binder call from appdomain to appdomain but they can
still communicate.
I should like to know if I can do this with the emulator or there are
restrictions, otherwise I assume that I'm writing a wrong policy.

Thanks for your reply,

Kind regards

--001a11c3218aac115704ea22c504
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"color:rgb(0,0,0);font-family:&#39;Helv=
etica Neue&#39;,Helvetica,Arial,san-serif;font-size:13px;line-height:16px">=
Dear Sirs,</span><span style=3D"line-height:14.390625px;font-size:12px;back=
ground-color:rgb(245,245,243);font-family:Arial,Helvetica,sans-serif"><br>
</span></div><div><span style=3D"color:rgb(0,0,0);font-family:&#39;Helvetic=
a Neue&#39;,Helvetica,Arial,san-serif;font-size:13px;line-height:16px"><br>=
</span></div><span style=3D"line-height:14.390625px;font-size:12px;backgrou=
nd-color:rgb(245,245,243);font-family:Arial,Helvetica,sans-serif">I am writ=
ing to enquire about the android emulator behavior: I&#39;m using the=A0</s=
pan><span style=3D"line-height:19.046875px;font-size:13px;font-family:sans-=
serif">AOSP master branch with the SE for Android modifications and I&#39;m=
=A0</span><font color=3D"#000000" face=3D"sans-serif"><span style=3D"line-h=
eight:19.046875px">trying to place restrictions on what application can use=
 the bind channel.</span></font><div>
<font color=3D"#000000" face=3D"sans-serif"><span style=3D"line-height:19.0=
46875px">I have two custom application in the untrusted domain that can com=
municate each other and I want to block this communication, so I modified t=
he file app.te by removing the binder call from appdomain to appdomain but =
they can still communicate.</span></font></div>
<div><span style=3D"color:rgb(51,51,51);font-family:&#39;Helvetica Neue&#39=
;,Helvetica,Arial,sans-serif;font-size:13px;line-height:18px">I should like=
 to know if I can do this with the emulator or there are=A0</span><span sty=
le=3D"background-color:rgb(240,240,240);color:rgb(51,51,51);font-family:&#3=
9;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;font-size:13px;line-height=
:18px">restrictions</span><span style=3D"color:rgb(51,51,51);font-family:&#=
39;Helvetica Neue&#39;,Helvetica,Arial,sans-serif;font-size:13px;line-heigh=
t:18px">, otherwise I assume that I&#39;m writing a wrong policy.</span></d=
iv>
<div><font color=3D"#333333" face=3D"Helvetica Neue, Helvetica, Arial, sans=
-serif"><span style=3D"line-height:18px"><br></span></font></div><div><span=
 style=3D"color:rgb(0,0,0);font-family:&#39;Helvetica Neue&#39;,Helvetica,A=
rial,san-serif;font-size:13px;line-height:16px">Thanks for your reply,=A0</=
span><br style=3D"color:rgb(0,0,0);font-family:&#39;Helvetica Neue&#39;,Hel=
vetica,Arial,san-serif;font-size:13px;line-height:16px">
<br style=3D"color:rgb(0,0,0);font-family:&#39;Helvetica Neue&#39;,Helvetic=
a,Arial,san-serif;font-size:13px;line-height:16px"><span style=3D"color:rgb=
(0,0,0);font-family:&#39;Helvetica Neue&#39;,Helvetica,Arial,san-serif;font=
-size:13px;line-height:16px">Kind regards</span><font color=3D"#333333" fac=
e=3D"Helvetica Neue, Helvetica, Arial, sans-serif"><span style=3D"line-heig=
ht:18px"><br>
</span></font><table style=3D"font-size:13px;border-spacing:0px;color:rgb(1=
19,119,119);font-family:arial,sans-serif">
<tbody><tr><td style=3D"padding:0px"><div style=3D"color:rgb(0,0,0);min-hei=
ght:18px;margin:1px 0px;overflow:hidden;padding:0px;vertical-align:top;whit=
e-space:nowrap;direction:ltr"><br></div><div><br></div></td></tr></tbody></=
table>

<div><table style=3D"border-spacing:0px;color:rgb(119,119,119);font-family:=
arial,sans-serif;font-size:13px"><tbody><tr><td style=3D"padding:0px"><div =
style=3D"color:rgb(0,0,0);min-height:18px;margin:1px 0px;overflow:hidden;pa=
dding:0px;vertical-align:top;white-space:nowrap;direction:ltr">

<br></div></td><td style=3D"padding:0px;width:567px"></td></tr></tbody></ta=
ble></div></div></div>

--001a11c3218aac115704ea22c504--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
