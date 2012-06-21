Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q5LInRZg015615
	for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2012 14:49:27 -0400
Received: by pbbrr13 with SMTP id rr13so2509237pbb.12
        for <selinux@tycho.nsa.gov>; Thu, 21 Jun 2012 11:49:25 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 21 Jun 2012 11:49:25 -0700
Message-ID: <CAFftDdq=pKM7zheXbV=ONnbJ90TFVSQL-Uk6S2J3diyfT6=nUw@mail.gmail.com>
Subject: AOSP commit 0cd29e3a3268f99ef0cb72a51782a35f407de1ae to manifests
 cause failure
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=047d7b10ce63873c6204c2fff9a2
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce63873c6204c2fff9a2
Content-Type: text/plain; charset=ISO-8859-1

Commit 0cd29e3a3268f99ef0cb72a51782a35f407de1ae in the manifest for AOSP
changed dalvik to dalvik2, not sure how you guys are managing this switch
but it broke the build. Currently I set my head back by one on the manifest
to work around this.

See the below info for the details:

hqjiang@sta-hqjiang:~/seandroid$ repo sync -j1
Traceback (most recent call last):
  File "/home/hqjiang/seandroid/.repo/repo/main.py", line 385, in <module>
    _Main(sys.argv[1:])
  File "/home/hqjiang/seandroid/.repo/repo/main.py", line 365, in _Main
    result = repo._Run(argv) or 0
  File "/home/hqjiang/seandroid/.repo/repo/main.py", line 121, in _Run
    copts, cargs = cmd.OptionParser.parse_args(argv)
  File "/home/hqjiang/seandroid/.repo/repo/command.py", line 45, in
OptionParser
    self._Options(self._optparse)
  File "/home/hqjiang/seandroid/.repo/repo/subcmds/sync.py", line 126, in
_Options
    self.jobs = self.manifest.default.sync_j
  File "/home/hqjiang/seandroid/.repo/repo/manifest_xml.py", line 245, in
default
    self._Load()
  File "/home/hqjiang/seandroid/.repo/repo/manifest_xml.py", line 293, in
_Load
    self._ParseManifest(nodes)
  File "/home/hqjiang/seandroid/.repo/repo/manifest_xml.py", line 405, in
_ParseManifest
    (name))
error.ManifestParseError: project platform/dalvik not found
hqjiang@sta-hqjiang:~/seandroid$
hqjiang@sta-hqjiang:~/seandroid$
hqjiang@sta-hqjiang:~/seandroid$
hqjiang@sta-hqjiang:~/seandroid$ cd .repo/
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$ grep dalvik *
local_manifest.xml:  <remove-project name="platform/dalvik"/>
local_manifest.xml:  <project path="dalvik" remote="selinuxproject"
name="platform/dalvik" revision="seandroid" />
manifest.xml:  <project path="dalvik" name="platform/dalvik2" />
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$ cd manifests.git/
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$ ls
branches  config  description  FETCH_HEAD  HEAD  hooks  info  logs  objects
 packed-refs  refs  rr-cache
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$ git log
fatal: bad default revision 'HEAD'
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$ cd ..
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$
hqjiang@sta-hqjiang:~/seandroid/.repo$ cd manifests
manifests/     manifests.git/
hqjiang@sta-hqjiang:~/seandroid/.repo$ cd manifests
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$ git log
commit 0cd29e3a3268f99ef0cb72a51782a35f407de1ae
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Thu Jun 21 10:20:14 2012 -0700

    Switch to snapshots for dalvik and libcore

commit b5a0d13b2f49a9fb5e2ae619331c5e6f17c8f46e
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Wed Jun 13 18:01:59 2012 -0700

    Add chromium-trace

commit 00ece54b1be0831140102c453d2e108bbd2072ec
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Fri May 18 11:13:34 2012 -0700

    Remove i686-android-linux-4.4.3 toolchain

commit 8c70177169eab0247227667fb1d318f770617a68
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Mon May 14 15:14:53 2012 -0700

    Add ant-glob

