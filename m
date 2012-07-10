Received: from goalie.tycho.ncsc.mil (goalie [144.51.3.250])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id q6ALOxh7020972
	for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 17:24:59 -0400
Received: by pbbrr13 with SMTP id rr13so869602pbb.12
        for <selinux@tycho.nsa.gov>; Tue, 10 Jul 2012 14:24:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1341955378-20471-2-git-send-email-bill.c.roberts@gmail.com>
References: <1341955378-20471-2-git-send-email-bill.c.roberts@gmail.com>
Date: Tue, 10 Jul 2012 14:24:58 -0700
Message-ID: <CAFftDdoiGsZpkLz-Vz3cD5PAUQhjdEra0qn4GKT2S-xGxcgFMw@mail.gmail.com>
Subject: Fwd: [PATCH] Add build property ro.build.selinux when building
From: William Roberts <bill.c.roberts@gmail.com>
To: selinux@tycho.nsa.gov
Content-Type: multipart/alternative; boundary=e89a8ff1bf64c4c4cd04c4805c7d
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

--e89a8ff1bf64c4c4cd04c4805c7d
Content-Type: text/plain; charset=ISO-8859-1

When building with HAVE_SELINUX:=true, this build property will be
added to the systems properties.
---
 core/main.mk |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/core/main.mk b/core/main.mk
index 3d8d6e0..e527160 100644
--- a/core/main.mk
+++ b/core/main.mk
@@ -218,6 +218,10 @@ ifneq ($(filter sdk win_sdk
sdk_addon,$(MAKECMDGOALS)),)
 is_sdk_build := true
 endif

+## have selinux ##
+ifeq ($(HAVE_SELINUX),true)
+ADDITIONAL_BUILD_PROPERTIES += ro.build.selinux=1
+endif # HAVE_SELINUX

 ## user/userdebug ##

--
1.7.0.4




-- 
Respectfully,

William C Roberts

--e89a8ff1bf64c4c4cd04c4805c7d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">When building with HAVE_SELINUX:=3Dtrue, this bu=
ild property will be<br>
added to the systems properties.<br>
---<br>
=A0core/<a href=3D"http://main.mk" target=3D"_blank">main.mk</a> | =A0 =A04=
 ++++<br>
=A01 files changed, 4 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/core/<a href=3D"http://main.mk" target=3D"_blank">main.mk</a> =
b/core/<a href=3D"http://main.mk" target=3D"_blank">main.mk</a><br>
index 3d8d6e0..e527160 100644<br>
--- a/core/<a href=3D"http://main.mk" target=3D"_blank">main.mk</a><br>
+++ b/core/<a href=3D"http://main.mk" target=3D"_blank">main.mk</a><br>
@@ -218,6 +218,10 @@ ifneq ($(filter sdk win_sdk sdk_addon,$(MAKECMDGOALS))=
,)<br>
=A0is_sdk_build :=3D true<br>
=A0endif<br>
<br>
+## have selinux ##<br>
+ifeq ($(HAVE_SELINUX),true)<br>
+ADDITIONAL_BUILD_PROPERTIES +=3D ro.build.selinux=3D1<br>
+endif # HAVE_SELINUX<br>
<br>
=A0## user/userdebug ##<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.7.0.4<br>
<br>
</font></span></div><br><br clear=3D"all"><div><br></div>-- <br>Respectfull=
y,<br><br>William C Roberts<br><br><br>

--e89a8ff1bf64c4c4cd04c4805c7d--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
