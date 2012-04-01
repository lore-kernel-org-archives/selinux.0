MIME-Version: 1.0
In-Reply-To: <CADtWkVnyXPv99Hh-xTKz-03Qnv5AueYs7e8CqbQTUzu4dEX47Q@mail.gmail.com>
References: <CADtWkVnyXPv99Hh-xTKz-03Qnv5AueYs7e8CqbQTUzu4dEX47Q@mail.gmail.com>
Date: Sun, 1 Apr 2012 19:59:54 -0400
Message-ID: <CADQgGG1A4YaJGgqAir9TxMutEYY4MAriNNS1cisHK-LyQz_dqA@mail.gmail.com>
Subject: Re: DexOpt freezes on SettingsProvider.apk@classes.dex
From: Robert Craig <robertpcraig@gmail.com>
To: michael <0xffdc@gmail.com>
Cc: seandroid@tycho.nsa.gov, selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8fb2065ec0faf804bca6de56
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8fb2065ec0faf804bca6de56
Content-Type: text/plain; charset=ISO-8859-1

- When's the last time you repo synced? There was a recent fix to solve the
very boot deadlock you're seeing.
 https://android-review.googlesource.com/#/c/34210/

On Sun, Apr 1, 2012 at 6:34 PM, michael <0xffdc@gmail.com> wrote:

> Hello,
>
> I'm trying to boot SE Android on Samsung/Google Nexus S 4G
> using full_crespo4g-eng configuration.The original AOSP (android-4.0.3_r1
> revision) works just fine, but there are two issues with SE Android (aosp
> master revision + selinuxproject). First of all, it was not possible to
> build emulator because of some errors, so I had to exclude it from
> compilation, I believe that it should not affect booting process. Second,
> after flashing, the device hangs every time during the Android boot process:
>
> (1st reboot)
> 01-01 00:00:58.433: I/ActivityThread(168): Pub settings:
> com.android.providers.settings.SettingsProvider
> 01-01 00:00:58.433: I/SystemServer(168): System Content Providers
> 01-01 00:00:58.437: D/dalvikvm(168): DexOpt: --- BEGIN
> 'SettingsProvider.apk' (bootstrap=0) ---
> hang!
>
> (2nd reboot)
> 01-01 00:00:21.980: I/ActivityThread(159): Pub settings:
> com.android.providers.settings.SettingsProvider
> 01-01 00:00:21.980: I/SystemServer(159): System Content Providers
> 01-01 00:00:21.984: D/dalvikvm(159): DexOpt: incorrect opt magic number
> (0xff ff ff ff)
> 01-01 00:00:21.984: D/dalvikvm(159): ODEX file is stale or bad; removing
> and retrying (/data/dalvik-cache/system@app
> @SettingsProvider.apk@classes.dex)
> 01-01 00:00:21.988: D/dalvikvm(159): DexOpt: --- BEGIN
> 'SettingsProvider.apk' (bootstrap=0) ---
> hang!
>
> You can see that DexOpt is causing a system hang while
> optimizing SettingsProvider.apk@classes.dex. The source code
> of SetttingProvider is unchanged and DexOpt works great for many other
> system apps, so it's unclear why it freezes. Thank you in advance for your
> answers. Also, I appreciate any BKMs on how to debug similar issues.
>

--e89a8fb2065ec0faf804bca6de56
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

- When&#39;s the last time you repo synced? There was a recent fix to solve=
 the very boot deadlock you&#39;re seeing.=A0<div>=A0<a href=3D"https://and=
roid-review.googlesource.com/#/c/34210/">https://android-review.googlesourc=
e.com/#/c/34210/</a>=A0<div>
<br><div class=3D"gmail_quote">On Sun, Apr 1, 2012 at 6:34 PM, michael <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:0xffdc@gmail.com">0xffdc@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span>Hello,</span><div><br></div><div>I&#39;m trying to boot SE Android on=
 Samsung/Google Nexus S 4G using=A0full_crespo4g-eng=A0configuration.The or=
iginal AOSP (android-4.0.3_r1 revision) works just fine, but there are two =
issues with SE Android (aosp master revision + selinuxproject). First of al=
l, it was not possible to build emulator=A0because=A0of some=A0errors, so I=
 had to=A0exclude it from compilation, I believe that it should not affect =
booting process. Second, after flashing, the device hangs every time during=
 the Android boot process:</div>


<div><br></div><div>(1st reboot)</div><div><div>01-01 00:00:58.433: I/Activ=
ityThread(168): Pub settings: com.android.providers.settings.SettingsProvid=
er</div><div>01-01 00:00:58.433: I/SystemServer(168): System Content Provid=
ers</div>


<div>01-01 00:00:58.437: D/dalvikvm(168): DexOpt: --- BEGIN &#39;SettingsPr=
ovider.apk&#39; (bootstrap=3D0) ---</div></div><div>hang!</div><div><br></d=
iv><div><div>(2nd reboot)</div><div>01-01 00:00:21.980: I/ActivityThread(15=
9): Pub settings: com.android.providers.settings.SettingsProvider</div>


<div>01-01 00:00:21.980: I/SystemServer(159): System Content Providers</div=
><div>01-01 00:00:21.984: D/dalvikvm(159): DexOpt: incorrect opt magic numb=
er (0xff ff ff ff)</div><div>01-01 00:00:21.984: D/dalvikvm(159): ODEX file=
 is stale or bad; removing and retrying (/data/dalvik-cache/system@app@Sett=
ingsProvider.apk@classes.dex)</div>


<div>01-01 00:00:21.988: D/dalvikvm(159): DexOpt: --- BEGIN &#39;SettingsPr=
ovider.apk&#39; (bootstrap=3D0) ---</div></div><div><div>hang!</div><br></d=
iv><div>You can see that DexOpt is causing a system hang while optimizing=
=A0SettingsProvider.apk@classes.dex. The source code of=A0SetttingProvider =
is unchanged and DexOpt works great for many other system apps, so it&#39;s=
 unclear why it freezes. Thank you in advance for your answers. Also, I=A0a=
ppreciate=A0any BKMs on how to debug similar issues.</div>


</blockquote></div><br></div></div>

--e89a8fb2065ec0faf804bca6de56--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