commit 03fc9565bbe48f8a74cb8333f31febf8f228b138
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Mon Apr 30 15:48:17 2012 -0700

    Add prebuilts/misc

commit 8f95dff32fcbe4287582bb481de67e210ae158bd
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Thu Apr 26 14:14:23 2012 -0700

    Switch to the proper location of IA 4.6 toolchain

commit e56e10bfa2344561c5b4d0f65661d0e65742e622
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Tue Apr 24 14:21:39 2012 -0700

    Add 4.6 toolchains

commit 527678f04df1205ddf229cd114d978fa63130f73
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Fri Apr 20 14:29:22 2012 -0700

    Add new toolchains

commit 23f0e7830de760d2a907fbf4ede543042df41beb
Author: The Android Open Source Project <initial-contribution@android.com>
Date:   Thu Apr 19 10:41:14 2012 -0700

    Add prebuilts/eclipse
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$
hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$ git diff HEAD^1
diff --git a/default.xml b/default.xml
index c8769eb..54d9d8d 100644
--- a/default.xml
+++ b/default.xml
@@ -17,7 +17,7 @@
   <project path="bootable/diskinstaller"
name="platform/bootable/diskinstaller" />
   <project path="bootable/recovery" name="platform/bootable/recovery" />
   <project path="cts" name="platform/cts" />
-  <project path="dalvik" name="platform/dalvik" />
+  <project path="dalvik" name="platform/dalvik2" />
   <project path="development" name="platform/development" />
   <project path="device/common" name="device/common" />
   <project path="device/generic/goldfish" name="device/generic/goldfish" />
@@ -191,7 +191,7 @@
   <project path="hardware/ti/omap4xxx"
name="platform/hardware/ti/omap4xxx" />
   <project path="hardware/ti/wlan" name="platform/hardware/ti/wlan" />
   <project path="hardware/ti/wpan" name="platform/hardware/ti/wpan" />
-  <project path="libcore" name="platform/libcore" />
+  <project path="libcore" name="platform/libcore2" />
   <project path="ndk" name="platform/ndk" />
   <project path="packages/apps/BasicSmsReceiver"
name="platform/packages/apps/BasicSmsReceiver" />
   <project path="packages/apps/Bluetooth"
name="platform/packages/apps/Bluetooth" />

-- 
Respectfully,

William C Roberts

