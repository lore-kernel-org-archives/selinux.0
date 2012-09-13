Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q8D8wwD0018358
	for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 04:58:58 -0400
Received: by vbbfc21 with SMTP id fc21so3508454vbb.12
        for <selinux@tycho.nsa.gov>; Thu, 13 Sep 2012 01:58:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKi3Puq_WerKfbr61dn1mc0rKcyXhrDvPtKdioXKEKKC1=o9qw@mail.gmail.com>
References: <CAKi3Pur6qLVmK5qv4QuWcuYFY_g+GNzcxOQjyQHj0Wxxm4FLcA@mail.gmail.com>
	<CAFftDdqBq-sOd8eDMbNg=sZA+HHVaG270LwJf33Uni1XVO-Fcg@mail.gmail.com>
	<CAKi3PurX_V+e79bh3xtS1-OMyAMw8caXu+n9iv5ZKoiSiO3bJw@mail.gmail.com>
	<CAFftDdod91UB6gWT5_QwT_q818fGgpBoU81hjLhwaY37ePjE4Q@mail.gmail.com>
	<CAKi3Puq_WerKfbr61dn1mc0rKcyXhrDvPtKdioXKEKKC1=o9qw@mail.gmail.com>
Date: Thu, 13 Sep 2012 01:58:56 -0700
Message-ID: <CAFftDdp0NL7CP5nMgpBboVw3cy3xc7bRk=N9PZbFErDWpvP=qA@mail.gmail.com>
Subject: Re: maguro 4.1.4
From: William Roberts <bill.c.roberts@gmail.com>
To: Alexandra Test <testalexandrainstitute@gmail.com>
Cc: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b66fb0578612204c9918414
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b66fb0578612204c9918414
Content-Type: text/plain; charset=ISO-8859-1

A bunch of services in service manager are dying. Try doing a factory reset.
On Sep 13, 2012 1:51 AM, "Alexandra Test" <testalexandrainstitute@gmail.com>
wrote:

> The output in the attached file.
>
>
> On Thu, Sep 13, 2012 at 10:37 AM, William Roberts <
> bill.c.roberts@gmail.com> wrote:
>
>> Added mailing list back in. Send us your log cat output.
>> On Sep 13, 2012 1:35 AM, "Alexandra Test" <
>> testalexandrainstitute@gmail.com> wrote:
>>
>>> Yes, I am.
>>>
>>>
>>> On Thu, Sep 13, 2012 at 10:32 AM, William Roberts <
>>> bill.c.roberts@gmail.com> wrote:
>>>
>>>> Are you able to adb shell into the device or do adb log cat?
>>>> On Sep 13, 2012 1:21 AM, "Alexandra Test" <
>>>> testalexandrainstitute@gmail.com> wrote:
>>>>
>>>>> Hi all,
>>>>> I am trying to update my seandroid release on my Samsung Galaxy Nexus.
>>>>>
>>>>> Yesterday I compiled the full maguro 4.1.4 and put it in the phone.
>>>>> The compiling has done well but now the phone can't turn on.
>>>>>
>>>>> Do you know what can be the problem?
>>>>>
>>>>> This is the procedure I follow.
>>>>>
>>>>>
>>>>> git clone -b seandroid-4.1.1 https://bitbucket.org/seandroid/manifests.git
>>>>> mkdir seandroid-4.1.1
>>>>> cd seandroid-4.1.1
>>>>> repo init -u https://android.googlesource.com/platform/manifest -b android-4.1.1_r4
>>>>> repo sync
>>>>> cp ../manifests/local_manifest.xml .repo/
>>>>> repo sync -j1
>>>>>
>>>>> export PREFIX=/path/to/your/aospclone
>>>>> cd $PREFIX/kernel/omap
>>>>> make ARCH=arm tuna_defconfig
>>>>> make ARCH=arm CROSS_COMPILE=$PREFIX/prebuilts/gcc/linux-x86/arm/arm-eabi-4.6/bin/arm-eabi-
>>>>>
>>>>> cd $PREFIX
>>>>> source build/envsetup.sh
>>>>> lunch full_maguro-userdebug
>>>>> export HAVE_SELINUX=true
>>>>> make
>>>>>
>>>>>
>>>>> Thanks for your help.
>>>>>
>>>>
>>>
>

