Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2L1evHb016821
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2012 21:40:57 -0400
Received: by dady25 with SMTP id y25so844374dad.12
        for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2012 18:40:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFftDdo1Cn9SWXNkkPPQ+_NH73zy+aENCPRdTA-nmpDgQBAfkg@mail.gmail.com>
References: <CAFftDdo1Cn9SWXNkkPPQ+_NH73zy+aENCPRdTA-nmpDgQBAfkg@mail.gmail.com>
Date: Tue, 20 Mar 2012 18:40:54 -0700
Message-ID: <CAFftDdqRJ1huU5EmY6idK_FC+=2jfW4QhsOkr2yz=oLsnVXMpw@mail.gmail.com>
Subject: Re: Maguro SE Manager app crash
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b2edcafd47fda04bbb6e1b7
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b2edcafd47fda04bbb6e1b7
Content-Type: text/plain; charset=ISO-8859-1

Alright I found the problem (it was my mistake), the manifest file changes
included adding a path to device/samsung/tuna which caused my prebuilt
kernel file to overwritten with the default kernel which doesn't have se
linux enabled in the config. Is their any particular reason we don't make
tuna's kernel a selinux enabled kernel and commit that back to the branch?
I know it's not hard to set TARGET_PREBUILT_KERNEL or just cp zImage to
kernel, just wondering what the communities feelings on that are.

On Tue, Mar 20, 2012 at 4:18 PM, William Roberts
<bill.c.roberts@gmail.com>wrote:

> On maguro the SE Manager app crashes, see the logs at the end. Some
> information on the build:
>
> I updated my local manifest file at Noon pacific time.
>
> I kept with the instructions in the repo.
>
> I did a clean build.
>
> My guess is that function  SELinux.getBooleanNames() is returning NULL,
>
> I am debugging it now. Is anyone else having this problem?
>
> D/AndroidRuntime(  566): Shutting down VM
> W/dalvikvm(  566): threadid=1: thread exiting with uncaught exception
> (group=0x40a7b1f8)
> I/bluedroid(  196): bt_enable: ret: -1, errno: 19
> E/AndroidRuntime(  566): FATAL EXCEPTION: main
> E/AndroidRuntime(  566): java.lang.RuntimeException: Unable to start
> activity
> ComponentInfo{com.android.seandroid_manager/com.android.seandroid_manager.SEAndroidManager}:
> java.lang.NullPointerException
> E/AndroidRuntime(  566): at
> android.app.ActivityThread.performLaunchActivity(ActivityThread.java:1956)
> E/AndroidRuntime(  566): at
> android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:1981)
> E/AndroidRuntime(  566): at
> android.app.ActivityThread.access$600(ActivityThread.java:123)
> E/AndroidRuntime(  566): at
> android.app.ActivityThread$H.handleMessage(ActivityThread.java:1147)
> E/AndroidRuntime(  566): at
> android.os.Handler.dispatchMessage(Handler.java:99)
> E/AndroidRuntime(  566): at android.os.Looper.loop(Looper.java:137)
> E/AndroidRuntime(  566): at
> android.app.ActivityThread.main(ActivityThread.java:4424)
> E/AndroidRuntime(  566): at java.lang.reflect.Method.invokeNative(Native
> Method)
> E/AndroidRuntime(  566): at
> java.lang.reflect.Method.invoke(Method.java:511)
> E/AndroidRuntime(  566): at
> com.android.internal.os.ZygoteInit$MethodAndArgsCaller.run(ZygoteInit.java:784)
> E/AndroidRuntime(  566): at
> com.android.internal.os.ZygoteInit.main(ZygoteInit.java:551)
> E/AndroidRuntime(  566): at dalvik.system.NativeStart.main(Native Method)
> E/AndroidRuntime(  566): Caused by: java.lang.NullPointerException
> E/AndroidRuntime(  566): at
> java.util.Arrays$ArrayList.<init>(Arrays.java:38)
> E/AndroidRuntime(  566): at java.util.Arrays.asList(Arrays.java:154)
> E/AndroidRuntime(  566): at
> android.widget.ArrayAdapter.<init>(ArrayAdapter.java:128)
> E/AndroidRuntime(  566): at
> com.android.seandroid_manager.SEAndroidManager$SELinuxBooleanFragment$myBooleanAdapter.<init>(SEAndroidManager.java:76)
> E/AndroidRuntime(  566): at
> com.android.seandroid_manager.SEAndroidManager$SELinuxBooleanFragment.onCreate(SEAndroidManager.java:119)
> E/AndroidRuntime(  566): at
> android.app.FragmentManagerImpl.moveToState(FragmentManager.java:795)
> E/AndroidRuntime(  566): at
> android.app.FragmentManagerImpl.moveToState(FragmentManager.java:1032)
> E/AndroidRuntime(  566): at
> android.app.BackStackRecord.run(BackStackRecord.java:622)
> E/AndroidRuntime(  566): at
> android.app.FragmentManagerImpl.execPendingActions(FragmentManager.java:1382)
> E/AndroidRuntime(  566): at
> android.app.Activity.performStart(Activity.java:4474)
> E/AndroidRuntime(  566): at
> android.app.ActivityThread.performLaunchActivity(ActivityThread.java:1929)
> E/AndroidRuntime(  566): ... 11 more
> W/ActivityManager(  196):   Force finishing activity
> com.android.seandroid_manager/.SEAndroidManager
> W/ActivityManager(  196):   Force finishing activity
> com.android.seandroid_manager/.SEAndroidManager
>
>
>
>
> --
> Respectfully,
>
> William C Roberts
>
>
>


-- 
Respectfully,

William C Roberts