--047d7b10ce63873c6204c2fff9a2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style>Commit=A00cd29e3a3268f99ef0cb72a51782a35f407de1ae in the manifes=
t for AOSP changed dalvik to dalvik2, not sure how you guys are managing th=
is switch but it broke the build. Currently I set my head back by one on th=
e manifest to work around this.</div>
<div style><br></div><div style>See the below info for the details:</div><d=
iv style><br></div><div style>hqjiang@sta-hqjiang:~/seandroid$ repo sync -j=
1</div><div style>Traceback (most recent call last):</div><div style>=A0 Fi=
le &quot;/home/hqjiang/seandroid/.repo/repo/main.py&quot;, line 385, in &lt=
;module&gt;</div>
<div style>=A0 =A0 _Main(sys.argv[1:])</div><div style>=A0 File &quot;/home=
/hqjiang/seandroid/.repo/repo/main.py&quot;, line 365, in _Main</div><div s=
tyle>=A0 =A0 result =3D repo._Run(argv) or 0</div><div style>=A0 File &quot=
;/home/hqjiang/seandroid/.repo/repo/main.py&quot;, line 121, in _Run</div>
<div style>=A0 =A0 copts, cargs =3D cmd.OptionParser.parse_args(argv)</div>=
<div style>=A0 File &quot;/home/hqjiang/seandroid/.repo/repo/command.py&quo=
t;, line 45, in OptionParser</div><div style>=A0 =A0 self._Options(self._op=
tparse)</div>
<div style>=A0 File &quot;/home/hqjiang/seandroid/.repo/repo/subcmds/sync.p=
y&quot;, line 126, in _Options</div><div style>=A0 =A0=A0<a href=3D"http://=
self.jobs/" target=3D"_blank" style=3D"color:rgb(17,85,204)">self.jobs</a>=
=A0=3D self.manifest.default.sync_j</div>
<div style>=A0 File &quot;/home/hqjiang/seandroid/.repo/repo/manifest_xml.p=
y&quot;, line 245, in default</div><div style>=A0 =A0 self._Load()</div><di=
v style>=A0 File &quot;/home/hqjiang/seandroid/.repo/repo/manifest_xml.py&q=
uot;, line 293, in _Load</div>
<div style>=A0 =A0 self._ParseManifest(nodes)</div><div style>=A0 File &quo=
t;/home/hqjiang/seandroid/.repo/repo/manifest_xml.py&quot;, line 405, in _P=
arseManifest</div><div style>=A0 =A0 (name))</div><div style>error.Manifest=
ParseError: project platform/dalvik not found</div>
<div style>hqjiang@sta-hqjiang:~/seandroid$=A0</div><div style>hqjiang@sta-=
hqjiang:~/seandroid$=A0</div><div style>hqjiang@sta-hqjiang:~/seandroid$=A0=
</div><div style>hqjiang@sta-hqjiang:~/seandroid$ cd .repo/</div><div style=
>hqjiang@sta-hqjiang:~/seandroid/.repo$=A0</div>
<div style>hqjiang@sta-hqjiang:~/seandroid/.repo$ grep dalvik *</div><div s=
tyle>local_manifest.xml: =A0&lt;remove-project name=3D&quot;platform/dalvik=
&quot;/&gt;</div><div style>local_manifest.xml: =A0&lt;project path=3D&quot=
;dalvik&quot; remote=3D&quot;selinuxproject&quot; name=3D&quot;platform/dal=
vik&quot; revision=3D&quot;seandroid&quot; /&gt;</div>
<div style>manifest.xml: =A0&lt;project path=3D&quot;dalvik&quot; name=3D&q=
uot;platform/dalvik2&quot; /&gt;</div><div style>hqjiang@sta-hqjiang:~/sean=
droid/.repo$=A0</div><div style>hqjiang@sta-hqjiang:~/seandroid/.repo$=A0</=
div><div style>
hqjiang@sta-hqjiang:~/seandroid/.repo$=A0</div><div style>hqjiang@sta-hqjia=
ng:~/seandroid/.repo$=A0</div><div style>hqjiang@sta-hqjiang:~/seandroid/.r=
epo$ cd manifests.git/</div><div style>hqjiang@sta-hqjiang:~/seandroid/.rep=
o/manifests.git$ ls</div>
<div style>branches =A0config =A0description =A0FETCH_HEAD =A0HEAD =A0hooks=
 =A0info =A0logs =A0objects =A0packed-refs =A0refs =A0rr-cache</div><div st=
