Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q2KNIetO010846
	for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2012 19:18:40 -0400
Received: by pbcuo1 with SMTP id uo1so393942pbc.12
        for <selinux@tycho.nsa.gov>; Tue, 20 Mar 2012 16:18:38 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 20 Mar 2012 16:18:38 -0700
Message-ID: <CAFftDdo1Cn9SWXNkkPPQ+_NH73zy+aENCPRdTA-nmpDgQBAfkg@mail.gmail.com>
Subject: Maguro SE Manager app crash
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff1c12c15698204bbb4e5ad
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff1c12c15698204bbb4e5ad
Content-Type: text/plain; charset=ISO-8859-1

On maguro the SE Manager app crashes, see the logs at the end. Some
information on the build:

I updated my local manifest file at Noon pacific time.

I kept with the instructions in the repo.

I did a clean build.

My guess is that function  SELinux.getBooleanNames() is returning NULL,

I am debugging it now. Is anyone else having this problem?

D/AndroidRuntime(  566): Shutting down VM
W/dalvikvm(  566): threadid=1: thread exiting with uncaught exception
(group=0x40a7b1f8)
I/bluedroid(  196): bt_enable: ret: -1, errno: 19
E/AndroidRuntime(  566): FATAL EXCEPTION: main
E/AndroidRuntime(  566): java.lang.RuntimeException: Unable to start
activity
ComponentInfo{com.android.seandroid_manager/com.android.seandroid_manager.SEAndroidManager}:
java.lang.NullPointerException
E/AndroidRuntime(  566): at
android.app.ActivityThread.performLaunchActivity(ActivityThread.java:1956)
E/AndroidRuntime(  566): at
android.app.ActivityThread.handleLaunchActivity(ActivityThread.java:1981)
E/AndroidRuntime(  566): at
android.app.ActivityThread.access$600(ActivityThread.java:123)
E/AndroidRuntime(  566): at
android.app.ActivityThread$H.handleMessage(ActivityThread.java:1147)
E/AndroidRuntime(  566): at
android.os.Handler.dispatchMessage(Handler.java:99)
E/AndroidRuntime(  566): at android.os.Looper.loop(Looper.java:137)
E/AndroidRuntime(  566): at
android.app.ActivityThread.main(ActivityThread.java:4424)
E/AndroidRuntime(  566): at java.lang.reflect.Method.invokeNative(Native
Method)
E/AndroidRuntime(  566): at java.lang.reflect.Method.invoke(Method.java:511)
E/AndroidRuntime(  566): at
com.android.internal.os.ZygoteInit$MethodAndArgsCaller.run(ZygoteInit.java:784)
E/AndroidRuntime(  566): at
com.android.internal.os.ZygoteInit.main(ZygoteInit.java:551)
E/AndroidRuntime(  566): at dalvik.system.NativeStart.main(Native Method)
E/AndroidRuntime(  566): Caused by: java.lang.NullPointerException
E/AndroidRuntime(  566): at
java.util.Arrays$ArrayList.<init>(Arrays.java:38)
E/AndroidRuntime(  566): at java.util.Arrays.asList(Arrays.java:154)
E/AndroidRuntime(  566): at
android.widget.ArrayAdapter.<init>(ArrayAdapter.java:128)
E/AndroidRuntime(  566): at
com.android.seandroid_manager.SEAndroidManager$SELinuxBooleanFragment$myBooleanAdapter.<init>(SEAndroidManager.java:76)
E/AndroidRuntime(  566): at
com.android.seandroid_manager.SEAndroidManager$SELinuxBooleanFragment.onCreate(SEAndroidManager.java:119)
E/AndroidRuntime(  566): at
android.app.FragmentManagerImpl.moveToState(FragmentManager.java:795)
E/AndroidRuntime(  566): at
android.app.FragmentManagerImpl.moveToState(FragmentManager.java:1032)
E/AndroidRuntime(  566): at
android.app.BackStackRecord.run(BackStackRecord.java:622)
E/AndroidRuntime(  566): at
android.app.FragmentManagerImpl.execPendingActions(FragmentManager.java:1382)
E/AndroidRuntime(  566): at
android.app.Activity.performStart(Activity.java:4474)
E/AndroidRuntime(  566): at
android.app.ActivityThread.performLaunchActivity(ActivityThread.java:1929)
E/AndroidRuntime(  566): ... 11 more
W/ActivityManager(  196):   Force finishing activity
com.android.seandroid_manager/.SEAndroidManager
W/ActivityManager(  196):   Force finishing activity
com.android.seandroid_manager/.SEAndroidManager




