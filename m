MIME-Version: 1.0
Date: Wed, 11 Jul 2012 18:46:51 -0700
Message-ID: <CAFftDdrEvkkVwdhgfCjpwFEC+Dh2ZO5OhG9S+a-t-y=TbUHeDw@mail.gmail.com>
Subject: [PATCH] local_manifest.xml for 4.1.1 branch has dalvik instead of dalvik2
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=e89a8ff244cf328e0604c4982398
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff244cf328e0604c4982398
Content-Type: text/plain; charset=ISO-8859-1

This is a fix for dalvik being removed when it should have been dalvik2 on
the local_manifest 4.1.1 branch

diff --git a/local_manifest.xml b/local_manifest.xml
index 18bbb02..530dc02 100644
--- a/local_manifest.xml
+++ b/local_manifest.xml
@@ -23,7 +23,7 @@
     <copyfile src="core/root.mk" dest="Makefile" />
   </project>

-  <remove-project name="platform/dalvik"/>
+  <remove-project name="platform/dalvik2"/>
   <project path="dalvik" remote="selinuxproject" name="platform/dalvik"
revision="seandroid-4.1.1" />

   <remove-project name="platform/libcore"/>

-- 
Respectfully,

William C Roberts

--e89a8ff244cf328e0604c4982398
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>This is a fix for dalvik being removed when it should have been dalvik=
2 on the local_manifest 4.1.1 branch</div><div><br></div><div>diff --git a/=
local_manifest.xml b/local_manifest.xml</div><div>index 18bbb02..530dc02 10=
0644</div>
<div>--- a/local_manifest.xml</div><div>+++ b/local_manifest.xml</div><div>=
@@ -23,7 +23,7 @@</div><div>=A0 =A0 =A0&lt;copyfile src=3D&quot;core/<a hre=
f=3D"http://root.mk">root.mk</a>&quot; dest=3D&quot;Makefile&quot; /&gt;</d=
iv><div>
=A0 =A0&lt;/project&gt;</div><div>=A0</div><div>- =A0&lt;remove-project nam=
e=3D&quot;platform/dalvik&quot;/&gt;</div><div>+ =A0&lt;remove-project name=
=3D&quot;platform/dalvik2&quot;/&gt;</div><div>=A0 =A0&lt;project path=3D&q=
uot;dalvik&quot; remote=3D&quot;selinuxproject&quot; name=3D&quot;platform/=
dalvik&quot; revision=3D&quot;seandroid-4.1.1&quot; /&gt;</div>
<div>=A0</div><div>=A0 =A0&lt;remove-project name=3D&quot;platform/libcore&=
quot;/&gt;</div><div><br></div>-- <br>Respectfully,<br><br>William C Robert=
s<br><br><br>

--e89a8ff244cf328e0604c4982398--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