--047d7b66fb0578612204c9918414
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">A bunch of services in service manager are dying. Try doing =
a factory reset.</p>
<div class=3D"gmail_quote">On Sep 13, 2012 1:51 AM, &quot;Alexandra Test&qu=
ot; &lt;<a href=3D"mailto:testalexandrainstitute@gmail.com">testalexandrain=
stitute@gmail.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
The output in the attached file.<br><br><br><div class=3D"gmail_quote">On T=
hu, Sep 13, 2012 at 10:37 AM, William Roberts <span dir=3D"ltr">&lt;<a href=
=3D"mailto:bill.c.roberts@gmail.com" target=3D"_blank">bill.c.roberts@gmail=
.com</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><p dir=3D"ltr">Added mailing list back in. S=
end us your log cat output.</p><div><div>
<div class=3D"gmail_quote">On Sep 13, 2012 1:35 AM, &quot;Alexandra Test&qu=
ot; &lt;<a href=3D"mailto:testalexandrainstitute@gmail.com" target=3D"_blan=
k">testalexandrainstitute@gmail.com</a>&gt; wrote:<br type=3D"attribution">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">


Yes, I am.<div><br><br><div class=3D"gmail_quote">On Thu, Sep 13, 2012 at 1=
0:32 AM, William Roberts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.rob=
erts@gmail.com" target=3D"_blank">bill.c.roberts@gmail.com</a>&gt;</span> w=
rote:<br>



<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><p dir=3D"ltr">Are you able to adb shell int=
o the device or do adb log cat?</p><div><div>
<div class=3D"gmail_quote">On Sep 13, 2012 1:21 AM, &quot;Alexandra Test&qu=
ot; &lt;<a href=3D"mailto:testalexandrainstitute@gmail.com" target=3D"_blan=
k">testalexandrainstitute@gmail.com</a>&gt; wrote:<br type=3D"attribution">=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">




Hi all,<div>I am trying to update my seandroid release on my Samsung Galaxy=
 Nexus.</div><div><br></div><div>Yesterday I compiled the full maguro 4.1.4=
 and put it in the phone. The compiling has done well but now the phone can=
&#39;t turn on.=A0</div>





<div><br></div><div>Do you know what can be the problem?=A0</div><div><br><=
/div><div>This is the procedure I follow.</div><div><br></div><div><pre sty=
le=3D"padding:1em;border:1px dashed rgb(47,111,171);background-color:rgb(24=
9,249,249);line-height:1.1em">

git clone -b seandroid-4.1.1 <a href=3D"https://bitbucket.org/seandroid/man=
ifests.git" target=3D"_blank">https://bitbucket.org/seandroid/manifests.git=
</a>
mkdir seandroid-4.1.1
cd seandroid-4.1.1
repo init -u <a href=3D"https://android.googlesource.com/platform/manifest"=
 target=3D"_blank">https://android.googlesource.com/platform/manifest</a> -=
b android-4.1.1_r4
repo sync
cp ../manifests/local_manifest.xml .repo/
repo sync -j1</pre></div><div><pre style=3D"padding:1em;border:1px dashed r=
gb(47,111,171);background-color:rgb(249,249,249);line-height:1.1em">export =
PREFIX=3D/path/to/your/aospclone
cd $PREFIX/kernel/omap
make ARCH=3Darm tuna_defconfig
make ARCH=3Darm CROSS_COMPILE=3D$PREFIX/prebuilts/gcc/linux-x86/arm/arm-eab=
i-4.6/bin/arm-eabi-</pre></div><div><pre style=3D"padding:1em;border:1px da=
shed rgb(47,111,171);background-color:rgb(249,249,249);line-height:1.1em">c=
d $PREFIX
source build/envsetup.sh
lunch full_maguro-userdebug
export HAVE_SELINUX=3Dtrue
make</pre></div><div><br></div><div>Thanks for your help.</div>
</blockquote></div>
</div></div></blockquote></div><br></div>
</blockquote></div>
</div></div></blockquote></div><br>
</blockquote></div>

--047d7b66fb0578612204c9918414--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
