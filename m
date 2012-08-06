MIME-Version: 1.0
In-Reply-To: <CAFftDdrNKJM_DJLxMFuwm6i-v=kG-Q9ZXPEK699tcCUYdpYe-g@mail.gmail.com>
References: <CAFftDdrNKJM_DJLxMFuwm6i-v=kG-Q9ZXPEK699tcCUYdpYe-g@mail.gmail.com>
Date: Mon, 6 Aug 2012 11:22:05 -0400
Message-ID: <CADQgGG0XFgRNcUw2yLtH57mhA_DogeDiWKeWg8SXWdYz3owTwg@mail.gmail.com>
Subject: Re: re-loadable policy support
From: Robert Craig <robertpcraig@gmail.com>
To: William Roberts <bill.c.roberts@gmail.com>
Cc: selinux@tycho.nsa.gov, Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=0016364ee516bea69504c69a7009
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--0016364ee516bea69504c69a7009
Content-Type: text/plain; charset=ISO-8859-1

This issue has now been resolved. We have updated the libselinux project to
reflect the change. Please refresh your copy.

On Thu, Aug 2, 2012 at 6:30 PM, William Roberts <bill.c.roberts@gmail.com>wrote:

> Doing the following steps on master is causing a reboot...
>
> 1. boot the device
> 2. push a sepolicy.24 to /data/system/sepolicy.24
> 3. adb shell setprop selinux.reload_policy 1
> 4. wait a few seconds
> 5. repeat step 3 and a reboot happens
>
>
> --
> Respectfully,
>
> William C Roberts
>
> --
> This message was distributed to subscribers of the selinux mailing list.
> If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.govwith
> the words "unsubscribe selinux" without quotes as the message.
>

--0016364ee516bea69504c69a7009
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This issue has now been resolved. We have updated the libselinux project to=
 reflect the change. Please refresh your copy.=A0<br><br><div class=3D"gmai=
l_quote">On Thu, Aug 2, 2012 at 6:30 PM, William Roberts <span dir=3D"ltr">=
&lt;<a href=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.ro=
berts@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Doing the following steps on master is causi=
ng a reboot...<br>
<br>
1. boot the device<br>
2. push a sepolicy.24 to /data/system/sepolicy.24<br>
3. adb shell setprop selinux.reload_policy 1<br>
4. wait a few seconds<br>
5. repeat step 3 and a reboot happens<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Respectfully,<br>
<br>
William C Roberts<br>
<br>
--<br>
This message was distributed to subscribers of the selinux mailing list.<br=
>
If you no longer wish to subscribe, send mail to <a href=3D"mailto:majordom=
o@tycho.nsa.gov">majordomo@tycho.nsa.gov</a> with<br>
the words &quot;unsubscribe selinux&quot; without quotes as the message.<br=
>
</font></span></blockquote></div><br>

--0016364ee516bea69504c69a7009--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
