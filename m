Received: from facesaver.epoch.ncsc.mil (facesaver [144.51.25.10])
	by tarius.tycho.ncsc.mil (8.13.1/8.13.1) with ESMTP id m3UNVxAO001749
	for <selinux@tycho.nsa.gov>; Wed, 30 Apr 2008 19:31:59 -0400
Message-ID: <481900C9.40406@tycho.nsa.gov>
Date: Wed, 30 Apr 2008 19:29:13 -0400
From: Eamon Walsh <ewalsh@tycho.nsa.gov>
MIME-Version: 1.0
To: Xavier Toth <txtoth@gmail.com>
CC: "Christopher J. PeBenito" <cpebenito@tresys.com>,
        SE Linux <selinux@tycho.nsa.gov>
Subject: Re: copy/paste policy patch
References: <cadfc0e40804250607q6e6542ecmc1fa3d1e78a84cb8@mail.gmail.com>	 <1209386863.30483.44.camel@gorn.columbia.tresys.com>	 <4816523B.4030905@tycho.nsa.gov> <cadfc0e40804281546n188882c2w2c84241878f2d7ef@mail.gmail.com>
In-Reply-To: <cadfc0e40804281546n188882c2w2c84241878f2d7ef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-selinux@tycho.nsa.gov
List-Id: selinux@tycho.nsa.gov

Xavier Toth wrote:
> Seems to me that paste mlsconstrain should be (l1 eq l2) and should be 
> a mlsconstrain for paste_after_confirm which is (l1 domby l2).

Revised patch attached.

Signed-off-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
---

Index: policy/flask/security_classes
===================================================================
--- policy/flask/security_classes	(revision 2669)
+++ policy/flask/security_classes	(working copy)
@@ -114,5 +114,6 @@
 class x_resource		# userspace
 class x_event			# userspace
 class x_synthetic_event		# userspace
+class x_application_data	# userspace
 
 # FLASK
Index: policy/flask/access_vectors
===================================================================
--- policy/flask/access_vectors	(revision 2669)
+++ policy/flask/access_vectors	(working copy)
@@ -775,3 +775,10 @@
 {
 	recv
 }
+
+class x_application_data
+{
+	paste
+	paste_after_confirm
+	copy
+}
Index: policy/mls
===================================================================
--- policy/mls	(revision 2669)
+++ policy/mls	(working copy)
@@ -568,7 +568,19 @@
 	 ( t1 == mlsxwinwrite ));
 
 
+#
+# MLS policy for the x_application_data class
+#
 
+# the x_application_data "paste" ops (explicit single level)
+mlsconstrain x_application_data { paste }
+	( l1 eq l2 );
+
+# the x_application_data "paste_after_confirm" ops (downgrade permitted)
+mlsconstrain x_application_data { paste_after_confirm }
+	( l1 domby l2 );
+
+
 #
 # MLS policy for the pax class
 #


-- 
Eamon Walsh <ewalsh@tycho.nsa.gov>
National Security Agency


--
This message was distributed to subscribers of the selinux mailing list.
If you no longer wish to subscribe, send mail to majordomo@tycho.nsa.gov with
the words "unsubscribe selinux" without quotes as the message.
