Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5PBIIxv026634
	for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 07:18:18 -0400
Received: by wgbds1 with SMTP id ds1so2732723wgb.30
        for <selinux@tycho.nsa.gov>; Mon, 25 Jun 2012 04:18:16 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 25 Jun 2012 13:18:16 +0200
Message-ID: <CAKi3PurN13FgosvoP600NuegoLOPLqc7ueyd8XaEg4-Z0WQvnw@mail.gmail.com>
Subject: samsung galaxy nexus
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8f3ba7fb7007a004c34a2364
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8f3ba7fb7007a004c34a2364
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
I succeed (hopefully) in building the version for my samsung galaxy nexus.
Now I am trying to verify if SEAndroid is also installed.

*Once you have the emulator or a device running SE Android, you can run adb
shell and then look for signs that SELinux is present, e.g. *

*getenforce
ls -Z
ps -Z
dmesg*

What do I have to check? If I send the command *getenforce* in the adb
shell, nothing happens!

Can you help me?

Thank you,
Alexandra



On Thu, Jun 21, 2012 at 4:17 PM, Stephen Smalley <sds@tycho.nsa.gov> wrote:

> On Thu, 2012-06-21 at 16:08 +0200, Alexandra Test wrote:
> > Hi,
> > I need a help but I don't know where to ask for it.
>
> seandroid@tycho.nsa.gov is our team mail alias, so you can use it for
> questions that you don't want to be public.  selinux@tycho.nsa.gov is
> the public SELinux mailing list, so you can use it for questions that
> don't require privacy.  When possible, use the public list so that
> others can benefit from the questions and answers.
>
> > Which kernel can I use for Galaxy Nexus and what are the commands to
> > execute?
>
> The omap kernel with the tuna_defconfig is the one to use for Galaxy
> Nexus.  Commands to execute from the seandroid directory:
> cd kernel/omap
> make ARCH=arm tuna_defconfig
> make ARCH=arm
> CROSS_COMPILE=$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-
>
>
> --
> Stephen Smalley
> National Security Agency
>
>

--e89a8f3ba7fb7007a004c34a2364
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family:arial,helvetica,sans-serif">Hi all,</span><br st=
yle=3D"font-family:arial,helvetica,sans-serif"><span style=3D"font-family:a=
rial,helvetica,sans-serif">I succeed (hopefully) in building the version fo=
r my samsung galaxy nexus. </span><br style=3D"font-family:arial,helvetica,=
sans-serif">
<span style=3D"font-family:arial,helvetica,sans-serif">Now I am trying to v=
erify if SEAndroid is also installed. </span><br style=3D"font-family:arial=
,helvetica,sans-serif"><br style=3D"font-family:arial,helvetica,sans-serif"=
><p style=3D"font-family:arial,helvetica,sans-serif">
<i>Once you have the emulator or a device running SE Android, you can=20
run adb shell and then look for signs that SELinux is present, e.g.
</i></p>
<pre style=3D"font-family:arial,helvetica,sans-serif"><i>getenforce
ls -Z
ps -Z
dmesg</i><br><br><font>What do I have to check? If I send the command <i>ge=
tenforce</i> in the adb shell, nothing happens!<br><br>Can you help me?<br>=
<br>Thank you,<br>Alexandra<br></font></pre><br style=3D"font-family:arial,=
helvetica,sans-serif">
<br><div class=3D"gmail_quote">On Thu, Jun 21, 2012 at 4:17 PM, Stephen Sma=
lley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov" target=3D"_=
blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">

<div>On Thu, 2012-06-21 at 16:08 +0200, Alexandra Test wrote:<br>
&gt; Hi,<br>
&gt; I need a help but I don&#39;t know where to ask for it.<br>
<br>
</div><a href=3D"mailto:seandroid@tycho.nsa.gov" target=3D"_blank">seandroi=
d@tycho.nsa.gov</a> is our team mail alias, so you can use it for<br>
questions that you don&#39;t want to be public. =A0<a href=3D"mailto:selinu=
x@tycho.nsa.gov" target=3D"_blank">selinux@tycho.nsa.gov</a> is<br>
the public SELinux mailing list, so you can use it for questions that<br>
don&#39;t require privacy. =A0When possible, use the public list so that<br=
>
others can benefit from the questions and answers.<br>
<div><br>
&gt; Which kernel can I use for Galaxy Nexus and what are the commands to<b=
r>
&gt; execute?<br>
<br>
</div>The omap kernel with the tuna_defconfig is the one to use for Galaxy<=
br>
Nexus. =A0Commands to execute from the seandroid directory:<br>
cd kernel/omap<br>
make ARCH=3Darm tuna_defconfig<br>
make ARCH=3Darm CROSS_COMPILE=3D$PREFIX/prebuilt/linux-x86/toolchain/arm-ea=
bi-4.4.3/bin/arm-eabi-<br>
<span><font color=3D"#888888"><br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br>

--e89a8f3ba7fb7007a004c34a2364--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
