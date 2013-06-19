Received: from goalie.tycho.ncsc.mil (goalie [144.51.31.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id r5JLqKBV029150
	for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2013 17:52:20 -0400
Received: by mail-vb0-f47.google.com with SMTP id x14so4068711vbb.6
        for <selinux@tycho.nsa.gov>; Wed, 19 Jun 2013 14:52:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAO-4OdE3gXaoaL4wZ22P4kTzomusYiqFEMFkkAv63Wyd0Ncd=A@mail.gmail.com>
References: <CAO-4OdE3gXaoaL4wZ22P4kTzomusYiqFEMFkkAv63Wyd0Ncd=A@mail.gmail.com>
Date: Wed, 19 Jun 2013 14:52:20 -0700
Message-ID: <CAO-4OdGFz=6=9uUcXA7bMKEWQrScGGC52-vyxfifrJRbpLiMLA@mail.gmail.com>
Subject: Re: Problems regarding booting devices
From: Haiqing Jiang <hqjiang1988@gmail.com>
To: SELinux <selinux@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=bcaec5015ffd0dcf0f04df88d8e2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--bcaec5015ffd0dcf0f04df88d8e2
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

My problem has been solved. The reason is that I made a mistake in my flash
script. I put the fastboot format cache in a wrong place.

Thanks anyway,

Haiqing


On Tue, Jun 18, 2013 at 10:57 PM, Haiqing Jiang <hqjiang1988@gmail.com>wrote:

> Hi Stephen,
>
> Thanks for reading this email. I am Haiqing, working with Bill Roberts at
> Samsung previously.
>
> Recently I got two nexus devices and tried to run seandroid on them. When
> I flash the devices, after booting up, they stuck in the stage of flashing
> ANDROID logo. They cannot boot into android home screen. I checked the
> logcat, it says nothing. The two devices are Neuxs 4 and Nexus 10.
>
> I followed the instruction on website and add corresponding nexus binaries
> (vendor) in source codes.
>
> Could you help to give some suggestions? Thanks....
>
> --
> Thanks,
>
> Haiqing Jiang
>
>


-- 
Thanks,

Haiqing Jiang

--bcaec5015ffd0dcf0f04df88d8e2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-family:arial,sans-serif;font-size:13px=
">Hi all,</span><div style=3D"font-family:arial,sans-serif;font-size:13px">=
<br></div><div style=3D"font-family:arial,sans-serif;font-size:13px">My pro=
blem has been solved. The reason is that I made a mistake in my flash scrip=
t. I put the fastboot format cache in a wrong place.=A0</div>
<div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div s=
tyle=3D"font-family:arial,sans-serif;font-size:13px">Thanks anyway,</div><d=
iv style=3D"font-family:arial,sans-serif;font-size:13px"><br></div><div sty=
le=3D"font-family:arial,sans-serif;font-size:13px">
Haiqing</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_q=
uote">On Tue, Jun 18, 2013 at 10:57 PM, Haiqing Jiang <span dir=3D"ltr">&lt=
;<a href=3D"mailto:hqjiang1988@gmail.com" target=3D"_blank">hqjiang1988@gma=
il.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div dir=3D"ltr">Hi Stephen,<div><br></div><=
div>Thanks for reading this email. I am Haiqing, working with Bill Roberts =
at Samsung previously.=A0</div>
<div><br></div><div>Recently I got two nexus devices and tried to run seand=
roid on them. When I flash the devices, after booting up, they stuck in the=
 stage of flashing ANDROID logo. They cannot boot into android home screen.=
 I checked the logcat, it says nothing. The two devices are Neuxs 4 and Nex=
us 10.=A0</div>

<div><br></div><div>I followed the instruction on website and add correspon=
ding nexus binaries (vendor) in source codes.</div><div><br></div><div>Coul=
d you help to give some suggestions? Thanks....<span class=3D"HOEnZb"><font=
 color=3D"#888888"><br clear=3D"all">
<div><br>
</div>-- <br><div dir=3D"ltr"><div>Thanks,<br></div><div><br></div>Haiqing =
Jiang<div><div><br></div></div></div>
</font></span></div></div>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr"><div>Thanks,<br></div><div><br></div>Haiqing Jiang<div><div><br></div>=
</div></div>
</div>

--bcaec5015ffd0dcf0f04df88d8e2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
