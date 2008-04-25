Received: from mummy.ncsc.mil (mummy.ncsc.mil [144.51.88.129])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3PExdAl016043
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 10:59:39 -0400
Received: from fg-out-1718.google.com (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m3PExYTG004171
	for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 14:59:34 GMT
Received: by fg-out-1718.google.com with SMTP id 16so3232920fgg.40
        for <selinux@tycho.nsa.gov>; Fri, 25 Apr 2008 07:59:33 -0700 (PDT)
Message-ID: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>
Date: Fri, 25 Apr 2008 08:07:52 -0500
From: "Xavier Toth" <txtoth@gmail.com>
To: "SE Linux" <selinux@tycho.nsa.gov>, "Eamon Walsh" <ewalsh@tycho.nsa.gov>,
        "Christopher J. PeBenito" <cpebenito@tresys.com>
Subject: copy/paste policy patch
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_1698_30447241.1209128872473"
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

------=_Part_1698_30447241.1209128872473
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here's a patch I'm using with an MLS version of glipper to give the
capability to check for dominance between copy and paste data contexts.
Hopefully some version of this can be upstreamed.

--- serefpolicy-3.3.1/policy/flask/access_vectors       2008-04-08
13:41:18.000000000 -0500
+++ serefpolicy-3.3.1.new//policy/flask/access_vectors  2008-04-08
13:35:43.000000000 -0500
@@ -765,3 +765,10 @@
 {
        recv
 }
+
+class x_application_data
+{
+        paste
+        paste_without_confirm
+        copy
+}
--- serefpolicy-3.3.1/policy/flask/security_classes     2008-04-08
13:41:18.000000000 -0500
+++ serefpolicy-3.3.1.new//policy/flask/security_classes        2008-04-08
13:34:36.000000000 -0500
@@ -114,5 +114,6 @@
 class x_resource               # userspace
 class x_event                  # userspace
 class x_synthetic_event                # userspace
+class x_application_data        # userspace

 # FLASK
--- serefpolicy-3.3.1/policy/mls        2008-04-08 13:41:18.000000000 -0500
+++ serefpolicy-3.3.1.new/policy/mls    2008-04-08 14:20:49.000000000 -0500
@@ -567,6 +567,12 @@
         ( t1 == mlsxwinwritexinput ) or
         ( t1 == mlsxwinwrite ));

+#
+# MLS policy for the x_application_data class
+#
+mlsconstrain x_application_data { paste_without_confirm }
+       ( l1 domby l2 );
+

 #
 # MLS policy for the pax class

------=_Part_1698_30447241.1209128872473
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here&#39;s a patch I&#39;m using with an MLS version of glipper to give the capability to check for dominance between copy and paste data contexts. Hopefully some version of this can be upstreamed.<br><br>--- serefpolicy-3.3.1/policy/flask/access_vectors&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-04-08 13:41:18.000000000 -0500<br>
+++ serefpolicy-3.3.1.new//policy/flask/access_vectors&nbsp; 2008-04-08 13:35:43.000000000 -0500<br>@@ -765,3 +765,10 @@<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; recv<br>&nbsp;}<br>+<br>+class x_application_data <br>+{<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; paste<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; paste_without_confirm<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; copy<br>+}<br>--- serefpolicy-3.3.1/policy/flask/security_classes&nbsp;&nbsp;&nbsp;&nbsp; 2008-04-08 13:41:18.000000000 -0500<br>+++ serefpolicy-3.3.1.new//policy/flask/security_classes&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-04-08 13:34:36.000000000 -0500<br>
@@ -114,5 +114,6 @@<br>&nbsp;class x_resource&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # userspace<br>&nbsp;class x_event&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # userspace<br>&nbsp;class x_synthetic_event&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # userspace<br>+class x_application_data&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # userspace<br>&nbsp;<br>
&nbsp;# FLASK<br>--- serefpolicy-3.3.1/policy/mls&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2008-04-08 13:41:18.000000000 -0500<br>+++ serefpolicy-3.3.1.new/policy/mls&nbsp;&nbsp;&nbsp; 2008-04-08 14:20:49.000000000 -0500<br>@@ -567,6 +567,12 @@<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( t1 == mlsxwinwritexinput ) or<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( t1 == mlsxwinwrite ));<br>&nbsp;<br>+#<br>+# MLS policy for the x_application_data class<br>+#<br>+mlsconstrain x_application_data { paste_without_confirm }<br>+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ( l1 domby l2 );<br>+<br>&nbsp;<br>&nbsp;#<br>&nbsp;# MLS policy for the pax class<br>
<br>

------=_Part_1698_30447241.1209128872473--

--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
