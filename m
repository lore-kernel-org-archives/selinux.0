Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6ANnOcr026853
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 19:49:24 -0400
Received: by pbbrr13 with SMTP id rr13so1040860pbb.12
        for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 16:49:17 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Jul 2012 16:49:17 -0700
Message-ID: <CAFftDdo=pXiZQjTNi=EpqqrEd6i4U0Gf3G8kw57wmBmYjT+HdA@mail.gmail.com>
Subject: Adding support for ro.build.selinux to Android.os.SELinux
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Cc: rpcraig <rpcraig@tycho.ncsc.mil>
Content-Type: multipart/alternative; boundary=047d7b10ce63ec9fb604c48260e8
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--047d7b10ce63ec9fb604c48260e8
Content-Type: text/plain; charset=ISO-8859-1

Wasn't sure if we wanted to move away from going through a JNI binding
since we now have access to ro.build.selinux.

This is some rough draft code, didn't know if we wanted to replace
SELinux.isSELinuxEnabled() or augment another function for it.

Please advise.

Bill

diff --git a/core/java/android/os/SELinux.java
b/core/java/android/os/SELinux.java
index 0ad24b7..59ae38b 100644
--- a/core/java/android/os/SELinux.java
+++ b/core/java/android/os/SELinux.java
@@ -109,4 +109,19 @@ public class SELinux {
      * @return a boolean indicating whether the relabeling succeeded.
      */
     public static final native boolean restorecon(String pathname);
+
+
+    /**
+     * Determines if the platform was built with SELinux Support.
+     * @return a boolean indicating whether or not the system was
+     * built with HAVE_SELINUX:=true.
+     */
+    public static final boolean isSystemSupported() {
+
+        Properties props = new Properties();
+        String selinuxStatus = props.getProperty("ro.build.selinux");
+
+        return selinuxStatus.equals("1") ? true : false;
+    }
+
 }



-- 
Respectfully,

William C Roberts

--047d7b10ce63ec9fb604c48260e8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div><div>Wasn&#39;t sure if we wanted to move away from going through a JN=
I binding since we now have access to ro.build.selinux.</div><div><br></div=
><div>This is some rough draft code, didn&#39;t know if we wanted to replac=
e SELinux.isSELinuxEnabled() or augment another function for it.</div>
<div><br></div><div>Please advise.</div><div><br></div><div>Bill</div><div>=
<br></div><div>diff --git a/core/java/android/os/SELinux.java b/core/java/a=
ndroid/os/SELinux.java</div><div>index 0ad24b7..59ae38b 100644</div><div>
--- a/core/java/android/os/SELinux.java</div><div>+++ b/core/java/android/o=
s/SELinux.java</div><div>@@ -109,4 +109,19 @@ public class SELinux {</div><=
div>=A0 =A0 =A0 * @return a boolean indicating whether the relabeling succe=
eded.</div>
<div>=A0 =A0 =A0 */</div><div>=A0 =A0 =A0public static final native boolean=
 restorecon(String pathname);</div><div>+</div><div>+</div><div>+ =A0 =A0/*=
*</div><div>+ =A0 =A0 * Determines if the platform was built with SELinux S=
upport.</div><div>
+ =A0 =A0 * @return a boolean indicating whether or not the system was</div=
><div>+ =A0 =A0 * built with HAVE_SELINUX:=3Dtrue.</div><div>+ =A0 =A0 */</=
div><div>+ =A0 =A0public static final boolean isSystemSupported() {</div><d=
iv>+</div><div>
+ =A0 =A0 =A0 =A0Properties props =3D new Properties();</div><div>+ =A0 =A0=
 =A0 =A0String selinuxStatus =3D props.getProperty(&quot;ro.build.selinux&q=
uot;);</div><div>+</div><div>+ =A0 =A0 =A0 =A0return selinuxStatus.equals(&=
quot;1&quot;) ? true : false;</div>
<div>+ =A0 =A0}</div><div>+</div><div>=A0}</div></div><div><br></div><div><=
br></div><div><br></div>-- <br>Respectfully,<br><br>William C Roberts<br><b=
r><br>

--047d7b10ce63ec9fb604c48260e8--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