-- 
Respectfully,

William C Roberts

--e89a8ff1c12c15698204bbb4e5ad
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

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
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.app.ActivityThread.performLaunchActivity(A=
ctivityThread.java:1956)</div><div>E/AndroidRuntime( =A0566): <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>at android.app.Activi=
tyThread.handleLaunchActivity(ActivityThread.java:1981)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.app.ActivityThread.access$600(ActivityThre=
ad.java:123)</div><div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-=
span" style=3D"white-space:pre">	</span>at android.app.ActivityThread$H.han=
dleMessage(ActivityThread.java:1147)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.os.Handler.dispatchMessage(Handler.java:99=
)</div><div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=
=3D"white-space:pre">	</span>at android.os.Looper.loop(Looper.java:137)</di=
v>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.app.ActivityThread.main(ActivityThread.jav=
a:4424)</div><div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span"=
 style=3D"white-space:pre">	</span>at java.lang.reflect.Method.invokeNative=
(Native Method)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at java.lang.reflect.Method.invoke(Method.java:511)</=
div><div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>at com.android.internal.os.ZygoteInit$MethodAndAr=
gsCaller.run(ZygoteInit.java:784)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at com.android.internal.os.ZygoteInit.main(ZygoteInit=
.java:551)</div><div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-sp=
an" style=3D"white-space:pre">	</span>at dalvik.system.NativeStart.main(Nat=
ive Method)</div>
<div>E/AndroidRuntime( =A0566): Caused by: java.lang.NullPointerException</=
div><div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D=
"white-space:pre">	</span>at java.util.Arrays$ArrayList.&lt;init&gt;(Arrays=
.java:38)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at java.util.Arrays.asList(Arrays.java:154)</div><div=
>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"white-s=
pace:pre">	</span>at android.widget.ArrayAdapter.&lt;init&gt;(ArrayAdapter.=
java:128)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at com.android.seandroid_manager.SEAndroidManager$SEL=
inuxBooleanFragment$myBooleanAdapter.&lt;init&gt;(SEAndroidManager.java:76)=
</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at com.android.seandroid_manager.SEAndroidManager$SEL=
inuxBooleanFragment.onCreate(SEAndroidManager.java:119)</div><div>E/Android=
Runtime( =A0566): <span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span>at android.app.FragmentManagerImpl.moveToState(FragmentManager.java=
:795)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.app.FragmentManagerImpl.moveToState(Fragme=
ntManager.java:1032)</div><div>E/AndroidRuntime( =A0566): <span class=3D"Ap=
ple-tab-span" style=3D"white-space:pre">	</span>at android.app.BackStackRec=
ord.run(BackStackRecord.java:622)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.app.FragmentManagerImpl.execPendingActions=
(FragmentManager.java:1382)</div><div>E/AndroidRuntime( =A0566): <span clas=
s=3D"Apple-tab-span" style=3D"white-space:pre">	</span>at android.app.Activ=
ity.performStart(Activity.java:4474)</div>
<div>E/AndroidRuntime( =A0566): <span class=3D"Apple-tab-span" style=3D"whi=
te-space:pre">	</span>at android.app.ActivityThread.performLaunchActivity(A=
ctivityThread.java:1929)</div><div>E/AndroidRuntime( =A0566): <span class=
=3D"Apple-tab-span" style=3D"white-space:pre">	</span>... 11 more</div>
<div>W/ActivityManager( =A0196): =A0 Force finishing activity com.android.s=
eandroid_manager/.SEAndroidManager</div><div>W/ActivityManager( =A0196): =
=A0 Force finishing activity com.android.seandroid_manager/.SEAndroidManage=
r</div>
</div><div><br></div><div><br></div><div><br><div><div><br></div>-- <br>Res=
pectfully,<br><br>William C Roberts<br><br><br>
</div></div>

--e89a8ff1c12c15698204bbb4e5ad--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
