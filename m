MIME-Version: 1.0
Date: Wed, 11 Jul 2012 19:05:13 -0700
Message-ID: <CAFftDdqnQXqyDYbAV9ooApg3mCcchyx84sqhnNzx1rNT-VBSYQ@mail.gmail.com>
Subject: [PATCH] libcore2 and dalvik2 in local_manifest.xml
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Content-Type: multipart/alternative; boundary=047d7b10ce79dee0d104c498642b
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce79dee0d104c498642b
Content-Type: text/plain; charset=ISO-8859-1

Previous patch missed libcore being libcore2, this patch addresses dalvik
and libcore being changed to dalvik2 and libcore2

diff --git a/local_manifest.xml b/local_manifest.xml
index 18bbb02..5fea852 100644
--- a/local_manifest.xml
+++ b/local_manifest.xml
@@ -23,10 +23,10 @@
     <copyfile src="core/root.mk" dest="Makefile" />
   </project>

-  <remove-project name="platform/dalvik"/>
+  <remove-project name="platform/dalvik2"/>
   <project path="dalvik" remote="selinuxproject" name="platform/dalvik"
revision="seandroid-4.1.1" />

-  <remove-project name="platform/libcore"/>
+  <remove-project name="platform/libcore2"/>
   <project path="libcore" remote="selinuxproject" name="platform/libcore"
revision="seandroid-4.1.1" />

   <remove-project name="platform/frameworks/base"/>

--047d7b10ce79dee0d104c498642b
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Previous patch missed libcore being libcore2, this patch addresses dalvik a=
nd libcore being changed to dalvik2 and libcore2<div><br></div><div><div>di=
ff --git a/local_manifest.xml b/local_manifest.xml</div><div>index 18bbb02.=
.5fea852 100644</div>
<div>--- a/local_manifest.xml</div><div>+++ b/local_manifest.xml</div><div>=
@@ -23,10 +23,10 @@</div><div>=A0 =A0 =A0&lt;copyfile src=3D&quot;core/<a h=
ref=3D"http://root.mk">root.mk</a>&quot; dest=3D&quot;Makefile&quot; /&gt;<=
/div><div>
=A0 =A0&lt;/project&gt;</div><div>=A0</div><div>- =A0&lt;remove-project nam=
e=3D&quot;platform/dalvik&quot;/&gt;</div><div>+ =A0&lt;remove-project name=
=3D&quot;platform/dalvik2&quot;/&gt;</div><div>=A0 =A0&lt;project path=3D&q=
uot;dalvik&quot; remote=3D&quot;selinuxproject&quot; name=3D&quot;platform/=
dalvik&quot; revision=3D&quot;seandroid-4.1.1&quot; /&gt;</div>
<div>=A0</div><div>- =A0&lt;remove-project name=3D&quot;platform/libcore&qu=
ot;/&gt;</div><div>+ =A0&lt;remove-project name=3D&quot;platform/libcore2&q=
uot;/&gt;</div><div>=A0 =A0&lt;project path=3D&quot;libcore&quot; remote=3D=
&quot;selinuxproject&quot; name=3D&quot;platform/libcore&quot; revision=3D&=
quot;seandroid-4.1.1&quot; /&gt;</div>
<div>=A0</div><div>=A0 =A0&lt;remove-project name=3D&quot;platform/framewor=
ks/base&quot;/&gt;</div><br>
</div>

--047d7b10ce79dee0d104c498642b--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
