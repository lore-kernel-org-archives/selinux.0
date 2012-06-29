MIME-Version: 1.0
In-Reply-To: <1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
References: <201206211329.q5LDT6PW031262@tarius.tycho.ncsc.mil>
	<CAKi3Pur-Ne8vAfbw6t4hutrqJO73x=wOaHvTg8dca4W-LUOuLg@mail.gmail.com>
	<1340288275.4234.48.camel@moss-pluto.epoch.ncsc.mil>
Date: Fri, 29 Jun 2012 11:59:51 +0200
Message-ID: <CAKi3PuqSFBw8EHLCXuASBxoMEEX4wTuW0MZOdEURO5_GWTVcnA@mail.gmail.com>
Subject: Re: Welcome to selinux
From: Alexandra Test <testalexandrainstitute@gmail.com>
To: Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=f46d0443040460ff4a04c39982d9
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--f46d0443040460ff4a04c39982d9
Content-Type: text/plain; charset=ISO-8859-1

I have a samsung galaxy nexus and I am using ubuntu 12.04...

Unfortunately I could't see any SeAndroid when I lunch the adb shell
getenforce, so I decided to try again.

this is my procedure:
- initialize repo with the master version
- add the master local_manifest.xml in the .repo folder
- sync
- build a modified kernel with the necessary support for SELinux

export PREFIX=/path/to/your/aospclone
cd $PREFIX/kernel/samsung
make ARCH=arm tuna_defconfig
make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilt/linux-x86/toolchain/arm-eabi-4.4.3/bin/arm-eabi-

- make HAVE_SELINUX=true

Now the device tries to boot but I can only see an horizontal line on the
screen.
However if I try to interrogate the device with the adb shell getenforce, I
can see that it is in a permissive mode.
What is wrong??

When I compiled AOSP the first time I had the same problem with the screen
and I solved with additional hardware-related proprietary libraries, that
are here
https://developers.google.com/android/nexus/drivers?hl=da#maguroimm76d
I used this one: Galaxy Nexus (GSM/HSPA+) binaries for Android 4.0.4
(IMM76D to IMM76L).
I also tried to add these libraries but it doesn't work yet!

Can anyone help me?


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

--f46d0443040460ff4a04c39982d9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>I have a samsung galaxy nexus and I am using ubuntu 12.04...=A0</div><=
div><br></div>Unfortunately I could&#39;t see any SeAndroid when I lunch th=
e adb shell getenforce, so I decided to try again.<div>

<br></div><div>this is my procedure:</div>
<div>- initialize repo with the master version</div><div>- add the master l=
ocal_manifest.xml in the .repo folder</div><div>- sync</div><div>-=A0<span =
style=3D"line-height:19px;font-size:13px;font-family:sans-serif">build a mo=
dified kernel with the necessary support for SELinux</span></div>



<div><pre style=3D"padding:1em;border:1px dashed rgb(47,111,171);background=
-color:rgb(249,249,249);line-height:1.1em"><font size=3D"1" face=3D"times n=
ew roman, serif">export PREFIX=3D/path/to/your/aospclone
cd $PREFIX/kernel/samsung
make ARCH=3Darm <span style=3D"line-height:19px;white-space:normal;backgrou=
nd-color:rgb(255,255,255)">tuna_defconfig</span>
make ARCH=3Darm CROSS_COMPILE=3D$PREFIX/prebuilt/linux-x86/toolchain/arm-ea=
bi-4.4.3/bin/arm-eabi-</font></pre></div><div><span style=3D"line-height:19=
px;font-family:sans-serif">-=A0</span><span style=3D"background-color:rgb(2=
49,249,249);line-height:1.1em">make HAVE_SELINUX=3Dtrue</span></div>



<div><span style=3D"line-height:14px"><br></span></div><div><span style=3D"=
line-height:14px">Now the device tries to boot but I can only see an horizo=
ntal line on the screen.</span></div><div><span style=3D"line-height:14px">=
However if I try to interrogate the device with the adb shell getenforce, I=
 can see that it is in a permissive mode.</span></div>



<div><span style=3D"line-height:14px">What is wrong??</span></div><div><spa=
n style=3D"line-height:14px"><br></span></div><div><font face=3D"arial, hel=
vetica, sans-serif"><span style=3D"background-color:rgb(249,249,249);line-h=
eight:1.1em">When I compiled AOSP the first time I had the same problem wit=
h the screen and I solved with ad</span><span style=3D"line-height:21px;col=
or:rgb(32,32,32)">ditional hardware-related proprietary libraries</span><sp=
an style=3D"line-height:14px;color:rgb(32,32,32)">, that are here</span></f=
ont></div>



<div><a href=3D"https://developers.google.com/android/nexus/drivers?hl=3Dda=
#maguroimm76d" target=3D"_blank">https://developers.google.com/android/nexu=
s/drivers?hl=3Dda#maguroimm76d</a>
</div><div>I used this one:=A0<span style=3D"line-height:24px;color:rgb(34,=
34,34);font-family:arial,helvetica,sans-serif">Galaxy Nexus (GSM/HSPA+) bin=
aries for Android 4.0.4 (IMM76D to IMM76L).</span></div>
<div><font color=3D"#222222" face=3D"arial, helvetica, sans-serif"><span st=
yle=3D"line-height:24px">I also tried to add these libraries but it doesn&#=
39;t work yet!</span></font></div><div><font color=3D"#222222" face=3D"aria=
l, helvetica, sans-serif"><span style=3D"line-height:24px"><br>



</span></font></div><div><font color=3D"#222222" face=3D"arial, helvetica, =
sans-serif"><span style=3D"line-height:24px">Can anyone help me?</span></fo=
nt></div><br><br><div class=3D"gmail_quote">On Thu, Jun 21, 2012 at 4:17 PM=
, Stephen Smalley <span dir=3D"ltr">&lt;<a href=3D"mailto:sds@tycho.nsa.gov=
" target=3D"_blank">sds@tycho.nsa.gov</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Thu, 2012-06-21 at 16:0=
8 +0200, Alexandra Test wrote:<br>
&gt; Hi,<br>
&gt; I need a help but I don&#39;t know where to ask for it.<br>
<br>
</div><a href=3D"mailto:seandroid@tycho.nsa.gov">seandroid@tycho.nsa.gov</a=
> is our team mail alias, so you can use it for<br>
questions that you don&#39;t want to be public. =A0<a href=3D"mailto:selinu=
x@tycho.nsa.gov">selinux@tycho.nsa.gov</a> is<br>
the public SELinux mailing list, so you can use it for questions that<br>
don&#39;t require privacy. =A0When possible, use the public list so that<br=
>
others can benefit from the questions and answers.<br>
<div class=3D"im"><br>
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
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Stephen Smalley<br>
National Security Agency<br>
<br>
</font></span></blockquote></div><br>

--f46d0443040460ff4a04c39982d9--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