yle>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$=A0</div><div style=
>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$=A0</div>
<div style>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$=A0</div><di=
v style>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$ git log</div><=
div style>fatal: bad default revision &#39;HEAD&#39;</div><div style>hqjian=
g@sta-hqjiang:~/seandroid/.repo/manifests.git$=A0</div>
<div style>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$=A0</div><di=
v style>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$=A0</div><div s=
tyle>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests.git$ cd ..</div><div s=
tyle>
hqjiang@sta-hqjiang:~/seandroid/.repo$=A0</div><div style>hqjiang@sta-hqjia=
ng:~/seandroid/.repo$=A0</div><div style>hqjiang@sta-hqjiang:~/seandroid/.r=
epo$ cd manifests</div><div style>manifests/ =A0 =A0 manifests.git/=A0</div=
><div style>
hqjiang@sta-hqjiang:~/seandroid/.repo$ cd manifests</div><div style>hqjiang=
@sta-hqjiang:~/seandroid/.repo/manifests$=A0</div><div style>hqjiang@sta-hq=
jiang:~/seandroid/.repo/manifests$=A0</div><div style>hqjiang@sta-hqjiang:~=
/seandroid/.repo/manifests$ git log</div>
<div style>commit 0cd29e3a3268f99ef0cb72a51782a35f407de1ae</div><div style>=
Author: The Android Open Source Project &lt;<a href=3D"mailto:initial-contr=
ibution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,204)">initi=
al-contribution@android.com</a>&gt;</div>
<div style>Date: =A0 Thu Jun 21 10:20:14 2012 -0700</div><div style><br></d=
iv><div style>=A0 =A0 Switch to snapshots for dalvik and libcore</div><div =
style><br></div><div style>commit b5a0d13b2f49a9fb5e2ae619331c5e6f17c8f46e<=
/div>
<div style>Author: The Android Open Source Project &lt;<a href=3D"mailto:in=
itial-contribution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,=
204)">initial-contribution@android.com</a>&gt;</div><div style>Date: =A0 We=
d Jun 13 18:01:59 2012 -0700</div>
<div style><br></div><div style>=A0 =A0 Add chromium-trace</div><div style>=
<br></div><div style>commit 00ece54b1be0831140102c453d2e108bbd2072ec</div><=
div style>Author: The Android Open Source Project &lt;<a href=3D"mailto:ini=
tial-contribution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,2=
04)">initial-contribution@android.com</a>&gt;</div>
<div style>Date: =A0 Fri May 18 11:13:34 2012 -0700</div><div style><br></d=
iv><div style>=A0 =A0 Remove i686-android-linux-4.4.3 toolchain</div><div s=
tyle><br></div><div style>commit 8c70177169eab0247227667fb1d318f770617a68</=
div>
<div style>Author: The Android Open Source Project &lt;<a href=3D"mailto:in=
itial-contribution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,=
204)">initial-contribution@android.com</a>&gt;</div><div style>Date: =A0 Mo=
n May 14 15:14:53 2012 -0700</div>
<div style><br></div><div style>=A0 =A0 Add ant-glob</div><div style><br></=
div><div style>commit 03fc9565bbe48f8a74cb8333f31febf8f228b138</div><div st=
yle>Author: The Android Open Source Project &lt;<a href=3D"mailto:initial-c=
ontribution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,204)">i=
nitial-contribution@android.com</a>&gt;</div>
<div style>Date: =A0 Mon Apr 30 15:48:17 2012 -0700</div><div style><br></d=
iv><div style>=A0 =A0 Add prebuilts/misc</div><div style><br></div><div sty=
le>commit 8f95dff32fcbe4287582bb481de67e210ae158bd</div><div style>Author: =
The Android Open Source Project &lt;<a href=3D"mailto:initial-contribution@=
android.com" target=3D"_blank" style=3D"color:rgb(17,85,204)">initial-contr=
ibution@android.com</a>&gt;</div>
<div style>Date: =A0 Thu Apr 26 14:14:23 2012 -0700</div><div style><br></d=
iv><div style>=A0 =A0 Switch to the proper location of IA 4.6 toolchain</di=
v><div style><br></div><div style>commit e56e10bfa2344561c5b4d0f65661d0e657=
42e622</div>
<div style>Author: The Android Open Source Project &lt;<a href=3D"mailto:in=
itial-contribution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,=
204)">initial-contribution@android.com</a>&gt;</div><div style>Date: =A0 Tu=
e Apr 24 14:21:39 2012 -0700</div>
<div style><br></div><div style>=A0 =A0 Add 4.6 toolchains</div><div style>=
<br></div><div style>commit 527678f04df1205ddf229cd114d978fa63130f73</div><=
div style>Author: The Android Open Source Project &lt;<a href=3D"mailto:ini=
tial-contribution@android.com" target=3D"_blank" style=3D"color:rgb(17,85,2=
04)">initial-contribution@android.com</a>&gt;</div>
<div style>Date: =A0 Fri Apr 20 14:29:22 2012 -0700</div><div style><br></d=
iv><div style>=A0 =A0 Add new toolchains</div><div style><br></div><div sty=
le>commit 23f0e7830de760d2a907fbf4ede543042df41beb</div><div style>Author: =
The Android Open Source Project &lt;<a href=3D"mailto:initial-contribution@=
android.com" target=3D"_blank" style=3D"color:rgb(17,85,204)">initial-contr=
ibution@android.com</a>&gt;</div>
<div style>Date: =A0 Thu Apr 19 10:41:14 2012 -0700</div><div style><br></d=
iv><div style>=A0 =A0 Add prebuilts/eclipse</div><div style>hqjiang@sta-hqj=
iang:~/seandroid/.repo/manifests$=A0</div><div style>hqjiang@sta-hqjiang:~/=
seandroid/.repo/manifests$=A0</div>
<div style>hqjiang@sta-hqjiang:~/seandroid/.repo/manifests$ git diff HEAD^1=
</div><div style>diff --git a/default.xml b/default.xml</div><div style>ind=
ex c8769eb..54d9d8d 100644</div><div style>--- a/default.xml</div><div styl=
e>
+++ b/default.xml</div><div style>@@ -17,7 +17,7 @@</div><div style>=A0 =A0=
&lt;project path=3D&quot;bootable/diskinstaller&quot; name=3D&quot;platform=
/bootable/diskinstaller&quot; /&gt;</div><div style>=A0 =A0&lt;project path=
=3D&quot;bootable/recovery&quot; name=3D&quot;platform/bootable/recovery&qu=
ot; /&gt;</div>
<div style>=A0 =A0&lt;project path=3D&quot;cts&quot; name=3D&quot;platform/=
cts&quot; /&gt;</div><div style>- =A0&lt;project path=3D&quot;dalvik&quot; =
name=3D&quot;platform/dalvik&quot; /&gt;</div><div style>+ =A0&lt;project p=
ath=3D&quot;dalvik&quot; name=3D&quot;platform/dalvik2&quot; /&gt;</div>
<div style>=A0 =A0&lt;project path=3D&quot;development&quot; name=3D&quot;p=
latform/development&quot; /&gt;</div><div style>=A0 =A0&lt;project path=3D&=
quot;device/common&quot; name=3D&quot;device/common&quot; /&gt;</div><div s=
tyle>=A0 =A0&lt;project path=3D&quot;device/generic/goldfish&quot; name=3D&=
quot;device/generic/goldfish&quot; /&gt;</div>
<div style>@@ -191,7 +191,7 @@</div><div style>=A0 =A0&lt;project path=3D&q=
uot;hardware/ti/omap4xxx&quot; name=3D&quot;platform/hardware/ti/omap4xxx&q=
uot; /&gt;</div><div style>=A0 =A0&lt;project path=3D&quot;hardware/ti/wlan=
&quot; name=3D&quot;platform/hardware/ti/wlan&quot; /&gt;</div>
<div style>=A0 =A0&lt;project path=3D&quot;hardware/ti/wpan&quot; name=3D&q=
uot;platform/hardware/ti/wpan&quot; /&gt;</div><div style>- =A0&lt;project =
path=3D&quot;libcore&quot; name=3D&quot;platform/libcore&quot; /&gt;</div><=
div style>
+ =A0&lt;project path=3D&quot;libcore&quot; name=3D&quot;platform/libcore2&=
quot; /&gt;</div><div style>=A0 =A0&lt;project path=3D&quot;ndk&quot; name=
=3D&quot;platform/ndk&quot; /&gt;</div><div style>=A0 =A0&lt;project path=
=3D&quot;packages/apps/BasicSmsReceiver&quot; name=3D&quot;platform/package=
s/apps/BasicSmsReceiver&quot; /&gt;</div>
<div style>=A0 =A0&lt;project path=3D&quot;packages/apps/Bluetooth&quot; na=
me=3D&quot;platform/packages/apps/Bluetooth&quot; /&gt;</div><div><br></div=
>-- <br>Respectfully,<br><br>William C Roberts<br><br><br>

--047d7b10ce63873c6204c2fff9a2--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