--047d7b2edcafd47fda04bbb6e1b7
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Alright I found the problem (it was my mistake), the manifest file changes =
included adding a path to device/samsung/tuna which=A0caused my prebuilt ke=
rnel file to overwritten with the default kernel which doesn&#39;t have se =
linux enabled in the config. Is their any particular reason we don&#39;t ma=
ke tuna&#39;s kernel a selinux enabled kernel and commit that back to the b=
ranch? I know it&#39;s not hard to set TARGET_PREBUILT_KERNEL or just cp zI=
mage to kernel, just wondering what the communities feelings on that are.<b=
r>
<br><div class=3D"gmail_quote">On Tue, Mar 20, 2012 at 4:18 PM, William Rob=
erts <span dir=3D"ltr">&lt;<a href=3D"mailto:bill.c.roberts@gmail.com">bill=
.c.roberts@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
On maguro the SE Manager app crashes, see the logs at the end. Some informa=
tion on the build:<div><br></div><div>I updated my local manifest file at N=
oon pacific time.</div><div><br></div><div>I kept with the instructions in =
the repo.</div>

<div><br></div><div>I did a clean build.</div><div><br></div><div>My guess =
is that function=A0=A0SELinux.getBooleanNames() is returning NULL,=A0</div>=
<div><br></div><div>I am debugging it now. Is anyone else having this probl=
em?</div>

<div><br></div><div><div>D/AndroidRuntime( =A0566): Shutting down VM</div><=
div>W/dalvikvm( =A0566): threadid=3D1: thread exiting with uncaught excepti=
on (group=3D0x40a7b1f8)</div><div>I/bluedroid( =A0196): bt_enable: ret: -1,=
 errno: 19</div>

<div>E/AndroidRuntime( =A0566): FATAL EXCEPTION: main</div><div>E/AndroidRu=
ntime( =A0566): java.lang.RuntimeException: Unable to start activity Compon=
entInfo{com.android.seandroid_manager/com.android.seandroid_manager.SEAndro=
idManager}: java.lang.NullPointerException</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:1=
956)</div><div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wr=
ap">	</span>at android.app.ActivityThread.handleLaunchActivity(ActivityThre=
ad.java:1981)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.app.ActivityThread.access$600(ActivityThread.java:123)</div><d=
iv>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</span>=
at android.app.ActivityThread$H.handleMessage(ActivityThread.java:1147)</di=
v>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.os.Handler.dispatchMessage(Handler.java:99)</div><div>E/Androi=
dRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</span>at android.=
os.Looper.loop(Looper.java:137)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.app.ActivityThread.main(ActivityThread.java:4424)</div><div>E/=
AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</span>at ja=
va.lang.reflect.Method.invokeNative(Native Method)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at java.lang.reflect.Method.invoke(Method.java:511)</div><div>E/AndroidRu=
ntime( =A0566): <span style=3D"white-space:pre-wrap">	</span>at com.android=
.internal.os.ZygoteInit$MethodAndArgsCaller.run(ZygoteInit.java:784)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at com.android.internal.os.ZygoteInit.main(ZygoteInit.java:551)</div><div=
>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</span>at=
 dalvik.system.NativeStart.main(Native Method)</div>

<div>E/AndroidRuntime( =A0566): Caused by: java.lang.NullPointerException</=
div><div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	<=
/span>at java.util.Arrays$ArrayList.&lt;init&gt;(Arrays.java:38)</div>
<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at java.util.Arrays.asList(Arrays.java:154)</div><div>E/AndroidRuntime( =
=A0566): <span style=3D"white-space:pre-wrap">	</span>at android.widget.Arr=
ayAdapter.&lt;init&gt;(ArrayAdapter.java:128)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at com.android.seandroid_manager.SEAndroidManager$SELinuxBooleanFragment$=
myBooleanAdapter.&lt;init&gt;(SEAndroidManager.java:76)</div>
<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at com.android.seandroid_manager.SEAndroidManager$SELinuxBooleanFragment.=
onCreate(SEAndroidManager.java:119)</div><div>E/AndroidRuntime( =A0566): <s=
pan style=3D"white-space:pre-wrap">	</span>at android.app.FragmentManagerIm=
pl.moveToState(FragmentManager.java:795)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.app.FragmentManagerImpl.moveToState(FragmentManager.java:1032)=
</div><div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">=
	</span>at android.app.BackStackRecord.run(BackStackRecord.java:622)</div>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.app.FragmentManagerImpl.execPendingActions(FragmentManager.jav=
a:1382)</div><div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre=
-wrap">	</span>at android.app.Activity.performStart(Activity.java:4474)</di=
v>

<div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wrap">	</spa=
n>at android.app.ActivityThread.performLaunchActivity(ActivityThread.java:1=
929)</div><div>E/AndroidRuntime( =A0566): <span style=3D"white-space:pre-wr=
ap">	</span>... 11 more</div>

<div>W/ActivityManager( =A0196): =A0 Force finishing activity com.android.s=
eandroid_manager/.SEAndroidManager</div><div>W/ActivityManager( =A0196): =
=A0 Force finishing activity com.android.seandroid_manager/.SEAndroidManage=
r</div>
<span class=3D"HOEnZb"><font color=3D"#888888">
</font></span></div><span class=3D"HOEnZb"><font color=3D"#888888"><div><br=
></div><div><br></div><div><br><div><div><br></div>-- <br>Respectfully,<br>=
<br>William C Roberts<br><br><br>
</div></div>
</font></span></blockquote></div><br><br clear=3D"all"><div><br></div>-- <b=
r>Respectfully,<br><br>William C Roberts<br><br><br>

--047d7b2edcafd47fda04bbb6e1b7--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
